import 'package:flutter/material.dart';

import '../../domain/entities/sales.dart';
import '../../utils/app_colors.dart';

Widget individualOrderDetail(String outlet, List<Sales> sales) {
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
                    "Outlet",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(outlet)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              textInRow("Order", sales),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        )),
  );
}

Widget textInRow(String leadingText, List<Sales> outlet) {
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
        children: [
          for (var i = 0; i < outlet.length; i++) Text(outlet[i].product)
        ],
      )
    ],
  );
}
