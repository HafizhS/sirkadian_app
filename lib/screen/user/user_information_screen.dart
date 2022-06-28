import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:sirkadian_app/screen/user/user_information_setting_screen.dart';
import '../../controller/auth_controller.dart';
import '../../controller/hexcolor_controller.dart';
import '../../controller/text_controller.dart';
import '../../controller/user_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  _UserInformationScreenState createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final textController = Get.find<InitialSetupTextC>();
  final userController = Get.find<UserController>();
  final authController = Get.find<AuthController>();
  final informationController = Get.find<InformationController>();
  final color = Get.find<ColorConstantController>();
  bool isOpen = false;

  @override
  void initState() {
    // userController.getUserInformation();
    // userController.getUserHealthHistoryLatest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.w),
                      child: NeumorphicButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.circle(),
                          color: color.primaryColor,
                        ),
                        padding: EdgeInsets.all(16.sp),
                        child: FaIcon(
                          FontAwesomeIcons.chevronLeft,
                          size: 16.sp,
                          color: color.secondaryTextColor,
                        ),
                      ),
                    ),
                    Text(
                      'Informasi User',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20.w),
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
                        padding: EdgeInsets.all(16.sp),
                        child: FaIcon(
                          FontAwesomeIcons.cog,
                          size: 16.sp,
                          color: color.secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            preferredSize: Size.fromHeight(70.h)),
        body: Obx(
          () => userController.userInformationResponse.value.displayName ==
                      null ||
                  userController.userHealthHistoryLatestResponse.value.height ==
                      null
              ? Container(
                  height: 800.h,
                  width: 360.w,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: color.secondaryColor,
                        ),
                        NeumorphicButton(
                            margin: EdgeInsets.only(top: 28.h),
                            onPressed: () {
                              userController.getUserInformation();
                              userController.getUserHealthHistoryLatest();
                            },
                            style: NeumorphicStyle(
                                color: color.secondaryColor,
                                depth: 4,
                                // shadowDarkColor: HexColor.fromHex('#C3C3C3'),
                                // shadowLightColor: HexColor.fromHex('#FFFFFF'),
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(20),
                                )
                                //border: NeumorphicBorder()
                                ),
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 30.w),
                            child: Text(
                              "Refresh",
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: color.primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            )),
                      ]),
                )
              : SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10.sp),
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/user_male.jpg'),
                                  radius: 60.sp,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // SizedBox(width: 30.w),
                                    Text(
                                      '${userController.userInformationResponse.value.displayName ?? authController.data.read('dataUser')['username']}',
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            color: color.primaryTextColor,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    // SizedBox(width: 10.w),
                                    // InkWell(
                                    //   onTap: (){},
                                    //   child: FaIcon(
                                    //     FontAwesomeIcons.edit,
                                    //     size: 18.sp,
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                              Neumorphic(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  color: color.primaryColor,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(20)),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 20.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${DateTime.now().year - int.parse(userController.userInformationResponse.value.dob!.substring(0, 4))}',
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                color: color.primaryTextColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Text(
                                          'Usia',
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                color: color.primaryTextColor,
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Text(
                                          'BMI',
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                color: color.primaryTextColor,
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                    color:
                                                        color.primaryTextColor,
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: ' cm',
                                                  style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                        color: color
                                                            .primaryTextColor,
                                                        fontSize: 11.sp,
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
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                    color:
                                                        color.primaryTextColor,
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: ' kg',
                                                  style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                        color: color
                                                            .primaryTextColor,
                                                        fontSize: 11.sp,
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
                                                fontSize: 11.sp,
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
                            margin: EdgeInsets.all(10.sp),
                            child: Text(
                              'Integrasi Pola Hidup Sehat Anda Hari Ini',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                        SizedBox(height: 10.h),
                        childUserGauge(),
                      ],
                    ),
                  ),
                ),
        ));
  }

  Container childUserGauge() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Column(
            children: [
              IntegrateBarWidget(
                onTap: () {
                  informationController.snackBarError('Fitur Belum Tersedia',
                      'Kami sedang mengerjakan fitur tersebut');
                },
                colorText: color,

                title: 'Nutrisi',
                // kebutuhanDipenuhi: (foodC.calorie /
                //         necessityController
                //             .productList.value!.calorie!) *
                //     200,
                kebutuhanDipenuhi: 80,
                color: Colors.yellow.shade900,
              ),
              SizedBox(height: 18.h),
              IntegrateBarWidget(
                onTap: () {
                  informationController.snackBarError('Fitur Belum Tersedia',
                      'Kami sedang mengerjakan fitur tersebut');
                },
                colorText: color,
                title: 'Olahraga',
                kebutuhanDipenuhi: 120,
                color: Colors.green.shade400,
              ),
              SizedBox(height: 18.h),
              IntegrateBarWidget(
                onTap: () {
                  informationController.snackBarError('Fitur Belum Tersedia',
                      'Kami sedang mengerjakan fitur tersebut');
                },
                colorText: color,
                title: 'Cairan',
                kebutuhanDipenuhi: 40,
                color: Colors.blue.shade400,
              ),
              SizedBox(height: 18.h),
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
    required this.title,
    // required this.kebutuhanHarian,
    required this.kebutuhanDipenuhi,
    required this.color,
    required this.colorText,
    required this.onTap,
  }) : super(key: key);

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
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 60.w,
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: colorText.primaryTextColor,
                        fontSize: 12.sp,
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
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Container(
                    height: 18.h,
                    width: 200.w,
                  ),
                ),
                Container(
                  height: 18.h,
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
                iconSize: 12.sp,
                padding: EdgeInsets.all(0),
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                splashRadius: 16.sp,
              )
            ],
          ),
        ],
      ),
    );
  }
}
