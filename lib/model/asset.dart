class Asset {
  String name;
  String id;
  String image;
  late double marketCap;
  late double totalVolume; 
  late double circulatingSupply; 
  late double high24hr;
  late double low24hr;
  late int marketCapRank;
  late double priceChange24hr;

  Asset({
      required this.name,
      required this.id,
      required this.image,
      required this.marketCap,
      required this.totalVolume, 
      required this.circulatingSupply, 
      required this.high24hr,
      required this.low24hr,
      required this.marketCapRank,
      required this.priceChange24hr,
  });
  factory Asset.fromJson(Map<String, dynamic> json){
    return Asset(
      name: json['name'],
      id: json['id'],
      image: json['image'],
      marketCap: json['market_cap'].toDouble(),
      totalVolume: json['total_volume'].toDouble(),
      circulatingSupply: json['circulating_supply'].toDouble(),
      high24hr: json['high_24h'].toDouble(),
      low24hr: json['low_24h'].toDouble(),
      marketCapRank: json['market_cap_rank'],
      priceChange24hr: json['price_change_24h'].toDouble(),
    );
  }
  
}