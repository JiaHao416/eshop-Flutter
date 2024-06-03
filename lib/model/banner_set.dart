class BannerSetItem {
  final String? externalUrl;
  final int? id;
  final String? imageSrc;
  final String? linkType;
  final String? relatedId;
  final String? youtubeId;
  final List<dynamic>? notViewable;
  final String? bannerName;

  BannerSetItem({
    required this.externalUrl,
    required this.id,
    required this.imageSrc,
    required this.linkType,
    required this.relatedId,
    required this.youtubeId,
    required this.notViewable,
    required this.bannerName,
  });

  @override
  String toString() {
    return 'BannerSetItem{externalUrl: $externalUrl, id: $id, imageSrc: $imageSrc, linkType: $linkType, relatedId: $relatedId, youtubeId: $youtubeId, notViewable: $notViewable, bannerName: $bannerName}';
  }

  factory BannerSetItem.fromJson(Map<String, dynamic> json) {
    return BannerSetItem(
      externalUrl: json['external_url'],
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      imageSrc: json['image_src'],
      linkType: json['link_type'],
      relatedId: json['related_id'],
      youtubeId: json['youtube_id'],
      notViewable: json['not_viewable'] != null
          ? List<dynamic>.from(json['not_viewable'])
          : null,
      bannerName: json['banner_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'external_url': externalUrl,
      'id': id?.toInt(),
      'image_src': imageSrc,
      'link_type': linkType,
      'related_id': relatedId,
      'youtube_id': youtubeId,
      'not_viewable': notViewable,
      'banner_name': bannerName,
    };
  }
}
