

import '../../../home/data/models/products_model.dart';

class CartItemModel {
  late final ProductModel productModel;
  late  int quantity;
  late int variantId;

  CartItemModel({required this.productModel,this.quantity=1,this.variantId=0});

}
