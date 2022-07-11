import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:salesforce/utils/app_colors.dart';

Widget dropDownSearchWidget(
    List<String> items,String selectedItem ,  Function(String? string) onTap) {
  return DropdownSearch<String>(
      popupProps: const PopupProps.menu(
        showSearchBox: true,
        showSelectedItems: true,
      ),
      selectedItem: selectedItem,
      items: items,
      dropdownSearchDecoration: const InputDecoration(
          fillColor: Colors.white,
          errorStyle: TextStyle(color: Color.fromRGBO(2, 40, 89, 1)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            borderSide: BorderSide(color: AppColors.textFeildINputBorder),
          ),
          filled: true,
          hintStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Inter',
            fontSize: 15,
          ),
          hintText: "Select",
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ))),
      onChanged: onTap);
}
