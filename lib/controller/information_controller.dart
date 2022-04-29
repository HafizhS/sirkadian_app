import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/hex_color.dart';

class InformationController extends GetxController {
  void loadingDialog(String text) {
    Get.dialog(Scaffold(
      backgroundColor: HexColor.fromHex('#000000').withOpacity(0.3),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: HexColor.fromHex('#FFFFFF'),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              color: HexColor.fromHex('#FFFFFF'),
            )
          ],
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
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: HexColor.fromHex('#5B9423'),
      snackPosition: SnackPosition.TOP,
      borderRadius: 5,
      messageText: Text(
        body,
        maxLines: 30,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOut,
      barBlur: 20,
      margin: EdgeInsets.zero,
    );
  }

  void showErrorSnackBar(String e) {
    Get.rawSnackbar(
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: Colors.red,
      borderRadius: 5,
      messageText: Text(
        e,
        maxLines: 30,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOut,
      barBlur: 20,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.zero,
    );
  }

  void showErrorDialog(BuildContext context,
      {String? e,
      String? eventButtonText,
      void Function()? eventButtonFunction}) {
    var size = MediaQuery.of(context).size;
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.red.shade400,
        scrollable: true,
        content: Column(
          children: [
            Text(
              e!,
              style: TextStyle(color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF346343),
                          borderRadius: BorderRadius.circular(15)),
                      alignment: Alignment.center,
                      height: size.height * 0.05,
                      width: size.width * 0.2,
                      child: Text(
                        'Tutup',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                TextButton(
                  onPressed: eventButtonFunction!,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFCD7858),
                          borderRadius: BorderRadius.circular(15)),
                      alignment: Alignment.center,
                      height: size.height * 0.05,
                      width: size.width * 0.2,
                      child: Text(
                        eventButtonText!,
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
