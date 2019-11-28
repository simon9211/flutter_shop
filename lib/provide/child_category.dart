import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {

  List<CategoryItemModel> _childCategoryList = [];

  List<CategoryItemModel> get childCategoryList => _childCategoryList;

  void getChildCategory(List list) {
    _childCategoryList = list;
    notifyListeners();
  }
}

class SubCategory with ChangeNotifier {
  CategoryItemModel _subCategoryModel;

  CategoryItemModel get subCategoryModel => _subCategoryModel;

  void getCategoryItemModel(CategoryItemModel model) {
    _subCategoryModel = model;
    notifyListeners();
  }
}
