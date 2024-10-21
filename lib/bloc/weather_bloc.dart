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
    on<FetchWeatherByCityEvent>(_onFetchWeatherByCity);
    on<RefreshWeatherEvent>(_onRefreshWeather);
    on<SelectCityEvent>(_onSelectCity); // Handle selecting a city
  }

  // Fetch countries from the API
  Future<void> _onFetchCountry(
    FetchCountryEvent event,
    Emitter<WeatherStates> emit,
  ) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      List<Country> countries = await countryService.fetchCountries();
      print("Fetched Countries: ${countries.map((country) => country.countryname).toList()}");

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
      selectedCity: null, // Reset city when selecting a country
      postApiStatus: PostApiStatus.success,
    ));

    // Fetch weather for the selected country
    await _fetchWeatherForCountry(selectedCountry, emit);
  }

  // Handle city selection
  Future<void> _onSelectCity(
    SelectCityEvent event,
    Emitter<WeatherStates> emit,
  ) async {
    final selectedCity = event.cityName;

    emit(state.copyWith(
      selectedCity: selectedCity,
      postApiStatus: PostApiStatus.success,
    ));

    // Pass the selected city wrapped in a `FetchWeatherByCityEvent`
    await _onFetchWeatherByCity(FetchWeatherByCityEvent(cityName: selectedCity!), emit);
  }

  // Fetch weather for a selected country
  Future<void> _fetchWeatherForCountry(Country selectedCountry, Emitter<WeatherStates> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
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

  // Handle refreshing weather for both country and city
  Future<void> _onRefreshWeather(
    RefreshWeatherEvent event,
    Emitter<WeatherStates> emit,
  ) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      if (state.selectedCity != null) {
        // Refresh weather for the selected city
        await _onFetchWeatherByCity(
          FetchWeatherByCityEvent(cityName: state.selectedCity!),
          emit,
        );
      } else if (state.selectedCountry != null) {
        // Refresh weather for the selected country
        await _fetchWeatherForCountry(state.selectedCountry!, emit);
      } else {
        emit(state.copyWith(
          postApiStatus: PostApiStatus.error,
          errorMessage: 'No country or city selected for refresh.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        postApiStatus: PostApiStatus.error,
        errorMessage: 'Error refreshing weather: $e',
      ));
    }
  }

  // Handle fetching weather for the selected country
  Future<void> _onFetchWeather(
    FetchWeatherEvent event,
    Emitter<WeatherStates> emit,
  ) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      double latitude = event.selectedCountry.latitude;
      double longitude = event.selectedCountry.longitude;

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

  // Fetch weather by city name
  Future<void> _onFetchWeatherByCity(
    FetchWeatherByCityEvent event,
    Emitter<WeatherStates> emit,
  ) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      WeatherSummary weatherDetails =
          await weatherRepository.fetchWeatherByCityName(event.cityName);

      emit(state.copyWith(
        weatherDetails: weatherDetails,
        postApiStatus: PostApiStatus.success,
      ));
    } catch (e) {
      print('Error fetching weather by city: $e');
      emit(state.copyWith(
        postApiStatus: PostApiStatus.error,
        errorMessage: 'Error fetching weather by city: $e',
      ));
    }
  }
}
