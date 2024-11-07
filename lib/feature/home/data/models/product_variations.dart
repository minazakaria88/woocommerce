
class ProductVariations
{
  late final int id;
  late final String name;
  late final String price;
  List<ProductVariationsAttributes> attributes=[];

  ProductVariations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    if (json['attributes'] != null) {
      json['attributes'].forEach((v) {
        attributes.add(ProductVariationsAttributes.fromJson(v));
      });
    }
  }

}
class ProductVariationsAttributes {
  late final int id;
  late final String name;
  late final String option;

  ProductVariationsAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    option = json['option'];
  }
}