import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/models/user/user_model.dart';

class NotificationItem extends StatelessWidget {
  final UserNotification notification;
  const NotificationItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
            "https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=1380&t=st=1661270944~exp=1661271544~hmac=27633c09819b1643b83de21dc964cc6a5bc9b6f66a87701069f899f57b84ae02"),
      ),
      title: Column(
        children: [
          Text(
            notification.message.toString(),
            style: AppTextStyle.bodyText(),
          ),
          // if (isThereParagraph) ...[
          //   Row(
          //     children: [
          //       SizedBox(
          //         height: 50.h,
          //         child: const VerticalDivider(
          //           thickness: 4,
          //           color: Color(0xffDDDEE1),
          //         ),
          //       ),
          //       Expanded(
          //         child: Text(
          //           "leaves are an integral part of the stem system. They are attached by a continuous vascular system to the rest of the plant so that free exchange of nutrients.",
          //           maxLines: 3,
          //           overflow: TextOverflow.ellipsis,
          //           style: AppTextStyle.bodyText().copyWith(fontSize: 11.sp),
          //         ),
          //       )
          //     ],
          //   ),
          // ],
        ],
      ),
      subtitle: Text(
        DateFormat.yMEd().add_jms().format(notification.createdAt!),
        style: AppTextStyle.subTitle(),
      ),
    );
  }
}
