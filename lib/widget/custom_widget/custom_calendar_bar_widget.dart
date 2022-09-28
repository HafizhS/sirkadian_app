import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/hex_color.dart';

class CustomCalenderBarWidget extends StatefulWidget {
  CustomCalenderBarWidget({
    Key? key, this.onCenterPressed, this.centerWidget, this.onLeftPressed, this.onrightPressed
  }) : super(key: key);

  final VoidCallback? onCenterPressed;
  final Widget? centerWidget;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onrightPressed;

  @override
  State<CustomCalenderBarWidget> createState() => _CustomCalenderBarWidgetState();
}

class _CustomCalenderBarWidgetState extends State<CustomCalenderBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: HexColor.fromHex("#73C639"),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            SizedBox(
              height: double.infinity,
              width: 60,
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ),
            VerticalDivider(width: 1, thickness: 1, color: Colors.white),
            Expanded(
                flex: 1,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      widget.onCenterPressed?.call();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      child: widget.centerWidget != null? widget.centerWidget : Container()
                    ),
                  ),
                )),
            VerticalDivider(width: 1, thickness: 1, color: Colors.white),
            SizedBox(
              height: double.infinity,
              width: 60,
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
