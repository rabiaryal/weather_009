
part of 'weather_bloc.dart';

class WeatherStates extends Equatable {
  final PostApiStatus postApiStatus;
  final List<City> cities; // Changed to a non-nullable List<City>
  final City? selectedCity;
  final WeatherSummary? weatherDetails; // Updated to use WeatherSummary
  final String? errorMessage;

  WeatherStates({
    this.postApiStatus = PostApiStatus.initial,
    List<City>? cities, // Allow it to be passed as nullable
    this.selectedCity,
    this.weatherDetails, // Updated to use WeatherSummary
    this.errorMessage,
  }) : cities = cities ?? []; // Initialize to an empty list if null

  WeatherStates copyWith({
    PostApiStatus? postApiStatus,
    List<City>? cities,
    City? selectedCity,
    WeatherSummary? weatherDetails, // Updated to use WeatherSummary
    String? errorMessage,
  }) {
    return WeatherStates(
      postApiStatus: postApiStatus ?? this.postApiStatus,
      cities: cities ?? this.cities, // This will never be null
      selectedCity: selectedCity ?? this.selectedCity,
      weatherDetails: weatherDetails ?? this.weatherDetails, // Updated to use WeatherSummary
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        postApiStatus,
        cities, // This is now guaranteed to be non-null
        selectedCity,
        weatherDetails, // Updated to use WeatherSummary
        errorMessage,
      ];
}

// Define the possible states for API requests
enum PostApiStatus { initial, loading, success, error }
