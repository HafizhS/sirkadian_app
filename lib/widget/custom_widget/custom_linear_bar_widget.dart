import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLinearBarWidget extends StatefulWidget {
  CustomLinearBarWidget(
      {Key? key,
        this.width = 0,
        this.percent = 0,
        this.height = 15,
        this.topLeadingText = "",
        this.topTrailingText = "",
        this.isIndicatorVisible = true,
        this.holdIndicatorOnThreshold = true,
        this.minPercentHoldIndicator = 0.15,
        this.maxPercentHoldIndicator = 0.9,
        this.indicatorText = "",
        this.barColor = Colors.red,
        this.indicatorFontSize= 17})
      : super(key: key);

  final double? width;
  final double? height;
  final double percent;
  final String topLeadingText;
  final String topTrailingText;

  final bool isIndicatorVisible;
  final bool holdIndicatorOnThreshold;
  final double indicatorFontSize;
  final double minPercentHoldIndicator;
  final double maxPercentHoldIndicator;
  final String indicatorText;

  final Color? barColor;

  @override
  State<CustomLinearBarWidget> createState() => _CustomLinearBarWidgetState();
}

class _CustomLinearBarWidgetState extends State<CustomLinearBarWidget> {
  double? _getWidth(width) => (widget.width == 0) ? width : widget.width;

  double _getIndicatorWidth(constraint) =>
      _getWidth(constraint)! *
          widget.percent.clamp(
              widget.minPercentHoldIndicator, widget.maxPercentHoldIndicator);

  double _getBarWidth(constraint) =>
      (_getWidth(constraint)! - _getSmallGapWidth(constraint)) * widget.percent;

  double _getSmallGapWidth(constraint) => _getWidth(constraint)! * 0.038;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Container(
          width: _getWidth(constraint.maxWidth),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  widget.isIndicatorVisible
                      ? SizedBox(
                    width: _getIndicatorWidth(constraint.maxWidth),
                    height: 37,
                    child: Stack(
                      alignment: FractionalOffset.bottomRight,
                      children: [
                        Align(
                            child: Text(
                              "${widget.indicatorText}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: widget.indicatorFontSize,
                                  color: widget.barColor),
                            ),
                            alignment: Alignment.topRight),
                        Icon(Icons.arrow_drop_down,
                            color: widget.barColor),
                      ],
                    ),
                  )
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Leading
                      Text("${widget.topLeadingText}",
                          style: GoogleFonts.poppins()),
                      // Trailing
                      Text("${widget.topTrailingText}",
                          style: GoogleFonts.poppins()),
                    ],
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    width: _getWidth(constraint.maxWidth),
                    height: widget.height,
                    decoration: BoxDecoration(
                        border: Border.all(color: widget.barColor!),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Row(
                    children: [
                      Container(
                        width: _getSmallGapWidth(constraint.maxWidth),
                        height: widget.height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(widget.height! / 2),
                                topLeft: Radius.circular(widget.height! / 2)),
                            color: widget.barColor),
                      ),
                      Container(
                        width: _getBarWidth(constraint.maxWidth),
                        height: widget.height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight:
                                Radius.circular(widget.height! / 2),
                                topRight: Radius.circular(widget.height! / 2)),
                            color: widget.barColor),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}