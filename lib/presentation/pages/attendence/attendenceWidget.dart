import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

Widget attendenceWidget(
  BuildContext context,
) {
  DateTime dataeTime = DateTime.now();
  return Container(
      height: 280,
      width: 200,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
        color: AppColors.checkIn,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 30,
                  color: AppColors.buttonColor,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Attendence",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 12,
            ),
            customText("today:${dataeTime.day},may\n${dataeTime.year}"),
            const SizedBox(
              height: 12,
            ),
            customText(
                "checkin time: \n ${dataeTime.hour}:${dataeTime.minute}"),
            const SizedBox(
              height: 12,
            ),
            customText("Address:Kathmandu,Nepal"),
          ],
        ),
      ));
}

Widget customText(String text) {
  return Text(text,
      textAlign: TextAlign.center, style: const TextStyle(fontSize: 14));
}
