import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/presentation/widgets/textformfeild.dart';
import 'package:salesforce/utils/app_colors.dart';

import '../../routes.dart';
import '../widgets/deleteTheoryTestPopupWidget.dart';
import '../widgets/imageWidget.dart';
import '../widgets/visitedOutletWidget.dart';

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
  TextEditingController _nameController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  TextEditingController _imageInputController = TextEditingController();

  Future pickImage() async {
    try {
      ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        _imageInputController.text = image.name;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
    TextStyle linkStyle =
        const TextStyle(color: AppColors.buttonColor, fontSize: 23);

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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // const Text(
          //   'Name of Outlet',
          // ),
          // SizedBox(
          //   height: mediaQueryHeight * 0.01,
          // ),
          // textFormField(
          //   obsecureText: false,
          //   showObsecureIcon: false,
          //   validator: (value) {},
          //   controller: _nameController,
          //   hintText: 'Name of Outlet',
          //   obsecureText1: () {},
          // ),
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
                controller: _paymentController,
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
          ImageWidget(pickImage, "image", _imageInputController),

          SizedBox(
            height: mediaQueryHeight * 0.2,
          ),

          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'Do you want merchandise support?',
                    style: defaultStyle),
                TextSpan(
                    text: ' Okay',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (_paymentController.text == "" &&
                            _imageInputController.text == "") {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => popupWidget(
                                  context,
                                  "You havenot completly filled a form ?"));
                        } else {
                          print("this is running");
                          String awd = _paymentController.text;
                          print(awd);
                          print(_imageInputController.text.length);
                          //todo save payment
                          Navigator.of(context)
                              .pushNamed(Routes.merchandiseSupportScreen);
                        }
                      }),
              ],
            ),
          ),

          Spacer(),
          button(
            'Save Payment',
            () {
              final VistedOutlets visitedOutlets = VistedOutlets(
                navTitle: 'TOTAL',
                imageUrl: 'assets/images/total_order_complete.png',
                bodyTitle: 'Order Confirmed!',
                bodySubTitle:
                    'Your order has been confirmed, Order will send to distributor.',
                buttonText: 'Go to Home',
              );

              if (_paymentController.text == "" &&
                  _imageInputController.text == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => popupWidget(
                        context, "You havenot completly filled a form ?"));
              } else {
                print("this is running");
                String awd = _paymentController.text;
                print(awd);
                print(_imageInputController.text.length);
                //todo save payment
                Navigator.of(context).pushNamed(Routes.visitedOutlets,
                    arguments: visitedOutlets);
              }

              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => VisitedOutletWidget(
              //           visitedOutlets: visitedOutlets,
              //         )));

              print(image!.path);
              print(_paymentController.text);
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
                builder: (BuildContext context) => popupWidget(
                    context, "Are you sure you want to skip Payment ?"),
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
