import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/hex_color.dart';

class InformationController extends GetxController {
  void loadingDialog(String text) {
    Get.dialog(Scaffold(
      backgroundColor: HexColor.fromHex('#4E5749').withOpacity(0.3),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: HexColor.fromHex('#FFFFFF'),
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: HexColor.fromHex('#000000').withOpacity(0.2),
                  blurRadius: 40,
                  spreadRadius: 6)
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: HexColor.fromHex('#8CD15D'),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                color: HexColor.fromHex('#8CD15D'),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void snackBarError(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.white,
    );
  }

  void showSuccessSnackBar(String body) {
    Get.rawSnackbar(
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: HexColor.fromHex('#8CD15D'),
      boxShadows: <BoxShadow>[
        BoxShadow(
            color: HexColor.fromHex('#000000').withOpacity(0.2),
            blurRadius: 40,
            spreadRadius: 6)
      ],
      snackPosition: SnackPosition.TOP,
      borderRadius: 20,
      duration: Duration(seconds: 3),
      messageText: Text(
        body,
        textAlign: TextAlign.center,
        maxLines: 30,
        style: GoogleFonts.inter(
            textStyle: TextStyle(
                color: HexColor.fromHex('#FFFFFF'),
                fontSize: 16,
                fontWeight: FontWeight.normal)),
      ),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOut,
      barBlur: 20,
      margin: EdgeInsets.all(10),
    );
  }

  void showErrorSnackBar(String e) {
    Get.rawSnackbar(
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Colors.red,
      boxShadows: <BoxShadow>[
        BoxShadow(
            color: HexColor.fromHex('#000000').withOpacity(0.2),
            blurRadius: 40,
            spreadRadius: 6)
      ],
      duration: Duration(seconds: 3),
      borderRadius: 20,
      messageText: Text(
        e,
        textAlign: TextAlign.center,
        maxLines: 30,
        style: GoogleFonts.inter(
            textStyle: TextStyle(
                color: HexColor.fromHex('#FFFFFF'),
                fontSize: 16,
                fontWeight: FontWeight.normal)),
      ),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOut,
      barBlur: 20,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(10),
    );
  }
}
