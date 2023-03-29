class StatFields {
  static final List<String> values = [
    id, initialMoney, provider, profit, createAt
  ];
  static final String id = '_id';
  static final String initialMoney = 'initialMoney';
  static final String provider = 'provider';
  static final String profit = 'profit';
  static final String createAt = 'createAt';
}

class Stat{
  final int? id;
  final double initialMoney;
  final String provider;
  final double profit;
  final DateTime createAt;

  Stat({
    this.id,
    required this.initialMoney,
    required this.provider,
    required this.profit,
    required this.createAt,

  });

  static Stat fromJson(Map<String, Object?> json) => Stat(
    id: json[StatFields.id] as int?,
    initialMoney: json[StatFields.initialMoney] as double,
    provider: json[StatFields.provider] as String,
    profit: json[StatFields.profit] as double,
    createAt: DateTime.parse(json[StatFields.createAt] as String)
  );
  

  Map<String, Object?> toJson()=>{
    StatFields.id: id,
    StatFields.initialMoney: initialMoney,
    StatFields.provider: provider,
    StatFields.profit: profit,
    StatFields.createAt: createAt.toIso8601String(),
  };

}