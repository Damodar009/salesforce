// title("Available Time for delivery"),
// const SizedBox(
// height: 12,
// ),
// textFormField(
// controller: _textEditingController,
// validator: (string) {},
// obsecureText1: () {},
// hintText: 'From'),
// const SizedBox(
// height: 12,
// ),
// textFormField(
// controller: _textEditingController,
// validator: (string) {},
// obsecureText1: () {},
// hintText: 'To '),
// const SizedBox(
// height: 12,
// ),
//
// title("Availability"),
//
// textFormField(
// controller: _textEditingController,
// validator: (string) {},
// obsecureText1: () {},
// hintText: 'What is the status'),
// const SizedBox(
// height: 20,
// ),

import 'package:flutter/material.dart';
import 'package:salesforce/utils/app_colors.dart';

Widget cancleWidget(Function() onClick) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: InkWell(
      onTap: onClick,
      child: Container(
        height: 25,
        width: 25,
        color: AppColors.buttonColor,
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.orange),
        //   shape: BoxShape.rectangle,
        // ),
        child: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget circleContainer() {
  return Padding(
    padding: const EdgeInsets.only(left: 4.0),
    child: Container(
      height: 40,
      width: 37,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.delete,
        size: 20,
        color: AppColors.buttonColor,
      ),
    ),
  );
}
