import 'package:flutter/material.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_helper.dart';

import '../login/login_screen.dart';

void logoutAlertDialog(context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Logout"),
      content: const Text("Do you want to logout from your account?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(
          onPressed: () {
            CacheHelper.removeData(key: "accessToken").then(
              (value) {
                NavigationUtils.navigateAndClearStack(
                  context: context,
                  destinationScreen: LoginScreen(),
                );
              },
            );
          },
          child: const Text("Logout"),
        ),
      ],
    ),
  );
}
