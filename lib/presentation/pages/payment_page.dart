import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/presentation/widgets/textformfeild.dart';
import 'package:salesforce/utils/app_colors.dart';

import '../widgets/deleteTheoryTestPopupWidget.dart';
import '../widgets/imageWidget.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<String> items = [
    'Cash on Delivery',
    'Debit Card',
    'Credit',
    'Online transation',
    'Cheque',
  ];

  File? image;

  Future pickImage() async {
    try {
      ImagePicker picker = ImagePicker();
      final image =
          await picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  TextEditingController _nameController = TextEditingController();
  final TextEditingController _textEditingController =
      TextEditingController();
  TextEditingController _imageInputController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(
          // icon: Icons.arrow_back_ios_new_outlined,
          navTitle: 'PAYMENT',
          context: context
          // backNavigate: () {
          //   Navigator.pop(context);
          // },
          ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                hintText: 'Name of Outlet',
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
                    hintText: 'Choose',
                    item: items),
              ),
              SizedBox(
                height: mediaQueryHeight * 0.04,
              ),
              const Text(
                'Upload Document of Transaction',
              ),
              SizedBox(
                height: mediaQueryHeight * 0.01,
              ),
              ImageWidget(pickImage, "This is image path",
                  _imageInputController),
              Spacer(),
              button(
                'Save Payment',
                () {
                  print(image!.path);
                  print(_textEditingController.text);
                  print(_nameController.text);
                },
                false,
                AppColors.buttonColor,
              ),
              SizedBox(
                height: mediaQueryHeight * 0.01,
              ),
              button(
                'Skip',
                () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        deleteTheoryTestPopupWidget(context),
                  );
                },
                false,
                AppColors.buttonColor,
              ),
            ]),
      ),
    );
  }
}
