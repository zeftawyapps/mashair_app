import 'howe_models/categ.dart';

class SharedCategory {
  // single tone object with list of category
  List<CategoryHome> list = [] ;
  static final SharedCategory _instance = SharedCategory._internal();
  SharedCategory._internal() : list = [];
  factory SharedCategory() => _instance;
void addCategory(CategoryHome category) {
  list.add(category);
}

}