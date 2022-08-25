import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/view/blog/components/blog_item.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blogs",
          style: AppTextStyle.appBarText(),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => BlogItem(),
        separatorBuilder: (context, index) => SizedBox(
          height: 20.h,
        ),
        itemCount: 6,
      ),
    );
  }
}
