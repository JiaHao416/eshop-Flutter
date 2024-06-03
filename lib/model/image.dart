class Image {
  final int? height;
  final String? src;
  final int? width;

  Image({
    this.height,
    this.src,
    this.width,
  });

  @override
  String toString() {
    return 'Image{height: $height, src: $src, width: $width}';
  }

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      height:
          json['height'] != null ? int.parse(json['height'].toString()) : null,
      src: json['src'],
      width: json['width'] != null ? int.parse(json['width'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height?.toInt(),
      'src': src,
      'width': width?.toInt(),
    };
  }
}
