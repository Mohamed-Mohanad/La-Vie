part of 'discussion_forum_cubit.dart';

@immutable
abstract class DiscussionForumState {}

class DiscussionForumInitial extends DiscussionForumState {}
////////////////////////////////////////////////////////////
class ChangeTabBarItem extends DiscussionForumState {}
////////////////////////////////////////////////////////////
class DiscussionForumGetAllForumsLoadingState extends DiscussionForumState {}
class DiscussionForumGetAllForumsSuccessState extends DiscussionForumState {}
class DiscussionForumGetAllForumsErrorState extends DiscussionForumState {}
////////////////////////////////////////////////////////////
class DiscussionForumGetMyForumsLoadingState extends DiscussionForumState {}
class DiscussionForumGetMyForumsSuccessState extends DiscussionForumState {}
class DiscussionForumGetMyForumsErrorState extends DiscussionForumState {}
////////////////////////////////////////////////////////////
class DiscussionForumCreatePostLoadingState extends DiscussionForumState {}
class DiscussionForumCreatePostSuccessState extends DiscussionForumState {}
class DiscussionForumCreatePostErrorState extends DiscussionForumState {}
////////////////////////////////////////////////////////////
class DiscussionForumPickImageState extends DiscussionForumState {}
////////////////////////////////////////////////////////////
class DiscussionForumLikeLoadingState extends DiscussionForumState {}
class DiscussionForumLikeSuccessState extends DiscussionForumState {}
////////////////////////////////////////////////////////////
class DiscussionForumCommentLoadingState extends DiscussionForumState {}
class DiscussionForumCommentSuccessState extends DiscussionForumState {}
////////////////////////////////////////////////////////////
class DiscussionForumSearchLoadingState extends DiscussionForumState {}
class DiscussionForumSearchSuccessState extends DiscussionForumState {}
////////////////////////////////////////////////////////////
class DiscussionForumGetForumByIdLoadingState extends DiscussionForumState {}
class DiscussionForumGetForumByIdSuccessState extends DiscussionForumState {}
class DiscussionForumGetForumByIdErrorState extends DiscussionForumState {}