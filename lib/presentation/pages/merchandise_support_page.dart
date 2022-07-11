import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salesforce/data/models/merchandiseOrderModel.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/utils/app_colors.dart';
import 'package:salesforce/utils/dataChecker.dart';
import '../../domain/entities/SalesData.dart';
import '../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../routes.dart';
import '../../utils/hiveConstant.dart';
import '../blocs/newOrdrBloc/new_order_cubit.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/dropdown_search_widget.dart';
import '../widgets/imageWidget.dart';
import '../widgets/textformfeild.dart';
import '../widgets/visitedOutletWidget.dart';

//todo grt merchant from merchant drop down
class MerchandiseSupportScreen extends StatefulWidget {
  const MerchandiseSupportScreen({Key? key}) : super(key: key);

  @override
  State<MerchandiseSupportScreen> createState() =>
      _MerchandiseSupportScreenState();
}

class _MerchandiseSupportScreenState extends State<MerchandiseSupportScreen> {
  final TextEditingController _typesOfMerchandiseSupport =
      TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _imageInputController = TextEditingController();

  var useCaseHiveData = getIt<UseCaseForHiveImpl>();
  DataChecker dataChecker = DataChecker();
  late String merchantTypeId;
  List<String> merchandiseName = [];
  List<String> merchandiseId = [];
  File? image;

  Future pickImage() async {
    try {
      ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => {
            _imageInputController.text = image.name,
            this.image = imageTemporary
          });
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  clear() {
    _typesOfMerchandiseSupport.clear();
    _reasonController.clear();
  }

  getMerchantDropDownFromHive() async {
    Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    List<dynamic> ca = box.keys.toList();
    var sa = box.get("merchandise");

    var successOrFailed =
        useCaseHiveData.getValuesByKey(box, HiveConstants.merchandiseKey);
    successOrFailed.fold(
        (l) => {print("getting merchandise from hive is failed ")},
        (r) => {
              for (var i = 0; i < r.length; i++)
                {
                  merchandiseName.add(r[i].name),
                  merchandiseId.add(r[i].id),
                }
            });
  }

  @override
  void initState() {
    getMerchantDropDownFromHive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double heightBetweenTextField = mediaQueryHeight * 0.02;

    var newOrderCubit = BlocProvider.of<NewOrderCubit>(context);

    return Scaffold(
      appBar: appBar(navTitle: 'MERCHANDISE SUPPORT', context: context),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Types'),
              SizedBox(
                height: heightBetweenTextField,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: dropDownSearchWidget(
                    merchandiseName, _typesOfMerchandiseSupport.text, (string) {
                  setState(() {
                    _typesOfMerchandiseSupport.text = string!;
                  });
                }),
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
              ImageWidget(pickImage, "Upload Image", _imageInputController),
              const Spacer(),
              // Divider(),
              button(
                'Save',
                () {
                  if (image != null &&
                      _reasonController.text != "" &&
                      _typesOfMerchandiseSupport.text != "") {
                    MerchandiseOrderModel merchandiseOrderModel;
                    late SalesData sales;
                    if (newOrderCubit.state is NewOrderLoaded) {
                      Object? sdm = newOrderCubit.state.props[0];
                      if (sdm is SalesData) {
                        sales = sdm;
                        int index = merchandiseName
                            .indexOf(_typesOfMerchandiseSupport.text);
                        String merchandise = merchandiseId[index];

                        merchandiseOrderModel = MerchandiseOrderModel(
                            image: image!.path,
                            description: _reasonController.text,
                            merchandise_id: merchandise);

                        SalesData salesData = sales.copyWith(
                            merchandiseOrderPojo: merchandiseOrderModel);

                        newOrderCubit.getOrders(salesData);

                        newOrderCubit.saveSalesDataToHive(salesData);
                        dataChecker.setLocalDataChecker(true);

                        newOrderCubit.setInitialState();

                        final VistedOutlets visitedOutlets = VistedOutlets(
                          navTitle: 'TOTAL',
                          imageUrl: 'assets/images/total_order_complete.png',
                          bodyTitle: 'Order Confirmed!',
                          bodySubTitle:
                              'Your order has been confirmed, Order will send to distributor.',
                          buttonText: 'Go to Home',
                        );
                        Navigator.of(context).pushReplacementNamed(
                            Routes.visitedOutlets,
                            arguments: visitedOutlets);
                      }
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please fill all form",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColors.primaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }

                  // clear();
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
                  late SalesData sales;
                  if (newOrderCubit.state is NewOrderLoaded) {
                    Object? sdm = newOrderCubit.state.props[0];
                    if (sdm is SalesData) {
                      sales = sdm;
                      newOrderCubit.saveSalesDataToHive(sales);
                      newOrderCubit.setInitialState();
                      final VistedOutlets visitedOutlets = VistedOutlets(
                        navTitle: 'TOTAL',
                        imageUrl: 'assets/images/total_order_complete.png',
                        bodyTitle: 'Order Confirmed!',
                        bodySubTitle:
                            'Your order has been confirmed, Order will send to distributor.',
                        buttonText: 'Go to Home',
                      );

                      Navigator.of(context).pushReplacementNamed(
                          Routes.visitedOutlets,
                          arguments: visitedOutlets);
                    }
                  }
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
