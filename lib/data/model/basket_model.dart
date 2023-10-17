class BasketModel {
  int count;
  int totalPrice;
  String orderId;
  String coffeeId;
  String userId;
  String orderStatus;
  String createdAt;
  String coffeeName;
  String userName;
  String userPhone;
  String userAddress;

  BasketModel({
    required this.count,
    required this.totalPrice,
    required this.orderId,
    required this.coffeeId,
    required this.userId,
    required this.orderStatus,
    required this.createdAt,
    required this.coffeeName,
    required this.userName,
    required this.userPhone,
    required this.userAddress,
  });

  BasketModel copWith({
    int? count,
    int? totalPrice,
    String? orderId,
    String? coffeeId,
    String? userId,
    String? orderStatus,
    String? createdAt,
    String? coffeeName,
    String? userName,
    String? userPhone,
    String? userAddress,
  }) =>
      BasketModel(
        count: count ?? this.count,
        totalPrice: totalPrice ?? this.totalPrice,
        orderId: orderId ?? this.orderId,
        coffeeId: coffeeId ?? this.coffeeId,
        coffeeName: coffeeName ?? this.coffeeName,
        userId: userId ?? this.userId,
        orderStatus: orderStatus ?? this.orderStatus,
        createdAt: createdAt ?? this.createdAt,
        userName: userName ?? this.userName,
        userPhone: userPhone ?? this.userPhone,
        userAddress: userAddress ?? this.userAddress,
      );

  factory BasketModel.fromJson(Map<String, dynamic> jsonData) {
    return BasketModel(
      count: jsonData['count'] as int? ?? 0,
      totalPrice: jsonData['totalPrice'] as int? ?? 0,
      orderId: jsonData['orderId'] as String? ?? '',
      coffeeName: jsonData['coffeeName'] as String? ?? '',
      coffeeId: jsonData['coffeeId'] as String? ?? '',
      userId: jsonData['userId'] as String? ?? '',
      orderStatus: jsonData['orderStatus'] as String? ?? '',
      createdAt: jsonData['createdAt'] as String? ?? '',
      userName: jsonData['userName'] as String? ?? '',
      userPhone: jsonData['userPhone'] as String? ?? '',
      userAddress: jsonData['userAddress'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'totalPrice': totalPrice,
      'orderId': orderId,
      'coffeeId': coffeeId,
      'userId': userId,
      'orderStatus': orderStatus,
      'createdAt': createdAt,
      'coffeeName': coffeeName,
      'userName': userName,
      'userPhone': userPhone,
      'userAddress': userAddress,
    };
  }

  @override
  String toString() {
    return '''
      count: $count,
      totalPrice: $totalPrice,
      orderId: $orderId,
      coffeeId: $coffeeId,
      userId: $userId,
      orderStatus: $orderStatus,
      createdAt: $createdAt,
      coffeeName: $coffeeName,
      userName: $userName,
      userPhone: $userPhone,
      userAddress: $userAddress,
      ''';
  }
}
