import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/components/default_button.dart';
import 'package:la_vie_app/core/enum/product_type.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/cubit/cart/cart_cubit.dart';
import 'package:la_vie_app/models/cart/cart_model.dart';
import 'package:la_vie_app/models/products/plant.dart';
import 'package:la_vie_app/models/products/product.dart';
import 'package:la_vie_app/view/home/components/plant_info.dart';
import 'package:la_vie_app/view/home/count_quantity_widget.dart';
import 'package:la_vie_app/view/plant_details/plant_details_screen.dart';

class ProductItem extends StatelessWidget {
  final ProductType productType;
  final Product product;
  const ProductItem({
    Key? key,
    required this.productType,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (productType == ProductType.Plant) {
          NavigationUtils.navigateTo(
            context: context,
            destinationScreen: PlantDetailsScreen(
              plant: product as Plant,
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.lightBackGroundColor,
          boxShadow: [
            BoxShadow(
                offset: const Offset(5, 5),
                blurRadius: 10,
                color: Colors.grey.shade300)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  "https://lavie.orangedigitalcenteregypt.com${product.imageUrl}",
                  fit: BoxFit.cover,
                  height: 120.h,
                  width: 70.w,
                  errorBuilder: (context, object, stacktrace) => SizedBox(
                    height: 120.h,
                    child: Image.asset(
                      "assets/images/grid${(product.hashCode % 2 == 0) ? 1 : 2}.png",
                      fit: BoxFit.cover,
                      height: 120.h,
                      width: 70.w,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CountQuantityWidget(
                            isIncrement: false,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              "0",
                              style: AppTextStyle.bodyText(),
                            ),
                          ),
                          CountQuantityWidget(isIncrement: true),
                        ],
                      ),
                      if (productType == ProductType.Plant) ...[
                        PlantInfoItem(
                          text: "${product.temperature}\xB0c",
                          icon: Icons.thermostat_outlined,
                        ),
                        PlantInfoItem(
                          text: product.sunLight.toString(),
                          icon: Icons.sunny,
                        ),
                        PlantInfoItem(
                          text: product.waterCapacity.toString(),
                          icon: Icons.water_drop,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            Text(
              product.name.toString(),
              style: AppTextStyle.bodyText(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              product.description.toString(),
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
                    id: product.id.toString(),
                    name: product.name.toString(),
                    quantity: 1,
                    imageUrl:
                        "https://lavie.orangedigitalcenteregypt.com${product.imageUrl}",
                  ),
                );
              },
              text: "Add to cart",
              borderRadius: 10.r,
              height: 35.h,
            ),
          ],
        ),
      ),
    );
  }
}
