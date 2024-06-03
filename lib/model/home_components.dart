import 'banner_set.dart';
import 'home_collection.dart';
import 'marquee.dart';
import 'popular_categories.dart';
import 'splash_ad.dart';

class HomeComponent {
  final SplashAd? splashAd;
  final List<BannerSetItem>? bannerSet;
  final PopularCategories? popularCategories;
  final int? popularCategoriesId;
  final HomeCollection? collection;
  final List<Marquee>? marquees;
  final String? type;
  final bool? isHidden;

  HomeComponent({
    this.splashAd,
    this.bannerSet,
    this.popularCategories,
    this.popularCategoriesId,
    this.collection,
    this.marquees,
    this.type,
    this.isHidden,
  });

  factory HomeComponent.fromJson(Map<String, dynamic> json) {
    return HomeComponent(
      splashAd: json['splash_ad'] != null
          ? SplashAd.fromJson(json['splash_ad'])
          : null,
      bannerSet: json['banner_set'] != null
          ? (json['banner_set'] as List)
              .map((item) => BannerSetItem.fromJson(item))
              .toList()
          : null,
      popularCategories: json['popular_categories'] != null
          ? PopularCategories.fromJson(json['popular_categories'])
          : null,
      popularCategoriesId: json['popular_categories_id'] != null
          ? int.parse(json['popular_categories_id'].toString())
          : null,
      collection: json['collection'] != null
          ? HomeCollection.fromJson(json['collection'])
          : null,
      marquees: json['messages'] != null
          ? (json['messages'] as List)
              .map((item) => Marquee.fromJson(item))
              .toList()
          : null,
      type: json['type'],
      isHidden: json['is_hidden'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'splash_ad': splashAd?.toJson(),
      'banner_set': bannerSet?.map((item) => item.toJson()).toList(),
      'popular_categories': popularCategories?.toJson(),
      'popular_categories_id': popularCategoriesId?.toInt(),
      'collection': collection?.toJson(),
      'messages': marquees?.map((item) => item.toJson()).toList(),
      'type': type,
      'is_hidden': isHidden,
    };
  }
}
