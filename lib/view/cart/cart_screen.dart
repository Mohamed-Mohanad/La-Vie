import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/components/default_button.dart';
import 'package:la_vie_app/core/components/default_not_found_result_view.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/cubit/cart/cart_cubit.dart';
import 'package:la_vie_app/repositories/src/local/sql/sql_helper.dart';
import 'package:la_vie_app/view/cart/components/cart_componenets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SqlHelper.initDB();
    CartCubit.get(context).getAllCartProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: AppTextStyle.appBarText(),
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(26.0),
            child: state is CartGetProductsLoadingState
                ? const CircularProgressIndicator.adaptive()
                : (state is CartAddProductSuccessState ||
                            state is CartGetProductsErrorState) ||
                        CartCubit.get(context).products.isEmpty
                    ? const NotFoundResultView()
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) => CartItem(
                                cartModel:
                                    CartCubit.get(context).products[index],
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 25.h,
                              ),
                              itemCount: CartCubit.get(context).products.length,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: AppTextStyle.bodyText(),
                                ),
                                Text(
                                  "${CartCubit.get(context).price} EGP",
                                  style: AppTextStyle.subTitle().copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          DefaultButton(
                            onPress: () {},
                            text: "Checkout",
                          ),
                        ],
                      ),
          );
        },
      ),
    );
  }
}
