import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';

class OtpFieldRow extends StatefulWidget {
  final List<TextEditingController> controllers;

  const OtpFieldRow({
    super.key,
    required this.controllers,
  });

  @override
  State<OtpFieldRow> createState() => _OtpFieldRowState();
}

class _OtpFieldRowState extends State<OtpFieldRow> {

  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(6, (_) => FocusNode());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        focusNodes[0].requestFocus();
      }
    });

    for (var node in focusNodes) {
      node.addListener(() {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Widget otpBox(BuildContext context, int index) {
    return Container(
      width: 45,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: focusNodes[index].hasFocus
              ? appColor
              : Colors.grey.shade300,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Focus(
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            if (widget.controllers[index].text.isEmpty && index > 0) {
              focusNodes[index - 1].requestFocus();
            }
          }
          return KeyEventResult.ignored;
        },
        child: TextField(
          controller: widget.controllers[index],
          focusNode: focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          textInputAction:
              index == 5 ? TextInputAction.done : TextInputAction.next,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              if (index < focusNodes.length - 1) {
                focusNodes[index + 1].requestFocus();
              }
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) => otpBox(context, index)),
    );
  }
}