import 'package:flutter/material.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/utils/app_colors.dart';

import '../widgets/appBarWidget.dart';
import '../widgets/textformfeild.dart';

class MerchandiseSupportScreen extends StatelessWidget {
  const MerchandiseSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    final TextEditingController _textEditingController =
        TextEditingController();

    double mediaQueryHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(
        icon: Icons.arrow_back_ios_new_outlined,
        navTitle: 'MERCHANDISE SUPPORT',
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Types',
          ),
          SizedBox(
            height: mediaQueryHeight * 0.01,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: textFeildWithDropDown(
                controller: _textEditingController,
                validator: (string) {},
                hintText: 'Banner'),
          ),
          SizedBox(
            height: mediaQueryHeight * 0.04,
          ),
          textFeildWithMultipleLines(
              validator: (string) {},
              hintText: 'Reason',
              controller: _textEditingController),
          SizedBox(
            height: mediaQueryHeight * 0.04,
          ),
          const Text(
            'Upload Document of Transaction',
          ),
          Spacer(),
          button(
            'Save Payment',
            () {},
            false,
            AppColors.buttonColor,
          ),
          SizedBox(
            height: mediaQueryHeight * 0.01,
          ),
          button(
            'Skip',
            () {},
            false,
            AppColors.buttonColor,
          ),
        ]),
      ),
    );
  }
}
