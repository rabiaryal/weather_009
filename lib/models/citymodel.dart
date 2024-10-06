class City {
  final String? name;
  final String? country;
  final double? latitude;
  final double? longitude;

  City({
    this.name,
    this.country,
    this.latitude,
    this.longitude,
  });

  // Improved toString method to handle null values gracefully
  @override
  String toString() {
    return "${name ?? 'Unknown City'}, ${country ?? 'Unknown Country'}";
  }

  // Factory constructor to create a City instance from a JSON map
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'], // Assume 'name' might be null in some cases
      country: json['sys'] != null ? json['sys']['country'] : 'Unknown Country', // Handle missing country data
      latitude: json['coord'] != null ? (json['coord']['lat'] as num?)?.toDouble() : null, // Safely convert to double
      longitude: json['coord'] != null ? (json['coord']['lon'] as num?)?.toDouble() : null, // Safely convert to double
    );
  }
}
