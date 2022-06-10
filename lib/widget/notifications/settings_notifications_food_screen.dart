import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/hexcolor_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/notification_controller.dart';

class SettingsNotificationsFoodWidget extends StatefulWidget {
  final ColorConstantController color;
  final NotificationController notificationController;
  const SettingsNotificationsFoodWidget(
      {Key? key, required this.color, required this.notificationController})
      : super(key: key);

  @override
  _SettingsNotificationsFoodWidgetState createState() =>
      _SettingsNotificationsFoodWidgetState();
}

class _SettingsNotificationsFoodWidgetState
    extends State<SettingsNotificationsFoodWidget> {
  final data = GetStorage('myData');
  bool isOpen = false;
  bool isMuteSarapan = false;
  bool isMuteMakanSiang = false;
  bool isMuteMakanMalam = false;
  TimeOfDay timeOfDaySarapan = TimeOfDay(hour: 7, minute: 00);
  TimeOfDay timeOfDayMakanSiang = TimeOfDay(hour: 14, minute: 00);
  TimeOfDay timeOfDayMakanMalam = TimeOfDay(hour: 17, minute: 00);
  @override
  void initState() {
    getToD();
    super.initState();
  }

  void getToD() {
    if (data.read('dataNotificationFoodSarapan') != null) {
      timeOfDaySarapan = TimeOfDay(
          hour: data.read('dataNotificationFoodSarapan')['hour'],
          minute: data.read('dataNotificationFoodSarapan')['minute']);
    }
    if (data.read('dataNotificationFoodMakanSiang') != null) {
      timeOfDayMakanSiang = TimeOfDay(
          hour: data.read('dataNotificationFoodMakanSiang')['hour'],
          minute: data.read('dataNotificationFoodMakanSiang')['minute']);
    }
    if (data.read('dataNotificationFoodMakanMalam') != null) {
      timeOfDayMakanMalam = TimeOfDay(
          hour: data.read('dataNotificationFoodMakanMalam')['hour'],
          minute: data.read('dataNotificationFoodMakanMalam')['minute']);
    }
  }

  void _showTimePicker(session, initialTime) {
    showTimePicker(
      context: context,
      initialTime: initialTime,
    ).then((value) {
      if (session == 'Sarapan') {
        setState(() {
          timeOfDaySarapan = value!;
          widget.notificationController.hourSarapan = timeOfDaySarapan.hour;
          widget.notificationController.minuteSarapan = timeOfDaySarapan.minute;
        });
        widget.notificationController.cancel(1);
        widget.notificationController.rememberNotificationFood('Sarapan');
        widget.notificationController.notificationFoodSarapan(1);
      } else if (session == 'Makan Siang') {
        setState(() {
          timeOfDayMakanSiang = value!;
          widget.notificationController.hourMakanSiang =
              timeOfDayMakanSiang.hour;
          widget.notificationController.minuteMakanSiang =
              timeOfDayMakanSiang.minute;
        });
        widget.notificationController.cancel(2);
        widget.notificationController.rememberNotificationFood('Makan Siang');
        widget.notificationController.notificationFoodMakanSiang(2);
      } else {
        setState(() {
          timeOfDayMakanMalam = value!;
          widget.notificationController.hourMakanMalam =
              timeOfDayMakanMalam.hour;
          widget.notificationController.minuteMakanMalam =
              timeOfDayMakanMalam.minute;
        });
        widget.notificationController.cancel(3);
        widget.notificationController.rememberNotificationFood('Makan Malam');
        widget.notificationController.notificationFoodMakanMalam(3);
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
              height: 400.h,
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
                        'Notifikasi SirkaDiet',
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
                          onPressed: () {},
                          style: NeumorphicStyle(
                              color: widget.color.secondaryColor,
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(20),
                              )
                              //border: NeumorphicBorder()
                              ),
                          padding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 30.w),
                          child: Text(
                            "Ganti Ringtones",
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
                      Text(
                        'Jadwal Makan',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: widget.color.secondaryTextColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
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
                              timeOfDaySarapan.format(context).toString(),
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
                                        'Sarapan', timeOfDaySarapan);
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
                                      isMuteSarapan = !isMuteSarapan;
                                    });
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
                                    isMuteSarapan
                                        ? FontAwesomeIcons.volumeMute
                                        : FontAwesomeIcons.volumeUp,
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
                              timeOfDayMakanSiang.format(context).toString(),
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
                                        'Makan Siang', timeOfDayMakanSiang);
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
                                      isMuteMakanSiang = !isMuteMakanSiang;
                                    });
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
                                    isMuteMakanSiang
                                        ? FontAwesomeIcons.volumeMute
                                        : FontAwesomeIcons.volumeUp,
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
                              timeOfDayMakanMalam.format(context).toString(),
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
                                        'Makan Malam', timeOfDayMakanMalam);
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
                                      isMuteMakanMalam = !isMuteMakanMalam;
                                    });
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
                                    isMuteMakanMalam
                                        ? FontAwesomeIcons.volumeMute
                                        : FontAwesomeIcons.volumeUp,
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
                    'Notifikasi SirkaDiet',
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
