class SplashAd {
  final String? externalUrl;
  final int? id;
  final String? imageSrc;
  final String? linkType;
  final String? relatedId;
  final String? youtubeId;

  SplashAd({
    required this.externalUrl,
    required this.id,
    required this.imageSrc,
    required this.linkType,
    required this.relatedId,
    required this.youtubeId,
  });

  factory SplashAd.fromJson(Map<String, dynamic> json) {
    return SplashAd(
      externalUrl: json['external_url'],
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      imageSrc: json['image_src'],
      linkType: json['link_type'],
      relatedId: json['related_id'],
      youtubeId: json['youtube_id'],
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
    };
  }
}
