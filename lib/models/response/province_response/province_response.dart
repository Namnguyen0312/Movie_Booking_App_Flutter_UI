import 'result.dart';

class ProvinceResponse {
  List<Result>? results;

  ProvinceResponse({this.results});

  factory ProvinceResponse.fromJson(Map<String, dynamic> json) {
    return ProvinceResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'results': results?.map((e) => e.toJson()).toList(),
      };
}
