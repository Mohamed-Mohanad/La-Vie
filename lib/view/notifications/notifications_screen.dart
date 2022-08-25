import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/components/default_not_found_result_view.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/cubit/user/user_cubit.dart';
import 'package:la_vie_app/view/notifications/components/notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserCubit.get(context).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Text(
          "Notification",
          textAlign: TextAlign.center,
          style: AppTextStyle.appBarText(),
        ),
        SizedBox(
          height: 20.h,
        ),
        BlocBuilder<UserCubit, UserState>(
          builder: (_, state) => UserCubit.get(context).userModel == null ||
                  UserCubit.get(context).userModel!.userNotification == null
              ? NotFoundResultView()
              : Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => NotificationItem(
                      notification: UserCubit.get(context)
                          .userModel!
                          .userNotification![index],
                    ),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: UserCubit.get(context)
                        .userModel!
                        .userNotification!
                        .length,
                  ),
                ),
        ),
      ],
    );
  }
}
