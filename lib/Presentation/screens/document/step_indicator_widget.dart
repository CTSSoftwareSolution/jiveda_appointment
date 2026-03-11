import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/color_data.dart';
import '../../providers/document_provider.dart';

Widget buildStepIndicators(BuildContext context) {
  final docProvider = context.watch<DocumentProvider>();
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
    child: Row(
      children: List.generate(docProvider.steps.length, (i) {
        final isActive = i == docProvider.currentStep;
        final isDone = i < docProvider.currentStep;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              if (i <= docProvider.currentStep || isDone) {
                docProvider.currentStep = i;
                docProvider.updateProgress();
              }
            },
            child: Column(
              children: [
                Row(
                  children: [
                    if (i > 0)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: isDone ? docProvider.steps[i].color : borderColor,
                        ),
                      ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDone
                            ? docProvider.steps[i].color
                            : isActive
                            ? docProvider.steps[i].color.withValues(alpha: 0.15)
                            : surfaceColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isActive || isDone
                              ? docProvider.steps[i].color
                              : borderColor,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        isDone ? Icons.check : docProvider.steps[i].icon,
                        size: 16,
                        color: isDone
                            ? Colors.white
                            : isActive
                            ? docProvider.steps[i].color
                            : textSecondaryColor,
                      ),
                    ),
                    if (i < docProvider.steps.length - 1)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: i < docProvider.currentStep
                              ? docProvider.steps[i + 1].color
                              : borderColor,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    ),
  );
}