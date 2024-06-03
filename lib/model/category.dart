import 'product.dart';

class Category {
  final String? imageSrc;
  final String? shopifyCollectionId;
  final String? title;
  final List<Product>? products;
  final List<dynamic>? notViewable;

  Category({
    required this.imageSrc,
    required this.shopifyCollectionId,
    required this.title,
    required this.products,
    required this.notViewable,
  });

  @override
  String toString() {
    return 'Category{imageSrc: $imageSrc, shopifyCollectionId: $shopifyCollectionId, title: $title, products: $products, notViewable: $notViewable}';
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      imageSrc: json['image_src'],
      shopifyCollectionId: json['shopify_collection_id'],
      title: json['title'],
      products: json['products'] != null
          ? (json['products'] as List)
              .map((item) => Product.fromJson(item))
              .toList()
          : null,
      notViewable: json['not_viewable'] != null
          ? List<dynamic>.from(json['not_viewable'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_src': imageSrc,
      'shopify_collection_id': shopifyCollectionId,
      'title': title,
      'products': products?.map((item) => item.toJson()).toList(),
      'not_viewable': notViewable,
    };
  }
}
