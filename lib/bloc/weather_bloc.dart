import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
import 'package:weather_009/extensions/enums.dart';
import 'package:weather_009/models/countrymodel.dart';
import 'package:weather_009/models/jsonmodels.dart';
import 'package:weather_009/repository/fetchcountry.dart';
import 'package:weather_009/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';





class WeatherBloc extends Bloc<WeatherEvent, WeatherStates> {
  final CountryService countryService;
  final WeatherRepository weatherRepository;

  WeatherBloc({
    required this.weatherRepository,
    required this.countryService,
  }) : super(const WeatherStates()) {
    on<FetchCountries>(_onFetchCountries);
    on<LoadCountry>(_onLoadCountry);
    on<SelectCountry>(_onSelectCountry);
    on<WeatherApi>(_onfetchWeather);
  }

  Future<void> _onFetchCountries(
    FetchCountries event,
    Emitter<WeatherStates> emit,
  ) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));
    try {
      final countries = await countryService.fetchCountries();
      emit(state.copyWith(
        postApiStatus: PostApiStatus.success,
        countries: countries,
      ));
    } catch (e) {
      print('Error fetching countries: $e');
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
    }
  }

  Future<void> _onLoadCountry(
    LoadCountry event,
    Emitter<WeatherStates> emit,
  ) async {
    emit(state.copyWith(
      postApiStatus: PostApiStatus.success,
      countries: event.countries,
    ));
  }

  Future<void> _onSelectCountry(
    SelectCountry event,
    Emitter<WeatherStates> emit,
  ) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));
    try {
      final selectedCountry = event.selectedCountry;
      final lat = selectedCountry.latitude;
      final lon = selectedCountry.longitude;

      // Check if lat and lon are valid
      if (lat == null || lon == null) {
        print('Invalid latitude or longitude');
        emit(state.copyWith(postApiStatus: PostApiStatus.error));
        return;
      }

      emit(state.copyWith(
        countryName: selectedCountry.countryname,
        flagUrl: selectedCountry.flagUrl,
        latitude: lat,
        longitude: lon,
        postApiStatus: PostApiStatus.success,
      ));

      // Trigger fetching weather using the selected country's latitude/longitude
      add(WeatherApi(latitude: lat, longitude: lon));
    } catch (e) {
      print('Error selecting country: $e');
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
    }
  }

  Future<void> _onfetchWeather(
  WeatherApi event,
  Emitter<WeatherStates> emit,
) async {
  emit(state.copyWith(postApiStatus: PostApiStatus.loading));
  try {
    // Check if latitude and longitude are valid
    if (event.longitude == null) {
      emit(state.copyWith(postApiStatus: PostApiStatus.error));
      print('Invalid latitude or longitude: $event');
      return;
    }

    print('Fetching weather for lat: ${event.latitude}, lon: ${event.longitude}');
    final weatherDetails = await weatherRepository.fetchWeathers(
      event.latitude,
      event.longitude,
    );

    emit(state.copyWith(
      weatherDetails: weatherDetails,
      postApiStatus: PostApiStatus.success,
    ));
  } catch (e) {
    print('Error fetching weather data: $e');
    emit(state.copyWith(postApiStatus: PostApiStatus.error));
  }
}


  
}
