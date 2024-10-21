  part of 'weather_bloc.dart';

  abstract class WeatherEvent extends Equatable {
    const WeatherEvent();

    @override
    List<Object?> get props => [];
  }

  // Event to refresh the weather
  class RefreshWeatherEvent extends WeatherEvent {
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

  // Event to fetch weather by city name
  class FetchWeatherByCityEvent extends WeatherEvent {
    final String cityName;

    const FetchWeatherByCityEvent({required this.cityName});

    @override
    List<Object?> get props => [cityName];
  }

  // Event to select a city
  class SelectCityEvent extends WeatherEvent {
    final String cityName;

    const SelectCityEvent({required this.cityName});

    @override
    List<Object?> get props => [cityName];
  }
