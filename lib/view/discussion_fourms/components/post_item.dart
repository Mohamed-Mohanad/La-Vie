import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/components/default_button.dart';
import 'package:la_vie_app/core/components/default_text_form_field.dart';
import 'package:la_vie_app/core/enum/forum_type.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/cubit/discussion_forum/discussion_forum_cubit.dart';
import 'package:la_vie_app/models/forum/forum_model.dart';
import 'package:la_vie_app/view/discussion_fourms/forum_comments_screen.dart';

class PostItem extends StatelessWidget {
  final ForumModel forumModel;
  final ForumType forumType;
  final int index;
  PostItem({
    super.key,
    required this.forumModel,
    required this.forumType,
    required this.index,
  });
  final TextEditingController commentController = TextEditingController();
  final keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
        ),
      ),
      child: Form(
        key: keyForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(forumModel.publisher!.imageUrl!),
              ),
              title: Text(
                "${forumModel.publisher!.firstName} ${forumModel.publisher!.lastName}",
                style: AppTextStyle.bodyText(),
              ),
              subtitle: Text(
                "a month ago",
                style: AppTextStyle.subTitle(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${forumModel.title}",
                    style: AppTextStyle.bodyText().copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${forumModel.description}",
                    style: AppTextStyle.subTitle(),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Image(
                      image: NetworkImage(
                        'https://lavie.orangedigitalcenteregypt.com${forumModel.imageUrl}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  BlocBuilder<DiscussionForumCubit, DiscussionForumState>(
                    builder: (_, state) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                DiscussionForumCubit.get(context)
                                    .likeForum(forumModel.forumId!, forumType, index, forumModel);
                              },
                              icon: Icon(
                                DiscussionForumCubit.get(context)
                                        .checkIfUserLikedPost(forumModel)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              "${forumModel.forumLikes!.length} Likes",
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                NavigationUtils.navigateTo(
                                  context: context,
                                  destinationScreen: ForumCommentsScreen(
                                    comments: forumModel.forumComments ?? [],
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.comment_outlined,
                              ),
                            ),
                            Text(
                              "${forumModel.forumComments!.length} Replies",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultTextFormField(
                controller: commentController,
                textInputType: TextInputType.text,
                required: true,
              ),
            ),
            BlocBuilder<DiscussionForumCubit, DiscussionForumState>(
              builder: (_, state) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: state is DiscussionForumCommentLoadingState
                    ? Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : DefaultButton(
                        height: 28.h,
                        onPress: () {
                          if (keyForm.currentState!.validate()) {
                            DiscussionForumCubit.get(context).commentForum(
                              forumModel.forumId!,
                              commentController.text,
                              forumType,
                              index,
                            );
                            commentController.clear();
                          }
                        },
                        text: "comment",
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
