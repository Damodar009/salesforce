import 'package:flutter/material.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/utils/app_colors.dart';

class XlsOrder extends StatelessWidget {
  const XlsOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(icon: Icons.arrow_back, navTitle: "ORDER"),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text("Name of shop : Name of shop "),
          const SizedBox(
            height: 15,
          ),
          const Text("Name of shop : Name of shop "),
          const SizedBox(
            height: 200,
            width: 200,
            child: Center(
              child: Text("here lies the xls document view "),
            ),
          ),
          button("title", () {}, false, AppColors.buttonColor),
          button("title", () {}, false, AppColors.buttonColor),
        ],
      ),
    );
  }
}
