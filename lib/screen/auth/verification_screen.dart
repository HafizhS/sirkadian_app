import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/hex_color.dart';

import '../../controller/hexcolor_controller.dart';
import '../../model/auth_model/activation_request_model.dart';

class VerificationScreen extends StatefulWidget {
  // final int? id;
  // final String? websocketUrl;
  // final String? purpose;
  VerificationScreen({
    Key? key,
    // this.id,
    // this.websocketUrl,
    // this.purpose,
  }) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with WidgetsBindingObserver {
  final data = GetStorage('myData');
  final authController = Get.find<AuthController>();
  final informationController = Get.find<InformationController>();
  final color = Get.find<ColorConstantController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.bgColor,
      body: SafeArea(
          child: Obx(
        () => authController.cekWebsocket.value
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 40.h),
                height: 800.h,
                width: 360.w,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //segmen 1
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: NeumorphicButton(
                                    onPressed: () {
                                      Get.back();
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
                                  'Aktivasi Akun',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: color.secondaryTextColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(width: 30.h)
                              ],
                            ),
                            SizedBox(
                              height: 28.h,
                            ),
                            Text(
                              'Akun Anda Telah diverifikasi, aktivasi sekarang!',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: color.secondaryTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),

                      //segmen 2
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          NeumorphicButton(
                              margin: EdgeInsets.only(top: 12.h),
                              onPressed: () {
                                final _data = data.read('dataRegister');
                                final activationRequest = ActivationRequest(
                                    code: int.parse(
                                        authController.websocketResponse.code!),
                                    email: _data['email']);

                                authController.postActivation(
                                    activationRequest, _data['id']);
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
                                  vertical: 12.h, horizontal: 120.w),
                              child: Text(
                                "Aktivasi",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.primaryColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              )),
                        ],
                      ),
                    ]),
              )
            : Container(
                margin: EdgeInsets.symmetric(vertical: 40.h),
                height: 800.h,
                width: 360.w,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //segmen 1
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: NeumorphicButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.circle(),
                                      color: HexColor.fromHex('#F0F3EC'),
                                    ),
                                    padding: EdgeInsets.all(16.sp),
                                    child: FaIcon(
                                      FontAwesomeIcons.chevronLeft,
                                      size: 16.sp,
                                      color: HexColor.fromHex('#777B71'),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Verifikasi Akun',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: color.secondaryTextColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(width: 30.w)
                              ],
                            ),
                            SizedBox(
                              height: 28.h,
                            ),
                            Text(
                              'Kami sudah mengirimkan e-mail verfikasi ke alamat e-mail Kamu! Silahkan cek akun kamu di :',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: color.secondaryTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                authController.data
                                            .read('dataRegister')['email']
                                            .toString() !=
                                        ''
                                    ? authController.data
                                        .read('dataRegister')['email']
                                        .toString()
                                    : 'user@gmail.com',
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.tersierColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
      )),
    );
  }
}
