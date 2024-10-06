
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_009/extensions/enums.dart';
import 'package:weather_009/models/citymodel.dart';
import 'package:weather_009/models/weathermode.dart';
import 'package:weather_009/repository/fetchcitylist.dart';
import 'package:weather_009/repository/weather_repository.dart';


// Import event and state parts
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherStates> {
  final FetchCity fetchCity = FetchCity();
  final WeatherRepository weatherRepository = WeatherRepository();

  WeatherBloc() : super(WeatherStates()) {
    on<FetchCityEvent>(_onFetchCity);
    on<SelectCityEvent>(_onSelectCity);  
    on<FetchWeatherEvent>(_onFetchWeather);  // Renamed to FetchWeatherEvent for clarity
  }

  // Fetch cities based on search query
  Future<void> _onFetchCity(
    FetchCityEvent event,
    Emitter<WeatherStates> emit,
  ) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      List<City> cities = await fetchCity.fetchCitiesWithWeather(event.query);
      print("Fetched Cities: ${cities.map((city) => city.name).toList()}");

      if (cities.isNotEmpty) {
        emit(state.copyWith(
          postApiStatus: PostApiStatus.success,
          cities: cities,
        ));
      } else {
        print('No cities found for query: ${event.query}');
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

  // Handle city selection


  Future<void> _onSelectCity(
  SelectCityEvent event,
  Emitter<WeatherStates> emit,
) async {
  final selectedCity = event.selectedCity;

  emit(state.copyWith(
    selectedCity: selectedCity,
    postApiStatus: PostApiStatus.success,
  ));

  // Once a city is selected, fetch weather data for that city
  add(FetchWeatherEvent(selectedCity: selectedCity)); // Correct event
}
Future<void> _onFetchWeather(
  FetchWeatherEvent event, // Correct event name
  Emitter<WeatherStates> emit,
) async {
  emit(state.copyWith(postApiStatus: PostApiStatus.loading));

  try {
    City city = event.selectedCity;
    String cityName = city.name ?? 'Unknown City'; // Handle null case

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
