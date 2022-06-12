import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import '../../../controller/hexcolor_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/notification_controller.dart';

class SettingsNotificationsFoodWidget extends StatefulWidget {
  final ColorConstantController color;
  final NotificationController notificationController;
  final InformationController informationController;
  const SettingsNotificationsFoodWidget(
      {Key? key,
      required this.color,
      required this.notificationController,
      required this.informationController})
      : super(key: key);

  @override
  _SettingsNotificationsFoodWidgetState createState() =>
      _SettingsNotificationsFoodWidgetState();
}

class _SettingsNotificationsFoodWidgetState
    extends State<SettingsNotificationsFoodWidget> {
  bool isOpen = false;

  Future<void> _showTimePicker(session, initialTime) async {
    await showTimePicker(
      context: context,
      initialTime: initialTime,
    ).then((value) {
      if (value != null) {
        if (session == 'Sarapan') {
          setState(() {
            widget.notificationController.timeOfDaySarapan = value;
            widget.notificationController.hourSarapan =
                widget.notificationController.timeOfDaySarapan.hour;
            widget.notificationController.minuteSarapan =
                widget.notificationController.timeOfDaySarapan.minute;
          });

          widget.notificationController.rememberNotificationFood('Sarapan');

          widget.notificationController.notificationFoodSarapan(
              1, widget.notificationController.isSoundSarapan);
        } else if (session == 'Makan Siang') {
          setState(() {
            widget.notificationController.timeOfDayMakanSiang = value;
            widget.notificationController.hourMakanSiang =
                widget.notificationController.timeOfDayMakanSiang.hour;
            widget.notificationController.minuteMakanSiang =
                widget.notificationController.timeOfDayMakanSiang.minute;
          });

          widget.notificationController.rememberNotificationFood('Makan Siang');

          widget.notificationController.notificationFoodMakanSiang(
              2, widget.notificationController.isSoundMakanSiang);
        } else {
          setState(() {
            widget.notificationController.timeOfDayMakanMalam = value;
            widget.notificationController.hourMakanMalam =
                widget.notificationController.timeOfDayMakanMalam.hour;
            widget.notificationController.minuteMakanMalam =
                widget.notificationController.timeOfDayMakanMalam.minute;
          });

          widget.notificationController.rememberNotificationFood('Makan Malam');

          widget.notificationController.notificationFoodMakanMalam(
              3, widget.notificationController.isSoundMakanMalam);
        }
      } else {
        print('timepicker value null');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isOpen
        ? Neumorphic(
            padding: EdgeInsets.all(10.sp),
            style: NeumorphicStyle(
                color: widget.color.bgColor,
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(20),
                )),
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Container(
              height: 380.h,
              width: 360.w,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset('assets/images/menuMakan.png'),
                        ),
                      ),
                      SizedBox(width: 18.w),
                      Text(
                        'SirkaDiet',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: widget.color.primaryTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 18.w),
                      NeumorphicButton(
                        onPressed: () {
                          setState(() {
                            isOpen = false;
                          });
                        },
                        margin: EdgeInsets.all(10.sp),
                        style: NeumorphicStyle(
                          depth: 4,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.circle(),
                          color: widget.color.bgColor,
                        ),
                        padding: EdgeInsets.all(8.sp),
                        child: FaIcon(
                          FontAwesomeIcons.chevronUp,
                          size: 16.sp,
                          color: widget.color.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Suara: Default.wav',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: widget.color.secondaryTextColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      NeumorphicButton(
                          margin: EdgeInsets.only(top: 8.h, right: 10.w),
                          onPressed: () {
                            widget.informationController.snackBarError(
                                'Fitur Belum Tersedia',
                                'Kami sedang mengerjakan fitur tersebut.');
                          },
                          style: NeumorphicStyle(
                              color: widget.color.secondaryColor,
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(20),
                              )
                              //border: NeumorphicBorder()
                              ),
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 30.w),
                          child: Text(
                            "Ubah",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: widget.color.primaryColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jadwal Makan',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: widget.color.secondaryTextColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          NeumorphicButton(
                            onPressed: () {
                              setState(() {
                                //Sarapan
                                widget.notificationController.hourSarapan = 7;
                                widget.notificationController.minuteSarapan =
                                    00;
                                widget.notificationController.timeOfDaySarapan =
                                    TimeOfDay(
                                        hour: widget.notificationController
                                            .hourSarapan!,
                                        minute: widget.notificationController
                                            .minuteSarapan!);
                                widget.notificationController.isSoundSarapan =
                                    true;

                                //Makan Siang
                                widget.notificationController.hourMakanSiang =
                                    14;
                                widget.notificationController.minuteMakanSiang =
                                    00;

                                widget.notificationController
                                        .timeOfDayMakanSiang =
                                    TimeOfDay(
                                        hour: widget.notificationController
                                            .hourMakanSiang!,
                                        minute: widget.notificationController
                                            .minuteMakanSiang!);
                                widget.notificationController
                                    .isSoundMakanSiang = true;

                                //Makan Malam
                                widget.notificationController.hourMakanMalam =
                                    19;
                                widget.notificationController.minuteMakanMalam =
                                    00;
                                widget.notificationController
                                        .timeOfDayMakanMalam =
                                    TimeOfDay(
                                        hour: widget.notificationController
                                            .hourMakanMalam!,
                                        minute: widget.notificationController
                                            .minuteMakanMalam!);
                                widget.notificationController
                                    .isSoundMakanMalam = true;
                              });
                              widget.notificationController
                                  .rememberNotificationFood('Sarapan');

                              widget.notificationController
                                  .notificationFoodSarapan(
                                      1,
                                      widget.notificationController
                                          .isSoundSarapan);

                              widget.notificationController
                                  .rememberNotificationFood('Makan Siang');

                              widget.notificationController
                                  .notificationFoodMakanSiang(
                                      2,
                                      widget.notificationController
                                          .isSoundMakanSiang);

                              widget.notificationController
                                  .rememberNotificationFood('Makan Malam');

                              widget.notificationController
                                  .notificationFoodMakanMalam(
                                      3,
                                      widget.notificationController
                                          .isSoundMakanMalam);
                            },
                            style: NeumorphicStyle(
                                color: widget.color.bgColor,
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(20),
                                )),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 5.h),
                            margin: EdgeInsets.only(right: 8.w),
                            child: RichText(
                              text: TextSpan(
                                text: ' ',
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                  color: widget.color.primaryTextColor,
                                  fontSize: 12.sp,
                                )),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Reset',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: widget.color.secondaryColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Neumorphic(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        style: NeumorphicStyle(
                            depth: -4,
                            color: widget.color.backupPrimaryColor,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20),
                            )),
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.notificationController.timeOfDaySarapan
                                  .format(context)
                                  .toString(),
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: widget.color.secondaryTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Row(
                              children: [
                                NeumorphicButton(
                                  onPressed: () {
                                    _showTimePicker(
                                        'Sarapan',
                                        widget.notificationController
                                            .timeOfDaySarapan);
                                  },
                                  margin: EdgeInsets.all(5.sp),
                                  style: NeumorphicStyle(
                                    depth: 4,
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.circle(),
                                    color: widget.color.bgColor,
                                  ),
                                  padding: EdgeInsets.all(8.sp),
                                  child: FaIcon(
                                    FontAwesomeIcons.clock,
                                    size: 16.sp,
                                    color: widget.color.secondaryColor,
                                  ),
                                ),
                                NeumorphicButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.notificationController
                                              .isSoundSarapan =
                                          !widget.notificationController
                                              .isSoundSarapan;
                                    });
                                    widget.notificationController
                                        .rememberNotificationFood('Sarapan');
                                    widget.notificationController
                                        .notificationFoodSarapan(
                                            1,
                                            widget.notificationController
                                                .isSoundSarapan);
                                  },
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 10.h),
                                  style: NeumorphicStyle(
                                    depth: 4,
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.circle(),
                                    color: widget.color.bgColor,
                                  ),
                                  padding: EdgeInsets.all(8.sp),
                                  child: FaIcon(
                                    widget.notificationController.isSoundSarapan
                                        ? FontAwesomeIcons.volumeUp
                                        : FontAwesomeIcons.volumeMute,
                                    size: 16.sp,
                                    color: widget.color.secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Neumorphic(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        style: NeumorphicStyle(
                            depth: -4,
                            color: widget.color.backupPrimaryColor,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20),
                            )),
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.notificationController.timeOfDayMakanSiang
                                  .format(context)
                                  .toString(),
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: widget.color.secondaryTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Row(
                              children: [
                                NeumorphicButton(
                                  onPressed: () {
                                    _showTimePicker(
                                        'Makan Siang',
                                        widget.notificationController
                                            .timeOfDayMakanSiang);
                                  },
                                  margin: EdgeInsets.all(5.sp),
                                  style: NeumorphicStyle(
                                    depth: 4,
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.circle(),
                                    color: widget.color.bgColor,
                                  ),
                                  padding: EdgeInsets.all(8.sp),
                                  child: FaIcon(
                                    FontAwesomeIcons.clock,
                                    size: 16.sp,
                                    color: widget.color.secondaryColor,
                                  ),
                                ),
                                NeumorphicButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.notificationController
                                              .isSoundMakanSiang =
                                          !widget.notificationController
                                              .isSoundMakanSiang;
                                    });
                                    widget.notificationController
                                        .rememberNotificationFood(
                                            'Makan Siang');
                                    widget.notificationController
                                        .notificationFoodMakanSiang(
                                            2,
                                            widget.notificationController
                                                .isSoundMakanSiang);
                                  },
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 10.h),
                                  style: NeumorphicStyle(
                                    depth: 4,
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.circle(),
                                    color: widget.color.bgColor,
                                  ),
                                  padding: EdgeInsets.all(8.sp),
                                  child: FaIcon(
                                    widget.notificationController
                                            .isSoundMakanSiang
                                        ? FontAwesomeIcons.volumeUp
                                        : FontAwesomeIcons.volumeMute,
                                    size: 16.sp,
                                    color: widget.color.secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Neumorphic(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        style: NeumorphicStyle(
                            depth: -4,
                            color: widget.color.backupPrimaryColor,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20),
                            )),
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.notificationController.timeOfDayMakanMalam
                                  .format(context)
                                  .toString(),
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: widget.color.secondaryTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Row(
                              children: [
                                NeumorphicButton(
                                  onPressed: () {
                                    _showTimePicker(
                                        'Makan Malam',
                                        widget.notificationController
                                            .timeOfDayMakanMalam);
                                  },
                                  margin: EdgeInsets.all(5.sp),
                                  style: NeumorphicStyle(
                                    depth: 4,
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.circle(),
                                    color: widget.color.bgColor,
                                  ),
                                  padding: EdgeInsets.all(8.sp),
                                  child: FaIcon(
                                    FontAwesomeIcons.clock,
                                    size: 16.sp,
                                    color: widget.color.secondaryColor,
                                  ),
                                ),
                                NeumorphicButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.notificationController
                                              .isSoundMakanMalam =
                                          !widget.notificationController
                                              .isSoundMakanMalam;
                                    });
                                    widget.notificationController
                                        .rememberNotificationFood(
                                            'Makan Malam');
                                    widget.notificationController
                                        .notificationFoodMakanMalam(
                                            3,
                                            widget.notificationController
                                                .isSoundMakanMalam);
                                  },
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 10.h),
                                  style: NeumorphicStyle(
                                    depth: 4,
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.circle(),
                                    color: widget.color.bgColor,
                                  ),
                                  padding: EdgeInsets.all(8.sp),
                                  child: FaIcon(
                                    widget.notificationController
                                            .isSoundMakanMalam
                                        ? FontAwesomeIcons.volumeUp
                                        : FontAwesomeIcons.volumeMute,
                                    size: 16.sp,
                                    color: widget.color.secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ))
        : NeumorphicButton(
            onPressed: () {
              setState(() {
                isOpen = true;
              });
            },
            padding: EdgeInsets.all(10.sp),
            style: NeumorphicStyle(
                color: widget.color.bgColor,
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(20),
                )),
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Container(
              height: 50.h,
              width: 360.w,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/menuMakan.png'),
                    ),
                  ),
                  SizedBox(width: 18.w),
                  Text(
                    'SirkaDiet',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: widget.color.primaryTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 18.w),
                  Neumorphic(
                    margin: EdgeInsets.all(10.sp),
                    style: NeumorphicStyle(
                      depth: 0,
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.circle(),
                      color: widget.color.bgColor,
                    ),
                    padding: EdgeInsets.all(8.sp),
                    child: FaIcon(
                      FontAwesomeIcons.chevronDown,
                      size: 16.sp,
                      color: widget.color.secondaryColor,
                    ),
                  ),
                ],
              ),
            ));
  }
}
