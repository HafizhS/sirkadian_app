import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/constant/hex_color.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:sirkadian_app/controller/subscription_controller.dart';
import 'package:sirkadian_app/screen/subscription/subscription_payment_screen.dart';

import '../../controller/hexcolor_controller.dart';
import '../../model/subscription_model/subscription_all_model.dart';

class ProgramDetailScreen2 extends StatefulWidget {
  final SubscriptionPackages subscriptionItem;

  ProgramDetailScreen2({
    required this.subscriptionItem,
    Key? key,
  }) : super(key: key);

  @override
  State<ProgramDetailScreen2> createState() => _ProgramDetailScreen2State();
}

class _ProgramDetailScreen2State extends State<ProgramDetailScreen2> {
  final subscriptionController = Get.find<SubscriptionController>();
  final informationController = Get.put(InformationController());
  final color = Get.find<ColorConstantController>();
  List<String> listDapatkan = [
    'Rekomendasi pola makan',
    'Rekomendasi menu dan resep makanan',
    'Rekomendasi pola kebutuhan cairan',
    'Reminder kebutuhan cairan',
    'Rekomendasi olahraga'
  ];

  final isSubscriptionVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    var imageContainerHeight = MediaQuery.of(context).size.height * .35;
    var roundDecorationHeight = 30.0;

    var title = widget.subscriptionItem.name;
    var desc = widget.subscriptionItem.description;
    var type = widget.subscriptionItem.subscriptionTypeName;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 35),
          onPressed: () {
            if (isSubscriptionVisible.value) {
              isSubscriptionVisible.value = false;
              return;
            }
            Navigator.of(context).pop();
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: imageContainerHeight,
                  color: Colors.blue,
                  child: Stack(fit: StackFit.expand, children: [
                    Image.asset("assets/images/testImage1.jpg",
                        fit: BoxFit.cover),
                    Container(
                      height: 350.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0),
                            Colors.black,
                          ],
                          stops: [0.0, 1],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: roundDecorationHeight + 10,
                          left: 15,
                          right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("${type}",
                              style: GoogleFonts.poppins(color: Colors.white)),
                          Text("${title}",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 21.sp))
                        ],
                      ),
                    ),
                  ]),
                ),
                WillPopScope(
                  onWillPop: () {
                    return Future(() {
                      if (isSubscriptionVisible.value) {
                        isSubscriptionVisible.value = false;
                        return false;
                      }
                      return true;
                    });
                  },
                  child: Obx(() => isSubscriptionVisible.value
                      ? _buildSubscription()
                      : _buildContent(context)),
                ),
              ],
            ),

            // Round Decoration
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(
                  top: imageContainerHeight - roundDecorationHeight + 1),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white,
              ),
              height: roundDecorationHeight,
            )
          ],
        ),
      ),
    );
  }

  Expanded _buildSubscription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Program yang anda pilih tersedia",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 22.sp),
              ),
              const SizedBox(height: 35),
              Text(
                "Upgrade your account and get full access to jumpstart your practice.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400, fontSize: 15.sp),
              ),
              const SizedBox(height: 45),
              SizedBox(
                height: 70,
                child: Card(
                  color: HexColor.fromHex("#F5F5F5"),
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(50),
                          right: Radius.circular(50))),
                  child: Row(
                    children: [
                      Checkbox(
                          shape: CircleBorder(),
                          activeColor: Colors.green,
                          value: true,
                          onChanged: (value) {}),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("1 Bulan",
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600)),
                          Text(
                            "Bayar per bulan, batalkan kapan saja.",
                            style: GoogleFonts.inter(fontSize: 9.sp),
                          )
                        ],
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("IDR",
                                      style: GoogleFonts.poppins(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w400)),
                                  const SizedBox(width: 3),
                                  Text("35.000",
                                      style: GoogleFonts.poppins(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600)),
                                  Text("/bulan",
                                      style: GoogleFonts.poppins(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w400)),
                                ],
                              )))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 70,
                child: Card(
                  color: HexColor.fromHex("#F5F5F5"),
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(50),
                          right: Radius.circular(50))),
                  child: Row(
                    children: [
                      Checkbox(
                          shape: CircleBorder(),
                          activeColor: Colors.green,
                          value: true,
                          onChanged: (value) {}),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("1 Bulan",
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600)),
                          Text(
                            "Bayar per bulan, batalkan kapan saja.",
                            style: GoogleFonts.inter(fontSize: 9.sp),
                          )
                        ],
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("IDR",
                                      style: GoogleFonts.poppins(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w400)),
                                  const SizedBox(width: 3),
                                  Text("35.000",
                                      style: GoogleFonts.poppins(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600)),
                                  Text("/bulan",
                                      style: GoogleFonts.poppins(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w400)),
                                ],
                              )))
                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + 5),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: HexColor.fromHex("73C639")),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).push(
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    SubscriptionPaymentScreen()));
                      },
                      child: Text("Lanjutkan Pembayaran",
                          style: GoogleFonts.inter(color: Colors.white)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildContent(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "Mulailah perjalanan penurunan berat badanmu dan dapatkan hasil yang diinginkan dengan rekomendasi program diet berlangganan yang telah Sirkadian rencanakan sehari-hari khusus untukmu.",
                  style: GoogleFonts.inter(fontSize: 13.sp),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dapatkan :",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    ...listDapatkan
                        .map((e) => Row(children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: HexColor.fromHex("#73C639")),
                                width: 10,
                                height: 10,
                                margin: EdgeInsets.symmetric(vertical: 6),
                              ),
                              const SizedBox(width: 10),
                              Text(e, style: GoogleFonts.inter())
                            ]))
                        .toList()
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 5),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: HexColor.fromHex("73C639")),
                      onPressed: () {
                        isSubscriptionVisible.value = true;
                      },
                      child: Text(
                        "Berlangganan",
                        style: GoogleFonts.inter(color: Colors.white),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
