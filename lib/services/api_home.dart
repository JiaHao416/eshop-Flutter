class HomePageResponse {
  final List<HomeComponent>? data;
  final String? errorMessage;
  final bool? success;

  HomePageResponse({this.data, this.errorMessage, this.success});

  factory HomePageResponse.fromJson(Map<String, dynamic> json) {
    return HomePageResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HomeComponent.fromJson(e))
          .toList(),
      errorMessage: json['error_message'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((e) => e.toJson()).toList(),
      'error_message': errorMessage,
      'success': success,
    };
  }
}

class HomeComponent {
  final String title;

  HomeComponent({required this.title});

  factory HomeComponent.fromJson(Map<String, dynamic> json) {
    return HomeComponent(
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }
}
