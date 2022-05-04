import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

PreferredSizeWidget appBar({
  required IconData icon,
  required String navTitle,
  Widget? settingIcon,
  String? settingTitle,
  required Function() backNavigate,
}) {
  return AppBar(
    actions: [
      settingIcon ?? Container(),
    ],
    leading: BackButton(),
    title: Text(
      navTitle,
      style: TextStyle(color: AppColors.primaryColor),
    ),
    centerTitle: false,
  );
}
