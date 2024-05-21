import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({
    super.key,
    required this.size,
    required this.items,
  });

  final Size size;
  final List<String> items;

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: const Row(
          children: [
            Icon(
              FontAwesomeIcons.locationDot,
              size: 16,
              color: AppColors.grey,
            ),
            Expanded(
              child: Text(
                'Chọn Tỉnh Thành',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        items: widget.items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: widget.size.height / 18,
          width: widget.size.width / 2,
          padding:
              const EdgeInsets.only(left: kItemPadding, right: kItemPadding),
          decoration: BoxDecoration(
            borderRadius: kDefaultBorderRadius,
            border: Border.all(
              color: AppColors.grey,
              width: 2,
            ),
            color: AppColors.darkBackground,
          ),
          elevation: 5,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
          ),
          iconSize: 20,
          iconEnabledColor: AppColors.grey,
          iconDisabledColor: Colors.white,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: widget.size.height / 5,
          decoration: const BoxDecoration(
            borderRadius: kDefaultBorderRadius,
            color: AppColors.darkBackground,
          ),
          // offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
