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
  final Country selectedCountry;

  const FetchWeatherEvent({required this.selectedCountry});

  @override
  List<Object?> get props => [selectedCountry];
}
