import 'package:flutter/material.dart';

Widget attendanceRow(String checkIn, Function() onclick, bool loading) {
  return Row(
    children: [
      Text(checkIn,
          style: const TextStyle(
            fontSize: 18,
          )),
      const SizedBox(
        width: 10,
      ),
      InkWell(
        onTap: onclick,
        child: loading
            ? const CircularProgressIndicator(
                strokeWidth: 2,
              )
            : Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: const Color(0xffF29F05),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
              ),
      ),
    ],
  );
}

// setState(() {
// loading = true;
// });
// // check internet
// bool result = await InternetConnectionChecker().hasConnection;
//
// if (result) {
// bool check = await attendenceCubit.checkIn();
// if (!check) {
// Navigator.of(context).pushNamed(Routes.attendanceRoute);
// } else {
// ScaffoldMessenger.of(context).showSnackBar(
// const SnackBar(content: Text('Please go to depot first')));
// }
// } else {
// ScaffoldMessenger.of(context).showSnackBar(
// const SnackBar(content: Text('Please connect to internet')));
// }
//
// setState(() {
// loading = false;
// });
