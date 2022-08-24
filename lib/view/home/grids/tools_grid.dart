import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubit/home/home_cubit.dart';
import '../grid_item_types/tool_item.dart';

class ToolsGrid extends StatelessWidget {
  const ToolsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return (cubit.tools == null)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.count(
                crossAxisCount: 2,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10),
                childAspectRatio: 1.w / 1.51.h,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 20.h,
                children:
                    cubit.tools!.data.map((e) => ToolItem(tool: e)).toList());
      },
    );
  }
}
