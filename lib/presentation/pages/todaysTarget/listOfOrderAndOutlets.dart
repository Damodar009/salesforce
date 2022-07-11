import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salesforce/domain/entities/SalesData.dart';
import 'package:salesforce/domain/entities/retailerDropDown.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import '../../../domain/entities/sales.dart';
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

  List<SalesData> salesData = [];
  List<RetailerDropDown> retailerData = [];

  List<Map<String, String>> childAndChildId = [];

  getProductsFromHiveBox() async {
    List<dynamic> products = [];
    Map<String, String> map;
    Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    var sucessOrNot = useCaseForHiveImpl.getValuesByKey(
      box,
      HiveConstants.productKey,
    );
    sucessOrNot.fold(
        (l) => {print("no success")},
        (r) => {
              products = r,
              for (var i = 0; i < products.length; i++)
                {
                  for (int j = 0; j < products[i].childProducts.length; j++)
                    {
                      map = {
                        products[i].childProducts[j]["name"]:
                            products[i].childProducts[j]["id"]
                      },
                      childAndChildId.add(map),
                    }
                },
            });
  }

  List<String>? changeIdTOName(List<Sales> childProductsId) {
    List<String> name = [];
    for (int i = 0; i < childProductsId.length; i++) {
      childAndChildId.forEach((element) {
        element.forEach((key, value) {
          if (value == childProductsId[i].product) {
            name.add(key);
          }
        });
      });
    }

    return name;
  }

  getDataFromHiveForTodaySalesData() async {
    Box boxs = await Hive.openBox(HiveConstants.salesDataCollection);
    print("sales data collection inside hive ");
    var successOrFailed = useCaseForHiveImpl.getAllValuesFromHiveBox(boxs);
    successOrFailed.fold(
        (l) => {print("this is so sad")},
        (r) => {
              setState(() {
                for (var i = 0; i < r.length; i++) {
                  salesData.add(r[i]);
                  print(r[i]);
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
              for (var i = 0; i < r.length; i++) {retailerData.add(r[i])},
            });
  }

  String? getNameFromId(String retailerId) {
    String? retailerName;
    retailerData.map((e) => {
          print(e.id),
          print(retailerId),
          if (e.id == retailerId)
            {print("it is not equal"), retailerName = e.name}
          else
            {}
        });

    return retailerName;
  }

  @override
  void initState() {
    getDataFromHiveForTodaySalesData();
    getProductsFromHiveBox();
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
                //  Text(text),
                ListView.builder(
                    primary: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      List<String>? products = [];

                      products = changeIdTOName(salesData[index].sales!);

                      // List<String>? products = [];
                      // products = changeIdTOName(salesData[index].sales!);

                      return individualOrderDetail(
                          salesData[index].retailer != null
                              ? getNameFromId(salesData[index].retailer!)
                              : salesData[index].retailerPojo!.name,
                          changeIdTOName(salesData[index].sales!));
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

// getProductsFromHiveBox() async {
//   Map<String, String> map;
//   Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
//   var sucessOrNot = useCaseForHiveImpl.getValuesByKey(
//     box,
//     HiveConstants.productKey,
//   );
//   sucessOrNot.fold(
//           (l) => {print("no success")},
//           (r) => {
//         print("getting products from hive is spasseds"),
//         products = r,
//         for (var i = 0; i < products.length; i++)
//           {
//             productName.add(products[i].name),
//             for (int j = 0; j < products[i].childProducts.length; j++)
//               {
//                 map = {
//                   products[i].childProducts[j]["name"]:
//                   products[i].childProducts[j]["id"]
//                 },
//                 childAndChildId.add(map),
//               }
//           },
//         print(childAndChildId),
//       });
// }
//
// String? changeNameTOId(String childProductName) {
//   String? id;
//   childAndChildId.forEach((element) {
//     element.forEach((key, value) {
//       if (key == childProductName) {
//         id = value;
//       }
//     });
//   });
//   return id;
// }
