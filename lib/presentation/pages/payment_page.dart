import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salesforce/data/models/SalesDataModel.dart';
import 'package:salesforce/presentation/blocs/newOrdrBloc/new_order_cubit.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/presentation/widgets/textformfeild.dart';
import 'package:salesforce/utils/app_colors.dart';
import '../../domain/entities/SalesData.dart';
import '../../routes.dart';
import '../widgets/deleteTheoryTestPopupWidget.dart';
import '../widgets/imageWidget.dart';
import '../widgets/visitedOutletWidget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final TextEditingController _imageInputController = TextEditingController();

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
    TextStyle defaultStyle =
        const TextStyle(color: Colors.grey, fontSize: 20.0);

    TextStyle linkStyle =
        const TextStyle(color: AppColors.buttonColor, fontSize: 23);

    var newOrderCubit = BlocProvider.of<NewOrderCubit>(context);

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
          BlocBuilder<NewOrderCubit, NewOrderState>(
            builder: (context, state) {
              if (state is NewOrderLoaded) {}
              return SizedBox(
                height: mediaQueryHeight * 0.01,
              );
            },
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
                        print("asdfadsfasdfasdf");
                        if (_paymentController.text == "" &&
                            _imageInputController.text == "") {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => popupWidget(
                                      context,
                                      "You have not filled payment detail.Do you want to fill?",
                                      "Yes",
                                      "No", () {
                                        print("inside yes");
                                    Navigator.of(context).pop();
                                  }, () {
                                print("inside yes");
                                    Navigator.of(context).pushNamed(
                                        Routes.merchandiseSupportScreen);
                                  }));
                        } else {
                          print("asdfadsfasdfasdf");
                          String awd = _paymentController.text;
                          print(awd);

                          //
                          // Navigator.of(context)
                          //     .pushNamed(Routes.merchandiseSupportScreen);
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
                            context,
                            "Do you want to continue without filling payment details ?",
                            "Yes",
                            "No", () {
                          Navigator.of(context).pop();
                          late SalesData sales;
                          print("its running");

                          if (newOrderCubit.state is NewOrderLoaded) {
                            Object? sdm = newOrderCubit.state.props[0];
                            if (sdm is SalesData) {
                              sales = sdm;
      
                              newOrderCubit.saveSalesDataToHive(sales);
                              //todo replacement
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => VisitedOutletWidget(
                                        visitedOutlets: visitedOutlets,
                                      )));
                            }
                          }
                        }, () {
                          Navigator.of(context).pop();
                        }));
      
                //todo show snackbar
      
              } else {
                late SalesData sales;
                print("tsisfasdf");

                if (newOrderCubit.state is NewOrderLoaded) {
                  Object? sdm = newOrderCubit.state.props[0];
                  if (sdm is SalesData) {
                    sales = sdm;
      
                    SalesData model = sales.copyWith(
                        paymentType: _paymentController.text,
                        paymentdocument: image!.path);
      
                    newOrderCubit.getOrders(model);
      
                    newOrderCubit.saveSalesDataToHive(model);
      
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VisitedOutletWidget(
                              visitedOutlets: visitedOutlets,
                            )));
                  }
                }
              }
            },
            false,
            AppColors.buttonColor,
          ),
          SizedBox(
            height: mediaQueryHeight * 0.03,
          ),
        ]),
      ),
    );
  }
}
