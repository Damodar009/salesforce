import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salesforce/domain/entities/SalesData.dart';
import 'package:salesforce/domain/entities/retailerDropDown.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../injectable.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/hiveConstant.dart';
import '../../widgets/individualOrderDetail.dart';

class ListOfOrderAndOutletDetailScreen extends StatefulWidget {
  const ListOfOrderAndOutletDetailScreen({Key? key}) : super(key: key);

  @override
  State<ListOfOrderAndOutletDetailScreen> createState() =>
      _ListOfOrderAndOutletDetailScreenState();
}

class _ListOfOrderAndOutletDetailScreenState
    extends State<ListOfOrderAndOutletDetailScreen> {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  String text = "1234567890m";
  List<SalesData> salesData = [];
  List<RetailerDropDown> retailerData = [];

  // getDataFromHiveFor(String routes) {
  //   switch (routes) {
  //     case "totalOutlets":
  //       break;
  //     case "newOutlet":
  //       break;
  //     case "totalOutLetsVisited":
  //       break;
  //     case "totalSales":
  //       break;
  //   }
  // }

  getDataFromHiveForTodaySalesData() async {
    Box boxs = await Hive.openBox(HiveConstants.salesDataCollection);
    print("sales data collection inside hive ");
    var successOrFailed = useCaseForHiveImpl.getAllValuesFromHiveBox(boxs);
    successOrFailed.fold(
        (l) => {print("this is so sad")},
        (r) => {
              setState(() {
                for (var i = 0; i < r.length; i++) {
                  print(r[i]);
                  salesData.add(r[i]);
                }
              }),
              print(salesData.length)
            });
  }

  getRetailerLists() async {
    Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    var successOrNot = useCaseForHiveImpl.getValuesByKey(
        box, HiveConstants.retailerDropdownKey);
    successOrNot.fold(
        (l) => {print("no success")},
        (r) => {
              for (var i = 0; i < r.length; i++)
                {retailerData.add(r[i]), print(retailerData[i])},
            });
  }

  String? getNameFromId(String retailerId) {
    String? retailerName;
    retailerData.map((e) => {
          if (e.id == retailerId) {retailerName = e.name} else {}
        });
    return retailerName;
  }

  // getRetailerList() async {
  //   Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
  //   var sucessOrNot = useCaseForHiveImpl.getValuesByKey(box, "retailerTypes");
  //   sucessOrNot.fold(
  //       (l) => {print("no success")},
  //       (r) => {
  //             for (var i = 0; i < r.length; i++)
  //               {
  //                 print(r[i].id),
  //                 print(r[i].name),
  //               },
  //           });
  // }

  @override
  void initState() {
    getDataFromHiveForTodaySalesData();
    getRetailerLists();
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
                      return individualOrderDetail(
                          getNameFromId(salesData[index].retailer!),
                          salesData[index].sales!);
                    },
                    itemCount: salesData.length),
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
