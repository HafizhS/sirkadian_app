import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/subscription_controller.dart';
import 'package:sirkadian_app/screen/subscription/program_detail_screen.dart';

import '../../controller/auth_controller.dart';
import '../../controller/hexcolor_controller.dart';
import '../../controller/user_controller.dart';
import '../../widget/drawer_sidebar.dart';

class ProgramScreen extends StatefulWidget {
  ProgramScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProgramScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  final subscriptionController = Get.find<SubscriptionController>();
  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();
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
    return Obx(
      () => subscriptionController.isLoadingSubscriptionAll.isTrue
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: color.secondaryColor,
                ),
              ),
            )
          : Scaffold(
              backgroundColor: color.backgroundColor,
              drawer: DrawerSideBar(
                authController: authController,
                userController: userController,
                color: color,
              ),
              appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(!closeTopContainer.value ? 290.h : 80.h),
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 200),
                    crossFadeState: !closeTopContainer.value
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: Container(
                      padding:
                          EdgeInsets.only(top: 40.h, right: 20.w, left: 20.w),
                      width: double.infinity,
                      height: 290.h,
                      decoration: BoxDecoration(
                          color: color.secondaryColor,
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
                                GestureDetector(
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
                                    radius: 25.sp,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/user_male.jpg'),
                                    radius: 20.sp,
                                  ),
                                ]),
                              ],
                            ),
                            //

                            SizedBox(height: 18.h),

                            Text(
                              "Program Kesehatan Sirkadian",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin:
                                    EdgeInsets.only(top: 10.h, bottom: 20.h),
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
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    secondChild: Container(
                        padding:
                            EdgeInsets.only(top: 40.h, right: 20.w, left: 20.w),
                        width: 360.w,
                        decoration: BoxDecoration(
                            color: color.secondaryColor,
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
                                  GestureDetector(
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
                                      radius: 25.sp,
                                    ),
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/user_male.jpg'),
                                      radius: 20.sp,
                                    ),
                                  ]),
                                ],
                              ),
                            ])),
                  )),

              //
              body: Container(
                  margin: EdgeInsets.only(top: 10.h, left: 20.w),
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
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              height: 150.h,
                              width: 360.w,
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: subscriptionController
                                      .listSubscription[index]
                                      .subscriptionPackages!
                                      .length,
                                  itemBuilder: (context, idx) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProgramDetailScreen(
                                                      subscriptionItem:
                                                          subscriptionController
                                                              .listSubscription[
                                                                  index]
                                                              .subscriptionPackages![idx],
                                                    )));
                                      },
                                      child: Container(
                                        width: 240.w,
                                        padding: EdgeInsets.all(10.sp),
                                        margin: EdgeInsets.all(10.sp),
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
                                                    fontSize: 14.sp,
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
                                                    fontSize: 20.sp,
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
                                                    fontSize: 10.sp,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          color: color.purpleColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
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
