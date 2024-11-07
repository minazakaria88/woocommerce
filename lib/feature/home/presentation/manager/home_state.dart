abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangeBottomNavState extends HomeState {}



class AddToCartState extends HomeState{}


class ProductsSuccessState extends HomeState{}
class ProductsLoadingState extends HomeState{}
class ProductsErrorState extends HomeState{}


class OrderLoadingState extends HomeState{}
class OrderSuccessState extends HomeState{}
class OrderErrorState extends HomeState{}

class CategoriesSuccessState extends HomeState{}
class CategoriesLoadingState extends HomeState{}
class CategoriesErrorState extends HomeState{}

class SearchByCategoryState extends HomeState{}
class SearchByCategoryEmptyState extends HomeState{}
class ProductVariationLoadingState extends HomeState{}


class UserLoadingState extends HomeState{}
class UserSuccessState extends HomeState{}
class UserErrorState extends HomeState{}

class EditOrderLoadingState extends HomeState{}
class EditOrderSuccessState extends HomeState{}
class EditOrderErrorState extends HomeState{}

