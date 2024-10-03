class Country {
  final String countryname;
  final dynamic  latitude;
  final dynamic longitude;
  final String flagUrl;

  Country({
    required this.countryname,
    required this.latitude,
    required this.longitude,
    required this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
  countryname: json['name']['common'],
      // Explicitly convert to double if the values are returned as int
      latitude: (json['latlng'][0] is int)
          ? (json['latlng'][0] as int).toDouble()
          : json['latlng'][0],
      longitude: (json['latlng'][1] is int)
          ? (json['latlng'][1] as int).toDouble()
          : json['latlng'][1],
      flagUrl: json['flags']['png'],
    );
  }
}