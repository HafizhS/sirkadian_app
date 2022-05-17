import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/subscription_controller.dart';

import '../../controller/hexcolor_controller.dart';

class ProgramDetailScreen extends StatefulWidget {
  ProgramDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProgramDetailScreen> createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<ProgramDetailScreen> {
  final subscriptionController = Get.find<SubscriptionController>();
  final color = Get.find<ColorConstantController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color.backgroundColor,

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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          fontWeight: FontWeight.normal),
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
                                          fontWeight: FontWeight.normal),
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
                                          fontWeight: FontWeight.normal),
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
    );
  }
}
