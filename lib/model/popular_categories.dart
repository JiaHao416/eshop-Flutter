import 'category.dart';

class PopularCategories {
  final List<Category>? categories;
  final String? layout;
  final String? title;

  PopularCategories({
    required this.categories,
    required this.layout,
    required this.title,
  });

  factory PopularCategories.fromJson(Map<String, dynamic> json) {
    return PopularCategories(
      categories: json['categories'] != null
          ? (json['categories'] as List)
              .map((item) => Category.fromJson(item))
              .toList()
          : null,
      layout: json['layout'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories?.map((item) => item.toJson()).toList(),
      'layout': layout,
      'title': title,
    };
  }
}
