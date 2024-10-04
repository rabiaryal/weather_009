class City {
  final String name;
  final String country;
  final double latitude;
  final double longitude;

  City({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
  });
   factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      country: json['sys']['country'],
      latitude: json['coord']['lat'],
      longitude: json['coord']['lon'],
    );
  }
}
