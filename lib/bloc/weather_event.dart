part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

// Event to fetch cities based on a query
class FetchCityEvent extends WeatherEvent {
  final String query;

  FetchCityEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

// Event to select a city
class SelectCityEvent extends WeatherEvent {
  final City selectedCity;

  const SelectCityEvent({required this.selectedCity});

  @override
  List<Object?> get props => [selectedCity];
}

// Event to fetch weather data for a selected city
class FetchWeatherEvent extends WeatherEvent {
  final City selectedCity;

  const FetchWeatherEvent({required this.selectedCity});

  @override
  List<Object?> get props => [selectedCity];
}
