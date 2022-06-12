import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import '../../../controller/hexcolor_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/notification_controller.dart';

class SettingsNotificationsFluidWidget extends StatefulWidget {
  final ColorConstantController color;
  final NotificationController notificationController;
  final InformationController informationController;
  const SettingsNotificationsFluidWidget(
      {Key? key,
      required this.color,
      required this.notificationController,
      required this.informationController})
      : super(key: key);

  @override
  _SettingsNotificationsFluidWidgetState createState() =>
      _SettingsNotificationsFluidWidgetState();
}

class _SettingsNotificationsFluidWidgetState
    extends State<SettingsNotificationsFluidWidget> {
  bool isOpen = false;

  Future<void> _showTimePicker(session, initialTime) async {
    await showTimePicker(
      context: context,
      initialTime: initialTime,
    ).then((value) {
      if (value != null) {
        if (session == 'Minum1') {
          setState(() {
            widget.notificationController.timeOfDayMinum1 = value;
            widget.notificationController.hourMinum1 =
                widget.notificationController.timeOfDayMinum1.hour;
            widget.notificationController.minuteMinum1 =
                widget.notificationController.timeOfDayMinum1.minute;
          });

          widget.notificationController.rememberNotificationFluid('Minum1');

          widget.notificationController.notificationFluidMinum1(
              4, widget.notificationController.isSoundMinum1);
        } else if (session == 'Minum2') {
          setState(() {
            widget.notificationController.timeOfDayMinum2 = value;
            widget.notificationController.hourMinum2 =
                widget.notificationController.timeOfDayMinum2.hour;
            widget.notificationController.minuteMinum2 =
                widget.notificationController.timeOfDayMinum2.minute;
          });

          widget.notificationController.rememberNotificationFluid('Minum2');

          widget.notificationController.notificationFluidMinum2(
              5, widget.notificationController.isSoundMinum2);
        } else if (session == 'Minum3') {
          setState(() {
            widget.notificationController.timeOfDayMinum3 = value;
            widget.notificationController.hourMinum3 =
                widget.notificationController.timeOfDayMinum3.hour;
            widget.notificationController.minuteMinum3 =
                widget.notificationController.timeOfDayMinum3.minute;
          });

          widget.notificationController.rememberNotificationFluid('Minum3');

          widget.notificationController.notificationFluidMinum3(
              6, widget.notificationController.isSoundMinum3);
        } else {
          setState(() {
            widget.notificationController.timeOfDayMinum4 = value;
            widget.notificationController.hourMinum4 =
                widget.notificationController.timeOfDayMinum4.hour;
            widget.notificationController.minuteMinum4 =
                widget.notificationController.timeOfDayMinum4.minute;
          });

          widget.notificationController.rememberNotificationFluid('Minum4');

          widget.notificationController.notificationFluidMinum4(
              7, widget.notificationController.isSoundMinum4);
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
              height: 450.h,
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
                          child: Image.asset('assets/images/menuCairan.png'),
                        ),
                      ),
                      SizedBox(width: 18.w),
                      Text(
                        'Notifikasi SirkaFluid',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jadwal Minum',
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
                                //Minum1
                                widget.notificationController.hourMinum1 = 7;
                                widget.notificationController.minuteMinum1 = 00;
                                widget.notificationController.timeOfDayMinum1 =
                                    TimeOfDay(
                                        hour: widget
                                            .notificationController.hourMinum1!,
                                        minute: widget.notificationController
                                            .minuteMinum1!);
                                widget.notificationController.isSoundMinum1 =
                                    true;

                                //Minum2
                                widget.notificationController.hourMinum2 = 12;
                                widget.notificationController.minuteMinum2 = 00;

                                widget.notificationController.timeOfDayMinum2 =
                                    TimeOfDay(
                                        hour: widget
                                            .notificationController.hourMinum2!,
                                        minute: widget.notificationController
                                            .minuteMinum2!);
                                widget.notificationController.isSoundMinum2 =
                                    true;

                                //Minum3
                                widget.notificationController.hourMinum3 = 17;
                                widget.notificationController.minuteMinum3 = 00;
                                widget.notificationController.timeOfDayMinum3 =
                                    TimeOfDay(
                                        hour: widget
                                            .notificationController.hourMinum3!,
                                        minute: widget.notificationController
                                            .minuteMinum3!);
                                widget.notificationController.isSoundMinum3 =
                                    true;
                                //Minum4
                                widget.notificationController.hourMinum4 = 21;
                                widget.notificationController.minuteMinum4 = 00;
                                widget.notificationController.timeOfDayMinum4 =
                                    TimeOfDay(
                                        hour: widget
                                            .notificationController.hourMinum4!,
                                        minute: widget.notificationController
                                            .minuteMinum4!);
                                widget.notificationController.isSoundMinum4 =
                                    true;
                              });
                              widget.notificationController
                                  .rememberNotificationFluid('Minum1');

                              widget.notificationController
                                  .notificationFluidMinum1(
                                      4,
                                      widget.notificationController
                                          .isSoundMinum1);

                              widget.notificationController
                                  .rememberNotificationFluid('Minum2');

                              widget.notificationController
                                  .notificationFluidMinum2(
                                      5,
                                      widget.notificationController
                                          .isSoundMinum2);

                              widget.notificationController
                                  .rememberNotificationFluid('Minum3');

                              widget.notificationController
                                  .notificationFluidMinum3(
                                      6,
                                      widget.notificationController
                                          .isSoundMinum3);
                              widget.notificationController
                                  .rememberNotificationFluid('Minum4');

                              widget.notificationController
                                  .notificationFluidMinum3(
                                      7,
                                      widget.notificationController
                                          .isSoundMinum4);
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
                              widget.notificationController.timeOfDayMinum1
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
                                        'Minum1',
                                        widget.notificationController
                                            .timeOfDayMinum1);
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
                                              .isSoundMinum1 =
                                          !widget.notificationController
                                              .isSoundMinum1;
                                    });
                                    widget.notificationController
                                        .rememberNotificationFluid('Minum1');
                                    widget.notificationController
                                        .notificationFluidMinum1(
                                            4,
                                            widget.notificationController
                                                .isSoundMinum1);
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
                                    widget.notificationController.isSoundMinum1
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
                              widget.notificationController.timeOfDayMinum2
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
                                        'Minum2',
                                        widget.notificationController
                                            .timeOfDayMinum2);
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
                                              .isSoundMinum2 =
                                          !widget.notificationController
                                              .isSoundMinum2;
                                    });
                                    widget.notificationController
                                        .rememberNotificationFood('Minum2');
                                    widget.notificationController
                                        .notificationFluidMinum2(
                                            5,
                                            widget.notificationController
                                                .isSoundMinum2);
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
                                    widget.notificationController.isSoundMinum2
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
                              widget.notificationController.timeOfDayMinum3
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
                                        'Minum3',
                                        widget.notificationController
                                            .timeOfDayMinum3);
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
                                              .isSoundMinum3 =
                                          !widget.notificationController
                                              .isSoundMinum3;
                                    });
                                    widget.notificationController
                                        .rememberNotificationFluid('Minum3');
                                    widget.notificationController
                                        .notificationFluidMinum3(
                                            6,
                                            widget.notificationController
                                                .isSoundMinum3);
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
                                    widget.notificationController.isSoundMinum3
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
                              widget.notificationController.timeOfDayMinum4
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
                                        'Minum4',
                                        widget.notificationController
                                            .timeOfDayMinum4);
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
                                              .isSoundMinum4 =
                                          !widget.notificationController
                                              .isSoundMinum4;
                                    });
                                    widget.notificationController
                                        .rememberNotificationFood('Minum4');
                                    widget.notificationController
                                        .notificationFluidMinum4(
                                            7,
                                            widget.notificationController
                                                .isSoundMinum4);
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
                                    widget.notificationController.isSoundMinum4
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
                      child: Image.asset('assets/images/menuCairan.png'),
                    ),
                  ),
                  SizedBox(width: 18.w),
                  Text(
                    'Notifikasi SirkaFluid',
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
