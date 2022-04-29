import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

Widget card(String icon, String title, int number) {
  return Center(
    child: Container(
        height: 140,
        width: 150,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
          color: AppColors.primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.color),
                  child: Image(image: AssetImage(icon))),
              Text(
                number.toString(),
                style:
                    const TextStyle(color: AppColors.buttonColor, fontSize: 18),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              )
            ],
          ),
        )),
  );
}
