import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salesforce/domain/entities/requestedDropDown.dart';
import 'package:salesforce/presentation/pages/RequestOrder/widgets/eachRequestWidget.dart';
import 'package:salesforce/utils/app_colors.dart';
import '../../../domain/entities/productName.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../injectable.dart';
import '../../../utils/hiveConstant.dart';

class RequestOrderPage extends StatefulWidget {
  const RequestOrderPage({Key? key}) : super(key: key);

  @override
  State<RequestOrderPage> createState() => _RequestOrderPageState();
}

class _RequestOrderPageState extends State<RequestOrderPage> {
  List<RequestedDropDown> requestedDropDown = [
    const RequestedDropDown(productName: [
      ProductName(
          id: 'werrtytddsdggfytytty',
          quantity: 13,
          requestedDate: '2022-2-2',
          productName: 'rc'),
      ProductName(
          id: 'werrtytddsdggfvcvytytty',
          quantity: 13,
          requestedDate: '2022-2-2',
          productName: 'rc fanta'),
      ProductName(
          id: 'werrtytdfgfgdsdggfytytty',
          quantity: 13,
          requestedDate: '2022-2-2',
          productName: 'rc priny'),
      ProductName(
          id: 'werrtytddsdggfydfdtytty',
          quantity: 13,
          requestedDate: '2022-2-2',
          productName: 'rc as')
    ], retailerName: 'Surasa'),
    const RequestedDropDown(productName: [
      ProductName(
          id: 'werrtytytyuioyhjuhjngfhtty',
          quantity: 14,
          requestedDate: '2022-2-2',
          productName: 'rc asa')
    ], retailerName: 'Sanjay'),
    const RequestedDropDown(productName: [
      ProductName(
          id: 'werrtgfhrdfgrytjkjytytty',
          quantity: 15,
          requestedDate: '2022-2-2',
          productName: 'rc cola')
    ], retailerName: 'pujan'),
    const RequestedDropDown(productName: [
      ProductName(
          id: 'werrtydfgsdfgjkksdfgstytytty',
          quantity: 16,
          requestedDate: '2022-2-2',
          productName: 'rc cola')
    ], retailerName: 'laxmi')
  ];
  List<RequestedDropDown> searchRequestedDropDown = [];

  List<RequestedDropDown> deliveredRequested = [];
  getRequestedOrderFromHive() async {
    var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
    Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    useCaseForHiveImpl.getValuesByKey(box, HiveConstants.requestOrders).fold(
        (l) => {},
        (r) => {
              for (RequestedDropDown requested in r)
                {
                  requestedDropDown.add(requested),
                },
            });
    setState(() {});
  }

  searchRequestedDropDownList() {}

  @override
  initState() {
    getRequestedOrderFromHive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Requested Orders"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                    borderSide: BorderSide(color: AppColors.buttonColor)),
                labelText: 'Search',
                hintText: "search",
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.buttonColor,
                ),
              ),
              onChanged: (searchText) {
                searchRequestedDropDown = [];
                searchRequestedDropDown = requestedDropDown.where((element) {
                  bool contains = false;
                  //print(element.retailerName);
                  List<String> retailersName = element.retailerName.split(" ");
                  for (String words in retailersName) {
                    if (words
                        .toLowerCase()
                        .startsWith(searchText.toLowerCase())) {
                      contains = true;
                      break;
                    }
                  }

                  return contains;
                }).toList();

                setState(() {});
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                  itemCount: searchRequestedDropDown.isEmpty
                      ? requestedDropDown.length
                      : searchRequestedDropDown.length,
                  itemBuilder: (BuildContext context, index) {
                    return eachRequestedOrder(
                        searchRequestedDropDown.isEmpty
                            ? requestedDropDown[index].retailerName
                            : searchRequestedDropDown[index].retailerName,
                        searchRequestedDropDown.isEmpty
                            ? requestedDropDown[index]
                                .productName[0]
                                .requestedDate
                            : searchRequestedDropDown[index]
                                .productName[0]
                                .requestedDate,
                        searchRequestedDropDown.isEmpty
                            ? requestedDropDown[index].productName
                            : searchRequestedDropDown[index].productName,
                        deliveredRequested, (productIndex) {
                      int toRemove = -1;
                      bool addDeliveredRequested = true;
                      bool addProductNames = true;
                      if (deliveredRequested.isNotEmpty) {
                        for (int i = 0; i < deliveredRequested.length; i++) {
                          if (productIndex.retailerName ==
                              deliveredRequested[i].retailerName) {
                            addDeliveredRequested = false;
                            List<ProductName> productNames =
                                deliveredRequested[i].productName;
                            if (productNames.isNotEmpty) {
                              for (int j = productNames.length - 1;
                                  j >= 0;
                                  j--) {
                                if (productNames[j].id ==
                                    productIndex.productName[0].id) {
                                  addProductNames = false;
                                  toRemove = j;
                                  break;
                                }
                              }
                              if (addProductNames) {
                                productNames.add(productIndex.productName[0]);
                              }
                              if (toRemove != -1) {
                                productNames.remove(productNames[toRemove]);
                              }
                            } else {
                              productNames.add(productIndex.productName[0]);
                            }

                            RequestedDropDown vf = RequestedDropDown(
                                retailerName:
                                    deliveredRequested[i].retailerName,
                                productName: productNames);
                            deliveredRequested.removeAt(i);
                            deliveredRequested.add(vf);
                            break;
                          }
                        }
                        if (addDeliveredRequested) {
                          deliveredRequested.add(productIndex);
                        }
                      } else {
                        deliveredRequested.add(productIndex);
                      }
                      setState(() {});
                    });
                  }),
            ),
          )
        ],
      ),
    );
  }

  @override
  deactivate() async {
    // List<RequestedDropDown> deliveredOrders = [];
    // List<RequestedDropDown> notDeliveredOrders = [];
    // var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
    // Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    List<RequestedDropDown> remainedRequested = [];
    bool addRemainedRequestedDropDown = true;
    for (int i = 0; i < requestedDropDown.length; i++) {
      for (int j = 0; j < deliveredRequested.length; j++) {
        if (requestedDropDown[i].retailerName ==
            deliveredRequested[j].retailerName) {
          addRemainedRequestedDropDown = false;
          List<ProductName> productName = deliveredRequested[j].productName;
          List<ProductName> requestedProductName =
              requestedDropDown[i].productName;
          List<ProductName> newProductName = [];

          for (int k = 0; k < requestedProductName.length; k++) {
            for (int l = 0; l < productName.length; l++) {
              if (!(requestedProductName[k].productName ==
                  productName[l].productName)) {
                newProductName.add(productName[l]);
              }
            }
          }
          remainedRequested.add(RequestedDropDown(
              retailerName: deliveredRequested[j].retailerName,
              productName: newProductName));
        }
      }
      if (addRemainedRequestedDropDown) {
        remainedRequested.add(requestedDropDown[i]);
      }
    }
    print(remainedRequested.toString());
    //
    // for (RequestedDropDown as in requestedDropDown) {
    //   if (retailersName.contains(as.retailerName)) {
    //     deliveredOrders.add(as);
    //   } else {
    //     notDeliveredOrders.add(as);
    //   }
    // }
    // if (deliveredOrders.isNotEmpty) {
    //   useCaseForHiveImpl.saveValueByKey(
    //       box, HiveConstants.deliveredOrders, deliveredOrders);
    // }
    // if (notDeliveredOrders.isNotEmpty) {
    //   useCaseForHiveImpl.saveValueByKey(
    //       box, HiveConstants.requestOrders, notDeliveredOrders);
    // }
    super.deactivate();
  }
}

// {element.retailerName.split(" ").forEach((elment) {
// elment.startsWith(searchText)}
