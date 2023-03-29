class TokenFields {
  static final List<String> values = [
    id, tokenName, value, image, createAt
  ];
  static final String id = '_id';
  static final String tokenName = 'tokenName';
  static final String value = 'valuer';
  static final String image = 'image';
  static final String createAt = 'createAt';
}

class Token{
  final int? id;
  final String tokenName;
  final double value;
  final String image;
  final DateTime createAt;

  Token({
    this.id,
    required this.tokenName,
    required this.value,
    required this.image,
    required this.createAt,

  });

  static Token fromJson(Map<String, Object?> json) => Token(
    id: json[TokenFields.id] as int?,
    tokenName: json[TokenFields.tokenName] as String,
    value: json[TokenFields.value] as double,
    image: json[TokenFields.image] as String,
    createAt: DateTime.parse(json[TokenFields.createAt] as String)
  );
  

  Map<String, Object?> toJson()=>{
    TokenFields.id: id,
    TokenFields.tokenName: tokenName,
    TokenFields.value: value,
    TokenFields.image: image,
    TokenFields.createAt: createAt.toIso8601String(),
  };

}