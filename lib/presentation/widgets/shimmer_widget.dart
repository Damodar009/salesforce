import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerWidget(
    {required BuildContext context,
    required Color baseColor,
    required Color highlightColor,
    required double maxWidthVlaue,
    required double maxHeightValue,
    required double borderRadiusValue}) {
  return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
              maxWidth: maxWidthVlaue, maxHeight: maxHeightValue),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              // border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(borderRadiusValue),
              color: Colors.white),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Container()),
        ),
      ));
}
