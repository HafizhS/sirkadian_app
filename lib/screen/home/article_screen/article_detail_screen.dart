import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:sirkadian_app/controller/subscription_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controller/article_controller.dart';
import '../../../controller/hexcolor_controller.dart';

class ArticleDetailScreen extends StatefulWidget {
  ArticleDetailScreen({
    Key? key,
    required this.articleId,
  }) : super(key: key);
  final int articleId;
  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final subscriptionController = Get.find<SubscriptionController>();
  final informationController = Get.put(InformationController());
  final articleController = Get.find<ArticleController>();
  final color = Get.find<ColorConstantController>();
  var unescape = HtmlUnescape();

  @override
  void initState() {
    print(widget.articleId);
    articleController.getArticleDetail(widget.articleId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => articleController.isLoadingArticleDetail.isTrue
          ? Scaffold(
              body: SafeArea(
                child: Center(
                  child: CircularProgressIndicator(
                    color: color.secondaryColor,
                  ),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: color.bgColor,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100.h),
                child: Container(
                  padding: EdgeInsets.only(
                      top: 60.h, right: 20.w, left: 20.w, bottom: 20.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: color.bgColor,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: color.blackColor.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 6)
                      ]),
                  child: Row(
                    children: [
                      NeumorphicButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.circle(),
                          color: color.backgroundColor,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: FaIcon(
                          FontAwesomeIcons.chevronLeft,
                          size: 16.sp,
                          color: color.secondaryColor,
                        ),
                      ),
                      SizedBox(width: 18.w),
                      Flexible(
                        child: FittedBox(
                          child: Text(
                            articleController.articleDetail.value.title ?? '',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: color.secondaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: 300.h,
                        decoration: BoxDecoration(
                            color: color.primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: articleController
                                    .articleDetail.value.imageFilename ==
                                ''
                            ? Icon(Icons.image_not_supported_rounded)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  articleController
                                      .articleDetail.value.imageFilename!,
                                  fit: BoxFit.contain,
                                ),
                              )),
                    SizedBox(height: 18.h),
                    Html(
                      data: unescape.convert(
                          articleController.articleDetail.value.content!),
                    ),
                  ],
                ),
              )),
            ),
    );
  }
}
