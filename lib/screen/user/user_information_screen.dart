import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/screen/user/user_information_setting_screen.dart';

import '../../controller/hexcolor_controller.dart';
import '../../controller/text_controller.dart';
import '../../controller/user_controller.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  _UserInformationScreenState createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final textController = Get.find<InitialSetupTextC>();
  final userController = Get.find<UserController>();
  final color = Get.find<ColorConstantController>();
  bool isOpen = false;

  @override
  void initState() {
    userController.getUserInformation();
    // userController.getUserHealthHistoryLatest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Obx(
      () => userController.isLoadingUserInformation.isTrue ||
              userController.isLoadingUserHealthHistoryLatest.isTrue
          ? Center(
              child: CircularProgressIndicator(
                color: color.secondaryColor,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
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
                              'Informasi User',
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
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserInformationSettingScreen()));
                                },
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
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/user_male.jpg'),
                                radius: 60,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Text(
                                'Test',
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.primaryTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
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
                                  horizontal: 20, vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        20.toString(),
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                              color: color.primaryTextColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Text(
                                        'Usia',
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                              color: color.primaryTextColor,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        (userController
                                                    .userHealthHistoryLatestResponse
                                                    .value
                                                    .weight! /
                                                ((userController
                                                            .userHealthHistoryLatestResponse
                                                            .value
                                                            .height! /
                                                        100) *
                                                    (userController
                                                            .userHealthHistoryLatestResponse
                                                            .value
                                                            .height! /
                                                        100)))
                                            .toStringAsFixed(0),
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                              color: color.primaryTextColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Text(
                                        'BMI',
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                              color: color.primaryTextColor,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: userController
                                                .userHealthHistoryLatestResponse
                                                .value
                                                .height!
                                                .toStringAsFixed(0),
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: color.primaryTextColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: ' cm',
                                                style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      color: color
                                                          .primaryTextColor,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              )
                                            ]),
                                      ),
                                      Text(
                                        'Tinggi Badan',
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                              color: color.primaryTextColor,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: userController
                                                .userHealthHistoryLatestResponse
                                                .value
                                                .weight!
                                                .toStringAsFixed(0),
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: color.primaryTextColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: ' kg',
                                                style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      color: color
                                                          .primaryTextColor,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              )
                                            ]),
                                      ),
                                      Text(
                                        'Berat Badan',
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                              color: color.primaryTextColor,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            'Integrasi Pola Hidup Sehat Anda Hari Ini',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: color.primaryTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                      SizedBox(height: size.height * 0.01),
                      childUserGauge(size),
                    ],
                  ),
                ),
              ),
            ),
    ));
  }

  Container childUserGauge(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Column(
            children: [
              IntegrateBarWidget(
                onTap: () {},
                colorText: color,
                size: size,
                title: 'Nutrisi',
                // kebutuhanDipenuhi: (foodC.calorie /
                //         necessityController
                //             .productList.value!.calorie!) *
                //     200,
                kebutuhanDipenuhi: 80,
                color: Colors.yellow.shade900,
              ),
              SizedBox(height: size.height * 0.02),
              IntegrateBarWidget(
                onTap: () {},
                colorText: color,
                size: size,
                title: 'Olahraga',
                kebutuhanDipenuhi: 120,
                color: Colors.green.shade400,
              ),
              SizedBox(height: size.height * 0.02),
              IntegrateBarWidget(
                onTap: () {},
                colorText: color,
                size: size,
                title: 'Cairan',
                kebutuhanDipenuhi: 40,
                color: Colors.blue.shade400,
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ],
      ),
    );
  }
}

class IntegrateBarWidget extends StatelessWidget {
  const IntegrateBarWidget({
    Key? key,
    required this.size,
    required this.title,
    // required this.kebutuhanHarian,
    required this.kebutuhanDipenuhi,
    required this.color,
    required this.colorText,
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final String title;
  // final double kebutuhanHarian;
  final double kebutuhanDipenuhi;
  final Color color;
  final ColorConstantController colorText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.15,
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: colorText.primaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Stack(alignment: Alignment.centerLeft, children: [
                Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    color: colorText.primaryColor,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    height: size.height * 0.03,
                    width: size.width * 0.6,
                  ),
                ),
                Container(
                  height: size.height * 0.03,
                  width: kebutuhanDipenuhi,
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(20)),
                ),
              ]),
              // SizedBox(width: size.width * 0.01),
              IconButton(
                onPressed: onTap,
                icon: FaIcon(
                  FontAwesomeIcons.chevronDown,
                ),
                alignment: Alignment.center,
                iconSize: 12,
                padding: EdgeInsets.all(0),
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                splashRadius: 16,
              )
            ],
          ),
        ],
      ),
    );
  }
}
