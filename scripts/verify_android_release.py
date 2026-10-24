#!/usr/bin/env python3
"""Inspect the signed AAB, not just source configuration. Requires a JDK/bundletool."""

import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess
import sys
import xml.etree.ElementTree as ET
import zipfile


ANDROID = "{http://schemas.android.com/apk/res/android}"
FORBIDDEN = {
    "com.google.android.gms.permission.AD_ID",
    "android.permission.ACCESS_ADSERVICES_AD_ID",
    "android.permission.ACCESS_ADSERVICES_ATTRIBUTION",
    "android.permission.ACCESS_ADSERVICES_TOPICS",
}
FLAGS = (
    "google_analytics_adid_collection_enabled",
    "google_analytics_default_allow_ad_storage",
    "google_analytics_default_allow_ad_user_data",
    "google_analytics_default_allow_ad_personalization_signals",
)


def run(*args):
    result = subprocess.run(args, text=True, capture_output=True)
    if result.returncode:
        raise ValueError(f"{args[0]} failed: {result.stderr or result.stdout}")
    return result.stdout


def require(condition, message):
    if not condition:
        raise ValueError(message)


def fingerprint(bundle):
    text = run("keytool", "-J-Duser.language=en", "-printcert", "-jarfile", str(bundle))
    match = re.search(r"SHA256:\s*([0-9A-F:]+)", text)
    require(match is not None, "No signing certificate found")
    return match.group(1)


def verify(args):
    bundle = args.bundle.resolve()
    xml = run("java", "-jar", str(args.bundletool.resolve()), "dump", "manifest",
              f"--bundle={bundle}", "--module=base")
    root = ET.fromstring(xml)
    require(root.get("package") == "com.unlimitedhagzz.hagzz", "Wrong application package")
    require(root.get(ANDROID + "versionCode") == str(args.version_code), "Wrong version code")
    require(root.get(ANDROID + "versionName") == args.version_name, "Wrong version name")
    sdk = root.find("uses-sdk")
    require(sdk is not None, "Missing SDK declaration")
    target = int(sdk.get(ANDROID + "targetSdkVersion", "0"))
    minimum = int(sdk.get(ANDROID + "minSdkVersion", "0"))
    compile_sdk = int(root.get(ANDROID + "compileSdkVersion", "0"))
    require(target >= 36, "Target SDK must be at least 36")
    require(compile_sdk >= 36, "Compile SDK must be at least 36")
    require(minimum == 24, "Unexpected minimum SDK; review device coverage")
    permissions = {
        p.get(ANDROID + "name") for p in root
        if p.tag in ("uses-permission", "uses-permission-sdk-23", "uses-permission-sdk-m")
    }
    require(not permissions & FORBIDDEN,
            f"Advertising permissions in final AAB: {sorted(permissions & FORBIDDEN)}")
    for flag in FLAGS:
        values = [p.get(ANDROID + "value") for p in root.findall("./application/meta-data")
                  if p.get(ANDROID + "name") == flag]
        require(values == ["false"], f"{flag} must explicitly be false in final AAB")

    native_alignment = {}
    with zipfile.ZipFile(bundle) as archive:
        abis = sorted({p.split("/")[2] for p in archive.namelist()
                       if p.startswith("base/lib/") and p.endswith("/libapp.so")})
        require(abis == ["arm64-v8a", "armeabi-v7a", "x86_64"], "Unexpected ABI coverage")
        for name in archive.namelist():
            if not name.startswith(("base/lib/arm64-v8a/", "base/lib/x86_64/")) or not name.endswith(".so"):
                continue
            data = archive.read(name)
            require(data[:4] == b"\x7fELF" and data[4] == 2, f"Invalid ELF64: {name}")
            endian = "<" if data[5] == 1 else ">"
            offset = struct.unpack_from(endian + "Q", data, 32)[0]
            size, count = struct.unpack_from(endian + "HH", data, 54)
            alignments = [struct.unpack_from(endian + "Q", data, offset + i * size + 48)[0]
                          for i in range(count)
                          if struct.unpack_from(endian + "I", data, offset + i * size)[0] == 1]
            require(bool(alignments) and min(alignments) >= 16384,
                    f"ELF load segments are not 16 KB aligned: {name}")
            native_alignment[name] = min(alignments)

    run("java", "-jar", str(args.bundletool.resolve()), "validate", f"--bundle={bundle}")
    signature = run("jarsigner", "-J-Duser.language=en", "-verify", str(bundle))
    require("jar verified." in signature and "unsigned entries" not in signature.lower(),
            "AAB signature validation failed or unsigned entries found")
    signer = fingerprint(bundle)
    if args.previous_bundle:
        require(signer == fingerprint(args.previous_bundle.resolve()), "Signing certificate changed")
    with bundle.open("rb") as stream:
        checksum = hashlib.file_digest(stream, "sha256").hexdigest()
    return {
        "package": root.get("package"), "version_name": args.version_name,
        "version_code": args.version_code, "compile_sdk": compile_sdk,
        "target_sdk": target, "min_sdk": minimum,
        "abis": abis, "advertising_permissions": sorted(permissions & FORBIDDEN),
        "advertising_flags_disabled": list(FLAGS), "native_64_bit_elf_alignment": native_alignment,
        "signature_verified": True, "bundletool_validation_passed": True,
        "signer_sha256": signer, "previous_signer_matched": bool(args.previous_bundle),
        "size_bytes": bundle.stat().st_size, "sha256": checksum,
        "device_and_play_validation": "Not evaluated by this artifact verifier",
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--bundle", type=Path, required=True)
    parser.add_argument("--bundletool", type=Path, required=True)
    parser.add_argument("--version-code", type=int, required=True)
    parser.add_argument("--version-name", required=True)
    parser.add_argument("--previous-bundle", type=Path)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    try:
        report = json.dumps(verify(args), indent=2) + "\n"
    except (ValueError, OSError, ET.ParseError, struct.error, zipfile.BadZipFile) as error:
        parser.exit(1, f"Release verification failed: {error}\n")
    if args.output:
        args.output.write_text(report)
    sys.stdout.write(report)


if __name__ == "__main__":
    main()
