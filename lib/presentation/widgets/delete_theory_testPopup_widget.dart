import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesforce/domain/entities/Leave.dart';
import 'package:salesforce/injectable.dart';
import 'package:salesforce/presentation/widgets/buttonWidget.dart';
import 'package:salesforce/presentation/widgets/textButton.dart';
import 'package:salesforce/presentation/widgets/textformfeild.dart';
import 'package:salesforce/utils/app_colors.dart';

import '../../domain/usecases/usecasesForRemoteSource.dart';
import '../../routes.dart';

Widget popupWidget(BuildContext context, String text, String buttonText1,
    String buttonText2, Function() buttonClicked1, Function() buttonClicked2) {
  return AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(text,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor)),
      ],
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
              height: 50,
              child: button(
                  buttonText1, buttonClicked1, false, AppColors.buttonColor)),
          textButton(buttonText2, buttonClicked2),
        ],
      ),
    ],
  );
}

Widget buildDatePicker(String initialValue, String date, BuildContext context,
    Function() onDateSelected) {
  return Row(
    children: [
      Text(initialValue),
      const SizedBox(
        width: 10,
      ),
      InkWell(
          onTap: onDateSelected,
          child: Container(
            height: 35,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 1, color: AppColors.primaryColor)),
            child: Center(child: Text(date)),
          )),
    ],
  );
}

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  String fromDate = "";
  String toDate = "";
  late DateTime fromDateTime;
  late DateTime toDateTime;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4 +
          MediaQuery.of(context).viewInsets.bottom,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text("Request a Leave",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor)),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //TextField(),
              buildDatePicker("From:", fromDate, context, () {
                DateTime selectedDate = DateTime.now();
                var as = showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2101, 8))
                    .then((value) => {
                          if (value != null)
                            {
                              setState(() {
                                fromDateTime = value;
                                var day = value.day.toString().length == 1
                                    ? "0${value.day.toString()}"
                                    : value.day.toString();
                                var month = value.month.toString().length == 1
                                    ? "0${value.month.toString()}"
                                    : value.month.toString();
                                fromDate = "${value.year}-$month-$day";
                              })
                            }
                        });
              }),

              //
              buildDatePicker("To:", toDate, context, () {
                DateTime selectedDate = DateTime.now();
                var as = showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2101, 8))
                    .then((value) => {
                          if (value != null)
                            {
                              setState(() {
                                toDateTime = value;
                                var day = value.day.toString().length == 1
                                    ? "0${value.day.toString()}"
                                    : value.day.toString();
                                var month = value.month.toString().length == 1
                                    ? "0${value.month.toString()}"
                                    : value.month.toString();
                                toDate = "${value.year}-$month-$day";
                              })
                            }
                        });
              }),

              // TextField()
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textFeildWithMultipleLines(
                hintText: 'Reason for leave',
                controller: textEditingController,
                validator: (string) {}),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  width: 120,
                  child: button("Okay", () {
                    if (fromDate != "" &&
                        toDate != "" &&
                        textEditingController.text != "" &&
                        (fromDateTime.isBefore(toDateTime))) {
                      if (DateTime.now().isBefore(fromDateTime)) {
                        Leave leave = Leave(
                            fromDate: fromDate,
                            toDate: toDate,
                            userId: "NGBifEuwYylJoyRt7a8bkA==",
                            reason: textEditingController.text);

                        var useCaseForRemoteSourceimpl =
                            getIt<UseCaseForRemoteSourceimpl>();
                        useCaseForRemoteSourceimpl
                            .requestLeave(leave)
                            .then((value) => {
                                  value.fold(
                                      (l) => {print("failed")},
                                      (r) => {
                                            Navigator.pop(context),
                                            Fluttertoast.showToast(
                                                msg:
                                                    "leave request send successfully",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor:
                                                    AppColors.primaryColor,
                                                textColor: Colors.white,
                                                fontSize: 16.0)
                                          })
                                });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Choose Correct Date ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColors.primaryColor,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Enter valid data",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.primaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }, false, AppColors.primaryColor)),
              button("Cancel", () {
                Navigator.pop(context);
              }, false, AppColors.buttonColor)
            ],
          )
        ],
      ),
    );
  }
}

Future displayTextInputDialog(BuildContext context) {
  return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const Display();
      },
      context: context);
}
