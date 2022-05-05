import 'package:flutter/material.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/presentation/widgets/textformfeild.dart';
import 'package:salesforce/utils/app_colors.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    final TextEditingController _textEditingController =
        TextEditingController();

    double mediaQueryHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(
        icon: Icons.arrow_back_ios_new_outlined,
        navTitle: 'PAYMENT',
       backNavigate: () { Navigator.pop(context); }
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Name of Outlet',
          ),
          SizedBox(
            height: mediaQueryHeight * 0.01,
          ),
          textFormField(
            obsecureText: false,
            showObsecureIcon: false,
            validator: (value) {},
            controller: _nameController,
            hintText: 'Framk Miller',
            obsecureText1: () {},
          ),
          SizedBox(
            height: mediaQueryHeight * 0.04,
          ),
          const Text(
            'Payment Types',
          ),
          SizedBox(
            height: mediaQueryHeight * 0.01,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: textFeildWithDropDown(
                controller: _textEditingController,
                validator: (string) {},
                hintText: 'Frank miller '),
          ),
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
