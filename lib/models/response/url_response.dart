class UrlResponse {
  final String url;

  UrlResponse({required this.url});

  factory UrlResponse.fromJson(Map<String, dynamic> json) {
    return UrlResponse(
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}
