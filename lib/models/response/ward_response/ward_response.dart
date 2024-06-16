import 'result.dart';

class WardResponse {
  List<Result>? results;

  WardResponse({this.results});

  factory WardResponse.fromJson(Map<String, dynamic> json) => WardResponse(
        results: (json['results'] as List<dynamic>?)
            ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'results': results?.map((e) => e.toJson()).toList(),
      };
}
