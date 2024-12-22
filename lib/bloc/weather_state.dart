part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {
  final Weather weather;
  const WeatherInitial({required this.weather});
}

class WeatherLoadingState extends WeatherState {}

class WeatherErrorState extends WeatherState {}
