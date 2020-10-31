import 'networking.dart';

const apiKey = '4445d5f9a97f887aa3d9dc8a9afc3f62';

class Weather {
  var latitude, longitude;
  Weather({this.longitude, this.latitude});
  Future<dynamic> getLocationWeather() async {
    Networking networking = Networking(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=$apiKey&units=metric');
    var weatherData = await networking.getData();
    return weatherData;
  }
}
