import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:synapsis_challenge/config/themes/colors.dart';

enum SynapsisButtonType {
  primary,
  secondary,
}

class SynapsisButton extends StatelessWidget {
  final bool isLoading;
  final String content;
  final SynapsisButtonType type;
  final void Function() onclick;
  const SynapsisButton(
      {super.key,
      required this.content,
      required this.type,
      this.isLoading = false,
      required this.onclick});

  @override
  Widget build(BuildContext context) {
    final loading = [
      SizedBox(
          width: 2.h,
          height: 2.h,
          child: CircularProgressIndicator(
            color: type == SynapsisButtonType.primary
                ? Colors.white
                : SynapsisColor.primaryColor,
          )),
      SizedBox(
        width: 2.h,
      )
    ];
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLoading) ...loading,
          Text(
            content,
            style: TextStyle(
                fontSize: 15,
                height: 1.8,
                fontWeight: FontWeight.w600,
                color: type == SynapsisButtonType.primary
                    ? Colors.white
                    : SynapsisColor.primaryColor),
          ),
        ],
      ),
    );
  }
}
