abstract class CategoryEvent {}

// class SearchCategoryByName extends CategoryEvent {
//   final List<Category> categories;
//   final String query;

//   SearchCategoryByName({required this.query, required this.categories});
// }

class LoadCategory extends CategoryEvent {
  final int id;

  LoadCategory({required this.id});
}

class LoadCategories extends CategoryEvent {
  final bool? isIncome;

  LoadCategories({this.isIncome});
}
