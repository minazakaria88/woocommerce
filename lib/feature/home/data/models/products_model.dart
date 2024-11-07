class ProductModel {
  late  String price;
  late final String name;
  late final int id;
  late final String type;
  late final String salePrice;
  late final String regularPrice;
  List<Images> images = [];
  List<Attributes> attributes=[];

  ProductModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    type=json['type'];
    id = json['id'];
    salePrice=json['sale_price'];
    regularPrice=json['regular_price'];
    name = json['name'];
    images = (json['images'] as List).map((e) => Images.fromJson(e)).toList();
    attributes=(List<Attributes>.from(json['attributes'].map((x) => Attributes.fromJson(x))));
  }

  ProductModel copyWith()
  {
    return ProductModel(
      price: price,
      name: name,
      id: id,
      type: type,
      salePrice: salePrice,
      regularPrice: regularPrice,
      images: images,
      attributes: attributes
    );
  }

  ProductModel({
    required this.price,
    required this.name,
    required this.id,
    required this.type,
    required this.salePrice,
    required this.regularPrice,
    required this.images,
    required this.attributes,
  });
}

class Images {
  late final String src;
  late final String name;

  Images.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    name = json['name'];
  }
}

class Attributes
{
  late final int id;
  late final String name;
  late final List<dynamic> options;

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    options = json['options'];
  }




}