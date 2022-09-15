import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirkadian_app/screen/subscription/subscription_payment_screen.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlanScreen> {
  var subscriptionPlans = [
    {
      'title': 'Per Tahun',
      'price': 'IDR 29.917',
      'satuan': 'tahun',
      'description': 'Bayar per tahun, batalkan kapan saja'
    },
    {
      'title': 'Per 3 Bulan',
      'price': 'IDR 29.917',
      'satuan': '3 bulan',
      'description': 'Bayar per 3 bulan, batalkan kapan saja'
    },
    {
      'title': 'Per Bulan',
      'price': 'IDR 29.917',
      'satuan': 'bulan',
      'description': 'Bayar per bulan, batalkan kapan saja'
    }
  ];
  int selectedIndex = -1;
  var selectedPlan;
  bool isDialogOpen = false;

  void _toggleDialogOpen() {
    this.isDialogOpen = !isDialogOpen;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(children: [
        buildBody(context),
        Offstage(
          offstage: !isDialogOpen,
          child: WillPopScope(
            onWillPop: () {
              return Future<bool>(() async {
                if (isDialogOpen) {
                  setState(() {
                    isDialogOpen = false;
                  });
                  return false;
                }
                return true;
              });
            },
            child: buildPaymentMethodWidget(context),
          ),
        )
      ]),
    );
  }

  BackdropFilter buildPaymentMethodWidget(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Center(
        child: Container(
          color: Colors.black.withOpacity(0.2),
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width - 40,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              this.isDialogOpen = !isDialogOpen;
                            });
                          },
                          child: Text("Exit"),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) =>
                                        SubscriptionPaymentScreen()))
                                .then((value) => setState(() {
                                      isDialogOpen = !isDialogOpen;
                                    }));
                          },
                          child: Text("Lanjutkan Pembayaran"),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: 15),
                          Text(
                            "Pilih Metode Pembayaran",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(height: 25),
                          Card(
                            elevation: 8,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: SizedBox(
                              height: 50,
                              child: Flex(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                direction: Axis.horizontal,
                                children: [
                                  Text("Test"),
                                  Text("Test"),
                                  Text("Test")
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Card(
                            elevation: 8,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: SizedBox(
                              height: 50,
                              child: Flex(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                direction: Axis.horizontal,
                                children: [
                                  Text("Test"),
                                  Text("Test"),
                                  Text("Test")
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Card(
                            elevation: 8,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: SizedBox(
                              height: 50,
                              child: Flex(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                direction: Axis.horizontal,
                                children: [
                                  Text("Test"),
                                  Text("Test"),
                                  Text("Test")
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SafeArea buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Stack(
          fit: StackFit.expand,
          alignment: FractionalOffset.topCenter,
          children: [
            Positioned(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: subscriptionPlans.length,
                  itemBuilder: (context, index) {
                    var plan = subscriptionPlans[index];
                    return buildCard(context, index, plan);
                  }),
            ),
            Align(
              widthFactor: MediaQuery.of(context).size.width,
              alignment: FractionalOffset.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 18.sp,
                child: NeumorphicButton(
                  onPressed: () {
                    setState(() => isDialogOpen = !isDialogOpen);
                  },
                  margin: EdgeInsets.only(bottom: 25),
                  child:
                      Text("Lanjutkan Pembayaran", textAlign: TextAlign.center),
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildCard(BuildContext context, int index, Map<String, String> plan) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: EdgeInsets.all(13),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Checkbox(
                    shape: CircleBorder(),
                    activeColor: Colors.green,
                    value: index == selectedIndex,
                    onChanged: (value) {
                      setState(() {
                        this.selectedPlan = plan;
                        this.selectedIndex = index;
                      });
                    }),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plan['title']!),
                  SizedBox(height: 10),
                  Row(children: [
                    Text(plan['price']!,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("/${plan['satuan']!}"),
                  ]),
                  SizedBox(height: 10),
                  Text(plan['description']!),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
