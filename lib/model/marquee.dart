class Marquee {
  final String? externalUrl;
  final String? linkType;
  final String? relatedId;
  final String? text;
  final String? textColour;

  Marquee({
    this.externalUrl,
    this.linkType,
    this.relatedId,
    this.text,
    this.textColour,
  });

  @override
  String toString() {
    return 'Marquee{externalUrl: $externalUrl, linkType: $linkType, relatedId: $relatedId, text: $text, textColour: $textColour}';
  }

  factory Marquee.fromJson(Map<String, dynamic> json) {
    return Marquee(
      externalUrl: json['external_url'],
      linkType: json['link_type'],
      relatedId: json['related_id'],
      text: json['text'],
      textColour: json['text_colour'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'external_url': externalUrl,
      'link_type': linkType,
      'related_id': relatedId,
      'text': text,
      'text_colour': textColour,
    };
  }
}
