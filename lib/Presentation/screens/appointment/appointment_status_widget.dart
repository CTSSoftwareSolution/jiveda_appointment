import 'package:flutter/material.dart';
import 'package:jiveda_appointment/models/appointment_list_res_model.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';
import '../../../models.dart';

Widget buildStatsRow(List<AppointmentDataModel> appointments) {
  final total = appointments.length;
  final scheduled =
      appointments.where((a) => a.statusID == 'scheduled').length;
  final completed =
      appointments.where((a) => a.statusID == 'completed').length;
  // final docsUploaded =
  //     appointments.where((a) => a.isDocumentUploaded).length;

  return Container(
    color: whiteColor,
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
    child: Row(
      children: [
        statChip('Total', total, primaryColor),
        const SizedBox(width: 8),
        statChip('Scheduled', scheduled, orangeColor),
        const SizedBox(width: 8),
        statChip('Docs Done', 5, greenColor),
        const SizedBox(width: 8),
        statChip('Done', completed, blueColor),
      ],
    ),
  );
}



Widget statChip(String label, int count, Color color) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          CustomText(text: '$count',textColor: color, fontSize: 18,fontWeight: FontWeight.w800,),
          CustomText(text: label,textColor: color, fontSize: 10,fontWeight: FontWeight.w600,),
        ],
      ),
    ),
  );
}