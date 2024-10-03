part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class SelectCountry extends WeatherEvent {
  final Country selectedCountry;

  const SelectCountry({required this.selectedCountry});

  @override
  List<Object?> get props => [selectedCountry];
}

class FetchCountries extends WeatherEvent {
  const FetchCountries();
}

class LoadCountry extends WeatherEvent {
  final List<Country> countries;

  const LoadCountry({this.countries = const []});

  @override
  List<Object?> get props => [countries];
}

// Ensure latitude and longitude are double
class WeatherApi extends WeatherEvent {
  final double latitude; // Changed to double
  final double longitude; // Changed to double

  const WeatherApi({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
