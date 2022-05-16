import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/healthware_controller.dart';

import '../../constant/color.dart';

class HealthwareDeviceScreen extends StatefulWidget {
  HealthwareDeviceScreen({Key? key}) : super(key: key);

  @override
  State<HealthwareDeviceScreen> createState() => _HealthwareDeviceScreenState();
}

class _HealthwareDeviceScreenState extends State<HealthwareDeviceScreen> {
  final color = Get.find<ColorConstantController>();
  final healthwareController = Get.find<HealthwareController>();
  bool isMeasure = true;

  @override
  void initState() {
    healthwareController.getDateTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: NeumorphicButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.circle(),
                        color: color.primaryColor,
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: FaIcon(
                        FontAwesomeIcons.bars,
                        size: 16,
                        color: color.secondaryTextColor,
                      ),
                    ),
                  ),
                  Text(
                    'Sirka Smart Body Scale',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: color.primaryTextColor,
                          fontSize: 16,
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
                        FontAwesomeIcons.cog,
                        size: 16,
                        color: color.secondaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),

              //segment 2
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NeumorphicButton(
                      margin: EdgeInsets.only(top: 12),
                      onPressed: () {
                        setState(() {
                          isMeasure = true;
                        });
                      },
                      style: NeumorphicStyle(
                          depth: isMeasure ? -4 : 4,
                          color: color.primaryColor,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topLeft: Radius.circular(20)))),
                      padding: EdgeInsets.symmetric(
                          vertical: 12, horizontal: size.width * 0.1),
                      child: Text(
                        'Pengukuran',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: isMeasure
                                  ? color.secondaryColor
                                  : color.secondaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      )),
                  NeumorphicButton(
                      margin: EdgeInsets.only(top: 12),
                      onPressed: () {
                        setState(() {
                          isMeasure = false;
                        });
                      },
                      style: NeumorphicStyle(
                          depth: isMeasure ? 4 : -4,
                          color: color.primaryColor,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  topRight: Radius.circular(20)))),
                      padding: EdgeInsets.symmetric(
                          vertical: 12, horizontal: size.width * 0.1),
                      child: Text(
                        'Hasil Data',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: isMeasure
                                  ? color.secondaryTextColor
                                  : color.secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      )),
                ],
              ),
              SizedBox(height: size.height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 200),
                    crossFadeState: isMeasure
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: size.height * 0.2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                      'assets/images/sirkabodyscale.jpg'),
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Battery : ',
                                          style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                            color: color.primaryTextColor,
                                            fontSize: 14,
                                          )),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '70%  ',
                                              style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    color:
                                                        color.primaryTextColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      FaIcon(FontAwesomeIcons.bolt,
                                          color: color.yellowColor, size: 12)
                                    ],
                                  ),
                                  NeumorphicButton(
                                      margin: EdgeInsets.only(top: 12),
                                      onPressed: () {},
                                      style: NeumorphicStyle(
                                          color: color.secondaryColor,
                                          shape: NeumorphicShape.flat,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(20),
                                          )
                                          //border: NeumorphicBorder()
                                          ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: size.width * 0.15),
                                      child: Text(
                                        "Sync",
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                              color: color.primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )),
                                  NeumorphicButton(
                                      margin: EdgeInsets.only(top: 12),
                                      onPressed: () {},
                                      style: NeumorphicStyle(
                                          color: color.secondaryColor,
                                          shape: NeumorphicShape.flat,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(20),
                                          )
                                          //border: NeumorphicBorder()
                                          ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: size.width * 0.16),
                                      child: Text(
                                        "Pair",
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                              color: color.primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.03),
                          Text(
                            'Riwayat Pengukuran',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: isMeasure
                                      ? color.secondaryTextColor
                                      : color.secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: size.height * 0.5,
                            child: ListView(children: [
                              Neumorphic(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  color: color.primaryColor,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(20)),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: ListTile(
                                  leading: SizedBox(
                                    height: size.height * 0.2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                          'assets/images/sirkabodyscale.jpg'),
                                    ),
                                  ),
                                  title: RichText(
                                    text: TextSpan(
                                      text: healthwareController.dateNoww,
                                      style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                        color: color.primaryTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' (04.00 WIB)',
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                color: color.primaryTextColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Text(
                                    'BMI: 21 | TFB: 28% | FFM: 23  | TBF: 30',
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                      color: color.primaryTextColor,
                                      fontSize: 12,
                                    )),
                                  ),
                                  trailing: Text(
                                    '60 kg',
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                      color: color.primaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    )),
                                  ),
                                ),
                              ),
                              Neumorphic(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  color: color.primaryColor,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(20)),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: ListTile(
                                  leading: SizedBox(
                                    height: size.height * 0.2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                          'assets/images/sirkabodyscale.jpg'),
                                    ),
                                  ),
                                  title: RichText(
                                    text: TextSpan(
                                      text: healthwareController.dateNoww,
                                      style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                        color: color.primaryTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' (01.00 WIB)',
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                color: color.primaryTextColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Text(
                                    'BMI: 21 | TFB: 28% | FFM: 23   | TBF: 30',
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                      color: color.primaryTextColor,
                                      fontSize: 12,
                                    )),
                                  ),
                                  trailing: Text(
                                    '61 kg',
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                      color: color.primaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    )),
                                  ),
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                    secondChild: Container(
                      child: Column(
                        children: [
                          HealthwareGauge(
                            color: color,
                            size: size,
                            title: 'Berat Badan',
                            value: 0.5,
                            item_1: '60 kg',
                            item_2: '78 kg',
                            item_3: '85 kg',
                            class_1: 'Underweight',
                            class_2: 'Normal',
                            class_3: 'Overweight',
                            class_4: 'Obese',
                          ),
                          SizedBox(height: size.height * 0.01),
                          Divider(
                              color: color.secondaryTextColor.withOpacity(0.3),
                              height: 30),
                          SizedBox(height: size.height * 0.02),
                          HealthwareGauge(
                            color: color,
                            size: size,
                            title: 'Body Mass Index',
                            value: 0.5,
                            item_1: '18.5',
                            item_2: '25.0',
                            item_3: '30.0',
                            class_1: 'Underweight',
                            class_2: 'Normal',
                            class_3: 'Overweight',
                            class_4: 'Obese',
                          ),
                          SizedBox(height: size.height * 0.01),
                          Divider(
                              color: color.secondaryTextColor.withOpacity(0.3),
                              height: 30),
                          SizedBox(height: size.height * 0.02),
                          HealthwareGauge(
                            color: color,
                            size: size,
                            title: 'Total Fat Body',
                            value: 0.35,
                            item_1: '10%',
                            item_2: '30%',
                            item_3: '45%',
                            class_1: 'Underfat',
                            class_2: 'Healthy',
                            class_3: 'Overfat',
                            class_4: 'Obese',
                          ),
                          SizedBox(height: size.height * 0.01),
                          Divider(
                              color: color.secondaryTextColor.withOpacity(0.3),
                              height: 30),
                          SizedBox(height: size.height * 0.02),
                          HealthwareGauge(
                            color: color,
                            size: size,
                            title: 'Fat-Free Mass Index',
                            value: 0.5,
                            item_1: '18.5',
                            item_2: '25.0',
                            item_3: '30.0',
                            class_1: 'Underweight',
                            class_2: 'Normal',
                            class_3: 'Overweight',
                            class_4: 'Obese',
                          ),
                          SizedBox(height: size.height * 0.01),
                          Divider(
                              color: color.secondaryTextColor.withOpacity(0.3),
                              height: 30),
                          SizedBox(height: size.height * 0.02),
                          HealthwareGauge(
                            color: color,
                            size: size,
                            title: 'Total Body Fluid',
                            value: 0.5,
                            item_1: '18.5',
                            item_2: '25.0',
                            item_3: '30.0',
                            class_1: 'underweight',
                            class_2: 'normal',
                            class_3: 'overweight',
                            class_4: 'obese',
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class HealthwareGauge extends StatelessWidget {
  const HealthwareGauge({
    Key? key,
    required this.color,
    required this.size,
    required this.title,
    required this.value,
    required this.item_1,
    required this.item_2,
    required this.item_3,
    required this.class_1,
    required this.class_2,
    required this.class_3,
    required this.class_4,
  }) : super(key: key);

  final ColorConstantController color;
  final Size size;
  final String title;
  final double value;
  final String item_1;
  final String item_2;
  final String item_3;
  final String class_1;
  final String class_2;
  final String class_3;
  final String class_4;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(title,
          style: GoogleFonts.inter(
            textStyle: TextStyle(
                color: color.primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          )),
      SizedBox(height: size.height * 0.02),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(item_1,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  )),
              Text(item_2,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  )),
              Text(item_3,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  )),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Neumorphic(
              style: NeumorphicStyle(
                  depth: -4,
                  color: color.backgroundColor,
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(20),
                  )),
              child: Stack(alignment: Alignment.centerLeft, children: [
                Container(
                  height: size.height * 0.02,
                  width: size.width,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: color.secondaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  height: size.height * 0.02,
                  width: size.width * value,
                ),
              ])),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(class_1,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  )),
              Text(class_2,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  )),
              Text(class_3,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  )),
              Text(class_4,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  )),
            ],
          ),
        ],
      )
    ]);
  }
}
