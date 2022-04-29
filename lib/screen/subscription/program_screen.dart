import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/subscription_controller.dart';

import '../../constant/color.dart';

class ProgramScreen extends StatefulWidget {
  ProgramScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProgramScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  final subscriptionController = Get.find<SubscriptionController>();
  final color = Get.find<ColorConstantController>();
  ScrollController scrollController = ScrollController();
  final closeTopContainer = false.obs;
  @override
  void initState() {
    subscriptionController.getSubscriptionAll();
    scrollController.addListener(() {
      setState(() {
        closeTopContainer.value = scrollController.offset > 130;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => subscriptionController.isLoadingSubscriptionAll == true
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: color.secondaryColor,
                ),
              ),
            )
          : Scaffold(
              backgroundColor: color.backgroundColor,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(!closeTopContainer.value
                      ? size.height * 0.3
                      : size.height * 0.1),
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 200),
                    crossFadeState: !closeTopContainer.value
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: Container(
                      padding: EdgeInsets.only(top: 40, right: 20, left: 20),
                      width: double.infinity,
                      height: size.height * 0.3,
                      decoration: BoxDecoration(color: color.secondaryColor,
                          // borderRadius:
                          //     BorderRadius.vertical(bottom: Radius.circular(30)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: color.blackColor.withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 6)
                          ]),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.bars,
                                    color: color.primaryColor,
                                  ),
                                ),
                                Stack(alignment: Alignment.center, children: [
                                  CircleAvatar(
                                    backgroundColor: color.primaryColor,
                                    radius: 25,
                                  ),
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/yuda.jpg'),
                                    radius: 20,
                                  ),
                                ]),
                              ],
                            ),
                            //

                            SizedBox(height: size.height * 0.03),

                            Text(
                              "Program Kesehatan Sirkadian",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 10, bottom: 20),
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: color.primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color:
                                              color.blackColor.withOpacity(0.2),
                                          blurRadius: 20,
                                          spreadRadius: 6)
                                    ]),
                                child: Text(
                                  "Status Kesehatan User (BMI) dan target",
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    secondChild: Container(
                        padding: EdgeInsets.only(top: 40, right: 20, left: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(color: color.secondaryColor,
                            // borderRadius:
                            //     BorderRadius.vertical(bottom: Radius.circular(30)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: color.blackColor.withOpacity(0.2),
                                  blurRadius: 20,
                                  spreadRadius: 6)
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.bars,
                                      color: color.primaryColor,
                                    ),
                                  ),
                                  Stack(alignment: Alignment.center, children: [
                                    CircleAvatar(
                                      backgroundColor: color.primaryColor,
                                      radius: 25,
                                    ),
                                    CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/images/yuda.jpg'),
                                      radius: 20,
                                    ),
                                  ]),
                                ],
                              ),
                            ])),
                  )),

              //
              body: Container(
                  margin: EdgeInsets.only(top: 10, left: 20),
                  child: ListView.builder(
                      itemCount: subscriptionController.listSubscription.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subscriptionController
                                  .listSubscription[index].subscriptionType!,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.tersierTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              height: size.height * 0.2,
                              width: size.width,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: subscriptionController
                                      .listSubscription[index]
                                      .subscriptionPackages!
                                      .length,
                                  itemBuilder: (context, idx) {
                                    return Container(
                                      width: size.width * 0.6,
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.bottomLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            subscriptionController
                                                .listSubscription[index]
                                                .subscriptionPackages![idx]
                                                .name!,
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: color.primaryColor,
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Text(
                                            subscriptionController
                                                .listSubscription[index]
                                                .subscriptionPackages![idx]
                                                .subscriptionTypeName!,
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: color.primaryColor,
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Text(
                                            subscriptionController
                                                .listSubscription[index]
                                                .subscriptionPackages![idx]
                                                .description!,
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: color.primaryColor,
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: color.purpleColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        );
                      })),
            ),
    );
  }
}
