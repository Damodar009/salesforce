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
    title: Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          "x",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor),
        ),
      ),
    ),
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

Future<void> displayTextInputDialog(BuildContext context) async {
  TextEditingController textEditingController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 20,
          contentPadding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 2.0),
          content: SizedBox(
            width: 300,
            child: SizedBox(
              height: 200,
              child: Column(
                children: [
                  textFeildWithMultipleLines(
                      hintText: 'Reason for leave',
                      controller: textEditingController,
                      validator: (string) {}),
                  Row(
                    children: const [
                      Text("From"),
                      //buildDatePicker("initialValue"),
                      Text("To")
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
                width: 120,
                child: button("okay", () {
                  print("sending data to the api ");
                  //todo send data to api
                  Leave leave = Leave(
                      fromDate: "2021-01-01",
                      toDate: "2021-01-01",
                      userId: "NGBifEuwYylJoyRt7a8bkA==",
                      reason: "I have Headache");

                  var useCaseForRemoteSourceimpl =
                      getIt<UseCaseForRemoteSourceimpl>();
                  useCaseForRemoteSourceimpl.requestLeave(leave).then((value) =>
                      {
                        value.fold(
                            (l) => {print("failed")},
                            (r) => {
                                  Navigator.pop(context),
                                  Fluttertoast.showToast(
                                      msg: "leave request send successfully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: AppColors.primaryColor,
                                      textColor: Colors.white,
                                      fontSize: 16.0)
                                })
                      });
                }, false, AppColors.primaryColor)),
            SizedBox(
                width: 120,
                child: button("cancel", () {}, false, AppColors.buttonColor)),
          ],
        );
      });
}

Widget containerWithDate() {
  return Container(
    child: Row(
      children: [
        const Text(""),
        // buildDatePicker("initialValue"),
        IconButton(
            onPressed: () {
              buildDatePicker("initialValue");
            },
            icon: const Icon(Icons.calendar_month))
      ],
    ),
  );
}

Widget buildDatePicker(String? initialValue) {
  return DateTimePicker(
    type: DateTimePickerType.date,
    dateMask: 'd MMM, yyyy',
    initialValue: initialValue ?? "",
    firstDate: DateTime(1920),
    lastDate: DateTime(2050),
    icon: Icon(Icons.event),
    dateLabelText: 'Date',
    timeLabelText: "Time",
    onChanged: (val) {},
  );
}

//MediaQuery.of(context).size.width * 0.3
