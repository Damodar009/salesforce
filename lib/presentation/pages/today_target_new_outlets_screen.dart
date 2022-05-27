import 'package:flutter/material.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import '../../utils/app_colors.dart';

class NewTargetNewOutletsScreen extends StatelessWidget {
  const NewTargetNewOutletsScreen({Key? key}) : super(key: key);
  // String text = "1234567890m";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(navTitle: "New outlets Data", context: context),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                // Text(text),
                ListView.builder(
                    primary: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return newTargetNewOutletsDetailsWidget(context);
                    },
                    itemCount: 10),
                SizedBox(
                  height: size.height * 0.001,
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

Widget newTargetNewOutletsDetailsWidget(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
          color: AppColors.checkIn,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Name: ",
                  ),
                  SizedBox(
                    width: size.width * 0.19,
                  ),
                  Text(
                    "Pujan Bohora",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "Contact Person: ",
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Text(
                    "9817034302",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("location:"),
                  SizedBox(
                    width: size.width * 0.17,
                  ),
                  Text(
                    "Barahi,kathmandu,Nepal",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        )),
  );
}
