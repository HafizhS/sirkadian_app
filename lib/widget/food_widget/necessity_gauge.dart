import 'dart:math' as Math;

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return NeumorphicButton(
        onPressed: onpress,
        style: NeumorphicStyle(
          depth: 4,
          color: color.bgColor,
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(20),
          ),
        ),
        margin: const EdgeInsets.all(12),
        child: Container(
          height: size.height,
          width: size.width,

          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.05, bottom: size.height * 0.1),
                child: Text(
                  text,
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
                    child: Text(
                      '${((value) * 100).round().toString()}%',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(color: foregroundColor, fontSize: 25),
                    ),
                  ),
                ),
                foregroundPainter: CircleProgressBarPainter(
                  sizeContainer: size,
                  backgroundColor: backgroundColor,
                  foregroundColor: foregroundColor,
                  percentage: this.value,
                ),
              ),
            ],
          ),
          // decoration: BoxDecoration(
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.grey.withOpacity(0.3),
          //       spreadRadius: 2,
          //       blurRadius: 7,
          //       offset: Offset(0, 3), // changes position of shadow
          //     ),
          //   ],
          //   color: Colors.white,
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(30),
          //   ),
          // ),
        ));
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
