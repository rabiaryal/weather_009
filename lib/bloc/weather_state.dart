
part of 'weather_bloc.dart';

class WeatherStates extends Equatable {
  final PostApiStatus postApiStatus;
  final List<Country>? countries;
  final Country? selectedCountry;
  final String? selectedCity; // Add this line
  final WeatherSummary? weatherDetails;
  final String? errorMessage;

  const WeatherStates({
    this.postApiStatus = PostApiStatus.initial,
    this.countries,
    this.selectedCountry,
    this.selectedCity, // Add this line
    this.weatherDetails,
    this.errorMessage,
  });

  WeatherStates copyWith({
    PostApiStatus? postApiStatus,
    List<Country>? countries,
    Country? selectedCountry,
    String? selectedCity, // Add this line
    WeatherSummary? weatherDetails,
    String? errorMessage,
  }) {
    return WeatherStates(
      postApiStatus: postApiStatus ?? this.postApiStatus,
      countries: countries ?? this.countries,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCity: selectedCity ?? this.selectedCity, // Add this line
      weatherDetails: weatherDetails ?? this.weatherDetails,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [postApiStatus, countries, selectedCountry, selectedCity, weatherDetails, errorMessage]; // Add selectedCity
}
