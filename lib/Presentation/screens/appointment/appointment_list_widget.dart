import 'package:flutter/material.dart';
import 'package:jiveda_appointment/models/appointment_list_res_model.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import '../../../models.dart';
import '../../providers/appointment_provider.dart';
import 'appointment_card_widget.dart';


List<AppointmentDataModel> _filterByStatus(
    List<AppointmentDataModel> all, String? status) {
  if (status == null) return all;
  return all.where((a) => a.statusID == status).toList();
}

Widget buildList(List<AppointmentDataModel> all, String? statusFilter, BuildContext context) {
  final filtered = _filterByStatus(all, statusFilter);
  if (filtered.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 64, color: textSecondaryColor.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          CustomText(text: 'No appointments found', textColor: textSecondaryColor, fontSize: 16,),

        ],
      ),
    );
  }
  return RefreshIndicator(
    onRefresh: () => context.read<AppointmentProvider>().fetchAppointments(),
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 16,right: 16,left: 16,bottom: 80.0),
      itemCount: filtered.length,
      itemBuilder: (context, i) => buildAppointmentCard(filtered[i],context),
    ),
  );
}