import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:synapsis_challenge/config/colors.dart';

enum SynapsisButtonType {
  primary,
  secondary,
}

class SynapsisButton extends StatelessWidget {
  final String content;
  final SynapsisButtonType type;
  final void Function() onclick;
  const SynapsisButton(
      {super.key,
      required this.content,
      required this.type,
      required this.onclick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.25.h),
        backgroundColor: type == SynapsisButtonType.primary
            ? SynapsisColor.primaryColor
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: const BorderSide(
          color: SynapsisColor.primaryColor,
          width: 1,
        ),
      ),
      onPressed: onclick,
      child: Text(
        content,
        style: TextStyle(
            fontSize: 15,
            height: 1.8,
            fontWeight: FontWeight.w600,
            color: type == SynapsisButtonType.primary
                ? Colors.white
                : SynapsisColor.primaryColor),
      ),
    );
  }
}
