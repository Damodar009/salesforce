import 'package:flutter/material.dart';
import 'package:salesforce/domain/entities/productName.dart';
import '../../../../domain/entities/requestedDropDown.dart';
import '../../../../utils/app_colors.dart';

Widget eachRequestedOrder(
    String retailerName,
    String collectionDate,
    List<ProductName> orderRequests,
    List<RequestedDropDown> deliveredRequested,
    Function(RequestedDropDown) onTap) {
  bool checkProduct(String productName) {
    bool hasProduct = false;
    for (int i = 0; i < deliveredRequested.length; i++) {
      if (deliveredRequested[i].retailerName == retailerName) {
        List<ProductName> productNames = deliveredRequested[i].productName;
        for (ProductName product in productNames) {
          if (product.productName == productName) {
            hasProduct = true;
            break;
          }
        }
        break;
      } else {
        hasProduct = false;
        // return false ;
      }
    }
    return hasProduct;
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.black12,
            width: 1,
          )),
      child: ExpansionTile(
        controlAffinity: ListTileControlAffinity.platform,
        title: Text(retailerName),
        subtitle: Text(collectionDate),
        children: [
          for (int i = 0; i < orderRequests.length; i++)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Center(child: Text(orderRequests[i].productName)),
                            const SizedBox(
                              width: 100,
                            ),
                            const VerticalDivider(
                              thickness: 2,
                              width: 10,
                              color: Colors.grey,
                            ),
                            Text(orderRequests[i].quantity.toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    RequestedDropDown delivered = RequestedDropDown(
                        retailerName: retailerName,
                        productName: [orderRequests[i]]);

                    onTap(delivered);
                  },
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            color: !checkProduct(orderRequests[i].productName)
                                ? Colors.grey
                                : AppColors.buttonColor,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text("Delivered"),
                          ))),
                ),
              ],
            )
        ],
      ),
    ),
  );
}
