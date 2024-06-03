// ignore_for_file: constant_identifier_names
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
  late final int viewType;

  HomeComponent({
    this.splashAd,
    this.bannerSet,
    this.popularCategories,
    this.popularCategoriesId,
    this.collection,
    this.marquees,
    this.type,
    this.isHidden,
  }) {
    viewType = calculateViewType();
  }

  @override
  String toString() {
    return 'data{splashAd: $splashAd, bannerSet: $bannerSet, popularCategories: $popularCategories, popularCategoriesId: $popularCategoriesId, collection: $collection, marquees: $marquees, type: $type, isHidden: $isHidden, viewType: $viewType}';
  }

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

  int calculateViewType() {
    if (bannerSet?.isNotEmpty == true) {
      return BANNER_SET;
    } else if (collection != null) {
      if (collection!.layout == "LinearLayout") {
        return COLLECTION_LINEAR_LAYOUT;
      } else {
        return COLLECTION;
      }
    } else if (popularCategories?.layout == "PageLayout") {
      return POPULAR_CATEGORIES_PAGE_LAYOUT;
    } else if (popularCategories?.layout == "ListLayout") {
      return POPULAR_CATEGORIES_LIST_LAYOUT;
    } else {
      return POPULAR_CATEGORIES_PLAIN_LAYOUT;
    }
  }
}

const int BANNER_SET = 1;
const int POPULAR_CATEGORIES_LIST_LAYOUT = 2;
const int POPULAR_CATEGORIES_PLAIN_LAYOUT = 3;
const int POPULAR_CATEGORIES_PAGE_LAYOUT = 4;
const int COLLECTION_LINEAR_LAYOUT = 5;
const int COLLECTION = 6;
