import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/models/forum/forum_model.dart';

class ForumCommentsScreen extends StatelessWidget {
  final List<ForumComments> comments;
  const ForumCommentsScreen({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comments",
          style: AppTextStyle.appBarText(),
        ),
        centerTitle: true,
      ),
      body: comments.isEmpty
          ? const Center(
              child: Text("No comments.."),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(25),
              itemBuilder: (context, index) => ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comments[index].userId.toString(),
                      style: AppTextStyle.bodyText(),
                    ),
                    Text(
                      comments[index].createdAt.toString(),
                      style: AppTextStyle.subTitle().copyWith(
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  comments[index].comment.toString(),
                  style: AppTextStyle.subTitle(),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: comments.length,
            ),
    );
  }
}
