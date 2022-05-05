import 'package:flutter/material.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/presentation/widgets/text_button_widget.dart';
import 'package:salesforce/utils/app_colors.dart';

Widget deleteTheoryTestPopupWidget(BuildContext context) {
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
      children: const <Widget>[
        Text("Are you sure you want to delete this theory test ? ",
            style: TextStyle(
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
              child: button("Delete", () {}, false, AppColors.buttonColor)),
          textButton("cancel", () {
            Navigator.of(context).pop();
          }),
        ],
      ),
    ],
  );
}
