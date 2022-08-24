import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/models/products/plants.dart';
import 'package:la_vie_app/models/products/tools.dart';

import '../../../cubit/home/home_cubit.dart';
import '../grid_item_types/plant_item.dart';
import '../grid_item_types/seed_item.dart';
import '../grid_item_types/tool_item.dart';

class AllGrid extends StatelessWidget {
  const AllGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return (cubit.allProductsResponse == null)
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
                children: cubit.products.map((e) {
                  if (e is Plant) {
                    return PlantItem(plant: e);
                  } else if (e is Tool) {
                    return ToolItem(tool: e);
                  } else {
                    return SeedItem(seed: e);
                  }
                }).toList());
      },
    );
  }
}
