class Variant {
  final String? option1;
  final String? option2;
  final String? option3;
  final String? shopifyProductVariantId;
  final String? title;
  // final double? priceV2LessExpensive;
  final String? compareAtPriceV2MoreExpensive;
  // final int? quantityAvailable;
  final String? image;
  final bool? availableForSale;

  Variant({
    this.option1,
    this.option2,
    this.option3,
    this.shopifyProductVariantId,
    this.title,
    // this.priceV2LessExpensive,
    this.compareAtPriceV2MoreExpensive,
    // this.quantityAvailable,
    this.image,
    this.availableForSale,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      option1: json['option1'],
      option2: json['option2'],
      option3: json['option3'],
      shopifyProductVariantId: json['shopify_product_variant_id'],
      title: json['title'],
      // priceV2LessExpensive: json['price'],
      compareAtPriceV2MoreExpensive: json['compare_at_price'],
      // quantityAvailable: json['inventory_quantity'] != null
      //     ? int.parse(json['inventory_quantity'].toString())
      //     : null,
      image: json['image'],
      availableForSale: json['available_for_sale'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'shopify_product_variant_id': shopifyProductVariantId,
      'title': title,
      // 'price': priceV2LessExpensive,
      'compare_at_price': compareAtPriceV2MoreExpensive,
      // 'inventory_quantity': quantityAvailable?.toInt(),
      'image': image,
      'available_for_sale': availableForSale,
    };
  }
}
