import 'package:flutter/material.dart';
import 'package:salesforce/presentation/widgets/appBarWidget.dart';
import 'package:salesforce/presentation/widgets/visitedOutletWidget.dart';
import 'package:salesforce/routes.dart';
import '../../utils/app_colors.dart';
import '../widgets/buttonWidget.dart';
import '../widgets/textformfeild.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({Key? key}) : super(key: key);

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  String dropdownvalue = '';

  final TextEditingController _nameOfOutletsSales = TextEditingController();
  final TextEditingController _productNameSales = TextEditingController();
  final TextEditingController _typesOfProductSales = TextEditingController();
  final TextEditingController _numberOfProductOfSales = TextEditingController();
  final TextEditingController _productNameAvailability =
      TextEditingController();
  final TextEditingController _typesOfProductAvailability =
      TextEditingController();
  final TextEditingController _describeProductAvailability =
      TextEditingController();
  final TextEditingController _productNameReturn = TextEditingController();
  final TextEditingController _typeOfProductReturn = TextEditingController();
  final TextEditingController _describeReturn = TextEditingController();
  final TextEditingController _availableTimeForDeliveryReturn =
      TextEditingController();
  final TextEditingController _avaibaleTimeToDeliveryReturn =
      TextEditingController();
  final TextEditingController _availabilityStatus = TextEditingController();

  bool showEditBUtton = false;
  bool showSaveBUtton = false;
  bool outletsCreated = true;
  bool ignorePointer = false;
  bool editCheckBoxValue = false;
  bool showXlsButton = false;

  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
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
              controller: _nameOfOutletsSales,
              validator: (string) {},
              obsecureText1: () {},
              hintText: 'Frank miller '),
          titles("Sales"),
          const SizedBox(
            height: 12,
          ),

          //todo
          title("Product Name"),
          const SizedBox(
            height: 12,
          ),
          textFormField(
              controller: _productNameSales,
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
                    controller: _typesOfProductSales,
                    validator: (string) {},
                    hintText: 'Frank miller ',
                    item: items),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: textFormFeildIncreAndDecre(
                    hintText: '9999',
                    controller: _numberOfProductOfSales,
                    validator: (string) {}),
              ),
              circleContainer()
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          textButton("Add More Product", MediaQuery.of(context).size.width),

          const SizedBox(
            height: 12,
          ),
          titles("Availability"),

          const SizedBox(
            height: 12,
          ),

          title("Product Name"),
          const SizedBox(
            height: 12,
          ),
          textFormField(
              controller: _productNameAvailability,
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
          textFeildWithDropDown(
              controller: _typesOfProductAvailability,
              validator: (string) {},
              hintText: 'Frank miller ',
              item: items),
          const SizedBox(
            height: 12,
          ),

          textFeildWithMultipleLines(
              validator: (string) {},
              hintText: 'Remark',
              controller: _describeProductAvailability),

          const SizedBox(
            height: 12,
          ),
          titles("Return"),

          const SizedBox(
            height: 12,
          ),

          //todo
          title("Product Name"),
          const SizedBox(
            height: 12,
          ),
          textFormField(
              controller: _productNameReturn,
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
                    controller: _typeOfProductReturn,
                    validator: (string) {},
                    hintText: 'Frank miller ',
                    item: items),
              ),
              circleContainer()
            ],
          ),
          const SizedBox(
            height: 12,
          ),

          Row(
            children: [
              textButton("true", 90),
              const SizedBox(
                width: 12,
              ),
              textButton("false", 90),
              const SizedBox(
                width: 12,
              ),
              circleContainer()
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          textFeildWithMultipleLines(
              validator: (string) {},
              hintText: 'Remark',
              controller: _describeReturn),

          const SizedBox(
            height: 12,
          ),
          title("Available Time for delivery"),
          const SizedBox(
            height: 12,
          ),
          textFormField(
              controller: _availableTimeForDeliveryReturn,
              validator: (string) {},
              obsecureText1: () {},
              hintText: 'From'),
          const SizedBox(
            height: 12,
          ),
          textFormField(
              controller: _avaibaleTimeToDeliveryReturn,
              validator: (string) {},
              obsecureText1: () {},
              hintText: 'To '),
          const SizedBox(
            height: 12,
          ),

          title("Availability"),

          textFormField(
              controller: _availabilityStatus,
              validator: (string) {},
              obsecureText1: () {},
              hintText: 'What is the status'),
          const SizedBox(
            height: 20,
          ),

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

  Widget textButton(String title, double width) {
    return InkWell(
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
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
