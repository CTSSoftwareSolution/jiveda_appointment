import 'package:flutter/material.dart';
import 'package:jiveda_appointment/Presentation/screens/appointment/shimmer_widget.dart';

import 'package:jiveda_appointment/utilities/color_data.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import '../../../Data/model/response/appointment_list_res_model.dart';
import '../../providers/appointment_list_provider.dart';
import 'appointment_card_widget.dart';


List<AppointmentDataModel> _filterByStatus(
    BuildContext context, String? status) {

  final provider = context.read<AppointmentListProvider>();
  final all = provider.filteredAppointments;

  if (status == null || status.isEmpty) return all;

  return all.where((a) => a.statusID == status).toList();
}


Widget buildList(String? statusFilter, BuildContext context) {
  final provider = context.watch<AppointmentListProvider>();

  final all = provider.filteredAppointments;
  final filtered = _filterByStatus(context, statusFilter);


  filtered.isEmpty ?
     Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 64, color: textSecondaryColor.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          CustomText(text: 'No appointments found', textColor: textSecondaryColor, fontSize: 16,),

        ],
      ),
    ) : buildShimmer();

  return RefreshIndicator(
    onRefresh: () => context.read<AppointmentListProvider>().fetchAppointments(),
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 16,right: 16,left: 16,bottom: 80.0),
      itemCount: filtered.length,
      itemBuilder: (context, i) => buildAppointmentCard(filtered[i],context),
    ),
  );
}