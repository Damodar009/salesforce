import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salesforce/utils/app_colors.dart';

Widget imagePickerWidget(BuildContext context, String title, IconData icon) {
  return InkWell(
    onTap: () {
      ImagePicker();
    },
    child: Container(
      color: AppColors.checkIn,
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.width / 3.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.image,
          ),
          Container(
            child: const Text(
              'Upload image of Proof.',
            ),
          ),
        ],
      ),
    ),
  );  
}
