import 'dart:math' as Math;

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/constant/hex_color.dart';
import 'package:sirkadian_app/controller/hexcolor_controller.dart';

class NecessityGauge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final Size size;
  final double value;
  final ColorConstantController color;
  final Function() onpress;

  const NecessityGauge({
    Key? key,
    required this.text,
    this.backgroundColor = Colors.black12,
    required this.foregroundColor,
    required this.value,
    required this.size,
    required this.color,
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor;
    final foregroundColor = this.foregroundColor;
    return Container(
      height: size.height,
      width: size.width,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 6,
            offset: Offset(4, 2), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onpress,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.05, bottom: size.height * 0.1),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: color.secondaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  CustomPaint(
                    child: Container(
                      width: size.width * 0.7,
                      height: size.height * 0.7,
                      child: Center(
                        child: Text('${((value) * 100).round().toString()}%',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: HexColor.fromHex("#4E5749"),
                                fontSize: 25)),
                      ),
                    ),
                    foregroundPainter: CircleProgressBarPainter(
                      sizeContainer: size*1.1,
                      backgroundColor: backgroundColor,
                      foregroundColor: foregroundColor,
                      percentage: this.value,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                      Icon(FontAwesomeIcons.ellipsisH, color: foregroundColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Draws the progress bar.
class CircleProgressBarPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color backgroundColor;
  final Color foregroundColor;
  final Size sizeContainer;

  CircleProgressBarPainter({
    required this.sizeContainer,
    this.backgroundColor = Colors.black12,
    required this.foregroundColor,
    required this.percentage,
    this.strokeWidth = 6,
  });

  @override
  void paint(canvas, size) {
    final Offset center = size.center(Offset(0, 0));
    final Size constrainedSize = sizeContainer;
    final foregroundPaint = Paint()
      ..color = this.foregroundColor
      ..strokeWidth = this.strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Start at the top. 0 radians represents the right edge
    final double startAngle = -(4 * Math.pi * 0.5);
    final double sweepAngle = (4 * Math.pi * (this.percentage * 0.5));

    // Don't draw the background if we don't have a background color
    if (this.backgroundColor != Colors.black12) {
      final backgroundPaint = Paint()
        ..color = this.backgroundColor
        ..strokeWidth = this.strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: constrainedSize.width * 0.35),
        startAngle,
        startAngle * -1,
        false,
        backgroundPaint,
      );
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: constrainedSize.width * 0.35),
      startAngle,
      sweepAngle * -1,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as CircleProgressBarPainter);
    return oldPainter.percentage != this.percentage ||
        oldPainter.backgroundColor != this.backgroundColor ||
        oldPainter.foregroundColor != this.foregroundColor ||
        oldPainter.strokeWidth != this.strokeWidth;
  }
}

class DotOnCircleProgressBarPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color backgroundColor;
  final Color foregroundColor;
  final Size sizeContainer;

  DotOnCircleProgressBarPainter({
    required this.sizeContainer,
    this.backgroundColor = Colors.black12,
    required this.foregroundColor,
    required this.percentage,
    this.strokeWidth = 10,
  });

  @override
  void paint(canvas, size) {
    final Offset center = size.center(Offset(0, 0));
    final Size constrainedSize = sizeContainer;
    final foregroundPaint = Paint()
      ..color = this.foregroundColor
      ..strokeWidth = this.strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Start at the top. 0 radians represents the right edge
    // final double startAngle = -(4 * Math.pi * 0.5);
    final double sweepAngle = (4 * Math.pi * (this.percentage * 0.5));

    // // Don't draw the background if we don't have a background color
    // if (this.backgroundColor != Colors.black12) {
    //   final backgroundPaint = Paint()
    //     ..color = this.backgroundColor
    //     ..strokeWidth = this.strokeWidth
    //     ..style = PaintingStyle.stroke;
    //   canvas.drawArc(
    //     Rect.fromCircle(center: center, radius: constrainedSize.width * 0.35),
    //     startAngle,
    //     startAngle * -1,
    //     false,
    //     backgroundPaint,
    //   );
    // }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: constrainedSize.width * 0.35),
      sweepAngle,
      1,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as CircleProgressBarPainter);
    return oldPainter.percentage != this.percentage ||
        oldPainter.backgroundColor != this.backgroundColor ||
        oldPainter.foregroundColor != this.foregroundColor ||
        oldPainter.strokeWidth != this.strokeWidth;
  }
}
