import 'package:bookit/core/util/constants/app_functions/app_functions.dart';
import 'package:bookit/core/util/constants/app_images/app_images.dart';
import 'package:bookit/core/util/widgets/svg_image_widget/svg_image_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/util/models/api_models/gallery_model/gallery_model.dart';

class GalleryWidget extends StatelessWidget {
  final List<GalleryModel> galleries;

  const GalleryWidget({super.key, required this.galleries});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 1.w,
      children: List.generate(
          galleries.length,
          (index) => CachedNetworkImage(
                imageUrl: galleries[index].image ?? '',
                imageBuilder: (context, imageProvider) => InkWell(
                  onTap: () {
                    List<ImageProvider<Object>> image = [];

                    galleries.forEach((element) {
                      AppFunctions.logPrint(
                          message: "Imageee: ${element.image}");
                      image.add(Image.network(
                        element.image ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, obj, _) => SVGImageWidget(
                            image: AppImages.defaultAcademyImage),
                      ).image);
                    });
                    MultiImageProvider multiImageProvider =
                        MultiImageProvider(image, initialIndex: index);

                    showImageViewerPager(context, multiImageProvider,
                        useSafeArea: true, onPageChanged: (page) {
                      AppFunctions.logPrint(message: "page changed to $page");
                    }, onViewerDismissed: (page) {
                      AppFunctions.logPrint(
                          message: "dismissed while on page $page");
                    });
                  },
                  child: Container(
                    child: Image(
                      image: imageProvider,
                    ),
                  ),
                ),
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
                errorWidget: (context, url, error) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )),
    );
  }
}
