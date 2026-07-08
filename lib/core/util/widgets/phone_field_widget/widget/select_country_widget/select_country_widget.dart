import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';

import '../../../../constants/app_colors/app_colors.dart';
import '../../../../constants/app_strings/app_strings.dart';
import '../../../text_widgets/title_text_widget/title_text_widget.dart';

class SelectCountryWidget extends StatefulWidget {
  final ValueChanged<Country> onUserSelect;
  final String selectedCountryCode;

  const SelectCountryWidget({
    super.key,
    required this.onUserSelect,
    required this.selectedCountryCode,
  });

  @override
  State<SelectCountryWidget> createState() => _SelectCountryWidgetState();
}

class _SelectCountryWidgetState extends State<SelectCountryWidget> {
  final TextEditingController _searchController = TextEditingController();
  late List<Country> _filteredCountries;

  @override
  void initState() {
    super.initState();
    _filteredCountries = List<Country>.from(countries);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries(String query) {
    final normalizedQuery = query.trim().toLowerCase().replaceFirst('+', '');
    setState(() {
      _filteredCountries = countries.where((country) {
        final localizedName = country
            .localizedName(Localizations.localeOf(context).languageCode)
            .toLowerCase();
        return country.name.toLowerCase().contains(normalizedQuery) ||
            localizedName.contains(normalizedQuery) ||
            country.code.toLowerCase().contains(normalizedQuery) ||
            country.dialCode.contains(normalizedQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;

    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 12.h),
          const TitleTextWidget(text: AppStrings.selectCountry),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 8.h),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCountries,
              decoration: InputDecoration(
                hintText: languageCode == 'ar'
                    ? 'ابحث باسم الدولة أو كود الاتصال'
                    : 'Search by country or calling code',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide:
                      const BorderSide(color: AppColors.greyBorderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide:
                      const BorderSide(color: AppColors.greyBorderColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 20.h),
              itemCount: _filteredCountries.length,
              separatorBuilder: (_, __) => SizedBox(height: 6.h),
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                final isSelected = country.code == widget.selectedCountryCode;
                return InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: () => widget.onUserSelect(country),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.black
                            : AppColors.greyBorderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(country.flag,
                            style: TextStyle(fontSize: 25.sp)),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            country.localizedName(languageCode),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            '+${country.fullCountryCode}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        if (isSelected) ...[
                          SizedBox(width: 8.w),
                          const Icon(Icons.check_circle, size: 20),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
