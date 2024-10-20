part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

// Event to fetch countries
class FetchCountryEvent extends WeatherEvent {
  const FetchCountryEvent();

  @override
  List<Object?> get props => [];
}

// Event to select a country
class SelectCountryEvent extends WeatherEvent {
  final Country selectedCountry;

  const SelectCountryEvent({required this.selectedCountry});

  @override
  List<Object?> get props => [selectedCountry];
}

// Event to fetch weather based on the selected country's coordinates
class FetchWeatherEvent extends WeatherEvent {
  final double latitude;  // Use latitude as a double
  final double longitude; // Use longitude as a double

  const FetchWeatherEvent({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
