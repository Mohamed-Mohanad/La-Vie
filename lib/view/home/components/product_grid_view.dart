import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/enum/product_type.dart';
import 'package:la_vie_app/cubit/product/product_cubit.dart';
import 'package:la_vie_app/models/products/product.dart';
import 'package:la_vie_app/view/home/components/product_item.dart';

class ProductGridView extends StatelessWidget {
  final ProductType productsType;
  final List<Product> products;
  ProductGridView({
    Key? key,
    required this.products,
    required this.productsType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (_, state) {
        return products.isEmpty
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : GridView.count(
                crossAxisCount: 2,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10),
                childAspectRatio: 1.w / 1.51.h,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 20.h,
                children: products
                    .map(
                      (e) => ProductItem(
                        productType: productsType,
                        product: e,
                      ),
                    )
                    .toList());
      },
    );
  }
}
