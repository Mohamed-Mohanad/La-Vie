import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/models/forum/forum_model.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_keys.dart';

class ForumComment extends StatelessWidget {
  final ForumComments comment;
  const ForumComment({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.userId.toString() == CacheKeysManger.getUserIdFromCache()
                ? "Me"
                : comment.userId.toString(),
            style: AppTextStyle.bodyText(),
          ),
          Text(
            DateFormat.yMEd().add_jms().format(comment.createdAt!),
            style: AppTextStyle.subTitle().copyWith(
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
      subtitle: Text(
        comment.comment.toString(),
        style: AppTextStyle.subTitle(),
      ),
    );
  }
}
