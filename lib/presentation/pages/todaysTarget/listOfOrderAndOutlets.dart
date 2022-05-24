import 'package:flutter/material.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';

import '../../../utils/app_colors.dart';
import '../../widgets/individualOrderDetail.dart';

class ListOfOrderAndOutletDetailScreen extends StatefulWidget {
  ListOfOrderAndOutletDetailScreen({Key? key}) : super(key: key);

  @override
  State<ListOfOrderAndOutletDetailScreen> createState() =>
      _ListOfOrderAndOutletDetailScreenState();
}

class _ListOfOrderAndOutletDetailScreenState
    extends State<ListOfOrderAndOutletDetailScreen> {
  String text = "1234567890m";
  List<dynamic> data = [];

  getDataFromHiveFor(String routes) {
    switch (routes) {
      case "totalOutlets":
        break;
      case "newOutlet":
        break;
      case "totalOutLetsVisited":
        break;
      case "totalSales":
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(navTitle: 'Data', context: context),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(text),
                ListView.builder(
                    primary: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return individualOrderDetail("", " ", 12);
                    },
                    itemCount: 4),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: button("Go to home", () {
                    Navigator.pop(context);
                  }, false, AppColors.buttonColor),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
