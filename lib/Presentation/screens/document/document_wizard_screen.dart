import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiveda_appointment/Presentation/providers/document_provider.dart';
import 'package:jiveda_appointment/Presentation/screens/document/progress_header_widget.dart';
import 'package:jiveda_appointment/Presentation/screens/document/step_content_widget.dart';
import 'package:jiveda_appointment/Presentation/screens/document/step_indicator_widget.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';

import 'package:provider/provider.dart';

import '../../../api_service.dart';
import '../../../models.dart';
import '../../providers/appointment_provider.dart';
import 'build_navigation_widget.dart';

class DocumentWizardScreen extends StatefulWidget {
  //final Appointment appointment;

  const DocumentWizardScreen({super.key,
    //required this.appointment
  });

  @override
  State<DocumentWizardScreen> createState() => _DocumentWizardScreenState();
}

class _DocumentWizardScreenState extends State<DocumentWizardScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final docProvider = Provider.of<DocumentProvider>(context, listen: false);
    docProvider.animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    docProvider.progressAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(docProvider.animCtrl);
    docProvider.updateProgress();
  }

  @override
  void dispose() {
    final docProvider = Provider.of<DocumentProvider>(context, listen: false);
    docProvider.animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final docProvider = context.watch<DocumentProvider>();
    return Scaffold(
      backgroundColor: surfaceColor,
      appBar: AppBar(
        titleSpacing: 0.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(text: "widget.appointment.clientName", textColor: whiteColor),
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back),color: whiteColor,),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryColor.withValues(alpha: 0.80),
                appColor,],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: CustomText(text: 'Step ${docProvider.currentStep + 1}/${docProvider.steps.length}',fontSize: 13.0,fontWeight: FontWeight.w600,textColor: Colors.white70,)

            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress
          buildProgressHeader(context),
          // Step indicators
          buildStepIndicators(context),
          // Content
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.1, 0),
                  end: Offset.zero,
                ).animate(anim),
                child: FadeTransition(opacity: anim, child: child),
              ),
              child: KeyedSubtree(
                key: ValueKey(docProvider.currentStep),
                child: buildStepContent(context),
              ),
            ),
          ),
          // Navigation
          buildNavigation(context, "widget.appointment.id"),
        ],
      ),
    );
  }
}
