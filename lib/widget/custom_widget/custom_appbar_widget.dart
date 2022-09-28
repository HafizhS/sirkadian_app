import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/hex_color.dart';

class CustomAppBarWidget extends StatefulWidget {
  const CustomAppBarWidget({Key? key, required this.title, this.trailingWidget}) : super(key: key);

  final String title;
  final Widget? trailingWidget;

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 65,
      title: Text(
        "Sarapan".toUpperCase(),
        style: GoogleFonts.poppins(
            fontSize: 20.sp,
            letterSpacing: 3.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      backgroundColor: HexColor.fromHex("73C639"),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(10), child: Container()),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: 35.sp, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      automaticallyImplyLeading: true,
    );
  }
}
