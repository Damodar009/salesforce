import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import 'buttonWidget.dart';

Widget reportPopUp(BuildContext context) {
  return AlertDialog(
    insetPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 85,
    ),
    title: const Center(
      child: Text(
        'Report',
        style: TextStyle(fontSize: 20),
      ),
    ),
    content: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.checkIn, width: 2.0),
              ),
              fillColor: AppColors.checkIn,
              filled: true,
              hintText:
                  'Please full this with your Repot and try to rell it on details',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    30,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                color: AppColors.checkIn,
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width / 3.5,
                // child: Text('hellojhsdgfjkshfjkdshjk'),
              ),
              const SizedBox(
                width: 10,
              ),
              button('Report Submit', () {}, false, AppColors.primaryColor)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          button('Back', () {
            Navigator.of(context).pop();
          }, false, AppColors.buttonColor)
        ],
      ),
    ),
  );
}
