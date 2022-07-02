// import 'dart:io';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sirkadian_app/controller/healthware_controller.dart';

// import '../../controller/hexcolor_controller.dart';
// import 'bluetooth.dart';

// class HealthwareDeviceScreen extends StatefulWidget {
//   HealthwareDeviceScreen({Key? key}) : super(key: key);

//   @override
//   State<HealthwareDeviceScreen> createState() => _HealthwareDeviceScreenState();
// }

// class _HealthwareDeviceScreenState extends State<HealthwareDeviceScreen> {
//   final color = Get.find<ColorConstantController>();
//   final healthwareController = Get.find<HealthwareController>();

//   bool bluetoothOn = false;

//   @override
//   void initState() {
//     getConnection();

//     super.initState();
//   }

//   Future<void> getConnection() async {
//     var connection = await FlutterBluePlus.instance.isOn;
//     if (connection) {
//       setState(() {
//         bluetoothOn = true;
//       });
//     } else {
//       setState(() {
//         bluetoothOn = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: bluetoothOn
//             ? StreamBuilder<bool>(
//                 stream: FlutterBluePlus.instance.isScanning,
//                 initialData: false,
//                 builder: (c, snapshot) {
//                   if (snapshot.data!) {
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: 20.h),
//                       child: FloatingActionButton(
//                         child: const Icon(Icons.stop),
//                         onPressed: () => FlutterBluePlus.instance.stopScan(),
//                         backgroundColor: color.redColor,
//                       ),
//                     );
//                   } else {
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: 20.h),
//                       child: FloatingActionButton(
//                           child: const Icon(Icons.search),
//                           onPressed: () => FlutterBluePlus.instance
//                               .startScan(timeout: const Duration(seconds: 4))),
//                     );
//                   }
//                 },
//               )
//             : Container(),
//         body: Container(
//           height: 800.h,
//           width: 360.w,
//           child: Column(
//             children: [
//               appBar(),
//               StreamBuilder<BluetoothState>(
//                   stream: FlutterBluePlus.instance.state,
//                   initialData: BluetoothState.unknown,
//                   builder: (c, snapshot) {
//                     final state = snapshot.data;
//                     if (state == BluetoothState.on) {
//                       return FindDevicesScreen();
//                     }
//                     return BluetoothOffScreen(state: state!, color: color);
//                   })
//             ],
//           ),
//         )

//         //
//         );
//   }

//   Widget appBar() {
//     return SafeArea(
//         child: Container(
//             margin: EdgeInsets.symmetric(vertical: 30),
//             child: SingleChildScrollView(
//                 child: Column(children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 20),
//                     child: NeumorphicButton(
//                       onPressed: () {
//                         Get.back();
//                       },
//                       style: NeumorphicStyle(
//                         shape: NeumorphicShape.flat,
//                         boxShape: NeumorphicBoxShape.circle(),
//                         color: color.primaryColor,
//                       ),
//                       padding: const EdgeInsets.all(16.0),
//                       child: FaIcon(
//                         FontAwesomeIcons.chevronLeft,
//                         size: 16,
//                         color: color.secondaryTextColor,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     'Bluetooth Devices',
//                     style: GoogleFonts.inter(
//                       textStyle: TextStyle(
//                           color: color.primaryTextColor,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(right: 20),
//                     child: NeumorphicButton(
//                       onPressed: () {
//                         if (bluetoothOn) {
//                           Platform.isAndroid
//                               ? FlutterBluePlus.instance.turnOff()
//                               : null;
//                           setState(() {
//                             bluetoothOn = false;
//                           });
//                         } else {
//                           Platform.isAndroid
//                               ? FlutterBluePlus.instance.turnOn()
//                               : null;
//                           setState(() {
//                             bluetoothOn = true;
//                           });
//                         }
//                       },
//                       style: NeumorphicStyle(
//                         depth: bluetoothOn ? -4 : 4,
//                         shape: NeumorphicShape.flat,
//                         boxShape: NeumorphicBoxShape.circle(),
//                         color: color.primaryColor,
//                       ),
//                       padding: const EdgeInsets.all(16.0),
//                       child: FaIcon(
//                         FontAwesomeIcons.powerOff,
//                         size: 16,
//                         color: bluetoothOn
//                             ? color.secondaryColor
//                             : color.secondaryTextColor,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ]))));
//   }
// }

// class HealthwareGauge extends StatelessWidget {
//   const HealthwareGauge({
//     Key? key,
//     required this.color,
//     required this.size,
//     required this.title,
//     required this.value,
//     required this.item_1,
//     required this.item_2,
//     required this.item_3,
//     required this.class_1,
//     required this.class_2,
//     required this.class_3,
//     required this.class_4,
//   }) : super(key: key);

//   final ColorConstantController color;
//   final Size size;
//   final String title;
//   final double value;
//   final String item_1;
//   final String item_2;
//   final String item_3;
//   final String class_1;
//   final String class_2;
//   final String class_3;
//   final String class_4;

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Text(title,
//           style: GoogleFonts.inter(
//             textStyle: TextStyle(
//                 color: color.primaryTextColor,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold),
//           )),
//       SizedBox(height: size.height * 0.02),
//       Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text(item_1,
//                   style: GoogleFonts.inter(
//                     textStyle: TextStyle(
//                         color: color.secondaryTextColor,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal),
//                   )),
//               Text(item_2,
//                   style: GoogleFonts.inter(
//                     textStyle: TextStyle(
//                         color: color.secondaryTextColor,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal),
//                   )),
//               Text(item_3,
//                   style: GoogleFonts.inter(
//                     textStyle: TextStyle(
//                         color: color.secondaryTextColor,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal),
//                   )),
//             ],
//           ),
//           SizedBox(height: size.height * 0.01),
//           Neumorphic(
//               style: NeumorphicStyle(
//                   depth: -4,
//                   color: color.backgroundColor,
//                   shape: NeumorphicShape.flat,
//                   boxShape: NeumorphicBoxShape.roundRect(
//                     BorderRadius.circular(20),
//                   )),
//               child: Stack(alignment: Alignment.centerLeft, children: [
//                 Container(
//                   height: size.height * 0.02,
//                   width: size.width,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       color: color.secondaryColor,
//                       borderRadius: BorderRadius.circular(20)),
//                   height: size.height * 0.02,
//                   width: size.width * value,
//                 ),
//               ])),
//           SizedBox(height: size.height * 0.01),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text(class_1,
//                   style: GoogleFonts.inter(
//                     textStyle: TextStyle(
//                         color: color.secondaryTextColor,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal),
//                   )),
//               Text(class_2,
//                   style: GoogleFonts.inter(
//                     textStyle: TextStyle(
//                         color: color.secondaryTextColor,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal),
//                   )),
//               Text(class_3,
//                   style: GoogleFonts.inter(
//                     textStyle: TextStyle(
//                         color: color.secondaryTextColor,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal),
//                   )),
//               Text(class_4,
//                   style: GoogleFonts.inter(
//                     textStyle: TextStyle(
//                         color: color.secondaryTextColor,
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal),
//                   )),
//             ],
//           ),
//         ],
//       )
//     ]);
//   }
// }
