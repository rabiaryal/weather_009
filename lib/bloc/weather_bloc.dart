import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_009/models/citymodel.dart';
import 'package:weather_009/models/weathermode.dart';
import 'package:weather_009/repository/fetchcitylist.dart';
import 'package:weather_009/repository/weather_repository.dart';
import 'package:http/http.dart' as http;

// Import event and state parts
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherStates> {
  final FetchCity fetchCity = FetchCity();
  final WeatherRepository weatherRepository = WeatherRepository();

  WeatherBloc() : super( WeatherStates()) {
    on<FetchCityEvent>(_onFetchCity);
    on<SelectCityEvent>(_onSelectCity);  // Ensure this matches the event name
    on<WeatherApi>(_onFetchWeather);
  }

  // Fetch cities based on search query
  Future<void> _onFetchCity(
    FetchCityEvent event,
    Emitter<WeatherStates> emit,
  ) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      // Fetch cities with weather data using the query provided in the event
      List<City> cities = await fetchCity.fetchCitiesWithWeather(event.query);

      if (cities.isNotEmpty) {
        emit(state.copyWith(
          postApiStatus: PostApiStatus.success,
          cities: cities,
        ));
      } else {
        emit(state.copyWith(
          postApiStatus: PostApiStatus.error,
          errorMessage: 'No cities found.',
        ));
      }
    } catch (e) {
      print('Error fetching cities: $e');
      emit(state.copyWith(
        postApiStatus: PostApiStatus.error,
        errorMessage: 'Error fetching cities: $e',
      ));
    }
  }

  // Handle city selection from the dropdown
  // Handle city selection from the dropdown
Future<void> _onSelectCity(
  SelectCityEvent event,
  Emitter<WeatherStates> emit,
) async {
  final selectedCity = event.selectedCity; // Make sure this is a City object

  emit(state.copyWith(
    selectedCity: selectedCity,
    postApiStatus: PostApiStatus.success,
  ));

  // Once a city is selected, fetch weather data for that city
  add(WeatherApi(selectedCity: selectedCity));
}


  // Fetch weather for the selected city (using city name)
  Future<void> _onFetchWeather(
    WeatherApi event,
    Emitter<WeatherStates> emit,
  ) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      // Fetch weather based on city name
      City city = event.selectedCity;
      String cityName = city.name ?? 'Unknown City';
      
      WeatherSummary weatherDetails = await weatherRepository.fetchWeathers(cityName);
      emit(state.copyWith(
        weatherDetails: weatherDetails,
        postApiStatus: PostApiStatus.success,
      ));
    } catch (e) {
      print('Error fetching weather data: $e');
      emit(state.copyWith(
        postApiStatus: PostApiStatus.error,
        errorMessage: 'Error fetching weather data: $e',
      ));
    }
  }
}
