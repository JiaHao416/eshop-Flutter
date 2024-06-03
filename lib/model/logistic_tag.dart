class LogisticTag {
  final String? bulletPoint;
  final String? deliveryEndDate;
  final int? deliveryLeadTime;
  final String? deliveryStartDate;
  final String? storePickupEndDate;
  final int? storePickupLeadTime;
  final String? storePickupStartDate;
  final String? tag;
  final String? tagName;
  final String? type;

  LogisticTag({
    this.bulletPoint,
    this.deliveryEndDate,
    this.deliveryLeadTime,
    this.deliveryStartDate,
    this.storePickupEndDate,
    this.storePickupLeadTime,
    this.storePickupStartDate,
    this.tag,
    this.tagName,
    this.type,
  });

  @override
  String toString() {
    return 'LogisticTag{bulletPoint: $bulletPoint, deliveryEndDate: $deliveryEndDate, deliveryLeadTime: $deliveryLeadTime, deliveryStartDate: $deliveryStartDate, storePickupEndDate: $storePickupEndDate, storePickupLeadTime: $storePickupLeadTime, storePickupStartDate: $storePickupStartDate, tag: $tag, tagName: $tagName, type: $type}';
  }

  factory LogisticTag.fromJson(Map<String, dynamic> json) {
    return LogisticTag(
      bulletPoint: json['bullet_point'],
      deliveryEndDate: json['delivery_end_date'],
      deliveryLeadTime: json['delivery_lead_time'] != null
          ? int.parse(json['delivery_lead_time'].toString())
          : null,
      deliveryStartDate: json['delivery_start_date'],
      storePickupEndDate: json['store_pickup_end_date'],
      storePickupLeadTime: json['store_pickup_lead_time'] != null
          ? int.parse(json['store_pickup_lead_time'].toString())
          : null,
      storePickupStartDate: json['store_pickup_start_date'],
      tag: json['tag'],
      tagName: json['tag_name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bullet_point': bulletPoint,
      'delivery_end_date': deliveryEndDate,
      'delivery_lead_time': deliveryLeadTime?.toInt(),
      'delivery_start_date': deliveryStartDate,
      'store_pickup_end_date': storePickupEndDate,
      // 'store_pickup_lead_time': storePickupLeadTime?.toInt(),
      'store_pickup_start_date': storePickupStartDate,
      'tag': tag,
      'tag_name': tagName,
      'type': type,
    };
  }
}
