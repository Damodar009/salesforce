import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

PreferredSizeWidget appBar({
  required IconData icon,
  required String navTitle,
  IconData? settingIcon,
  String? settingTitle,
  required Function() backNavigate,
}) {
  return AppBar(
    actions: [
      settingTitle != null
          ? Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: settingIcon != null
                      ? Icon(
                          settingIcon,
                          size: 20,
                        )
                      : Container(),
                ),
                const SizedBox(
                  width: 15,
                ),
                (Text(
                  settingTitle,
                  style: const TextStyle(color: AppColors.primaryColor),
                )),
                const SizedBox(
                  width: 25,
                )
              ],
            )
          : Container(),
    ],
    leading: BackButton(),
    title: Text(
      navTitle,
      style: TextStyle(color: AppColors.primaryColor),
    ),
    centerTitle: false,
  );
}
