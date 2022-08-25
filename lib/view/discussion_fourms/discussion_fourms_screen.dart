import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/components/default_tab_bar_buttons.dart';
import 'package:la_vie_app/core/components/default_text_form_field.dart';
import 'package:la_vie_app/core/enum/forum_type.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/cubit/discussion_forum/discussion_forum_cubit.dart';
import 'package:la_vie_app/view/discussion_fourms/components/forums_view.dart';
import 'package:la_vie_app/view/discussion_fourms/create_new_post_screen.dart';



class DiscussionForumsScreen extends StatefulWidget {
  const DiscussionForumsScreen({Key? key}) : super(key: key);

  @override
  State<DiscussionForumsScreen> createState() => _DiscussionForumsScreenState();
}

class _DiscussionForumsScreenState extends State<DiscussionForumsScreen> {
  final List<String> tabBarItems = ["All Forums", "My forums"];

  final TextEditingController searchController = TextEditingController();

  List<Widget> grids = [];

  bool isSearch = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DiscussionForumCubit.get(context).getAllForums();
    DiscussionForumCubit.get(context).getMyForums();
    grids = [
      ForumView(
        forums: DiscussionForumCubit.get(context).allForums,
        forumType: ForumType.All,
      ),
      ForumView(
        forums: DiscussionForumCubit.get(context).myForums,
        forumType: ForumType.My,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                if (isSearch) ...[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSearch = false;
                      });
                    },
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ],
                Expanded(
                  child: DefaultTextFormField(
                    textInputType: TextInputType.text,
                    controller: searchController,
                    prefixIcon: Icons.search_rounded,
                    borderRadius: 10.r,
                    enabledBorderRadius: 10.r,
                    hasBorder: false,
                    isFilled: true,
                    fillColor: Colors.grey.shade100,
                    onChange: (String val) {
                      DiscussionForumCubit.get(context).getSearchForums(val);
                    },
                    onTap: () {
                      setState(() {
                        isSearch = true;
                      });
                    },
                  ),
                ),
              ],
            ),
            BlocBuilder<DiscussionForumCubit, DiscussionForumState>(
              builder: (_, state) => Expanded(
                child: Column(
                  children: [
                    if (isSearch) ...[
                      SizedBox(
                        height: 15.h,
                      ),
                      DiscussionForumCubit.get(context).searchForums.isEmpty
                          ? Container()
                          : Expanded(
                              child: ForumView(
                                forums: DiscussionForumCubit.get(context)
                                    .searchForums,
                                forumType: ForumType.Search,
                              ),
                            ),
                    ],
                    if (!isSearch) ...[
                      SizedBox(
                        height: 50.h,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => SizedBox(
                            width: 10.w,
                          ),
                          itemCount: tabBarItems.length,
                          itemBuilder: (context, index) => DefaultTabBarButtons(
                              title: tabBarItems[index],
                              isActive: index ==
                                  DiscussionForumCubit.get(context)
                                      .currentTabBarItem,
                              onTap: () {
                                DiscussionForumCubit.get(context)
                                    .changeCurrentTabBarItem(index);
                              }),
                        ),
                      ),
                      Expanded(
                        child: state is DiscussionForumGetAllForumsLoadingState ||
                                state is DiscussionForumGetMyForumsLoadingState
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : grids[DiscussionForumCubit.get(context)
                                .currentTabBarItem],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationUtils.navigateTo(
            context: context,
            destinationScreen: CreateNewPostScreen(),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
