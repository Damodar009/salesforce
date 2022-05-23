import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../utils/app_colors.dart';

PreferredSizeWidget appBar({
  // required IconData icon,
  required String navTitle,
  required BuildContext context,
  Widget? settingIcon,
  String? settingTitle,
  // required Function() backNavigate,
}) {
  return AppBar(
    actions: [
      settingIcon ?? Container(),
    ],
    leading: InkWell(
      onTap: () {
        Navigator.pop(context);
        ;
      },
      child: const Icon(
        Icons.arrow_back_ios_new_outlined,
        size: 18,
      ),
    ),
    // BackButton(),
    title: Text(
      navTitle,
      style: TextStyle(color: AppColors.primaryColor),
    ),
    centerTitle: false,
  );
}
