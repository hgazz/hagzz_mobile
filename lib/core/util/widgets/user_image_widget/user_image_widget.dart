import 'dart:io';

import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svgProvider;
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
              backgroundColor: image == null && widget.url == null
                  ? AppColors.surfaceContainer
                  : null,
              backgroundImage: image == null
                  ? widget.url == null
                      ? svgProvider.Svg(AppImages.defaultCoachImage)
                      : Image.network(widget.url ?? '').image
                  : Image.file(image!).image,
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
}
