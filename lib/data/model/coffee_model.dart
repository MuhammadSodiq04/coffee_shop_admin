class CoffeeModel {
  int price;
  List<dynamic> coffeeImages;
  String coffeeId;
  String coffeeName;
  String description;
  String createdAt;

  CoffeeModel({
    required this.price,
    required this.coffeeImages,
    required this.coffeeId,
    required this.coffeeName,
    required this.description,
    required this.createdAt,
  });

  CoffeeModel copyWith({
    int? price,
    List<dynamic>? coffeeImages,
    String? coffeeId,
    String? coffeeName,
    String? description,
    String? createdAt,
  }) {
    return CoffeeModel(
      price: price ?? this.price,
      coffeeImages: coffeeImages ?? this.coffeeImages,
      coffeeId: coffeeId ?? this.coffeeId,
      coffeeName: coffeeName ?? this.coffeeName,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory CoffeeModel.fromJson(Map<String, dynamic> jsonData) {
    return CoffeeModel(
      price: jsonData['price'] as int? ?? 0,
      coffeeImages: (jsonData['coffeeImages'] as List<dynamic>? ?? []),
      coffeeId: jsonData['coffeeId'] as String? ?? '',
      coffeeName: jsonData['coffeeName'] as String? ?? '',
      description: jsonData['description'] as String? ?? '',
      createdAt: jsonData['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'coffeeImages': coffeeImages,
      'coffeeId': coffeeId,
      'coffeeName': coffeeName,
      'description': description,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return '''
      price: $price,
      coffeeImages: $coffeeImages,
      coffeeId: $coffeeId,
      coffeeName: $coffeeName,
      description: $description,
      createdAt: $createdAt,
      ''';
  }
}
