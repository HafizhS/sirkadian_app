import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/constant/hex_color.dart';

class ExerciseGauge extends StatelessWidget {
  const ExerciseGauge({
    Key? key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.size,
    required this.value,
    required this.day,
    required this.stringValue,
    required this.textColor,
  }) : super(key: key);

  final Color backgroundColor;
  final Color foregroundColor;
  final Size size;
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
        SizedBox(height: size.height * 0.02),
        Neumorphic(
            style: NeumorphicStyle(
                color: backgroundColor,
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(20),
                )),
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                height: size.height * 0.3,
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
        SizedBox(height: size.height * 0.02),
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
