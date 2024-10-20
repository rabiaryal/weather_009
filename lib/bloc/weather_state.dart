
part of 'weather_bloc.dart';

class WeatherStates extends Equatable {
  final PostApiStatus postApiStatus;
  final List<Country>? countries; // Add a list of countries
  final Country? selectedCountry; // Store selected country
  final WeatherSummary? weatherDetails;
  final String? errorMessage;

  const WeatherStates({
    this.postApiStatus = PostApiStatus.initial,
    this.countries,
    this.selectedCountry,
    this.weatherDetails,
    this.errorMessage,
  });

  WeatherStates copyWith({
    PostApiStatus? postApiStatus,
    List<Country>? countries,
    Country? selectedCountry,
    WeatherSummary? weatherDetails,
    String? errorMessage,
  }) {
    return WeatherStates(
      postApiStatus: postApiStatus ?? this.postApiStatus,
      countries: countries ?? this.countries,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      weatherDetails: weatherDetails ?? this.weatherDetails,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [postApiStatus, countries, selectedCountry, weatherDetails, errorMessage];
}
