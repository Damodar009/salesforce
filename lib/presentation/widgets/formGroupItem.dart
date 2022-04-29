import 'package:flutter/material.dart';

Widget formGroupItem(String title) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 5,
    shadowColor: Colors.black,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        trailing: Column(
          children: const [
            Icon(Icons.arrow_drop_up),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    ),
  );
}
