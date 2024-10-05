class City {
  final String? name;
  final String? country;
  final double? latitude; // Nullable
  final double? longitude; // Nullable

  City({
    this.name,
    this.country,
    this.latitude,
    this.longitude,
  });

  @override
  String toString() {
    return "$name, $country";
  }

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      country: json['sys']['country'],
      latitude: json['coord'] != null ? (json['coord']['lat'] as num).toDouble() : null, // Handle potential null
      longitude: json['coord'] != null ? (json['coord']['lon'] as num).toDouble() : null, // Handle potential null
    );
  }
}
