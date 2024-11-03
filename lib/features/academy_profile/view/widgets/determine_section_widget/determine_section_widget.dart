import 'package:bookit/features/academy_profile/view_model/academy_profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/enum_model/enum_details_model.dart';
import '../about_widget/about_widget.dart';
import '../activitiy_list_widget/activit_list_widget.dart';
import '../gallery_widget/gallery_widget.dart';

class DetermineSectionWidget extends StatelessWidget {
  final int id;

  const DetermineSectionWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AcademyProfileCubit, AcademyProfileState>(
      builder: (context, state) {
        var cubit = AcademyProfileCubit.get(context);
        return Expanded(
          child: PageView(
            controller: cubit.pageViewController,
            onPageChanged: (index) {
              if (index == 0) {
                cubit.changeDetailsCategory(
                    category: AcademyDetailsCategories.activities);
              }
              if (index == 1) {
                cubit.changeDetailsCategory(
                    category: AcademyDetailsCategories.gallery);
              }
              if (index == 2) {
                cubit.changeDetailsCategory(
                    category: AcademyDetailsCategories.about);
              }
            },
            children: [
              ActivityListWidget(id: id),
              GalleryWidget(
                galleries: cubit.academyDetails?.data?.academy?.galleries ?? [],
              ),
              AboutWidget(
                facebookUrl:
                    cubit.academyDetails?.data?.academy?.facebook ?? '',
                instagramUrl:
                    cubit.academyDetails?.data?.academy?.instagram ?? '',
                linkedInmUrl:
                    cubit.academyDetails?.data?.academy?.linkedin ?? '',
                websiteUrl: cubit.academyDetails?.data?.academy?.website ?? '',
              ),
            ],
          ),
        );
        return Expanded(
          child: Dismissible(
            onDismissed: (details) {
              if (details == DismissDirection.endToStart) {
                if (cubit.academyDetailsCategories ==
                    AcademyDetailsCategories.activities) {
                  cubit.changeDetailsCategory(
                      category: AcademyDetailsCategories.gallery);
                } else if (cubit.academyDetailsCategories ==
                    AcademyDetailsCategories.gallery) {
                  cubit.changeDetailsCategory(
                      category: AcademyDetailsCategories.about);
                } else {}
              } else if (details == DismissDirection.startToEnd) {
                if (cubit.academyDetailsCategories ==
                    AcademyDetailsCategories.about) {
                  cubit.changeDetailsCategory(
                      category: AcademyDetailsCategories.gallery);
                } else if (cubit.academyDetailsCategories ==
                    AcademyDetailsCategories.gallery) {
                  cubit.changeDetailsCategory(
                      category: AcademyDetailsCategories.activities);
                } else {}
              }
            },
            key: UniqueKey(),
            child: Column(
              children: [
                Visibility(
                    visible: cubit.academyDetailsCategories ==
                        AcademyDetailsCategories.activities,
                    child: ActivityListWidget(id: id)),
                Visibility(
                    visible: cubit.academyDetailsCategories ==
                        AcademyDetailsCategories.gallery,
                    child: GalleryWidget(
                      galleries:
                          cubit.academyDetails?.data?.academy?.galleries ?? [],
                    )),
                Visibility(
                    visible: cubit.academyDetailsCategories ==
                        AcademyDetailsCategories.about,
                    child: AboutWidget(
                      linkedInmUrl: "",
                      facebookUrl:
                          cubit.academyDetails?.data?.academy?.facebook ?? '',
                      instagramUrl:
                          cubit.academyDetails?.data?.academy?.instagram ?? '',
                      websiteUrl:
                          cubit.academyDetails?.data?.academy?.website ?? '',
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
