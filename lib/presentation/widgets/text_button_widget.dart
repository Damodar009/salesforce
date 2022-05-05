import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

Widget textButton(String title, Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.buttonColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.buttonColor,
            ),
          ),
        ),
      ),
    ),
  );
}