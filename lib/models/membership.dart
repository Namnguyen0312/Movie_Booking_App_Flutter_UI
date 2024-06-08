class Membership {
  final int id;
  final String name;
  final String description;
  final double discountRate;

  Membership({
    required this.id,
    required this.discountRate,
    required this.description,
    required this.name,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      discountRate: json['discount_rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'discount_rate': discountRate,
    };
  }
}
