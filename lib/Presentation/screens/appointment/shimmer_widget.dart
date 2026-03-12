import 'package:flutter/material.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';

Widget buildShimmer() {
  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: 5,
    itemBuilder: (context, i) => Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 120,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}