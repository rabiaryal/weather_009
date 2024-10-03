part of 'weather_bloc.dart';

class WeatherStates extends Equatable {
  const WeatherStates({
    this.postApiStatus = PostApiStatus.initial,
    this.countryName = '',
    this.flagUrl = '',
    this.latitude,
    this.longitude,
    this.countries,
    this.weatherDetails,
  });

  final PostApiStatus postApiStatus;
  final String? countryName;
  final String? flagUrl;
  final double? latitude; // Changed to double
  final double? longitude; // Changed to double
  final WeatherModel? weatherDetails;
  final List<Country>? countries;

  WeatherStates copyWith({
    PostApiStatus? postApiStatus,
    String? countryName,
    String? flagUrl,
    double? latitude, // Changed to double
    double? longitude, // Changed to double
    WeatherModel? weatherDetails,
    List<Country>? countries,
  }) {
    return WeatherStates(
      postApiStatus: postApiStatus ?? this.postApiStatus,
      countryName: countryName ?? this.countryName,
      flagUrl: flagUrl ?? this.flagUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      weatherDetails: weatherDetails ?? this.weatherDetails,
      countries: countries ?? this.countries,
    );
  }

  @override
  List<Object?> get props => [
        postApiStatus,
        countryName,
        flagUrl,
        latitude,
        longitude,
        weatherDetails,
        countries,
      ];
}
