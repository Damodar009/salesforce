import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

Widget individualOrderDetail(String icon, String title, int number) {
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
              textInRow("outlet", ["RajKumar cold store"]),
              const SizedBox(
                height: 10,
              ),
              textInRow(
                  "order", ["Rc cola 500", "other product ", "other product"]),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.buttonColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Location"),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Barahi,kathmandu,Nepal ")
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Total : Rs 1231213",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor),
                ),
              )
            ],
          ),
        )),
  );
}

Widget textInRow(String leadingText, List<String> outlet) {
  return Row(
    children: [
      Text(
        "$leadingText: ",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        width: 50,
      ),
      Column(
        children: [for (var i = 0; i < outlet.length; i++) Text(outlet[i])],
      )
    ],
  );
}
