import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/model/auth_model/initialSetup_request_model.dart';

import '../../constant/hex_color.dart';
import '../../controller/auth_controller.dart';

class InitialSetupScreen extends StatefulWidget {
  InitialSetupScreen({Key? key}) : super(key: key);

  @override
  State<InitialSetupScreen> createState() => _InitialSetupScreenState();
}

class _InitialSetupScreenState extends State<InitialSetupScreen> {
  final authController = Get.find<AuthController>();
  final arguments = Get.arguments;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: HexColor.fromHex('#F0F3EC'),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 30),
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
                      SizedBox(
                        height: size.height * 0.2,
                      ),
                      Text(
                        'Selamat Datang di',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: HexColor.fromHex('#4E5749'),
                              fontSize: 22,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Text(
                        'Sirkadian',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: HexColor.fromHex('#5B9423'),
                              fontSize: 34,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Image.asset('assets/images/sirkadianlogo.png',
                          fit: BoxFit.fitHeight,
                          height: size.height * 0.07,
                          width: size.width * 0.15),
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
                          final initialSetupRequest = InitialSetupRequest(
                              activityLevel: 'low',
                              dob: '2002-10-25',
                              gender: 'male',
                              halal: false,
                              vegetarian: false,
                              vegan: false,
                              sportDifficulty: 'vigorous',
                              height: 175,
                              weight: 65,
                              lang: 'indonesia');
                          authController.postInitialSetup(
                              initialSetupRequest: initialSetupRequest,
                              accessToken: arguments[0].toString());
                        },
                        style: NeumorphicStyle(
                            color: HexColor.fromHex('#5B9423'),
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
                          "Selanjutnya",
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: HexColor.fromHex('#FFFFFF'),
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
