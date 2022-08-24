import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/cubit/cart/cart_cubit.dart';
import 'package:la_vie_app/models/cart/cart_model.dart';
import 'package:la_vie_app/models/products/seeds.dart';


import '../../../core/components/default_button.dart';

import '../count_quantity_widget.dart';

class SeedItem extends StatelessWidget {
  SeedItem({Key? key, required this.seed}) : super(key: key);
  Seed seed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.lightBackGroundColor,
          boxShadow: [
            BoxShadow(
                offset: const Offset(5, 5),
                blurRadius: 10,
                color: Colors.grey.shade300)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                //"assets/images/grid${(seed.hashCode % 2 == 0) ? 1 : 2}.png",
                "https://lavie.orangedigitalcenteregypt.com${seed.imageUrl}",
                fit: BoxFit.cover,
                height: 120.h,
                width: 80.w,
                errorBuilder: (context, object, stacktrace) => SizedBox(
                  height: 120.h,
                  child: Image.asset("assets/images/grid${(seed.hashCode % 2 == 0) ? 1 : 2}.png",fit: BoxFit.cover,
                    height: 120.h,
                    width: 80.w,),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              CountQuantityWidget(
                isIncrement: false,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  "0",
                  style: AppTextStyle.bodyText(),
                ),
              ),
              CountQuantityWidget(isIncrement: true),
            ],
          ),
          Text(
            seed.name,
            style: AppTextStyle.bodyText(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            seed.description,
            style: AppTextStyle.subTitle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 5.h,
          ),
          const Spacer(),
          DefaultButton(
            onPress: () {
              CartCubit.get(context).addToCart(
                CartModel(
                  id: seed.seedId,
                  name: seed.name,
                  quantity: 1,
                  imageUrl:"https://lavie.orangedigitalcenteregypt.com${seed.imageUrl}",
                ),
              );
            },
            text: "Add to cart",
            borderRadius: 10.r,
            height: 35.h,
          )
        ],
      ),
    );
  }
}
