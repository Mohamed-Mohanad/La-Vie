import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountQuantityWidget extends StatelessWidget {
  bool isIncrement;
  Function? oTapFunc;
  CountQuantityWidget({Key? key, required this.isIncrement, this.oTapFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        oTapFunc!();
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(3.r)),
        child: Icon(
          isIncrement ? Icons.add : Icons.minimize,
          size: 15,
        ),
      ),
    );
  }
}
