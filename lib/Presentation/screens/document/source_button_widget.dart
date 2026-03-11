
import 'package:flutter/material.dart';
import 'package:jiveda_appointment/widgets/custom_text.dart';

Widget sourceButton({
  required IconData icon,
  required String label,
  required Color color,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 36),
          const SizedBox(height: 8),
          CustomText(text: label,textColor: color,fontWeight: FontWeight.w700,fontSize: 15,)

        ],
      ),
    ),
  );
}