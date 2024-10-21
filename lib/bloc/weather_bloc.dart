import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_009/models/weathermode.dart';
import 'package:weather_009/models/countrymodel.dart'; // Country model
import 'package:weather_009/repository/fetchcountry.dart';
import 'package:weather_009/repository/weather_repository.dart';
import 'package:weather_009/res/extensions/enums.dart';

// Import event and state parts
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherStates> {
  final WeatherRepository weatherRepository;
  final CountryService countryService;

  WeatherBloc({
    required this.weatherRepository,
    required this.countryService,
  }) : super(const WeatherStates()) {
    on<FetchCountryEvent>(_onFetchCountry);
    on<SelectCountryEvent>(_onSelectCountry);
    on<FetchWeatherEvent>(_onFetchWeather);
    on<RefreshWeatherEvent>(_onRefreshWeather); // Added RefreshWeatherEvent handler
  }

  // Fetch countries from the API
  Future<void> _onFetchCountry(
    FetchCountryEvent event,
    Emitter<WeatherStates> emit,
  ) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      List<Country> countries = await countryService.fetchCountries();
      print(
          "Fetched Countries: ${countries.map((country) => country.countryname).toList()}");

      emit(state.copyWith(
        postApiStatus: PostApiStatus.success,
        countries: countries,
      ));
    } catch (e) {
      print('Error fetching countries: $e');
      emit(state.copyWith(
        postApiStatus: PostApiStatus.error,
        errorMessage: 'Error fetching countries: $e',
      ));
    }
  }

  // Handle country selection and fetch weather
  Future<void> _onSelectCountry(
    SelectCountryEvent event,
    Emitter<WeatherStates> emit,
  ) async {
    final selectedCountry = event.selectedCountry;

    emit(state.copyWith(
      selectedCountry: selectedCountry,
      postApiStatus: PostApiStatus.success,
    ));

    // Fetch weather for the selected country
    await _fetchWeatherForCountry(selectedCountry, emit);
  }

  Future<void> _fetchWeatherForCountry(
      Country selectedCountry, Emitter<WeatherStates> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      // Pass latitude and longitude directly as double
      WeatherSummary weatherDetails = await weatherRepository.fetchWeathers(
        selectedCountry.latitude,
        selectedCountry.longitude,
      );

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

  // Fetch weather using latitude and longitude from the event
  Future<void> _onFetchWeather(
    FetchWeatherEvent event,
    Emitter<WeatherStates> emit,
  ) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      // Check if the event contains valid latitude and longitude
      double latitude = event.selectedCountry.latitude;
      double longitude = event.selectedCountry.longitude;

      // Fetch the weather data using latitude and longitude
      WeatherSummary weatherDetails =
          await weatherRepository.fetchWeathers(latitude, longitude);

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

  // Handle refresh event
  Future<void> _onRefreshWeather(
    RefreshWeatherEvent event,
    Emitter<WeatherStates> emit,
  ) async {
    // Ensure that a country is selected before trying to refresh the weather data
    if (state.selectedCountry != null) {
      await _fetchWeatherForCountry(state.selectedCountry!, emit);
    } else {
      emit(state.copyWith(
        postApiStatus: PostApiStatus.error,
        errorMessage: 'No country selected for refresh.',
      ));
    }
  }
}
