import 'package:flutter/services.dart';
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
  TextEditingController _couponTextController = TextEditingController();
  int pageActive = 0;
  final closeTopContainer = false.obs;
  @override
  void initState() {
    // subscriptionController.getSubscriptionAll();
    // subscriptionController.getSubscriptionActiveUser();
    // subscriptionController.getSubscriptionHistoryUser();
    subscriptionController.getIntegratedSubscriptionScreen();
    scrollController.addListener(() {
      setState(() {
        closeTopContainer.value = scrollController.offset > 50;
      });
    });

    super.initState();
  }

  void dialogClaimCoupon() {
    Get.dialog(Scaffold(
      backgroundColor: color.secondaryTextColor.withOpacity(0.3),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 10.w),
          height: 300.h,
          width: 360.w,
          decoration: BoxDecoration(
            color: color.primaryColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: color.blackColor.withOpacity(0.2),
                  blurRadius: 40,
                  spreadRadius: 6)
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Claim Coupon',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Neumorphic(
                style: NeumorphicStyle(
                    depth: -2,
                    color: color.secondaryTextColor.withOpacity(0.1),
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(30),
                    )),
                padding: EdgeInsets.only(left: 20.w, right: 10.w),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: TextFormField(
                  controller: _couponTextController,
                  // onChanged: (text) {
                  //   setState(() {
                  //     text.toUpperCase();
                  //   });
                  //   print(text);
                  // },
                  // validator: (value),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                  ],
                  textCapitalization: TextCapitalization.characters,

                  decoration: InputDecoration(
                    icon: FaIcon(
                      FontAwesomeIcons.ticketAlt,
                      size: 16.sp,
                      color: color.secondaryTextColor,
                    ),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: 'Kode Coupon',
                    hintStyle: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: color.secondaryTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NeumorphicButton(
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        _couponTextController.clear();
                        if (Get.isDialogOpen!) Get.back();
                      },
                      margin: EdgeInsets.only(top: 10.h),
                      style: NeumorphicStyle(
                          color: color.secondaryColor,
                          depth: 4,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20),
                          )),
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 30.w),
                      child: Text(
                        "Kembali",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: color.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal),
                        ),
                      )),
                  SizedBox(width: 20.w),
                  NeumorphicButton(
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        if (Get.isDialogOpen!) Get.back();

                        subscriptionController
                            .postSubscriptionClaimCoupon(
                                couponCode: _couponTextController.text)
                            .then((_) {
                          subscriptionController.getSubscriptionActiveUser();
                          subscriptionController.getSubscriptionHistoryUser();
                        });
                        _couponTextController.clear();
                      },
                      margin: EdgeInsets.only(top: 10.h),
                      style: NeumorphicStyle(
                          color: color.secondaryColor,
                          depth: 4,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20),
                          )),
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 30.w),
                      child: Text(
                        'Claim',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: color.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => subscriptionController.isLoadingSubscriptionAll.isTrue ||
              subscriptionController.isLoadingSubscriptionActiveUser.isTrue ||
              subscriptionController.isLoadingSubscriptionHistoryUser.isTrue
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: color.secondaryColor,
                ),
              ),
            )
          : subscriptionController.listSubscription.isEmpty
              ? Scaffold(
                  body: Container(
                    height: 800.h,
                    width: 360.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NeumorphicButton(
                            margin: EdgeInsets.only(top: 28.h),
                            onPressed: () {
                              subscriptionController.getSubscriptionAll();
                            },
                            style: NeumorphicStyle(
                                color: color.secondaryColor,
                                depth: 4,
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(20),
                                )),
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 30.w),
                            child: Text(
                              "Refresh",
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: color.primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            )),
                      ],
                    ),
                  ),
                )
              : Scaffold(
                  backgroundColor: color.backgroundColor,

                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(
                          !closeTopContainer.value ? 290.h : 80.h),
                      child: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 200),
                        crossFadeState: !closeTopContainer.value
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        firstChild: Container(
                          padding: EdgeInsets.only(
                              top: 60.h, right: 20.w, left: 20.w),
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
                                    NeumorphicButton(
                                      onPressed: () {
                                        dialogClaimCoupon();
                                      },
                                      style: NeumorphicStyle(
                                        depth: 0,
                                        shape: NeumorphicShape.flat,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        color: color.bgColor,
                                      ),
                                      padding: EdgeInsets.all(14.0.sp),
                                      child: FaIcon(
                                        FontAwesomeIcons.ticketAlt,
                                        size: 16.sp,
                                        color: color.secondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                //

                                SizedBox(height: 12.h),

                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          top: 10.h, bottom: 10.h),
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: color.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: color.blackColor
                                                    .withOpacity(0.2),
                                                blurRadius: 20,
                                                spreadRadius: 6)
                                          ]),
                                      child: subscriptionController
                                              .listSubscriptionActiveUser
                                              .isEmpty
                                          ? Text(
                                              "Anda sedang mengikuti program default Sirkadian (Maintain Health)",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    color: color
                                                        .secondaryTextColor,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            )
                                          : PageView.builder(
                                              itemCount: subscriptionController
                                                  .listSubscriptionActiveUser
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  padding: EdgeInsets.only(
                                                      top: 10.h,
                                                      left: 10.w,
                                                      right: 10.w),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Program Kesehatan Anda",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              textStyle: TextStyle(
                                                                  color: color
                                                                      .primaryTextColor,
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          NeumorphicButton(
                                                            onPressed: () {},
                                                            style:
                                                                NeumorphicStyle(
                                                              depth: 4,
                                                              shape:
                                                                  NeumorphicShape
                                                                      .flat,
                                                              boxShape:
                                                                  NeumorphicBoxShape
                                                                      .circle(),
                                                              color: Colors
                                                                  .transparent,
                                                            ),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0.sp),
                                                            child: Center(
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .history,
                                                                size: 18.sp,
                                                                color: color
                                                                    .primaryTextColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        subscriptionController
                                                                .listSubscriptionActiveUser[
                                                                    index]
                                                                .subscriptionPackageName! +
                                                            ' (' +
                                                            subscriptionController
                                                                .listSubscriptionActiveUser[
                                                                    index]
                                                                .subscriptionTypeName! +
                                                            ')',
                                                        style:
                                                            GoogleFonts.inter(
                                                          textStyle: TextStyle(
                                                              color: color
                                                                  .secondaryTextColor,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      // Text(
                                                      //   "Status Kesehatan User (BMI) dan target",
                                                      //   style: GoogleFonts.inter(
                                                      //     textStyle: TextStyle(
                                                      //         color: color
                                                      //             .secondaryTextColor,
                                                      //         fontSize: 14.sp,
                                                      //         fontWeight:
                                                      //             FontWeight.normal),
                                                      //   ),
                                                      // ),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: List<
                                                                  Widget>.generate(
                                                              subscriptionController
                                                                  .listSubscriptionActiveUser
                                                                  .length,
                                                              (int index) {
                                                            print(index);
                                                            return AnimatedContainer(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        300),
                                                                height: 8.h,
                                                                width: 6.w,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 5
                                                                            .w,
                                                                        right:
                                                                            5.w,
                                                                        bottom: 10
                                                                            .h),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                5),
                                                                    color: (subscriptionController.listSubscriptionActiveUser[index] ==
                                                                            pageActive)
                                                                        ? color
                                                                            .tersierColor
                                                                        : color
                                                                            .secondaryColor
                                                                            .withOpacity(0.4)));
                                                          })),
                                                    ],
                                                  ),
                                                );
                                              })),
                                ),
                              ]),
                        ),
                        secondChild: Container(
                            padding: EdgeInsets.only(
                                top: 60.h, right: 20.w, left: 20.w),
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
                                      NeumorphicButton(
                                        onPressed: () {
                                          dialogClaimCoupon();
                                        },
                                        style: NeumorphicStyle(
                                          depth: 0,
                                          shape: NeumorphicShape.flat,
                                          boxShape: NeumorphicBoxShape.circle(),
                                          color: color.bgColor,
                                        ),
                                        padding: EdgeInsets.all(14.0.sp),
                                        child: FaIcon(
                                          FontAwesomeIcons.ticketAlt,
                                          size: 16.sp,
                                          color: color.secondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ])),
                      )),

                  //
                  body: Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        controller: scrollController,
                        child: Column(
                          children: [
                            SizedBox(height: 8.h),
                            Text(
                              "Pilihan Program Tersedia",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.secondaryTextColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 18.h),
                            Column(
                              children: subscriptionController.listSubscription
                                  .map((listSubscription) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.w),
                                            child: Text(
                                              listSubscription
                                                  .subscriptionType!,
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color:
                                                        color.tersierTextColor,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 200.h,
                                            width: 360.w,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10.h,
                                                horizontal: 10.w),
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemCount: listSubscription
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
                                                                        listSubscription
                                                                            .subscriptionPackages![idx],
                                                                  )));
                                                    },
                                                    child: Container(
                                                      width: 240.w,
                                                      padding:
                                                          EdgeInsets.all(10.sp),
                                                      margin:
                                                          EdgeInsets.all(10.sp),
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            listSubscription
                                                                .subscriptionPackages![
                                                                    idx]
                                                                .name!,
                                                            style: GoogleFonts
                                                                .inter(
                                                              textStyle: TextStyle(
                                                                  color: color
                                                                      .primaryColor,
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                          Text(
                                                            listSubscription
                                                                .subscriptionPackages![
                                                                    idx]
                                                                .subscriptionTypeName!,
                                                            style: GoogleFonts
                                                                .inter(
                                                              textStyle: TextStyle(
                                                                  color: color
                                                                      .primaryColor,
                                                                  fontSize:
                                                                      20.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                          Text(
                                                            listSubscription
                                                                .subscriptionPackages![
                                                                    idx]
                                                                .description!,
                                                            style: GoogleFonts
                                                                .inter(
                                                              textStyle: TextStyle(
                                                                  color: color
                                                                      .primaryColor,
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            color.tersierColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          )
                                        ],
                                      ))
                                  .toList(),
                            ),
                            SizedBox(height: 200.h),
                          ],
                        ),
                      )),
                ),
    );
  }
}
