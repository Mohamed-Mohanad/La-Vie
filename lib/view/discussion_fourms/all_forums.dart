import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/components/default_not_found_result_view.dart';
import 'package:la_vie_app/cubit/discussion_forumn/discussion_forum_cubit.dart';

import '../../view/discussion_fourms/components/post_item.dart';

class AllForumsView extends StatelessWidget {
  const AllForumsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscussionForumCubit, DiscussionForumState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = DiscussionForumCubit.get(context);
        return cubit.allForumModel == null
            ? const NotFoundResultView()
            : ListView.separated(
                itemBuilder: (context, index) => PostItem(
                  forumModel: cubit.allForumModel!.data![index],
                  forumKind: 0,
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 15.h,
                ),
                itemCount: 10,
              );
      },
    );
  }
}
