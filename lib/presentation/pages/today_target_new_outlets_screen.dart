import 'package:flutter/material.dart';
import 'package:salesforce/presentation/pages/todaysTarget/todaysTarget.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import '../../domain/entities/retailer.dart';
import '../../domain/entities/retailerDropDown.dart';
import '../../utils/app_colors.dart';

class NewTargetNewOutletsScreen extends StatefulWidget {
  final bool isNewRetailer;
  const NewTargetNewOutletsScreen({Key? key, required this.isNewRetailer})
      : super(key: key);

  @override
  State<NewTargetNewOutletsScreen> createState() =>
      _NewTargetNewOutletsScreenState();
}

class _NewTargetNewOutletsScreenState extends State<NewTargetNewOutletsScreen> {
  TodayTarget todayTarget = TodayTarget();
  List<RetailerDropDown>? retailerDropDownList = [];
  List<Retailer>? retailers = [];
  getTotalOutlets() async {
    retailerDropDownList = await todayTarget.getTotalOutLetList();
    setState(() {
      retailerDropDownList;
    });
  }

  getNewOutlets() async {
    retailers = (await todayTarget.getNewOutletsList());

    setState(() {
      retailers;
    });
  }

  @override
  void initState() {
    if (widget.isNewRetailer) {
      getNewOutlets();
    } else {
      getTotalOutlets();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(
          navTitle:
              widget.isNewRetailer ? "New outlets Data" : "Total Outlets data",
          context: context),
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
                widget.isNewRetailer
                    ? retailers!.isNotEmpty
                        ? ListView.builder(
                            primary: true,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return newTargetNewOutletsDetailsWidget(
                                  context,
                                  retailers![index].name,
                                  retailers![index].contactNumber,
                                  retailers![index].address);
                            },
                            itemCount: retailers!.length)
                        : const Center(child: Text("No Data!"))
                    : retailerDropDownList!.isNotEmpty
                        ? ListView.builder(
                            primary: true,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return newTargetNewOutletsDetailsWidget(
                                  context,
                                  retailerDropDownList![index].name,
                                  retailerDropDownList![index].contact_number,
                                  retailerDropDownList![index].address);
                            },
                            itemCount: retailerDropDownList!.length)
                        : const Center(child: Text("No Data!")),
                SizedBox(
                  height: size.height * 0.001,
                ),
                (retailerDropDownList!.isNotEmpty || retailers!.isNotEmpty)
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: button("Go to home", () {
                          Navigator.pop(context);
                        }, false, AppColors.buttonColor),
                      )
                    : const SizedBox(),
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

Widget newTargetNewOutletsDetailsWidget(
    BuildContext context, String name, String contactPerson, String location) {
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
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                    contactPerson,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                    location,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        )),
  );
}
