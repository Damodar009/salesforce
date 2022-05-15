import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/app_colors.dart';
import 'buttonWidget.dart';

Widget reportPopUp({required BuildContext context}) {
  return AlertDialog(
    insetPadding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 85,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            child: const TextField(
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
                hintStyle: TextStyle(color: AppColors.textColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      30,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  final ImagePicker _picker = ImagePicker();
                  final PickedFile? photo = await _picker.getImage(
                      source: ImageSource.camera, imageQuality: 10);
                  if (photo != null) {
                    print(photo.path);
                    // rideController.uploadImage(photo.path, photo.name, index);
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.checkIn,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        spreadRadius: 1,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.amber,
                        ),
                        child: const Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Center(
                        child: Text(
                          'Upload any image or any other proof',
                          style: TextStyle(color: AppColors.textColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                    // width: 100,
                    child: button(
                        'Report Submit', () {}, false, AppColors.primaryColor)),
              )
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
