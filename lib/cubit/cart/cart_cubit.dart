import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_vie_app/models/cart/cart_model.dart';
import 'package:la_vie_app/repositories/src/local/sql/sql_helper.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);

  List<CartModel> products = [];

  void getAllCartProducts() {
    emit(CartGetProductsLoadingState());
    products.clear();
    SqlHelper.getAllCartProducts().then((value) {
      for (var element in value) {
        products.add(CartModel.fromDB(element));
      }
      emit(CartGetProductsSuccessState());
      getTotalPrice();
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CartGetProductsErrorState());
    });
  }

  void addToCart(CartModel cartModel) {
    emit(CartAddProductLoadingState());
    SqlHelper.insertProduct(cartModel).then((value) {
      Fluttertoast.showToast(
        msg: "Added To Cart Successfully",
        textColor: Colors.white,
        backgroundColor: Colors.green,
      );
      emit(CartAddProductSuccessState());
      getTotalPrice();
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CartAddProductErrorState());
    });
  }

  void updateProductQuantity(int quantity, String id) {
    emit(CartUpdateProductLoadingState());
    SqlHelper.updateProductQuantity(id, quantity).then((value) {
      getAllCartProducts();
      emit(CartUpdateProductSuccessState());
      getTotalPrice();
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CartUpdateProductErrorState());
    });
  }

  void removeProduct(CartModel cartModel) {
    emit(CartRemoveProductLoadingState());
    SqlHelper.deleteRecorde(cartModel.id!).then((value) {
      getAllCartProducts();
      Fluttertoast.showToast(
        msg: "Removed From Cart Successfully",
        textColor: Colors.white,
        backgroundColor: Colors.green,
      );
      getTotalPrice();
      emit(CartRemoveProductSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CartRemoveProductErrorState());
    });
  }

  double price = 0;
  void getTotalPrice() {
    price = 0;
    for (var element in products) {
      price += element.price! * element.quantity!;
    }
    emit(CartGetTotalPriceState());
  }
}
