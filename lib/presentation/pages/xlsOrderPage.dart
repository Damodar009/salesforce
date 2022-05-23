import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/presentation/widgets/report_pop_up.dart';
import 'package:salesforce/utils/app_colors.dart';

class XlsOrder extends StatefulWidget {
  const XlsOrder({Key? key}) : super(key: key);

  @override
  State<XlsOrder> createState() => _XlsOrderState();
}

class _XlsOrderState extends State<XlsOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          // icon: Icons.arrow_back, 
          navTitle: "ORDER", 
          // backNavigate: () {},
          context: context
          ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text("Name of shop : Name of shop "),
            const SizedBox(
              height: 15,
            ),
            const Text("Location: Longituide / Latitude "),
            const SizedBox(
              height: 200,
              width: 200,
              child: Center(
                child: Text("here lies the xls document view "),
              ),
            ),
            button("save & save", () {}, false, AppColors.buttonColor),
            const SizedBox(
              height: 15,
            ),
            button("Save XLS", () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => reportPopUp(
                        context: context,
                      ));
            }, false, AppColors.buttonColor),
          ],
        ),
      ),
    );
  }
}
