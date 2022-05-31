import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salesforce/domain/entities/SalesData.dart';
import 'package:salesforce/domain/entities/sales.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';

import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../injectable.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/hiveConstant.dart';
import '../../widgets/individualOrderDetail.dart';

class ListOfOrderAndOutletDetailScreen extends StatefulWidget {
  ListOfOrderAndOutletDetailScreen({Key? key}) : super(key: key);

  @override
  State<ListOfOrderAndOutletDetailScreen> createState() =>
      _ListOfOrderAndOutletDetailScreenState();
}

class _ListOfOrderAndOutletDetailScreenState
    extends State<ListOfOrderAndOutletDetailScreen> {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  String text = "1234567890m";
  List<dynamic> salesData = [];

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
    var successOrFailed = useCaseForHiveImpl.getAllValuesFromHiveBox(boxs);
    successOrFailed.fold(
        (l) => {print("this is so sad")}, (r) => {salesData.addAll(r)});
  }

  SalesData salesdata = SalesData(
      sales: [
        Sales(sales: 2, product: 'mr aryan'),
        Sales(sales: 3, product: 'mr surasa '),
        Sales(sales: 3, product: 'mr raj'),
        Sales(sales: 3, product: 'mr dhamala'),
        Sales(sales: 3, product: 'mr movieman'),
        Sales(sales: 3, product: 'mr saurav'),
      ],
      retailer: "mr movieMan",
      assignedDepot: "assignedDepot",
      collectionDate: "collectionDate",
      latitude: 34,
      longitude: 45,
      userId: "userId");

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
                      return individualOrderDetail(
                          "Mr rajkumar", salesdata.sales!);
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
