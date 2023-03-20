class StatFields {
  static final List<String> values = [
    id, initialMoney, provider, timeSpending, timestamp
  ];
  static final String id = '_id';
  static final String initialMoney = 'initialMoney';
  static final String provider = 'provider';
  static final String timeSpending = 'timeSpending';
  static final String timestamp = 'timestamp';
}

class Stat{
  final int? id;
  final double initialMoney;
  final String provider;
  final double timeSpending;
  final DateTime timestamp;

  Stat({
    this.id,
    required this.initialMoney,
    required this.provider,
    required this.timeSpending,
    required this.timestamp,

  });

  static Stat fromJson(Map<String, Object?> json) => Stat(
    id: json[StatFields.id] as int?,
    initialMoney: json[StatFields.initialMoney] as double,
    provider: json[StatFields.provider] as String,
    timeSpending: json[StatFields.timeSpending] as double,
    timestamp: DateTime.parse(json[StatFields.timestamp] as String)
  );
  

  Map<String, Object?> toJson()=>{
    StatFields.id: id,
    StatFields.initialMoney: initialMoney,
    StatFields.provider: provider,
    StatFields.timeSpending: timeSpending,
    StatFields.timestamp: timestamp.toIso8601String(),
  };

}