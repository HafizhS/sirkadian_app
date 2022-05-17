import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/controller/information_controller.dart';

import '../../constant/hex_color.dart';

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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: HexColor.fromHex('#F0F3EC'),
      body: SafeArea(
          child: Obx(
        () => authController.cekWebsocket.value
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                height: size.height,
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //segmen 1
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
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
                                      color: HexColor.fromHex('#F0F3EC'),
                                    ),
                                    padding: const EdgeInsets.all(16.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.chevronLeft,
                                      size: 16,
                                      color: HexColor.fromHex('#777B71'),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Aktivasi Akun',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: HexColor.fromHex('#4E5749'),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(width: size.width * 0.1)
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            Text(
                              'Akun Anda Telah diverifikasi, aktivasi sekarang!',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: HexColor.fromHex('#4E5749'),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                          ],
                        ),
                      ),

                      //segmen 2
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          NeumorphicButton(
                              margin: EdgeInsets.only(top: 12),
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
                                  color: HexColor.fromHex('#F0F3EC'),
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
                                  vertical: 12, horizontal: size.width * 0.3),
                              child: Text(
                                "Aktivasi",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: HexColor.fromHex('#4E5749'),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                              )),
                        ],
                      ),
                    ]),
              )
            : Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                height: size.height,
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //segmen 1
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
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
                                    padding: const EdgeInsets.all(16.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.chevronLeft,
                                      size: 16,
                                      color: HexColor.fromHex('#777B71'),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Verifikasi Akun',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: HexColor.fromHex('#4E5749'),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(width: size.width * 0.1)
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            Text(
                              'Kami sudah mengirimkan e-mail verfikasi ke alamat e-mail Kamu! Silahkan cek akun kamu di :',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: HexColor.fromHex('#4E5749'),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
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
                                      color: HexColor.fromHex('#6A994E'),
                                      fontSize: 16,
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
