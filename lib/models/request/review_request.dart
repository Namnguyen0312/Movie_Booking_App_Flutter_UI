class ReviewRequest {
  final int numberStar;
  final String content;

  ReviewRequest({required this.numberStar, required this.content});

  factory ReviewRequest.fromJson(Map<String, dynamic> json) {
    return ReviewRequest(
      numberStar: json['numberStar'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numberStar': numberStar,
      'content': content,
    };
  }
}
