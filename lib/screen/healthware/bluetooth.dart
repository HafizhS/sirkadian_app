// // Copyright 2017, Paul DeMarco.
// // All rights reserved. Use of this source code is governed by a
// // BSD-style license that can be found in the LICENSE file.

// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sirkadian_app/controller/healthware_controller.dart';
// import 'package:sirkadian_app/controller/information_controller.dart';
// import 'package:sirkadian_app/screen/healthware/widget.dart';
// import 'package:synchronized/synchronized.dart';

// import '../../controller/hexcolor_controller.dart';
// import 'healthware_device_screen.dart';

// class FlutterBlueApp extends StatefulWidget {
//   const FlutterBlueApp({Key? key, required this.color}) : super(key: key);
//   final ColorConstantController color;

//   @override
//   State<FlutterBlueApp> createState() => _FlutterBlueAppState();
// }

// class _FlutterBlueAppState extends State<FlutterBlueApp> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<BluetoothState>(
//         stream: FlutterBluePlus.instance.state,
//         initialData: BluetoothState.unknown,
//         builder: (c, snapshot) {
//           final state = snapshot.data;
//           if (state == BluetoothState.on) {
//             return FindDevicesScreen();
//           }
//           return BluetoothOffScreen(
//             state: state!,
//             color: widget.color,
//           );
//         });
//   }
// }

// class BluetoothOffScreen extends StatelessWidget {
//   const BluetoothOffScreen({Key? key, required this.state, required this.color})
//       : super(key: key);

//   final BluetoothState state;
//   final ColorConstantController color;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           SizedBox(height: 100.h),
//           Icon(
//             Icons.bluetooth_disabled,
//             size: 200.sp,
//             color: Colors.black,
//           ),
//           Text(
//               // 'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
//               'Bluetooth Perangkat anda Mati, Silakan hidupkan terlebih dahulu',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.inter(
//                 textStyle: TextStyle(
//                     color: color.primaryTextColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.normal),
//               )),
//         ],
//       ),
//     );
//   }
// }

// class FindDevicesScreen extends StatefulWidget {
//   const FindDevicesScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<FindDevicesScreen> createState() => _FindDevicesScreenState();
// }

// class _FindDevicesScreenState extends State<FindDevicesScreen> {
//   final healthwareController = Get.find<HealthwareController>();
//   final color = Get.find<ColorConstantController>();
//   final informationController = Get.find<InformationController>();
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//         onRefresh: () => FlutterBluePlus.instance
//             .startScan(timeout: const Duration(seconds: 4)),
//         child: SingleChildScrollView(
//             child: Column(children: <Widget>[
//           // iki 2
//           StreamBuilder<List<BluetoothDevice>>(
//             stream: Stream.periodic(const Duration(seconds: 2))
//                 .asyncMap((_) => FlutterBluePlus.instance.connectedDevices),
//             initialData: const [],
//             builder: (c, snapshot) {
//               return Column(
//                 children: snapshot.data!.map((d) {
//                   return ListTile(
//                     title: Text(d.name,
//                         style: GoogleFonts.inter(
//                           textStyle: TextStyle(
//                               color: color.tersierTextColor,
//                               fontSize: 14,
//                               fontWeight: FontWeight.normal),
//                         )),
//                     subtitle: Text(d.id.toString(),
//                         style: GoogleFonts.inter(
//                           textStyle: TextStyle(
//                               color: color.tersierTextColor,
//                               fontSize: 14,
//                               fontWeight: FontWeight.normal),
//                         )),
//                     trailing: StreamBuilder<BluetoothDeviceState>(
//                       stream: d.state,
//                       initialData: BluetoothDeviceState.disconnected,
//                       builder: (c, snapshot) {
//                         if (snapshot.data == BluetoothDeviceState.connected) {
//                           return NeumorphicButton(
//                               onPressed: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) =>
//                                         DeviceScreen(device: d)));
//                               },
//                               style: NeumorphicStyle(
//                                   color: color.secondaryColor,
//                                   depth: 4,
//                                   shape: NeumorphicShape.flat,
//                                   boxShape: NeumorphicBoxShape.roundRect(
//                                     BorderRadius.circular(20),
//                                   )),
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 12.h, horizontal: 30.w),
//                               child: Text(
//                                 "Buka",
//                                 style: GoogleFonts.inter(
//                                   textStyle: TextStyle(
//                                       color: color.primaryColor,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.normal),
//                                 ),
//                               ));
//                         }
//                         return Text(snapshot.data.toString(),
//                             style: GoogleFonts.inter(
//                               textStyle: TextStyle(
//                                   color: color.tersierTextColor,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.normal),
//                             ));
//                       },
//                     ),
//                   );
//                 }).toList(),
//               );
//             },
//           ),
//           StreamBuilder<List<BluetoothDevice>>(
//               stream: Stream.periodic(const Duration(seconds: 2))
//                   .asyncMap((_) => FlutterBluePlus.instance.connectedDevices),
//               initialData: const [],
//               builder: (c, snapshot) {
//                 return StreamBuilder<List<ScanResult>>(
//                     stream: FlutterBluePlus.instance.scanResults,
//                     initialData: const [],
//                     builder: (c, snapshott) {
//                       return snapshott.data!.isNotEmpty
//                           ? snapshot.data!.isNotEmpty
//                               ? Container()
//                               : Column(
//                                   children: snapshott.data!
//                                       .map(
//                                         (r) => ScanResultTile(
//                                             color: color,
//                                             result: r,
//                                             onTap: () {
//                                               informationController.loadingDialog(
//                                                   'Sedang Menyambungkan ke Perangkat Anda');
//                                               Future.delayed(
//                                                   Duration(seconds: 1), () {
//                                                 if (Get.isDialogOpen!)
//                                                   Get.back();
//                                                 Navigator.of(context).push(
//                                                     MaterialPageRoute(
//                                                         builder: (context) {
//                                                   r.device.connect();
//                                                   return DeviceScreen(
//                                                       device: r.device);
//                                                 }));
//                                               });
//                                             }),
//                                       )
//                                       .toList(),
//                                 )
//                           : Container(
//                               height: 400.h,
//                               padding: EdgeInsets.all(10.sp),
//                               alignment: Alignment.center,
//                               child: Text(
//                                   'Belum ada device yang ditemukan, silakan search device Anda terlebih dahulu.',
//                                   textAlign: TextAlign.center,
//                                   style: GoogleFonts.inter(
//                                     textStyle: TextStyle(
//                                         color: color.primaryTextColor,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.normal),
//                                   )),
//                             );
//                     });
//               })
//         ])));
//   }
// }

// class DeviceScreen extends StatefulWidget {
//   const DeviceScreen({Key? key, required this.device}) : super(key: key);

//   final BluetoothDevice device;

//   @override
//   State<DeviceScreen> createState() => _DeviceScreenState();
// }

// class _DeviceScreenState extends State<DeviceScreen> {
//   final color = Get.find<ColorConstantController>();
//   final healthwareController = Get.find<HealthwareController>();
//   String service_uuid = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
//   String charaCteristic_uuid = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
//   bool isReady = false;
//   late Stream<List<int>> stream;

//   bool isMeasure = true;

//   @override
//   void initState() {
//     super.initState();
//     isReady = false;
//     connectToDevice();
//   }

//   _pop() {
//     Navigator.of(context).pop(true);
//   }

//   String _dataParser(List<int> dataFromDevice) {
//     return utf8.decode(dataFromDevice);
//   }

//   connectToDevice() async {
//     if (widget.device == null) {
//       _pop();
//       return;
//     }

//     new Timer(const Duration(seconds: 15), () {
//       if (!isReady) {
//         disconnectFromDevice();
//         _pop();
//       }
//     });

//     await widget.device.connect();
//     discoverServices();
//   }

//   List<int> _getRandomBytes() {
//     final math = Random();
//     return [
//       math.nextInt(255),
//       math.nextInt(255),
//       math.nextInt(255),
//       math.nextInt(255)
//     ];
//   }

//   disconnectFromDevice() {
//     widget.device.disconnect();
//     if (widget.device == BluetoothDeviceState.disconnected) {
//       _pop();
//       return;
//     }
//   }

//   discoverServices() async {
//     if (widget.device == BluetoothDeviceState.disconnected) {
//       _pop();
//       return;
//     }

//     List<BluetoothService> services = await widget.device.discoverServices();

//     services.forEach((service) async {
//       // if (service.uuid.toString() == '6e400001-b5a3-f393-e0a9-e50e24dcca9e') {
//       //   service.characteristics.forEach((characteristic) {
//       //     print(characteristic.uuid);
//       //     if (characteristic.uuid.toString() ==
//       //         '6e400003-b5a3-f393-e0a9-e50e24dcca9e') {
//       //       characteristic.setNotifyValue(!characteristic.isNotifying);
//       //       // var lock = new Lock(reentrant: true);
//       //       // await lock.synchronized(() async {
//       //       //   // do some stuff
//       //       //   // ...
//       //       //   await characteristic.setNotifyValue(true);
//       //       // });

//       //       stream = characteristic.value;
//       //       print(characteristic.value);

//       //       print(isReady.toString() + '----------------');
//       //     }
//       //   });
//       //   }
//       // Reads all characteristics
//       var characteristics = service.characteristics;
//       // print(characteristics);
//       characteristics.forEach((element) {
//         stream = element.value;

//         print(element.value.toString() + '----------------------------------');
//       });
//       setState(() {
//         isReady = true;
//       });
//       // for (BluetoothCharacteristic c in characteristics) {
//       //   List<int> value = await c.read();

//       //   print(value);

//       // Writes to a characteristic
//       // await c.write([0x12, 0x34]);

//       // }
//       // Reads all descriptors
//     });

//     if (!isReady) {
//       _pop();
//     }
//   }

//   Widget healthware() {
//     return Column(
//       children: [
//         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//           NeumorphicButton(
//               margin: EdgeInsets.only(top: 12.h),
//               onPressed: () {
//                 setState(() {
//                   isMeasure = true;
//                 });
//               },
//               style: NeumorphicStyle(
//                   depth: isMeasure ? -4 : 4,
//                   color: color.primaryColor,
//                   shape: NeumorphicShape.flat,
//                   boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(
//                       bottomLeft: Radius.circular(20),
//                       topLeft: Radius.circular(20)))),
//               padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
//               child: Text(
//                 'Pengukuran',
//                 style: GoogleFonts.inter(
//                   textStyle: TextStyle(
//                       color: isMeasure
//                           ? color.secondaryColor
//                           : color.secondaryTextColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.normal),
//                 ),
//               )),
//           NeumorphicButton(
//               margin: EdgeInsets.only(top: 12.h),
//               onPressed: () {
//                 setState(() {
//                   isMeasure = false;
//                 });
//               },
//               style: NeumorphicStyle(
//                   depth: isMeasure ? 4 : -4,
//                   color: color.primaryColor,
//                   shape: NeumorphicShape.flat,
//                   boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(
//                       bottomRight: Radius.circular(20),
//                       topRight: Radius.circular(20)))),
//               padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
//               child: Text('Hasil Data',
//                   style: GoogleFonts.inter(
//                     textStyle: TextStyle(
//                         color: isMeasure
//                             ? color.secondaryTextColor
//                             : color.secondaryColor,
//                         fontSize: 14,
//                         fontWeight: FontWeight.normal),
//                   ))),
//           SizedBox(height: 30.h),
//         ]),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: AnimatedCrossFade(
//               duration: const Duration(milliseconds: 200),
//               crossFadeState: isMeasure
//                   ? CrossFadeState.showFirst
//                   : CrossFadeState.showSecond,
//               firstChild: Container(
//                 child: !isReady
//                     ? Container(
//                         height: 300.h,
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Waiting...",
//                           style: GoogleFonts.inter(
//                               textStyle: TextStyle(
//                             color: color.secondaryColor,
//                             fontSize: 20.sp,
//                           )),
//                         ),
//                       )
//                     : Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 30.h),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 height: 100.h,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(20),
//                                   child: Image.asset(
//                                       'assets/images/sirkabodyscale.jpg'),
//                                 ),
//                               ),
//                               Column(
//                                 children: [
//                                   // Row(
//                                   //   children: [
//                                   RichText(
//                                     text: TextSpan(
//                                       text: 'Berat badan : ',
//                                       style: GoogleFonts.inter(
//                                           textStyle: TextStyle(
//                                         color: color.primaryTextColor,
//                                         fontSize: 14.sp,
//                                       )),
//                                       children: <TextSpan>[
//                                         TextSpan(
//                                           text: '70 kg',
//                                           style: GoogleFonts.inter(
//                                             textStyle: TextStyle(
//                                                 color: color.primaryTextColor,
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),

//                                   NeumorphicButton(
//                                       margin: EdgeInsets.only(top: 12),
//                                       onPressed: () {},
//                                       style: NeumorphicStyle(
//                                           color: color.secondaryColor,
//                                           shape: NeumorphicShape.flat,
//                                           boxShape:
//                                               NeumorphicBoxShape.roundRect(
//                                             BorderRadius.circular(20),
//                                           )
//                                           //border: NeumorphicBorder()
//                                           ),
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 12.h, horizontal: 40.w),
//                                       child: Text(
//                                         "Save",
//                                         style: GoogleFonts.inter(
//                                           textStyle: TextStyle(
//                                               color: color.primaryColor,
//                                               fontSize: 14.sp,
//                                               fontWeight: FontWeight.normal),
//                                         ),
//                                       )),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 28.h),
//                           Text(
//                             'Riwayat Pengukuran',
//                             style: GoogleFonts.poppins(
//                               textStyle: TextStyle(
//                                   color: isMeasure
//                                       ? color.secondaryTextColor
//                                       : color.secondaryColor,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Container(
//                               height: 400.h,
//                               child: StreamBuilder<List<int>>(
//                                 stream: stream,
//                                 builder: (BuildContext context,
//                                     AsyncSnapshot<List<int>> snapshot) {
//                                   if (snapshot.hasError)
//                                     return Text('Error: ${snapshot.error}');

//                                   if (snapshot.connectionState ==
//                                       ConnectionState.active) {
//                                     // geting data from bluetooth
//                                     var currentValue =
//                                         _dataParser(snapshot.data!);
//                                     // _tem = currentValue.split(",");
//                                     // if (_temphumidata[0] != "nan") {
//                                     //   _temp = double.parse('${_temphumidata[0]}');
//                                     // }
//                                     // if (_temphumidata[1] != "nan") {
//                                     //   _humidity = double.parse('${_temphumidata[1]}');
//                                     // }

//                                     return Text(currentValue);
//                                     // return HomeUI(
//                                     //   humidity: _humidity,
//                                     //   temperature: _temp,
//                                     // );
//                                   } else {
//                                     return Text('Check the stream');
//                                   }
//                                 },
//                               ))
//                         ],
//                       ),
//               ),
//               secondChild: Container(
//                 child: Column(
//                   children: [
//                     HealthwareGauge(
//                       color: color,
//                       size: Size(
//                         360.w,
//                         800.h,
//                       ),
//                       title: 'Berat Badan',
//                       value: 0.5,
//                       item_1: '60 kg',
//                       item_2: '78 kg',
//                       item_3: '85 kg',
//                       class_1: 'Underweight',
//                       class_2: 'Normal',
//                       class_3: 'Overweight',
//                       class_4: 'Obese',
//                     ),
//                     SizedBox(height: 18.h),
//                     Divider(
//                         color: color.secondaryTextColor.withOpacity(0.3),
//                         height: 30),
//                     SizedBox(height: 18.h),
//                     HealthwareGauge(
//                       color: color,
//                       size: Size(
//                         360.w,
//                         800.h,
//                       ),
//                       title: 'Body Mass Index',
//                       value: 0.5,
//                       item_1: '18.5',
//                       item_2: '25.0',
//                       item_3: '30.0',
//                       class_1: 'Underweight',
//                       class_2: 'Normal',
//                       class_3: 'Overweight',
//                       class_4: 'Obese',
//                     ),
//                     SizedBox(height: 18.h),
//                     Divider(
//                         color: color.secondaryTextColor.withOpacity(0.3),
//                         height: 30),
//                     SizedBox(height: 18.h),
//                     HealthwareGauge(
//                       color: color,
//                       size: Size(
//                         360.w,
//                         800.h,
//                       ),
//                       title: 'Total Fat Body',
//                       value: 0.35,
//                       item_1: '10%',
//                       item_2: '30%',
//                       item_3: '45%',
//                       class_1: 'Underfat',
//                       class_2: 'Healthy',
//                       class_3: 'Overfat',
//                       class_4: 'Obese',
//                     ),
//                     SizedBox(height: 18.h),
//                     Divider(
//                         color: color.secondaryTextColor.withOpacity(0.3),
//                         height: 30),
//                     SizedBox(height: 18.h),
//                     HealthwareGauge(
//                       color: color,
//                       size: Size(
//                         360.w,
//                         800.h,
//                       ),
//                       title: 'Fat-Free Mass Index',
//                       value: 0.5,
//                       item_1: '18.5',
//                       item_2: '25.0',
//                       item_3: '30.0',
//                       class_1: 'Underweight',
//                       class_2: 'Normal',
//                       class_3: 'Overweight',
//                       class_4: 'Obese',
//                     ),
//                     SizedBox(height: 18.h),
//                     Divider(
//                         color: color.secondaryTextColor.withOpacity(0.3),
//                         height: 30),
//                     SizedBox(height: 18.h),
//                     HealthwareGauge(
//                       color: color,
//                       size: Size(
//                         360.w,
//                         800.h,
//                       ),
//                       title: 'Total Body Fluid',
//                       value: 0.5,
//                       item_1: '18.5',
//                       item_2: '25.0',
//                       item_3: '30.0',
//                       class_1: 'underweight',
//                       class_2: 'normal',
//                       class_3: 'overweight',
//                       class_4: 'obese',
//                     ),
//                   ],
//                 ),
//               )),
//         ),
//       ],
//     );
//   }

//   List<Widget> _buildServiceTiles(List<BluetoothService> services) {
//     return services
//         .map(
//           (s) => ServiceTile(
//             color: color,
//             service: s,
//             characteristicTiles: s.characteristics
//                 .map(
//                   (c) => CharacteristicTile(
//                     color: color,
//                     characteristic: c,
//                     onReadPressed: () => c.read(),
//                     onWritePressed: () async {
//                       await c.write(_getRandomBytes(), withoutResponse: true);
//                       await c.read();
//                     },
//                     onNotificationPressed: () async {
//                       await c.setNotifyValue(!c.isNotifying);
//                       await c.read();
//                     },
//                     descriptorTiles: c.descriptors
//                         .map(
//                           (d) => DescriptorTile(
//                             color: color,
//                             descriptor: d,
//                             onReadPressed: () => d.read(),
//                             onWritePressed: () => d.write(_getRandomBytes()),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 )
//                 .toList(),
//           ),
//         )
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size(360.w, 100.h),
//         child: Container(
//           color: color.secondaryColor,
//           child: SafeArea(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Text(widget.device.name,
//                     style: GoogleFonts.inter(
//                       textStyle: TextStyle(
//                           color: color.primaryColor,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold),
//                     )),
//                 StreamBuilder<BluetoothDeviceState>(
//                   stream: widget.device.state,
//                   initialData: BluetoothDeviceState.connecting,
//                   builder: (c, snapshot) {
//                     VoidCallback? onPressed;
//                     String text;
//                     switch (snapshot.data) {
//                       case BluetoothDeviceState.connected:
//                         onPressed = () {
//                           widget.device.disconnect();
//                           _pop();
//                         };
//                         text = 'DISCONNECT';
//                         break;
//                       case BluetoothDeviceState.disconnected:
//                         onPressed = () {
//                           widget.device.connect();
//                         };
//                         text = 'CONNECT';
//                         break;
//                       default:
//                         onPressed = null;
//                         text = snapshot.data
//                             .toString()
//                             .substring(21)
//                             .toUpperCase();
//                         break;
//                     }
//                     return TextButton(
//                         onPressed: onPressed,
//                         child: Text(text,
//                             style: GoogleFonts.inter(
//                               textStyle: TextStyle(
//                                   color: color.primaryColor,
//                                   fontSize: 12.sp,
//                                   fontWeight: FontWeight.normal),
//                             )));
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             StreamBuilder<BluetoothDeviceState>(
//               stream: widget.device.state,
//               initialData: BluetoothDeviceState.connecting,
//               builder: (c, snapshot) => ListTile(
//                 leading: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     snapshot.data == BluetoothDeviceState.connected
//                         ? const Icon(Icons.bluetooth_connected)
//                         : const Icon(Icons.bluetooth_disabled),
//                     snapshot.data == BluetoothDeviceState.connected
//                         ? StreamBuilder<int>(
//                             stream: rssiStream(),
//                             builder: (context, snapshot) {
//                               return Text(
//                                   snapshot.hasData ? '${snapshot.data}dBm' : '',
//                                   style: Theme.of(context).textTheme.caption);
//                             })
//                         : Text('', style: Theme.of(context).textTheme.caption),
//                   ],
//                 ),
//                 title: Text(
//                   // 'Device is ${snapshot.data.toString().split('.')[1]}.'),
//                   'Perangkat Tersambung',
//                   style: GoogleFonts.inter(
//                     textStyle: TextStyle(
//                         color: color.primaryTextColor,
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 subtitle: Text('${widget.device.id}'),
//                 trailing: StreamBuilder<bool>(
//                   stream: widget.device.isDiscoveringServices,
//                   initialData: false,
//                   builder: (c, snapshot) => IndexedStack(
//                     index: snapshot.data! ? 1 : 0,
//                     children: <Widget>[
//                       IconButton(
//                         icon: const Icon(Icons.refresh),
//                         onPressed: () => widget.device.discoverServices(),
//                       ),
//                       const IconButton(
//                         icon: SizedBox(
//                           child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation(Colors.grey),
//                           ),
//                           width: 18.0,
//                           height: 18.0,
//                         ),
//                         onPressed: null,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             // StreamBuilder<int>(
//             //   stream: widget.device.mtu,
//             //   initialData: 0,
//             //   builder: (c, snapshot) => ListTile(
//             //     title: const Text('MTU Size'),
//             //     subtitle: Text('${snapshot.data} bytes'),
//             //     trailing: IconButton(
//             //       icon: const Icon(Icons.edit),
//             //       onPressed: () => widget.device.requestMtu(223),
//             //     ),
//             //   ),
//             // ),
//             healthware(),
//             // StreamBuilder<List<BluetoothService>>(
//             //   stream: widget.device.services,
//             //   initialData: const [],
//             //   builder: (c, snapshot) {
//             //     return Column(
//             //       children: _buildServiceTiles(snapshot.data!),
//             //     );
//             //   },
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Stream<int> rssiStream() async* {
//     var isConnected = true;
//     final subscription = widget.device.state.listen((state) {
//       isConnected = state == BluetoothDeviceState.connected;
//     });
//     while (isConnected) {
//       yield await widget.device.readRssi();

//       await Future.delayed(Duration(seconds: 1));
//     }
//     subscription.cancel();
//     // Device disconnected, stopping RSSI stream
//   }
// }
