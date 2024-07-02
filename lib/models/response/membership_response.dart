class MembershipResponse {
  final int id;
  final String name;
  final String description;
  final double discountRate;
  final int rankprice;

  MembershipResponse({
    required this.id,
    required this.discountRate,
    required this.description,
    required this.name,
    required this.rankprice,
  });

  factory MembershipResponse.fromJson(Map<String, dynamic> json) {
    return MembershipResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      discountRate: json['discount_rate'],
      rankprice: json['rankprice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'discount_rate': discountRate,
      'rankprice': rankprice,
    };
  }
}
