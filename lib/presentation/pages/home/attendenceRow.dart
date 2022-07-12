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
