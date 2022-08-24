import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/view/notifications/components/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Notification",
          textAlign: TextAlign.center,
          style: AppTextStyle.appBarText(),
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: ListView(
            children: const [
              NotificationItem(
                isThereParagraph: false,
              ),
              Divider(),
              NotificationItem(
                isThereParagraph: true,
              ),
              Divider(),
              NotificationItem(
                isThereParagraph: false,
              ),
              Divider(),
              NotificationItem(
                isThereParagraph: false,
              ),
              Divider(),
              NotificationItem(
                isThereParagraph: true,
              ),
              Divider(),
              NotificationItem(
                isThereParagraph: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
