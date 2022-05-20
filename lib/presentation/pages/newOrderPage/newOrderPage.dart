import 'package:flutter/material.dart';
import 'package:salesforce/domain/entities/availability.dart';
import 'package:salesforce/domain/entities/returns.dart';
import 'package:salesforce/presentation/pages/newOrderPage/widgets/wid.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/visitedOutletWidget.dart';
import 'package:salesforce/routes.dart';
import '../../../domain/entities/sales.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/buttonWidget.dart';
import '../../widgets/textformfeild.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({Key? key}) : super(key: key);

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  String dropdownvalue = '';
  double? textbuttonSize;

  final TextEditingController _outletName = TextEditingController();
  final TextEditingController _textEditingController =
      TextEditingController();

  // final TextEditingController _textEditingController = TextEditingController();
  bool showEditBUtton = false;
  bool showSaveBUtton = false;
  bool outletsCreated = true;
  bool ignorePointer = false;
  bool editCheckBoxValue = false;
  bool showXlsButton = false;

  ///returned pressed
  bool returnPressed = false;
  bool availabilityPressed = false;
  bool salesPressed = false;
  int returnLength = 1;
  int availabilityLength = 1;
  int salesLength = 1;
  List<Returns> returns = [];
  List<Availability> availability = [];
  List<Sales> sales = [];

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    textbuttonSize = MediaQuery.of(context).size.width * 0.9;
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
          textFormField(
              controller: _outletName,
              validator: (string) {},
              obsecureText1: () {},
              hintText: 'Frank miller '),
          const SizedBox(
            height: 35,
          ),

          returnPressed
              ? returnsWidget()
              : textButton("Return",
                  MediaQuery.of(context).size.width * 0.9, true, () {
                  setState(() {
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
              : textButton("Availability",
                  MediaQuery.of(context).size.width * 0.9, true, () {
                  setState(() {
                    returnPressed = false;
                    availabilityPressed = true;
                    salesPressed = false;
                  });
                }),
          const SizedBox(
            height: 15,
          ),
          salesPressed
              ? salesWidet()
              : textButton("Sales", textbuttonSize!, true, () {
                  setState(() {
                    returnPressed = false;
                    availabilityPressed = false;
                    salesPressed = true;
                  });
                }),

          const SizedBox(
            height: 12,
          ),
          // textButton("Add More Product", MediaQuery.of(context).size.width),

          // textFeildWithMultipleLines(
          //     validator: (string) {},
          //     hintText: 'Remark',
          //     controller: _textEditingController),

          button("Save Order", () {
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

              Navigator.of(context).pushNamed(Routes.visitedOutlets,
                  arguments: visitedOutlets);
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
              : SizedBox(),
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
                constraints:
                    BoxConstraints(minHeight: constraint.maxHeight),
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

  Widget circleContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.delete,
          size: 20,
          color: AppColors.buttonColor,
        ),
      ),
    );
  }

  Widget textButton(
      String title, double width, bool isbold, Function() onClick) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: width,
        decoration: BoxDecoration(
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

  Widget salesWidet() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            titles("Sales"),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.27,
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
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 13.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              shape: BoxShape.rectangle,
              border: Border.all(color: AppColors.primaryColor)),
          child: Column(
            children: [
              title("Product Name"),
              const SizedBox(
                height: 12,
              ),
              textFormField(
                  controller: _textEditingController,
                  validator: (string) {},
                  obsecureText1: () {},
                  hintText: 'Rc cola '),
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
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: textFeildWithDropDown(
                        validator: (string) {},
                        hintText: 'Frank miller ',
                        item: []),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    //   child: textFormFeildIncreAndDecre(
                    //       hintText: '9999',
                    //       controller: _textEditingController,
                    //       validator: (string) {}),
                  ),
                  circleContainer()
                ],
              ),

              //todo
            ],
          ),
        ),
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
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 13.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              shape: BoxShape.rectangle,
              border: Border.all(color: AppColors.primaryColor)),
          child: Column(
            children: [
              title("Product Name"),
              const SizedBox(
                height: 12,
              ),
              textFormField(
                  controller: _textEditingController,
                  validator: (string) {},
                  obsecureText1: () {},
                  hintText: 'Rc cola '),
              const SizedBox(
                height: 12,
              ),
              title("Types of Product"),
              const SizedBox(
                height: 12,
              ),
              // textFeildWithDropDown(
              //     controller: _textEditingController,
              //     validator: (string) {},
              //     hintText: 'Frank miller '),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
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
        for (var i = 0; i < 3; i++)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 13.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 13.0),
                child: Column(
                  children: [
                    title("Product Name"),
                    const SizedBox(
                      height: 12,
                    ),
                    textFormField(
                        controller: _textEditingController,
                        validator: (string) {},
                        obsecureText1: () {},
                        hintText: 'Rc cola '),
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
                          width: 200,
                          child: textFeildWithDropDown(
                              controller: _textEditingController,
                              validator: (string) {},
                              hintText: 'Frank miller ',
                              item: []),
                        ),

                        //todo
                        circleContainer()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        textButton(
            "Add mmore Prodeucts", textbuttonSize!, false, () {})
      ],
    );
  }
}
