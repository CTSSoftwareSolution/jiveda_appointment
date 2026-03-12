
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiveda_appointment/models/appointment_list_res_model.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';
import 'package:jiveda_appointment/utilities/extension.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';

import '../../../models.dart';
import '../document/document_wizard_screen.dart';

Widget buildAppointmentCard(AppointmentDataModel apt, BuildContext context) {
  final statusColor = apt.statusID == '2'
      ? orangeColor
      : apt.statusID == '1'
      ? greenColor
      : redColor;



  DateTime parsedDate = DateFormat("MM/dd/yyyy hh:mm:ss a").parse(apt.appointmentDate.toString());

  String date = DateFormat("yyyy-MM-dd").format(parsedDate);
  String time = DateFormat("hh:mm a").format(parsedDate);

  return GestureDetector(
    onTap: () async {
      // await Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (_) => DocumentWizardScreen(appointment: apt)),
      // );
      },
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
          // apt.isDocumentUploaded
          //     ? greenColor.withValues(alpha: 0.4)
          //     :
          borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: blackColor.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // Avatar
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                       primaryColor.withValues(alpha: 0.80),
                        appColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: CustomText(text: apt.patientName!.substring(0,1).toUpperCase(), textColor: whiteColor, fontSize: 22, fontWeight: FontWeight.w700,)

                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: apt.patientName.toString(),fontSize: 16,fontWeight: FontWeight.w700,textColor: blackColor,),
                      const SizedBox(height: 2),
                      CustomText(text: apt.appointmentID.toString(),fontSize: 12,fontWeight: FontWeight.w600, textColor: textSecondaryColor,),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CustomText(text: apt.statusName!.toUpperCase(),fontSize: 10, textColor: statusColor,fontWeight: FontWeight.w700,letterSpacing: 0.5,)

                    ),
                    // if (apt.isDocumentUploaded) ...[
                    //   const SizedBox(height: 4),
                    //   const Row(
                    //     children: [
                    //       Icon(Icons.check_circle,
                    //           color: greenColor, size: 14),
                    //       SizedBox(width: 3),
                    //       CustomText(text: 'Docs uploaded', textColor: greenColor,fontSize: 10,fontWeight: FontWeight.w600,)
                    //     ],
                    //   ),
                    // ],
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(color: borderColor, height: 1),
            const SizedBox(height: 10),
            Row(
              children: [
                infoChip(Icons.calendar_today_outlined, date),
                const SizedBox(width: 12),
                infoChip(Icons.access_time_outlined, time),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      CustomText(text: 'Capture Docs', textColor: whiteColor, fontSize: 11, fontWeight: FontWeight.w700,),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios,
                          color: whiteColor, size: 10),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}


Widget infoChip(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, size: 13, color: blackColor),
      const SizedBox(width: 4),
      CustomText(text: text, fontSize: 12, textColor: textSecondaryColor, fontWeight: FontWeight.w500,)
    ],
  );
}