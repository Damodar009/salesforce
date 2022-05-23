import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/utils/app_colors.dart';

import '../../routes.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/imageWidget.dart';
import '../widgets/textformfeild.dart';

class MerchandiseSupportScreen extends StatefulWidget {
  MerchandiseSupportScreen({Key? key}) : super(key: key);

  @override
  State<MerchandiseSupportScreen> createState() =>
      _MerchandiseSupportScreenState();
}

class _MerchandiseSupportScreenState
    extends State<MerchandiseSupportScreen> {
  TextEditingController _typesOfMerchandiseSupport =
      TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  TextEditingController _imageInputController =
      TextEditingController();

  List<String> items = [
    'Banner',
    'Display',
    'Pharase',
    'T-shirt',
    'And more',
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

  clear() {
    _typesOfMerchandiseSupport.clear();
    _reasonController.clear();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double heightBetweenTextField = mediaQueryHeight * 0.02;

    return Scaffold(
      appBar: appBar(
          // icon: Icons.arrow_back_ios_new_outlined,
          navTitle: 'MERCHANDISE SUPPORT',
          context: context
          // backNavigate: () {
          //   Navigator.pop(context);
          // },
          ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Types'),
                  SizedBox(
                    height: heightBetweenTextField,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: textFeildWithDropDown(
                        controller: _typesOfMerchandiseSupport,
                        validator: (string) {},
                        hintText:
                            // widget.getProfileState.userDetail!.userDocument ??
                            "Choose",
                        item: items),
                  ),
                  SizedBox(
                    height: mediaQueryHeight * 0.04,
                  ),
                  textFeildWithMultipleLines(
                      validator: (string) {},
                      hintText: 'Reason',
                      controller: _reasonController),
                  SizedBox(
                    height: mediaQueryHeight * 0.04,
                  ),
                  const Text(
                    'Upload Document of Transaction',
                  ),
                  SizedBox(
                    height: mediaQueryHeight * 0.02,
                  ),
                  ImageWidget(pickImage, "This is image path",
                      _imageInputController),
                  const Spacer(),
                  // Divider(),
                  button(
                    'Save Payment',
                    () {
                      print('hello12345');
                      print(image!.path);
                      print(_reasonController.text);
                      print(_typesOfMerchandiseSupport.text);
                      clear();
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
                      print('hello12345');

                      Navigator.of(context)
                          .pushNamed(Routes.newOutletsRoute);
                      clear();
                    },
                    false,
                    AppColors.buttonColor,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
