import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/widget/exercise_widget/exercise_tile.dart';

import '../../../constant/color.dart';
import '../../../constant/hex_color.dart';
import '../../../widget/exercise_widget/exercise_gauge.dart';

class ExerciseGeneralScreen extends StatefulWidget {
  const ExerciseGeneralScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseGeneralScreen> createState() => _ExerciseGeneralScreenState();
}

class _ExerciseGeneralScreenState extends State<ExerciseGeneralScreen> {
  final authController = Get.find<AuthController>();
  final color = Get.find<ColorConstantController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: color.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: NeumorphicButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.circle(),
                        color: color.primaryColor,
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: FaIcon(
                        FontAwesomeIcons.chevronLeft,
                        size: 16,
                        color: color.secondaryTextColor,
                      ),
                    ),
                  ),
                  Text(
                    'SirkaExercise',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: color.primaryTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: NeumorphicButton(
                      onPressed: () {},
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.circle(),
                        color: color.primaryColor,
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: FaIcon(
                        FontAwesomeIcons.signal,
                        size: 16,
                        color: color.secondaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              //segment 2
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Progress',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.secondaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    margin: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ExerciseGauge(
                            backgroundColor: color.primaryColor,
                            foregroundColor: HexColor.fromHex('#94223D'),
                            value: 120,
                            day: 'S',
                            date: '21',
                            size: size),
                        ExerciseGauge(
                            backgroundColor: color.primaryColor,
                            foregroundColor: HexColor.fromHex('#5B9423'),
                            value: 65,
                            day: 'S',
                            date: '22',
                            size: size),
                        ExerciseGauge(
                            backgroundColor: color.primaryColor,
                            foregroundColor: HexColor.fromHex('#238094'),
                            value: 130,
                            day: 'R',
                            date: '23',
                            size: size),
                        ExerciseGauge(
                            backgroundColor: color.primaryColor,
                            foregroundColor: HexColor.fromHex('#5B9423'),
                            value: 150,
                            day: 'K',
                            date: '24',
                            size: size),
                        ExerciseGauge(
                            backgroundColor: color.primaryColor,
                            foregroundColor: HexColor.fromHex('#94223D'),
                            value: 100,
                            day: 'J',
                            date: '25',
                            size: size),
                        ExerciseGauge(
                            backgroundColor: color.primaryColor,
                            foregroundColor: HexColor.fromHex('#238094'),
                            value: 80,
                            day: 'S',
                            date: '26',
                            size: size),
                        ExerciseGauge(
                            backgroundColor: color.primaryColor,
                            foregroundColor: color.primaryColor,
                            value: 100,
                            day: 'M',
                            date: '27',
                            size: size),
                      ],
                    ),
                  )
                ],
              ),

              //segment 3
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Olahraga hari ini',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.secondaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  ExerciseTile(
                    title: 'Push Up',
                    subtitle_1: '3 reps',
                    subtitle_2: '500 kkal',
                    image: 'pushup.jpg',
                    color: color,
                    size: size,
                    isCheck: true,
                  ),
                  ExerciseTile(
                    title: 'Sit Up',
                    subtitle_1: '2 reps',
                    subtitle_2: '250 kkal',
                    image: 'situp.jpg',
                    color: color,
                    size: size,
                    isCheck: false,
                  ),
                  ExerciseTile(
                    title: 'Jogging',
                    subtitle_1: '30 menit',
                    subtitle_2: '800 kkal',
                    image: 'jogging.jpg',
                    color: color,
                    size: size,
                    isCheck: true,
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
