class Option {
  final String? name;
  final int? shopifyProductOptionId;
  final List<String>? values;

  Option({
    this.name,
    this.shopifyProductOptionId,
    this.values,
  });

  @override
  String toString() {
    return 'Option{name: $name, shopifyProductOptionId: $shopifyProductOptionId, values: $values}';
  }

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      name: json['name'],
      shopifyProductOptionId: json['shopify_product_option_id'] != null
          ? int.parse(json['shopify_product_option_id'].toString())
          : null,
      values: json['values'] != null ? List<String>.from(json['values']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'shopify_product_option_id': shopifyProductOptionId,
      'values': values,
    };
  }
}
