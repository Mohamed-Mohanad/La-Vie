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
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CartCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "My Cart",
              style: AppTextStyle.appBarText(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(26.0),
            child: state is CartGetProductsLoadingState
                ? const CircularProgressIndicator.adaptive()
                : (state is CartAddProductSuccessState ||
                            state is CartGetProductsErrorState) ||
                        cubit.products.isEmpty
                    ? const NotFoundResultView()
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) => CartItem(
                                cartModel: cubit.products[index],
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 25.h,
                              ),
                              itemCount: cubit.products.length,
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
                                  "${cubit.price} EGP",
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
          ),
        );
      },
    );
  }
}
