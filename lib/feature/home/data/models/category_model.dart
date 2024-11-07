class CategoryModel
{
  late final int id;
  late final String name;
    CategoryImage  ? images;
  CategoryModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    if (json['image'] != null) {
      images = CategoryImage.fromJson(json['image']);
    }
  }

}
class CategoryImage
{
  late final String  src;
  late final int id;

  CategoryImage.fromJson(Map<String, dynamic> json)
  {
    src = json['src'];
    id = json['id'];
  }
}