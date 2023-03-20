class TokenFields {
  static final List<String> values = [
    id, tokenName, value, image, timestamp
  ];
  static final String id = '_id';
  static final String tokenName = 'tokenName';
  static final String value = 'valuer';
  static final String image = 'image';
  static final String timestamp = 'timestamp';
}

class Token{
  final int? id;
  final String tokenName;
  final double value;
  final String image;
  final DateTime timestamp;

  Token({
    this.id,
    required this.tokenName,
    required this.value,
    required this.image,
    required this.timestamp,

  });

  static Token fromJson(Map<String, Object?> json) => Token(
    id: json[TokenFields.id] as int?,
    tokenName: json[TokenFields.tokenName] as String,
    value: json[TokenFields.value] as double,
    image: json[TokenFields.image] as String,
    timestamp: DateTime.parse(json[TokenFields.timestamp] as String)
  );
  

  Map<String, Object?> toJson()=>{
    TokenFields.id: id,
    TokenFields.tokenName: tokenName,
    TokenFields.value: value,
    TokenFields.image: image,
    TokenFields.timestamp: timestamp.toIso8601String(),
  };

}