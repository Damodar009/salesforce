import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salesforce/domain/entities/paymentType.dart';
import 'package:salesforce/presentation/blocs/newOrdrBloc/new_order_cubit.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/presentation/widgets/createExcelFile.dart';
import 'package:salesforce/utils/app_colors.dart';
import 'package:salesforce/utils/dataChecker.dart';
import '../../domain/entities/SalesData.dart';
import '../../domain/entities/sales.dart';
import '../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../injectable.dart';
import '../../routes.dart';
import '../../utils/hiveConstant.dart';
import '../widgets/delete_theory_testPopup_widget.dart';
import '../widgets/dropdown_search_widget.dart';
import '../widgets/imageWidget.dart';
import '../widgets/visitedOutletWidget.dart';
import 'newOrderPage/returnAndSale.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var useCaseHiveData = getIt<UseCaseForHiveImpl>();
  DataChecker dataChecker = DataChecker();

  List<String> paymentTypeName = [];
  List<String> paymentTypeId = [];

  File? image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final TextEditingController _imageInputController = TextEditingController();

  // todo don't repeat same function merge with merchandise support page
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
      if (kDebugMode) {
        print("Failed to pick image $e");
      }
    }
  }

//todo merge with payment type
  getPaymentTypeFromHive() async {
    Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    // List<dynamic> ca = box.keys.toList();
    // var sa = box.get("merchandise");
    PaymentType paymentType;
    var successOrFailed =
        useCaseHiveData.getValuesByKey(box, HiveConstants.paymentTypeKey);
    successOrFailed.fold(
        (l) => {print("getting merchandise from hive is failed ")},
        (r) => {
              for (var i = 0; i < r.length; i++)
                {
                  paymentType = r[i],
                  paymentTypeName.add(paymentType.payment_type),
                  paymentTypeId.add(paymentType.key),
                }
            });
  }

  String getIdFromName(String name) {
    return paymentTypeId[paymentTypeName.indexOf(name)];
  }

  @override
  void initState() {
    getPaymentTypeFromHive();
    super.initState();
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
            child: dropDownSearchWidget(paymentTypeName, _nameController.text,
                (string) {
              setState(() {
                _nameController.text = string!;
              });
            }),
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
                        if (_nameController.text == "" &&
                            _imageInputController.text == "") {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => popupWidget(
                                      context,
                                      "You have not filled payment detail.Do you want to fill?",
                                      "Yes",
                                      "No", () {
                                    Navigator.of(context).pop();
                                  }, () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushNamed(
                                        Routes.merchandiseSupportScreen);
                                  }));
                        } else {
                          late SalesData sales;
                          if (newOrderCubit.state is NewOrderLoaded) {
                            Object? sdm = newOrderCubit.state.props[0];
                            if (sdm is SalesData) {
                              sales = sdm;

                              SalesData model = sales.copyWith(
                                  paymentType:
                                      getIdFromName(_nameController.text),
                                  paymentdocument: image!.path);
                              newOrderCubit.getOrders(model);

                              // ExcelFile.generateExcel(model, "newOrder");

                              Navigator.of(context)
                                  .pushNamed(Routes.merchandiseSupportScreen);
                            }
                          }
                        }
                      }),
              ],
            ),
          ),
          const Spacer(),
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

                          if (newOrderCubit.state is NewOrderLoaded) {
                            Object? sdm = newOrderCubit.state.props[0];
                            if (sdm is SalesData) {
                              sales = sdm;

                              //  ExcelFile.generateExcel(sales, "newOrder");
                              newOrderCubit.saveSalesDataToHive(sales);
                              dataChecker.setLocalDataChecker(true);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => VisitedOutletWidget(
                                        visitedOutlets: visitedOutlets,
                                      )));
                            }
                          }
                        }, () {
                          Navigator.of(context).pop();
                        }));
              } else {
                late SalesData sales;
                if (newOrderCubit.state is NewOrderLoaded) {
                  Object? sdm = newOrderCubit.state.props[0];
                  if (sdm is SalesData) {
                    sales = sdm;

                    SalesData model = sales.copyWith(
                        paymentType: _paymentController.text,
                        paymentdocument: image!.path);
                    newOrderCubit.getOrders(model);
                    // JsonFile.writeJson(_controllerKey.text, _controllerValue.text);
                    //    ExcelFile.generateExcel(model, "newOrder");
                    newOrderCubit.saveSalesDataToHive(model);
                    dataChecker.setLocalDataChecker(true);
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
