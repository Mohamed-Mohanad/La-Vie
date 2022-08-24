import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/cubit/cart/cart_cubit.dart';
import 'package:la_vie_app/models/cart/cart_model.dart';

import '../../home/count_quantity_widget.dart';

class CartItem extends StatelessWidget {
  final CartModel cartModel;
  const CartItem({
    Key? key,
    required this.cartModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          15.r,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image(
                image: NetworkImage(
                    'https://img.freepik.com/free-psd/green-houseplant-mockup-psd-banner_53876-137827.jpg?w=1380&t=st=1661300452~exp=1661301052~hmac=322e9c03e18a19226627fdef7d290c7a27832075e8154e459b75b9355042e882'),
                fit: BoxFit.cover,
                height: 90.h,
                width: 130.w,
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartModel.name!,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.bodyText().copyWith(fontSize: 12.sp),
                ),
                Text(
                  '${cartModel.price!} EGP',
                  textAlign: TextAlign.start,
                  style: AppTextStyle.bodyText().copyWith(
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    CountQuantityWidget(
                      oTapFunc: () {
                        int q = cartModel.quantity!;
                        q++;
                        CartCubit.get(context)
                            .updateProductQuantity(q, cartModel.id!);
                      },
                      isIncrement: true,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      cartModel.quantity.toString(),
                      style: AppTextStyle.subTitle(),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    CountQuantityWidget(
                      oTapFunc: () {
                        int q = cartModel.quantity!;
                        if (q > 1) {
                          q--;
                          CartCubit.get(context)
                              .updateProductQuantity(q, cartModel.id!);
                        }
                      },
                      isIncrement: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: () {
                CartCubit.get(context).removeProduct(cartModel);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.green,
              ),
            ),
          )
        ],
      ),
    );
  }
}
