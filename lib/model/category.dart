import 'dart:ffi';

class CategoryListModel {

  List<CategoryModel> data;
  CategoryListModel(this.data);

  factory CategoryListModel.fromJson(List json) {

    List<CategoryModel> list = [];
    json.forEach((item) => list.add(CategoryModel.fromJson(item)));
    return CategoryListModel(list);
  }
}

class CategoryModel {
  String mallCategoryId, mallCategoryName, image, comments;
  List<CategoryItemModel> bxMallSubDto;

  CategoryModel({
    this.mallCategoryId, 
    this.mallCategoryName, 
    this.image, 
    this.comments, 
    this.bxMallSubDto});

  factory CategoryModel.fromJson(dynamic json) {

    List<CategoryItemModel> list = [];
    (json['bxMallSubDto'] as List).forEach((item) => list.add(CategoryItemModel.fromJson(item)));
    return CategoryModel(
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
      image: json['image'],
      comments: json['comments'],
      bxMallSubDto: list);
  }
}

class CategoryItemModel {
  String mallSubId, mallCategoryId, mallSubName, comments;

  CategoryItemModel({
    this.mallSubId,
    this.mallCategoryId,
    this.mallSubName,
    this.comments
  });

  factory CategoryItemModel.fromJson(dynamic json) {
    return CategoryItemModel(
      mallSubId: json['mallSubId'],
      mallCategoryId: json['mallCategoryId'],
      mallSubName: json['mallSubName'],
      comments: json['comments']
      );
  }
}

// detail
class CategoryDetailListModel {
  List<CategoryDetailItemModel> data;

  CategoryDetailListModel(this.data);

  factory CategoryDetailListModel.fromJson(List json) {

    List<CategoryDetailItemModel> list = [];
    json.forEach((item) => list.add(CategoryDetailItemModel.fromJson(item)));
    return CategoryDetailListModel(list);
  }

}

class CategoryDetailItemModel {

  String goodsName, goodsId, image;
  double oriPrice, presentPrice;

  CategoryDetailItemModel({this.goodsName, this.goodsId, this.image, this.oriPrice, this.presentPrice});


  factory CategoryDetailItemModel.fromJson(Map json) {

    return CategoryDetailItemModel(
      goodsName: json['goodsName'],
      goodsId: json['goodsId'],
      image: json['image'],
      oriPrice: json['oriPrice'],
      presentPrice: json['presentPrice'],
    );
  }
}

