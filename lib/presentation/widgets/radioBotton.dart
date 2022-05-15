import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

Widget buildIndividualRadio(
    String value, String groupValue, Function(String) onclick) {
  return Row(
    children: [
      Radio<String>(
        fillColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.textFeildINputBorder),
        toggleable: true,
        activeColor: AppColors.primaryColor,
        value: value,
        groupValue: groupValue,
        onChanged: (value) {
          onclick(value!);
        },
      ),
      Text(value),
    ],
  );
}
