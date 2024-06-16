import 'result.dart';

class DistrictResponse {
  List<Result>? results;

  DistrictResponse({this.results});

  factory DistrictResponse.fromJson(Map<String, dynamic> json) {
    return DistrictResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'results': results?.map((e) => e.toJson()).toList(),
      };
}
