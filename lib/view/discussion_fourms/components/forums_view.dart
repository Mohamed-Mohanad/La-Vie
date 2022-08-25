import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/components/default_not_found_result_view.dart';
import 'package:la_vie_app/core/enum/forum_type.dart';
import 'package:la_vie_app/cubit/discussion_forum/discussion_forum_cubit.dart';
import 'package:la_vie_app/models/forum/forum_model.dart';
import 'package:la_vie_app/view/discussion_fourms/components/post_item.dart';

class ForumView extends StatelessWidget {
  final List<ForumModel> forums;
  final ForumType forumType;
  const ForumView({
    Key? key,
    required this.forums,
    required this.forumType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscussionForumCubit, DiscussionForumState>(
      builder: (_, state) => forums.isEmpty
          ? const NotFoundResultView()
          : ListView.separated(
              itemBuilder: (context, index) => PostItem(
                forumModel: forums[index],
                forumType: forumType,
                index: index,
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 15.h,
              ),
              itemCount: forums.length,
            ),
    );
  }
}
