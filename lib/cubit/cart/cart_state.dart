part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartGetProductsLoadingState extends CartState {}
class CartGetProductsSuccessState extends CartState {}
class CartGetProductsErrorState extends CartState {}

class CartAddProductLoadingState extends CartState {}
class CartAddProductSuccessState extends CartState {}
class CartAddProductErrorState extends CartState {}

class CartUpdateProductLoadingState extends CartState {}
class CartUpdateProductSuccessState extends CartState {}
class CartUpdateProductErrorState extends CartState {}

class CartRemoveProductLoadingState extends CartState {}
class CartRemoveProductSuccessState extends CartState {}
class CartRemoveProductErrorState extends CartState {}

class CartGetTotalPriceState extends CartState {}
