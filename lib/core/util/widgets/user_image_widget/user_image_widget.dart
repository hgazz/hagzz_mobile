import 'dart:io';

import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_icons/app_icons.dart';
import '../../constants/app_images/app_images.dart';

class UserImageWidget extends StatefulWidget {
  final String? url;
  final void Function(File?) getImage;

  const UserImageWidget({super.key, this.url, required this.getImage});

  @override
  State<UserImageWidget> createState() => _UserImageWidgetState();
}

class _UserImageWidgetState extends State<UserImageWidget> {
  File? image;
  ImagePicker? imagePicker = ImagePicker();

  Future<void> getImageFromGallery() async {
    XFile? pickedImage =
        await imagePicker?.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
        widget.getImage(image);
      });
    } else {
      widget.getImage(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getImageFromGallery();
      },
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 55.r,
              backgroundColor: AppColors.surfaceContainer,
              child: ClipOval(
                child: SizedBox(
                  width: 110.r,
                  height: 110.r,
                  child: image != null
                      ? Image.file(image!, fit: BoxFit.cover)
                      : _profileImage(),
                ),
              ),
            ),
            Container(
              width: 30,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: SvgPicture.asset(
                AppIcons.edit,
                width: 30,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _profileImage() {
    final url = widget.url ?? '';
    final fallback = SvgPicture.asset(
      AppImages.defaultCoachImage,
      fit: BoxFit.cover,
    );

    if (url.isEmpty) return fallback;

    if (url.toLowerCase().contains('.svg')) {
      return SvgPicture.network(
        url,
        fit: BoxFit.cover,
        placeholderBuilder: (_) => fallback,
        errorBuilder: (_, __, ___) => fallback,
      );
    }

    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}
