import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseGauge extends StatelessWidget {
  const ExerciseGauge({
    Key? key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.value,
    required this.day,
    required this.stringValue,
    required this.textColor,
  }) : super(key: key);

  final Color backgroundColor;
  final Color foregroundColor;

  final double value;
  final String day;
  final String stringValue;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          stringValue,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: textColor, fontSize: 12, fontWeight: FontWeight.normal),
          ),
        ),
        SizedBox(height: 18.h),
        Neumorphic(
            style: NeumorphicStyle(
                color: backgroundColor,
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(20),
                )),
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                height: 200,
                width: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    color: foregroundColor,
                    borderRadius: BorderRadius.circular(20)),
                height: value,
                width: 15,
              ),
            ])),
        SizedBox(height: 18.h),
        Text(
          day,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
