import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:salesforce/data/models/Userdata.dart';
import 'package:salesforce/domain/entities/availability.dart';
import 'package:salesforce/domain/entities/returns.dart';
import 'package:salesforce/presentation/blocs/newOrdrBloc/new_order_cubit.dart';
import 'package:salesforce/presentation/pages/newOrderPage/returnAndSale.dart';
import 'package:salesforce/presentation/pages/newOrderPage/widgets/newOutletsPage.dart';
import 'package:salesforce/presentation/pages/newOrderPage/widgets/wid.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/routes.dart';
import 'package:salesforce/utils/geolocation.dart';
import '../../../data/datasource/local_data_sources.dart';
import '../../../data/models/AvailabilityModel.dart';
import '../../../data/models/RetailerModel.dart';
import '../../../data/models/SalesModel.dart';
import '../../../data/models/returnModel.dart';
import '../../../domain/entities/SalesData.dart';
import '../../../domain/entities/sales.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../injectable.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/hiveConstant.dart';
import '../../../utils/validators.dart';
import '../../widgets/buttonWidget.dart';
import '../../widgets/textformfeild.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({Key? key}) : super(key: key);

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  var sharedPreference = getIt<SignInLocalDataSource>();
  String nameOfOutlet = "";
  bool loading = false;

  ///availability
  List<OrderAvailability> availability = [];

  //list for getting value
  List<RerturnAndSale> sales = [];
  List<RerturnAndSale> returns = [];

  ////end here
  List<String> productName = [];
  List<String> returnParentProduct = [];
  List<String> availabilityParentProduct = [];
  List<String> salesParentProduct = [];
  List<dynamic> products = [];

  ///retailer
  List<String> retailerList = [];
  List<String> retailerIdList = [];

  String dropdownvalue = '';
  double? textbuttonSize;
  double? boolbuttonSize;

  final TextEditingController _returnRemarks = TextEditingController();
  final TextEditingController _salesRemarks = TextEditingController();
  final TextEditingController _availabilityRemarks = TextEditingController();

  bool outletsCreated = true;

  // to show the items full view
  bool returnPressed = false;
  bool availabilityPressed = false;
  bool salesPressed = false;

  // length of these widgets list
  late int returnLength;
  late int availabilityLength;
  late int salesLength;
  int _counter = 0;

  List<String> returnProductNames = [];

  bool checkIndex(List as, int i) {
    return as.asMap().containsKey(i);
  }

  //get types of product from parent products

  List<String> getChildProducts(String parentProduct) {
    List<String> childProducts = [];
    for (var i = 0; i < products.length; i++) {
      if (products[i].name == parentProduct) {
        for (var j = 0; j < products[i].childProducts.length; j++) {
          childProducts.add(products[i].childProducts[j]["name"]);
        }
      }
    }
    return childProducts;
  }

  getRetailerList() async {
    Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    var successOrNot = useCaseForHiveImpl.getValuesByKey(
        box, HiveConstants.retailerDropdownKey);
    successOrNot.fold(
        (l) => {print("no success")},
        (r) => {
              for (var i = 0; i < r.length; i++)
                {
                  print(r[i].id),
                  print(r[i].name),
                  retailerList.add(r[i].name),
                  retailerIdList.add(r[i].id),
                },
            });
  }

  void incrementReturn(String value) {
    int incNumber = int.parse(value);
    print("inc button is clicked");
    setState(() {
      incNumber++;
    });

    print(incNumber);
  }

  void decrementNumber() {
    setState(() {
      _counter--;
    });
  }

  @override
  void initState() {
    getRetailerList();
    getProductsFromHiveBox();
    super.initState();
  }

  getProductsFromHiveBox() async {
    Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    var sucessOrNot = useCaseForHiveImpl.getValuesByKey(
      box,
      HiveConstants.productKey,
    );
    sucessOrNot.fold(
        (l) => {print("no success")},
        (r) => {
              products = r,
              for (var i = 0; i < products.length; i++)
                {
                  productName.add(products[i].name),
                },
            });
  }

  @override
  Widget build(BuildContext context) {
    textbuttonSize = MediaQuery.of(context).size.width * 0.9;
    boolbuttonSize = MediaQuery.of(context).size.width * 0.2;
    var newOrderCubit = BlocProvider.of<NewOrderCubit>(context);

    Widget newOrderScreenBody() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocBuilder<NewOrderCubit, NewOrderState>(
            builder: (context, state) {
              if (state is NewRetailerCreated) {
                return const SizedBox();
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title("Name of Outlet"),
                    const SizedBox(
                      height: 12,
                    ),
                    textFeildWithDropDownFor(
                        validator: (string) {},
                        item: retailerList,
                        onselect: (string) {
                          setState(() {
                            nameOfOutlet = string;
                          });
                        },
                        initialText: nameOfOutlet),
                  ],
                );
              }
            },
          ),
          const SizedBox(
            height: 35,
          ),
          returnPressed
              ? returnsWidget()
              : textButton(
                  "Return", MediaQuery.of(context).size.width * 0.9, true, () {
                  setState(() {
                    returnLength = returns.length;
                    returnPressed = true;
                    availabilityPressed = false;
                    salesPressed = false;
                  });
                }),
          const SizedBox(
            height: 15,
          ),
          availabilityPressed
              ? availabilityWidget()
              : textButton(
                  "Availability", MediaQuery.of(context).size.width * 0.9, true,
                  () {
                  setState(() {
                    availabilityLength = availability.length;
                    returnPressed = false;
                    availabilityPressed = true;
                    salesPressed = false;
                  });
                }),
          const SizedBox(
            height: 15,
          ),
          salesPressed
              ? salesWidget()
              : textButton("Sales", textbuttonSize!, true, () {
                  setState(() {
                    returnPressed = false;
                    availabilityPressed = false;
                    salesPressed = true;
                    salesLength = sales.length;
                  });
                }),
          const SizedBox(
            height: 12,
          ),
          button("Save Order", () async {
            if (returns.isNotEmpty ||
                availability.isNotEmpty ||
                sales.isNotEmpty) {
              setState(() {
                loading = true;
              });

              List<Sales> salessPojo = [];
              List<Returns> returnspojo = [];
              List<Availability> availabilityPojo = [];
              for (var i = 0; i < returns.length; i++) {
                ReturnsModel returnsmodel = ReturnsModel(
                    returned: returns[i].getReturn(),
                    product: returns[i].getProduct());
                returnspojo.add(returnsmodel);

                print(returnspojo[i]);
              }
              for (var i = 0; i < availability.length; i++) {
                AvailabilityModel availabilityx = AvailabilityModel(
                    availability: availability[i].getavailability(),
                    stock: availability[i].getStock() ?? 0,
                    product: availability[i].getproduct());
                availabilityPojo.add(availabilityx);
                print(availabilityPojo[i]);
              }
              for (var i = 0; i < sales.length; i++) {
                SalesModel salesmodel = SalesModel(
                    sales: sales[i].getReturn(),
                    product: sales[i].getProduct());
                salessPojo.add(salesmodel);
                print(salessPojo[i]);
              }

              SalesData salesDataModel;
              GeoLocationData geoLocationData = GeoLocationData();
              Position? position = await geoLocationData.getCurrentLocation();
              double latitude = position!.latitude;
              double longitude = position.longitude;
              DateTime dateTimeNow = DateTime.now();

              String assignedDepots = "";
              String userId = "";
              Box box = await Hive.openBox(HiveConstants.attendence);
              var failureOrsucess = useCaseForHiveImpl.getValuesByKey(
                  box, HiveConstants.assignedDepot);

              failureOrsucess.fold(
                  (l) => {
                        //box.close(),
                        print("this is failed")
                      },
                  (r) => {
                        //box.close(),

                        assignedDepots = r[0]
                      });

              UserDataModel? userDataModel =
                  await sharedPreference.getUserDataFromLocal();
              if (userDataModel != null) {
                userId = userDataModel.userid!;
              }

              if (newOrderCubit.state is NewRetailerCreated) {
                Object? sdm = newOrderCubit.state.props[0];
                RetailerModel retailerModel;
                if (sdm is RetailerModel) {
                  retailerModel = sdm;

                  salesDataModel = SalesData(
                      sales: salessPojo,
                      returns: returnspojo,
                      availability: availabilityPojo,
                      salesDescription: _salesRemarks.text,
                      returnedDescription: _returnRemarks.text,
                      availabilityDescription: _availabilityRemarks.text,
                      userId: userId,
                      assignedDepot: assignedDepots,
                      longitude: longitude,
                      collectionDate: dateTimeNow.toString(),
                      latitude: latitude,
                      retailerPojo: retailerModel);
                  newOrderCubit.getOrders(salesDataModel);
                  setState(() {
                    loading = false;
                  });

                  Navigator.of(context).pushNamed(Routes.paymentScreen);
                  print("not okay");
                }
              } else {
                if (nameOfOutlet != "") {
                  int index = retailerList.indexOf(nameOfOutlet);
                  String retailerId = retailerIdList[index];
                  salesDataModel = SalesData(
                      sales: salessPojo,
                      returns: returnspojo,
                      availability: availabilityPojo,
                      salesDescription: _salesRemarks.text,
                      returnedDescription: _returnRemarks.text,
                      availabilityDescription: _availabilityRemarks.text,
                      retailer: retailerId,
                      userId: userId,
                      assignedDepot: assignedDepots,
                      longitude: longitude,
                      collectionDate: dateTimeNow.toString(),
                      latitude: latitude);
                  newOrderCubit.getOrders(salesDataModel);

                  setState(() {
                    loading = false;
                  });

                  Navigator.of(context).pushNamed(Routes.paymentScreen);
                  print("not okay");
                } else {
                  Fluttertoast.showToast(
                      msg: "Outlet is not selected",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  setState(() {
                    loading = false;
                  });
                }
              }
            } else {
              print("toasr");
              //TODO show SNACKBAR

              Fluttertoast.showToast(
                  msg: "There is no valid order",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  fontSize: 16.0);

              setState(() {
                loading = false;
              });
            }
          }, loading, AppColors.buttonColor),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 10,
          )
        ],
      );
    }

    return Scaffold(
      appBar: appBar(
          navTitle: 'NEW ORDER',
          // icon: Icons.arrow_back,
          context: context,
          settingTitle: "",
          settingIcon: const SizedBox()
          // backNavigate: () {}
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: Column(
                  children: [
                    BlocBuilder<NewOrderCubit, NewOrderState>(
                      builder: (context, state) {
                        if (state is NewRetailerCreated) {
                          return const SizedBox();
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Outlets already created',
                                style: TextStyle(color: Color(0xFF003049)),
                              ),
                              StatefulBuilder(builder: (context, setStat) {
                                return Checkbox(
                                    value: outletsCreated,
                                    activeColor: AppColors.buttonColor,
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => AppColors.buttonColor),
                                    onChanged: (newValue) {
                                      print(newValue);
                                      setStat(() {
                                        outletsCreated = newValue!;
                                      });
                                      setState(() {
                                        outletsCreated = newValue!;
                                      });
                                    });
                              }),
                            ],
                          );
                        }
                      },
                    ),
                    BlocBuilder<NewOrderCubit, NewOrderState>(
                        builder: (context, state) {
                      if (state is NewRetailerCreated) {
                        return newOrderScreenBody();
                      } else {
                        return outletsCreated
                            ? newOrderScreenBody()
                            : const NewOutletsScreenOrder();
                      }
                    }),
                  ],
                )),
          );
        }),
      ),
    );
  }

  Widget title(String title) {
    return Text(title);
  }

  Widget titles(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget textButton(String title, double width, bool isbold, Function() onClick,
      {Color? color}) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: width,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primaryColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Center(
            child: isbold
                ? Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )
                : Text(
                    title,
                    style: const TextStyle(fontSize: 16),
                  ),
          ),
        ),
      ),
    );
  }

  ///sales
  Widget salesWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            titles("Sales"),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.36,
            ),
            cancleWidget(() {
              setState(() {
                salesPressed = false;
              });
            }),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        for (var i = 0; i < salesLength + 1; i++)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title("Product Name"),
                    const SizedBox(
                      height: 12,
                    ),
                    textFeildWithDropDownFor(
                        validator: (string) {},
                        item: productName,
                        onselect: (string) {
                          setState(() {
                            if (checkIndex(salesParentProduct, i)) {
                              salesParentProduct[i] = string;
                              print(salesParentProduct[i]);
                            } else {
                              salesParentProduct.add(string);
                            }
                          });
                        },
                        initialText: checkIndex(salesParentProduct, i)
                            ? salesParentProduct[i]
                            : ""),
                    const SizedBox(
                      height: 12,
                    ),
                    title("Types of Product"),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [

                           textFeildWithDropDownFor(
                              validator: (string) {},
                              item: checkIndex(salesParentProduct, i)
                                  ? getChildProducts(salesParentProduct[i])
                                  : [],
                              // incrementReturn;
                              onselect: (string) {
                                setState(() {
                                  if (checkIndex(sales, i)) {
                                    sales[i].setProduct(string);
                                  } else {
                                    RerturnAndSale saless = RerturnAndSale();
                                    saless.setProduct(string);

                                    sales.add(saless);
                                  }
                                });
                              },
                              initialText: checkIndex(sales, i)
                                  ? sales[i].getProduct() ?? ""
                                  : ""
                                  ),

                        SizedBox(
                          width: 130,
                          child: textFormFeildIncreAndDecre(
                              validator: (string) {},
                              initialValue: checkIndex(sales, i)
                                  ? sales[i].getReturn() != null
                                      ? sales[i].getReturn().toString()
                                      : ""
                                  : "",
                              onChanged: (string) {
                                setState(() {
                                  print(string);

                                  print("increment number is clicked");
                                  if (checkIndex(sales, i)) {
                                    sales[i].setReturn(int.parse(string!));
                                  } else {
                                    RerturnAndSale saless = RerturnAndSale();
                                    saless.setReturn(int.parse(string!));

                                    sales.add(saless);
                                  }
                                });
                              }),
                        ),
                        InkWell(
                            onTap: () {
                              print("the delete is clicked");
                              print("weewewe $i");
                              setState(() {
                                if (sales.isNotEmpty) {
                                  print("this is niot what i want");
                                  setState(() {
                                    if (checkIndex(sales, i)) {
                                      salesParentProduct.removeAt(i);
                                      sales.removeAt(i);
                                      salesLength = sales.length;
                                    } else {
                                      salesLength = salesLength - 1;
                                    }
                                  });
                                } else {
                                  print("no way what");
                                  salesLength = sales.length;
                                }
                              });
                            },
                            child: circleContainer())
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        textButton("Add more Products", textbuttonSize!, false, () {
          setState(() {
            print("the return length ${sales.length}");

            salesLength = sales.length;
            print(sales);
          });
        }),
        const SizedBox(
          height: 12,
        ),
        textFeildWithMultipleLines(
            hintText: 'Remarks',
            controller: _salesRemarks,
            validator: (string) {
              Validators.validator(string);
            })
      ],
    );
  }

  Widget availabilityWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            titles("Availability"),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.27,
            ),
            cancleWidget(() {
              setState(() {
                availabilityPressed = false;
              });
            }),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        for (var i = 0; i < availabilityLength + 1; i++)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title("Product Name"),
                    const SizedBox(
                      height: 12,
                    ),
                    textFeildWithDropDownFor(
                        validator: (string) {},
                        item: productName,
                        onselect: (string) {
                          setState(() {
                            if (checkIndex(availabilityParentProduct, i)) {
                              availabilityParentProduct[i] = string;
                              print(availabilityParentProduct[i]);
                            } else {
                              availabilityParentProduct.add(string);
                            }
                          });
                        },
                        initialText: checkIndex(availabilityParentProduct, i)
                            ? availabilityParentProduct[i]
                            : "choose"),
                    const SizedBox(
                      height: 12,
                    ),
                    // title("Types of Product"),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    // textFeildWithDropDownFor(
                    //     validator: (string) {},
                    //     item: checkIndex(availabilityParentProduct, i)
                    //         ? getChildProducts(availabilityParentProduct[i])
                    //         : items,
                    //     onselect: (string) {
                    //       setState(() {
                    //         if (checkIndex(availability, i)) {
                    //           availability[i].setproduct(string);
                    //         } else {
                    //           //todo
                    //           Availability available = Availability();
                    //           available.setproduct(string);
                    //
                    //           availability.add(available);
                    //         }
                    //       });
                    //     },
                    //     initialText: checkIndex(availability, i)
                    //         ? availability[i].getproduct()!
                    //         : ""),
                    // const SizedBox(
                    //   height: 12,
                    // ),

                    title("Types of Product"),
                    const SizedBox(
                      height: 12,
                    ),

                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          //todo unchanged
                          child: textFeildWithDropDownFor(
                              validator: (string) {},
                              item: checkIndex(availabilityParentProduct, i)
                                  ? getChildProducts(
                                      availabilityParentProduct[i])
                                  : [],
                              onselect: (string) {
                                setState(() {
                                  if (checkIndex(availability, i)) {
                                    availability[i].setproduct(string);
                                  } else {
                                    //todo
                                    OrderAvailability available =
                                        OrderAvailability();
                                    available.setproduct(string);

                                    availability.add(available);
                                  }
                                });
                              },
                              initialText: checkIndex(availability, i)
                                  ? availability[i].getproduct() ?? ""
                                  : ""),
                        ),
                        SizedBox(
                          width: 140,
                          child: textFormFeildIncreAndDecre(
                              validator: (string) {},
                              initialValue: checkIndex(availability, i)
                                  ? availability[i].getStock() != null
                                      ? availability[i].getStock().toString()
                                      : ""
                                  : "",
                              onChanged: (string) {
                                setState(() {
                                  if (checkIndex(availability, i)) {
                                    availability[i]
                                        .setStock(int.parse(string!));
                                  } else {
                                    OrderAvailability available =
                                        OrderAvailability();
                                    available.setStock(int.parse(string!));

                                    availability.add(available);
                                  }
                                });
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    //todo true and false
                    Row(
                      children: [
                        textButton("True", boolbuttonSize!, false, () {
                          setState(() {
                            if (checkIndex(availability, i)) {
                              availability[i].setavailability(true);
                            } else {
                              OrderAvailability availabilitsy =
                                  OrderAvailability();
                              availabilitsy.availability = true;
                              availability.add(availabilitsy);
                            }
                          });
                        },
                            color: checkIndex(availability, i) &&
                                    availability[i].getavailability() != null
                                ? availability[i].getavailability()
                                    ? AppColors.buttonColor
                                    : null
                                : null),
                        const SizedBox(
                          width: 20,
                        ),
                        textButton("False", boolbuttonSize!, false, () {
                          setState(() {
                            if (checkIndex(availability, i)) {
                              availability[i].setavailability(false);
                            } else {
                              OrderAvailability availabilitsy =
                                  OrderAvailability();
                              availabilitsy.availability = false;
                              availability.add(availabilitsy);
                            }
                          });
                        },
                            color: checkIndex(availability, i) &&
                                    availability[i].getavailability() != null
                                ? availability[i].getavailability()
                                    ? null
                                    : AppColors.buttonColor
                                : null),
                        InkWell(
                            onTap: () {
                              if (availability.isNotEmpty) {
                                print("this is not what i want");
                                setState(() {
                                  if (checkIndex(availability, i)) {
                                    availabilityParentProduct.removeAt(i);
                                    availability.removeAt(i);
                                    availabilityLength = availability.length;
                                  } else {
                                    availabilityLength = availabilityLength - 1;
                                  }
                                });
                              } else {
                                print("no way what");
                                availabilityLength = availability.length;
                              }
                            },
                            child: circleContainer())
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(
          height: 12,
        ),
        textButton("Add more Products", textbuttonSize!, false, () {
          setState(() {
            print("the return length ${returns.length}");
            availabilityLength = availability.length;
          });
        }),
        const SizedBox(
          height: 12,
        ),
        textFeildWithMultipleLines(
            hintText: 'Remarks',
            controller: _availabilityRemarks,
            validator: (string) {
              Validators.validator(string);
            })
      ],
    );
  }

  Widget returnsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            titles("Return"),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.36,
            ),
            cancleWidget(() {
              setState(() {
                returnPressed = false;
              });
            }),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        //todo if empty show 1 else list length
        for (var i = 0; i < returnLength + 1; i++)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title("Product Name"),
                    const SizedBox(
                      height: 12,
                    ),
                    textFeildWithDropDownFor(
                        validator: (string) {},
                        item: productName,
                        onselect: (string) {
                          setState(() {
                            if (checkIndex(returnParentProduct, i)) {
                              returnParentProduct[i] = string;
                              print(returnParentProduct[i]);
                            } else {
                              returnParentProduct.add(string);
                            }
                          });
                        },
                        initialText: checkIndex(returnParentProduct, i)
                            ? returnParentProduct[i]
                            : ""),
                    const SizedBox(
                      height: 12,
                    ),
                    title("Types of Product"),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: 150,
                            //todo unchanged
                            child: textFeildWithDropDownFor(
                                validator: (string) {},
                                item: checkIndex(returnParentProduct, i)
                                    ? getChildProducts(returnParentProduct[i])
                                    : [],
                                onselect: (string) {
                                  print(string);
                                  setState(() {
                                    if (checkIndex(returns, i)) {
                                      returns[i].setProduct(string);
                                    } else {
                                      RerturnAndSale returna = RerturnAndSale();
                                      returna.setProduct(string);

                                      returns.add(returna);
                                    }
                                  });
                                },
                                initialText: checkIndex(returns, i)
                                    ? returns[i].getProduct() ?? ""
                                    : "")),
                        SizedBox(
                          width: 130,
                          child: textFormFeildIncreAndDecre(
                              validator: (string) {},
                              initialValue: checkIndex(returns, i)
                                  ? returns[i].getReturn() != null
                                      ? returns[i].getReturn().toString()
                                      : ""
                                  : "",
                              onChanged: (string) {
                                if (checkIndex(returns, i)) {
                                  returns[i].setReturn(int.parse(string!));
                                } else {
                                  RerturnAndSale returna = RerturnAndSale();
                                  returna.setReturn(int.parse(string!));

                                  returns.add(returna);
                                }
                              }),
                        ),
                        InkWell(
                            onTap: () {
                              if (returns.isNotEmpty) {
                                setState(() {
                                  if (checkIndex(returns, i)) {
                                    print("this is index at $i for remove ");
                                    print(returns[i].getProduct());
                                    print(returns[i].getReturn());

                                    setState(() {
                                      returnParentProduct.removeAt(i);
                                      returns.removeAt(i);
                                      returnLength = returns.length;
                                    });
                                    print(returnParentProduct.length);
                                    print(returns.length);
                                  } else {
                                    returnLength = returnLength - 1;
                                  }
                                });
                              } else {
                                print("no way what");
                                returnLength = returns.length;
                              }
                            },
                            child: circleContainer())
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        textButton("Add more Products", textbuttonSize!, false, () {
          setState(() {
            print("the return length ${returns.length}");

            returnLength = returns.length;
            print(returns);
          });
        }),
        const SizedBox(
          height: 12,
        ),
        textFeildWithMultipleLines(
            hintText: 'Remarks',
            controller: _returnRemarks,
            validator: (string) {
              Validators.validator(string);
            })
      ],
    );
  }
}
