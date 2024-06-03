import 'image.dart';
import 'logistic_tag.dart';
import 'option.dart';
import 'variant.dart';

class Product {
  final String? descriptionHtml;
  final String? handle;
  final bool? isFavourite;
  final String? displayImage;
  final List<LogisticTag>? logisticTags;
  final List<Option>? options;
  final String shopifyProductId;
  final String? title;
  final List<Variant>? variants;
  final List<Image>? images;
  final double? priceV2LessExpensive;
  final double? compareAtPriceV2MoreExpensive;
  final int? quantityAvailable;
  final List<Product>? similarProducts;

  Product({
    this.descriptionHtml,
    this.handle,
    this.isFavourite,
    this.displayImage,
    this.logisticTags,
    this.options,
    this.shopifyProductId = "",
    this.title,
    this.variants,
    this.images,
    this.priceV2LessExpensive,
    this.compareAtPriceV2MoreExpensive,
    this.quantityAvailable,
    this.similarProducts,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      descriptionHtml: json['description_html'],
      handle: json['handle'],
      isFavourite: json['is_favourite'],
      displayImage: json['image_src'],
      logisticTags: json['logistic_tags'] != null
          ? (json['logistic_tags'] as List)
              .map((tagJson) => LogisticTag.fromJson(tagJson))
              .toList()
          : null,
      options: json['options'] != null
          ? (json['options'] as List)
              .map((optionJson) => Option.fromJson(optionJson))
              .toList()
          : null,
      shopifyProductId: json['shopify_product_id'] ?? "",
      title: json['title'],
      variants: json['variants'] != null
          ? (json['variants'] as List)
              .map((variantJson) => Variant.fromJson(variantJson))
              .toList()
          : null,
      images: json['images'] != null
          ? (json['images'] as List)
              .map((imageJson) => Image.fromJson(imageJson))
              .toList()
          : null,
      priceV2LessExpensive:
          json['price'] != null ? double.parse(json['price'].toString()) : null,
      compareAtPriceV2MoreExpensive: json['compare_at_price'] != null
          ? double.parse(json['compare_at_price'].toString())
          : null,
      quantityAvailable: json['inventory_quantity'] != null
          ? int.parse(json['inventory_quantity'].toString())
          : null,
      similarProducts: json['similar_products'] != null
          ? (json['similar_products'] as List)
              .map((similarProductJson) => Product.fromJson(similarProductJson))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description_html': descriptionHtml,
      'handle': handle,
      'is_favourite': isFavourite,
      'image_src': displayImage,
      'logistic_tags': logisticTags?.map((tag) => tag.toJson()).toList(),
      'options': options?.map((option) => option.toJson()).toList(),
      'shopify_product_id': shopifyProductId,
      'title': title,
      'variants': variants?.map((variant) => variant.toJson()).toList(),
      'images': images?.map((image) => image.toJson()).toList(),
      'price': priceV2LessExpensive?.toDouble(),
      'compare_at_price': compareAtPriceV2MoreExpensive?.toDouble(),
      'inventory_quantity': quantityAvailable?.toInt(),
      'similar_products':
          similarProducts?.map((product) => product.toJson()).toList(),
    };
  }
}
