import 'product.dart'; // Importing Product class assuming it's defined in a separate file.

class HomeCollection {
  final String? layout;
  final List<Product>? products;
  final String? shopifyCollectionId;
  final String? title;
  final List<dynamic>? notViewable;

  HomeCollection({
    this.layout,
    this.products,
    this.shopifyCollectionId,
    this.title,
    this.notViewable,
  });

  @override
  String toString() {
    return 'HomeCollection{layout: $layout, products: $products, shopifyCollectionId: $shopifyCollectionId, title: $title, notViewable: $notViewable}';
  }

  factory HomeCollection.fromJson(Map<String, dynamic> json) {
    return HomeCollection(
      layout: json['layout'],
      products: json['products'] != null
          ? (json['products'] as List)
              .map((item) => Product.fromJson(item))
              .toList()
          : null,
      shopifyCollectionId: json['shopify_collection_id'],
      title: json['title'],
      notViewable: json['not_viewable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'layout': layout,
      'products': products?.map((item) => item.toJson()).toList(),
      'shopify_collection_id': shopifyCollectionId,
      'title': title,
      'not_viewable': notViewable,
    };
  }
}
