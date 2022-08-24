import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/components/default_text_form_field.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/cubit/discussion_forumn/discussion_forum_cubit.dart';
import 'package:la_vie_app/view/discussion_fourms/all_forums.dart';
import 'package:la_vie_app/view/discussion_fourms/create_new_post_screen.dart';
import 'package:la_vie_app/view/home/tab_bar_item.dart';


import 'my_forums.dart';

class DiscussionForumsScreen extends StatefulWidget {
  const DiscussionForumsScreen({Key? key}) : super(key: key);

  @override
  State<DiscussionForumsScreen> createState() => _DiscussionForumsScreenState();
}

class _DiscussionForumsScreenState extends State<DiscussionForumsScreen> {
  final List<String> tabBarItems = ["All Forums", "My forums"];

  final TextEditingController searchController = TextEditingController();

  List<Widget> grids = [
    const AllForumsView(),
    const MyForumsView(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DiscussionForumCubit.get(context).getAllForums();
    DiscussionForumCubit.get(context).getMyForums();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscussionForumCubit, DiscussionForumState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = DiscussionForumCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                DefaultTextFormField(
                  textInputType: TextInputType.text,
                  controller: searchController,
                  prefixIcon: Icons.search_rounded,
                  borderRadius: 10.r,
                  enabledBorderRadius: 10.r,
                  hasBorder: false,
                  isFilled: true,
                  fillColor: Colors.grey.shade100,
                ),
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
                    itemBuilder: (context, index) => HomeTabBarItem(
                        title: tabBarItems[index],
                        isActive: index == cubit.currentTabBarItem,
                        onTap: () {
                          cubit.changeCurrentTabBarItem(index);
                        }),
                  ),
                ),
                Expanded(
                  child: state is DiscussionForumGetAllForumsLoadingState ||
                          state is DiscussionForumGetMyForumsLoadingState
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : grids[cubit.currentTabBarItem],
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
      },
    );
  }
}
