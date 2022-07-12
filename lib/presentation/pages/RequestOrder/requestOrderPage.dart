import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salesforce/domain/entities/requestedDropDown.dart';
import 'package:salesforce/presentation/pages/RequestOrder/widgets/eachRequestWidget.dart';
import 'package:salesforce/utils/app_colors.dart';
import '../../../domain/entities/productName.dart';
import '../../../domain/entities/requestDeliver.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../injectable.dart';
import '../../../utils/hiveConstant.dart';
import '../../widgets/appBarWidget.dart';

class RequestOrderPage extends StatefulWidget {
  const RequestOrderPage({Key? key}) : super(key: key);

  @override
  State<RequestOrderPage> createState() => _RequestOrderPageState();
}

class _RequestOrderPageState extends State<RequestOrderPage> {
  List<RequestedDropDown> requestedDropDown = [];
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
      appBar: appBar(navTitle: 'Requested Order', context: context),
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
    var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
    Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    List<RequestedDropDown> remainedRequested = [];
    bool addRemainedRequestedDropDown = true;
    bool addProductName = true;
    for (int i = 0; i < requestedDropDown.length; i++) {
      addRemainedRequestedDropDown = true;
      for (int j = 0; j < deliveredRequested.length; j++) {
        if (requestedDropDown[i].retailerName ==
            deliveredRequested[j].retailerName) {
          addRemainedRequestedDropDown = false;
          List<ProductName> productName = deliveredRequested[j].productName;
          List<ProductName> requestedProductName =
              requestedDropDown[i].productName;
          List<ProductName> remainedProductName = [];

          for (int k = 0; k < requestedProductName.length; k++) {
            for (int l = 0; l < productName.length; l++) {
              addProductName = true;
              if ((requestedProductName[k].productName ==
                  productName[l].productName)) {
                addProductName = false;
                break;
              }
            }
            if (addProductName) {
              remainedProductName.add(requestedProductName[k]);
            }
          }
          remainedRequested.add(RequestedDropDown(
              retailerName: deliveredRequested[j].retailerName,
              productName: remainedProductName));
        }
      }
      if (addRemainedRequestedDropDown) {
        remainedRequested.add(requestedDropDown[i]);
      }
    }
    if (remainedRequested.isNotEmpty) {
      useCaseForHiveImpl.saveValueByKey(
          box, HiveConstants.requestOrders, remainedRequested);
    }
    if (deliveredRequested.isNotEmpty) {
      List<RequestDelivered> requestedDelivereds = [];
      for (int i = 0; i < deliveredRequested.length; i++) {
        List<ProductName> pr = deliveredRequested[i].productName;
        for (int j = 0; j < pr.length; j++) {
          requestedDelivereds
              .add(RequestDelivered(pr[j].id, pr[j].requestedDate));
        }
      }

      await useCaseForHiveImpl
          .getValueByKey(box, HiveConstants.deliveredOrders)
          .fold(
              (l) => {},
              (r) => {
                    for (RequestDelivered re in r)
                      {
                        requestedDelivereds.add(re),
                      }
                  });
      useCaseForHiveImpl.saveValueByKey(
          box, HiveConstants.deliveredOrders, requestedDelivereds);
      print(requestedDelivereds.toString());
    }
    super.deactivate();
  }
}
