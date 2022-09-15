import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sirkadian_app/constant/hex_color.dart';

class SubscriptionPaymentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubscriptionPaymentState();
}

class _SubscriptionPaymentState extends State<SubscriptionPaymentScreen> {
  // Styling
  double _cardElevation() => 9;

  _cardShape() =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15));

  _cardMargin() => EdgeInsets.symmetric(horizontal: 20, vertical: 10);

  _cardPadding() => EdgeInsets.symmetric(vertical: 25, horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildFirstCard(),
              _buildSecondCard(),
              _buildThirdCard(),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildThirdCard() {
    return Card(
      margin: _cardMargin(),
      elevation: _cardElevation(),
      shape: _cardShape(),
      child: Padding(
        padding: _cardPadding(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.access_time_filled, color: Colors.green),
                SizedBox(width: 7),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3),
                    Text(
                      "Selesaikan pembayaran sebelum",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                    SizedBox(height: 9),
                    Text(
                      "04:20 AM",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 9),
                    Text(
                      "Selesaikan transaksi dalam 24 jam",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.credit_card_rounded, color: Colors.green),
                SizedBox(width: 7),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3),
                      Text(
                        "Transfer ke",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                      SizedBox(height: 14),
                      Text(
                        "PT. Trinusa Travelindo",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: HexColor.fromHex("777B71"),
                        ),
                      ),
                      SizedBox(height: 7),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "165 00 66 77 0000",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                          ),
                          Text("Salin", style: TextStyle(color: Colors.green))
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Jumlah Bayar",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                      SizedBox(height: 7),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rp. 29.917",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                          ),
                          Text("Salin", style: TextStyle(color: Colors.green))
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        "*mohon transfer sesuai jumlah yang tertera (termasuk 3 digit terakhir)",
                        softWrap: true,
                        style: TextStyle(fontSize: 12.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),
            Center(
              child: NeumorphicButton(
                child: Text("Check Pembayaran"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Card _buildSecondCard() {
    return Card(
      margin: _cardMargin(),
      elevation: _cardElevation(),
      shape: _cardShape(),
      child: Padding(
        padding: _cardPadding(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tranfer Mandiri"),
            Text(
              "No. Transaksi xxxxxxx",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }

  Card _buildFirstCard() {
    return Card(
      margin: _cardMargin(),
      elevation: _cardElevation(),
      shape: _cardShape(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Paket berlangganan per tahun",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 15),
            Text(
              "IDR 29.917",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
