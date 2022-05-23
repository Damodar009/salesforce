import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:salesforce/presentation/pages/newOrderPage/returnAndSale.dart';
import 'package:salesforce/presentation/pages/newOrderPage/widgets/wid.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/routes.dart';
import 'package:salesforce/utils/geolocation.dart';
import '../../../domain/usecases/hiveUseCases/hiveUseCases.dart';
import '../../../injectable.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/hiveConstant.dart';
import '../../../utils/validators.dart';
import '../../widgets/buttonWidget.dart';
import '../../widgets/textformfeild.dart';
import '../../widgets/visitedOutletWidget.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({Key? key}) : super(key: key);

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  var useCaseForHiveImpl = getIt<UseCaseForHiveImpl>();
  String nameOfOutlet = "";

  ///availability
  List<Availability> availability = [];

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

  bool showEditBUtton = false;
  bool showSaveBUtton = false;
  bool outletsCreated = true;
  bool ignorePointer = false;
  bool editCheckBoxValue = false;
  bool showXlsButton = false;

  // to show the items full view
  bool returnPressed = false;
  bool availabilityPressed = false;
  bool salesPressed = false;

  // length of these widgets list
  late int returnLength;
  late int availabilityLength;
  late int salesLength;

  List<String> returnProductNames = [];

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
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

//todo do retiler in another page
  getRetailerList() async {
    Box box = await Hive.openBox(HiveConstants.depotProductRetailers);
    var sucessOrNot = useCaseForHiveImpl.getValuesByKey(box, "retailerTypes");
    sucessOrNot.fold(
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
    Widget newOrderScreenBody() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
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
                      //todo write code for outletsCreated
                      setStat(() {
                        outletsCreated = newValue!;
                      });
                    });
              }),
            ],
          ),
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
            print("it going to be awesome");
            int i = retailerList.indexOf(nameOfOutlet);
            String retailerId = retailerIdList[i];
            GeoLocationData geoLocationData = GeoLocationData();
            Position? position = await geoLocationData.getCurrentLocation();
            double latitude = position!.latitude;
            double longitude = position.longitude;
            DateTime dateTimeNow = DateTime.now();

            //todo get assigned depot

            // todo  payment type

            // todo user id
            //todo get payment document

            print(_availabilityRemarks.text);
            print(_salesRemarks.text);
            print(_returnRemarks.text);

            for (var i = 0; i < returns.length; i++) {
              print(returns[i].getReturn());
              print(returns[i].getProduct());
            }
            for (var i = 0; i < availability.length; i++) {
              print(availability[i].getStock());
              print(availability[i].getproduct());
              print(availability[i].getavailability());
            }
            for (var i = 0; i < sales.length; i++) {
              print(sales[i].getReturn());
              print(sales[i].getProduct());
            }

            setState(() {
              if (returns.isNotEmpty) returnPressed = true;

              if (availability.isNotEmpty) availabilityPressed = true;
              if (sales.isNotEmpty) salesPressed = true;
            });

            if (showXlsButton) {
              final VistedOutlets visitedOutlets = VistedOutlets(
                navTitle: 'TOTAL',
                imageUrl: 'assets/images/total_order_complete.png',
                bodyTitle: 'Order Confirmed!',
                bodySubTitle:
                    'Your order has been confirmed, Order will send to distributor.',
                buttonText: 'Go to Home',
              );
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => VisitedOutletWidget(
              //           visitedOutlets: visitedOutlets,
              //         )));

              Navigator.of(context)
                  .pushNamed(Routes.visitedOutlets, arguments: visitedOutlets);
            } else {
              setState(() {
                ignorePointer = true;
                showEditBUtton = true;
                showSaveBUtton = false;
              });
            }
          }, false, AppColors.buttonColor),
          const SizedBox(
            height: 20,
          ),
          showXlsButton
              ? button("Save Order in XLS", () {
                  Navigator.of(context).pushNamed(Routes.xlsOrder);
                }, false, AppColors.buttonColor)
              : const SizedBox(),
          const SizedBox(
            height: 10,
          )
        ],
      );
    }

    return Scaffold(
      appBar: appBar(
          navTitle: 'NEW ORDER',
          icon: Icons.arrow_back,
          settingTitle: showEditBUtton
              ? showSaveBUtton
                  ? 'save'
                  : "Edit"
              : "",
          settingIcon: Row(
            children: [
              showEditBUtton
                  ? StatefulBuilder(builder: (context, state) {
                      return Checkbox(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.buttonColor),
                          value: editCheckBoxValue,
                          onChanged: (value) {
                            state(() {
                              editCheckBoxValue = value!;
                            });
                            setState(() {
                              // editCheckBoxValue = value!;
                              showEditBUtton = false;
                              ignorePointer = false;
                              showSaveBUtton = true;
                              showXlsButton = true;
                            });
                          });
                    })
                  : SizedBox(),
              Text(showEditBUtton || showSaveBUtton
                  ? showSaveBUtton
                      ? 'save'
                      : "Edit"
                  : ""),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          backNavigate: () {}),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: ignorePointer
                    ? IgnorePointer(child: newOrderScreenBody())
                    : newOrderScreenBody()),
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

  Widget dropDown() {
    return DropdownButton(
        value: dropdownvalue,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((String items) {
          return DropdownMenuItem<String>(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            dropdownvalue = value.toString();
          });
        });
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
        //todo if empty show 1 else list length
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
                        SizedBox(
                            width: 150,
                            //todo unchanged
                            child: textFeildWithDropDownFor(
                                validator: (string) {},
                                item: checkIndex(salesParentProduct, i)
                                    ? getChildProducts(salesParentProduct[i])
                                    : [],
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
                                    ? sales[i].getProduct()
                                    : "")),
                        SizedBox(
                          width: 140,
                          child: textFormFeildIncreAndDecre(
                              validator: (string) {},
                              initialValue: checkIndex(sales, i)
                                  ? sales[i].getReturn().toString()
                                  : "",
                              onChanged: (string) {
                                setState(() {
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
                    title("Types of Product"),
                    const SizedBox(
                      height: 12,
                    ),
                    textFeildWithDropDownFor(
                        validator: (string) {},
                        item: checkIndex(availabilityParentProduct, i)
                            ? getChildProducts(availabilityParentProduct[i])
                            : items,
                        onselect: (string) {
                          setState(() {
                            if (checkIndex(availability, i)) {
                              availability[i].setproduct(string);
                            } else {
                              //todo
                              Availability available = Availability();
                              available.setproduct(string);

                              availability.add(available);
                            }
                          });
                        },
                        initialText: checkIndex(availability, i)
                            ? availability[i].getproduct()!
                            : ""),
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
                              Availability availabilitsy = Availability();
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
                              Availability availabilitsy = Availability();
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
                                print("this is niot what i want");
                                setState(() {
                                  if (checkIndex(availability, i)) {
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
            print(returns);
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
                                    ? returns[i].getProduct()
                                    : "")),
                        SizedBox(
                          width: 140,
                          child: textFormFeildIncreAndDecre(
                              validator: (string) {},
                              initialValue: checkIndex(returns, i)
                                  ? returns[i].getReturn().toString()
                                  : "",
                              onChanged: (string) {
                                setState(() {
                                  if (checkIndex(returns, i)) {
                                    returns[i].setReturn(int.parse(string!));
                                  } else {
                                    RerturnAndSale returna = RerturnAndSale();
                                    returna.setReturn(int.parse(string!));

                                    returns.add(returna);
                                  }
                                });
                              }),
                        ),
                        InkWell(
                            onTap: () {
                              if (returns.isNotEmpty) {
                                print("this is niot what i want");
                                setState(() {
                                  if (checkIndex(returns, i)) {
                                    returns.removeAt(i);
                                    returnLength = returns.length;
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
