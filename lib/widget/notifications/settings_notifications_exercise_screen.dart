import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/hexcolor_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsNotificationsExerciseWidget extends StatefulWidget {
  final ColorConstantController color;
  const SettingsNotificationsExerciseWidget({Key? key, required this.color})
      : super(key: key);

  @override
  _SettingsNotificationsExerciseWidgetState createState() =>
      _SettingsNotificationsExerciseWidgetState();
}

class _SettingsNotificationsExerciseWidgetState
    extends State<SettingsNotificationsExerciseWidget> {
  bool isOpen = false;
  bool isMute = false;

  @override
  void initState() {
    super.initState();
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
                          child: Image.asset('assets/images/menuOlahraga.png'),
                        ),
                      ),
                      SizedBox(width: 18.w),
                      Text(
                        'Notifikasi SirkaExercise',
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
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                      ]),
                  SizedBox(height: 18.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jadwal Olahraga',
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
                              'Sarapan: 7.00 WIB',
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
                                  onPressed: () {},
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
                                      isMute = !isMute;
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
                                    isMute
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
                              'Makan siang: 13.00 WIB',
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
                                  onPressed: () {},
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
                                      isMute = !isMute;
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
                                    isMute
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
                              'Makan Malam: 17.00 WIB',
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
                                  onPressed: () {},
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
                                      isMute = !isMute;
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
                                    isMute
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
                      child: Image.asset('assets/images/menuOlahraga.png'),
                    ),
                  ),
                  SizedBox(width: 18.w),
                  Text(
                    'Notifikasi SirkaExercise',
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
