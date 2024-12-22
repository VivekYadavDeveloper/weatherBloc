import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/Repo/repo.dart';

import '../Model/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  String lat = "";
  String log = "";
  final HomeRepositry _homeRepositry = HomeRepositry();

  Weather? weather;

  WeatherBloc() : super(WeatherLoadingState()) {
    on<WeatherEvent>((event, emit) async {
      if (event is WeatherInitizalize) {
        // To Get The Current Location
        bool serviceEnable;

        LocationPermission locationPermission;

        serviceEnable = await Geolocator.isLocationServiceEnabled();

        if (!serviceEnable) {
          await Geolocator.checkPermission();
          return Future.error("Location Service is Disable");
        }

        locationPermission = await Geolocator.checkPermission();
        if (locationPermission == LocationPermission.denied) {
          locationPermission = await Geolocator.requestPermission();
          if (locationPermission == LocationPermission.denied) {
            return Future.error("Location permissions are denied");
          }
        }

        if (locationPermission == LocationPermission.deniedForever) {
          // Permissions are denied forever, handle appropriately.
          return Future.error(
              'Location permissions are permanently denied, we cannot request permissions.');
        }

        await Geolocator.getCurrentPosition().then((value) async {
          lat = value.latitude.toString();
          log = value.longitude.toString();

          final response = await _homeRepositry.getWeatherData(
              latitude: lat, longitude: log);
          if (response.statusCode == 200) {
            weather = weatherFromJson(response.body);
          } else {
            emit(WeatherErrorState());
          }
        });
        emit(WeatherInitial(weather: weather!));
      }
    });
  }
}
