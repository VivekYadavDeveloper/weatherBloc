import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/View/Widget/custom_temp_info_text.dart';
import 'package:weather/bloc/weather_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => WeatherBloc()..add(WeatherInitizalize()),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              final int timezoneOffsetSeconds = state.weather.timezone!.toInt();

              final timezoneOffset = Duration(seconds: timezoneOffsetSeconds);

              final localTime = DateTime.now().toLocal().add(timezoneOffset);
              final DateFormat formatter = DateFormat('EEE, h:mm a');
              final String formattedTime = formatter.format(localTime);

              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background_image.jpg"),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 50),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.location_on,
                              color: Colors.white, size: 18),
                          const SizedBox(width: 5),
                          Text(
                            state.weather.name.toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Text(
                          //   '${state.weather.main!.temp!.toString()} K',
                          //   style: const TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 50,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // Text(
                          //   '${((state.weather.main!.temp! - 273.15) * 9 / 5 + 32).toStringAsFixed(2)} °F',
                          //   style: const TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 50,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          Text(
                            '${(state.weather.main!.temp! - 273.15).toStringAsFixed(0)}°',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.weather.weather![0].description
                                .toString()
                                .toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${(state.weather.main!.tempMin! - 273.15).toStringAsFixed(0)}° / ${(state.weather.main!.tempMax! - 273.15).toStringAsFixed(0)}° Feels like ${(state.weather.main!.feelsLike! - 273.15).toStringAsFixed(0)}°',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            formattedTime,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 180,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CustomTempInfoText(
                                  iconData: Icons.arrow_circle_down_rounded,
                                  title: "Pressure",
                                  data:
                                      state.weather.main!.pressure.toString()),
                              CustomTempInfoText(
                                  iconData: Icons.water_drop_rounded,
                                  title: "Humidity",
                                  data:
                                      state.weather.main!.humidity.toString()),
                              CustomTempInfoText(
                                  iconData: Icons.air,
                                  title: "Wind",
                                  data: state.weather.wind!.speed.toString()),
                            ],
                          ),
                        ),
                      ),
                    
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/background_image.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
