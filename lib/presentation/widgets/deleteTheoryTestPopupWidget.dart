import 'package:flutter/material.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/presentation/widgets/textButton.dart';
import 'package:salesforce/utils/app_colors.dart';

import '../../routes.dart';

Widget popupWidget(BuildContext context, String text) {
  return AlertDialog(
    title: Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          "x",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor),
        ),
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(text,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor)),
      ],
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
              height: 50,
              child: button("Skip", () {
                Navigator.of(context).pushNamed(Routes.merchandiseSupportScreen);
              }, false, AppColors.buttonColor)),
          textButton("cancel", () {
            Navigator.of(context).pop();
          }),
        ],
      ),
    ],
  );
}
