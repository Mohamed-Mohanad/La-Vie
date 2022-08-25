import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/cubit/discussion_forum/discussion_forum_cubit.dart';
import 'package:la_vie_app/models/forum/forum_model.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_keys.dart';
import 'package:la_vie_app/view/discussion_fourms/components/forum_comment.dart';

class ForumCommentsScreen extends StatefulWidget {
  final String forumId;
  const ForumCommentsScreen({super.key, required this.forumId});

  @override
  State<ForumCommentsScreen> createState() => _ForumCommentsScreenState();
}

class _ForumCommentsScreenState extends State<ForumCommentsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DiscussionForumCubit.get(context).getForumById(
      widget.forumId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            NavigationUtils.navigateBack(context: context);
            DiscussionForumCubit.get(context)
                .forumModel!
                .forumComments!
                .clear();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Comments",
          style: AppTextStyle.appBarText(),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DiscussionForumCubit, DiscussionForumState>(
        builder: (_, state) =>
            DiscussionForumCubit.get(context).forumModel == null ||
                    DiscussionForumCubit.get(context)
                        .forumModel!
                        .forumComments!
                        .isEmpty
                ? const Center(
                    child: Text("No comments.."),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(25),
                    itemBuilder: (context, index) => ForumComment(
                      comment: DiscussionForumCubit.get(context)
                          .forumModel!
                          .forumComments![index],
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: DiscussionForumCubit.get(context)
                        .forumModel!
                        .forumComments!
                        .length,
                  ),
      ),
    );
  }
}
