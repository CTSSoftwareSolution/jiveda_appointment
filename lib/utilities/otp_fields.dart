import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiveda_appointment/utilities/color_data.dart';

class OtpFieldRow extends StatefulWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  const OtpFieldRow({
    super.key,
    required this.controllers,
    required this.focusNodes,
  });

  @override
  State<OtpFieldRow> createState() => _OtpFieldRowState();
}

class _OtpFieldRowState extends State<OtpFieldRow> {
  @override
  void initState() {
    super.initState();
    for (var node in widget.focusNodes) {
      node.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }
  Widget otpBox(BuildContext context, int index) {
    return Container(
      width: 45,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.focusNodes[index].hasFocus
              ? appColor
              : Colors.grey.shade300,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        controller: widget.controllers[index],
        focusNode: widget.focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < widget.focusNodes.length - 1) {
              FocusScope.of(context).requestFocus(widget.focusNodes[index + 1]);
            } else {
              widget.focusNodes[index].unfocus();
            }
          }
          if (value.isEmpty) {
            if (index > 0) {
              FocusScope.of(context).requestFocus(widget.focusNodes[index - 1]);

              widget
                  .controllers[index - 1]
                  .selection = TextSelection.fromPosition(
                TextPosition(offset: widget.controllers[index - 1].text.length),
              );
            }
          }
        },
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
