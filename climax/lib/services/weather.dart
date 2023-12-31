import "package:climax/services/location.dart";
import "package:climax/services/networking.dart";

const apiKey = "5c91a1d854fba97feeb075883795e755";
const URL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = "$URL?q=$cityName&appid=$apiKey&units=metric";
    Networking networking = Networking(url: url);
    return await networking.getData();
  }

  Future<dynamic> locationWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();
    Networking newtwork = Networking(
        url:
            '$URL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    return await newtwork.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
