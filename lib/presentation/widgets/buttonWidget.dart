import 'package:flutter/material.dart';

Widget button(String title, Function() onclick, bool isLoading, Color color) {
  return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))),
      ),
      onPressed: () {
        onclick();
      },
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 12,
            ),
            !isLoading
                ? Text(title)
                : const SizedBox(
                    height: 17,
                    width: 15,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 0.5,
                    ),
                  ),
          ],
        ),
      ));
}
