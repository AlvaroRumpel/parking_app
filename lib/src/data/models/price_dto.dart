import 'dart:convert';

class PriceDTO {
  final double price;

  PriceDTO({required this.price});

  Map<String, dynamic> toMap() {
    return {
      'price': price,
    };
  }

  factory PriceDTO.fromMap(Map<String, dynamic> map) {
    return PriceDTO(
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceDTO.fromJson(String source) =>
      PriceDTO.fromMap(json.decode(source));
}
