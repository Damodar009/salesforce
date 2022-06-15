import 'package:flutter/material.dart';
import 'package:salesforce/utils/app_colors.dart';

Widget cancleWidget(Function() onClick) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: InkWell(
      onTap: onClick,
      child: Container(
        height: 25,
        width: 25,
        color: AppColors.buttonColor,
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.orange),
        //   shape: BoxShape.rectangle,
        // ),
        child: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget circleContainer() {
  return Padding(
    padding: const EdgeInsets.only(left: 4.0),
    child: Container(
      height: 40,
      width: 37,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.delete,
        size: 20,
        color: AppColors.buttonColor,
      ),
    ),
  );
}

Widget title(String title) {
  return Text(title);
}

Widget titles(String title) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}

// Widget returnsWidget(BuildContext context, Function() cancleWidgetOnClick) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Spacer(),
//           titles("Return"),
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.36,
//           ),
//           cancleWidget(() {
//             cancleWidgetOnClick;
//           }),
//         ],
//       ),
//       const SizedBox(
//         height: 12,
//       ),
//       //todo if empty show 1 else list length
//       for (var i = 0; i < returnLength + 1; i++)
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13.0),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: Colors.grey),
//               shape: BoxShape.rectangle,
//             ),
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   title("Product Name"),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   textFeildWithDropDownFor(
//                       validator: (string) {},
//                       item: productName,
//                       onselect: (string) {
//                         setState(() {
//                           if (checkIndex(returnParentProduct, i)) {
//                             returnParentProduct[i] = string;
//                             print(returnParentProduct[i]);
//                           } else {
//                             returnParentProduct.add(string);
//                           }
//                         });
//                       },
//                       initialText: checkIndex(returnParentProduct, i)
//                           ? returnParentProduct[i]
//                           : ""),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   title("Types of Product"),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Row(
//                     children: [
//                       SizedBox(
//                           width: 150,
//                           //todo unchanged
//                           child: textFeildWithDropDownFor(
//                               validator: (string) {},
//                               item: checkIndex(returnParentProduct, i)
//                                   ? getChildProducts(returnParentProduct[i])
//                                   : [],
//                               onselect: (string) {
//                                 print(string);
//                                 setState(() {
//                                   if (checkIndex(returns, i)) {
//                                     returns[i].setProduct(string);
//                                   } else {
//                                     RerturnAndSale returna = RerturnAndSale();
//                                     returna.setProduct(string);
//
//                                     returns.add(returna);
//                                   }
//                                 });
//                               },
//                               initialText: checkIndex(returns, i)
//                                   ? returns[i].getProduct() ?? ""
//                                   : "")),
//                       SizedBox(
//                         width: 130,
//                         child: textFormFeildIncreAndDecre(
//                             validator: (string) {},
//                             initialValue: checkIndex(returns, i)
//                                 ? returns[i].getReturn() != null
//                                     ? returns[i].getReturn().toString()
//                                     : ""
//                                 : "",
//                             onChanged: (string) {
//                               if (checkIndex(returns, i)) {
//                                 returns[i].setReturn(int.parse(string!));
//                               } else {
//                                 RerturnAndSale returna = RerturnAndSale();
//                                 returna.setReturn(int.parse(string!));
//
//                                 returns.add(returna);
//                               }
//                             }),
//                       ),
//                       InkWell(
//                           onTap: () {
//                             if (returns.isNotEmpty) {
//                               setState(() {
//                                 if (checkIndex(returns, i)) {
//                                   print("this is index at $i for remove ");
//                                   print(returns[i].getProduct());
//                                   print(returns[i].getReturn());
//
//                                   setState(() {
//                                     returnParentProduct.removeAt(i);
//                                     returns.removeAt(i);
//                                     returnLength = returns.length;
//                                   });
//                                   print(returnParentProduct.length);
//                                   print(returns.length);
//                                 } else {
//                                   returnLength = returnLength - 1;
//                                 }
//                               });
//                             } else {
//                               print("no way what");
//                               returnLength = returns.length;
//                             }
//                           },
//                           child: circleContainer())
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       textButton("Add more Products", textbuttonSize!, false, () {
//         setState(() {
//           print("the return length ${returns.length}");
//
//           returnLength = returns.length;
//           print(returns);
//         });
//       }),
//       const SizedBox(
//         height: 12,
//       ),
//       textFeildWithMultipleLines(
//           hintText: 'Remarks',
//           controller: _returnRemarks,
//           validator: (string) {
//             Validators.validator(string);
//           })
//     ],
//   );
// }
//
// // setState(() {
// // returnPressed = false;
// // });
