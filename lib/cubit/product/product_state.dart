part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class HomeInitial extends ProductState {}
///////////////////////////////////////////////
class ChangeTabBarItem extends ProductState {}
///////////////////////////////////////////////
class GetAllProductsLoadingState extends ProductState {}
class GetAllProductsSuccessfulState extends ProductState {}
class GetAllProductsErrorState extends ProductState {}
///////////////////////////////////////////////
class GetPlantDetailsLoadingState extends ProductState {}
class GetPlantDetailsSuccessfulState extends ProductState {}
class GetPlantDetailsErrorState extends ProductState {}
///////////////////////////////////////////////
class ResetScanResultState extends ProductState {}
///////////////////////////////////////////////
class SearchLoadingState extends ProductState {}
class SearchSuccessState extends ProductState {}