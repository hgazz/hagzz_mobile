import 'package:bookit/core/util/constants/app_colors/app_colors.dart';
import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/app_images/app_images.dart';
import '../container_with_circle_shape_with_white_background_color_widget/container_with_circle_shape_with_white_background_color_widget.dart';

class CircleImageWidget extends StatelessWidget {
  final BoxFit? imageFit;
  final String image;

  const CircleImageWidget({super.key, this.imageFit, required this.image});

  @override
  Widget build(BuildContext context) {
    AppFunctions.logPrint(message: "imageeeeeeeeeeee: ${image}");

    return image != ""
        ? CircleAvatar(
            radius: 35.r,
            backgroundColor: AppColors.transparent,
            backgroundImage: image.contains(".svg")
                ? null
                : Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, obj, _) =>
                        ContainerWithCircleShapeWithWhiteBackgroundColorWidget(
                      image: AppImages.defaultAcademyImage,
                      isDetails: false,
                    ),
                    loadingBuilder: (context, obj, _) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ).image,
            child: image.contains(".svg")
                ? SvgPicture.network(
                    image,
                    fit: BoxFit.cover,
                    placeholderBuilder: (context) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                : null,
          )
        : ContainerWithCircleShapeWithWhiteBackgroundColorWidget(
            image: AppImages.defaultAcademyImage,
            isDetails: false,
          );
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, provider) {
        return image.contains(".svg")
            ? SvgPicture.network(image)
            : CircleAvatar(
                radius: 40.r,
                backgroundImage: provider,
              );
      },
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      errorWidget: (context, url, error) {
        AppFunctions.logPrint(message: "Errrrorrrr: $error \n ${url}");
        return ContainerWithCircleShapeWithWhiteBackgroundColorWidget(
          image: AppImages.defaultAcademyImage,
          isDetails: false,
        );
      },
    );
  }
}
