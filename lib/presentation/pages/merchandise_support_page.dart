import 'package:flutter/material.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/utils/app_colors.dart';

import '../widgets/appBarWidget.dart';
import '../widgets/textformfeild.dart';

class MerchandiseSupportScreen extends StatelessWidget {
  MerchandiseSupportScreen({Key? key}) : super(key: key);

   List<String> items = [
    'Banner',
    'Display',
    'Pharase',
    'T-shirt',
    'And more',
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController _typesOfMerchandiseSupport = TextEditingController();
    final TextEditingController _reason =
        TextEditingController();

    double mediaQueryHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(
          icon: Icons.arrow_back_ios_new_outlined,
          navTitle: 'MERCHANDISE SUPPORT', backNavigate: () { Navigator.pop(context); }),
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
                controller: _typesOfMerchandiseSupport,
                validator: (string) {},
                hintText: 'Choose', item: items),
          ),
          SizedBox(
            height: mediaQueryHeight * 0.04,
          ),
          textFeildWithMultipleLines(
              validator: (string) {},
              hintText: 'Reason',
              controller: _reason),
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
