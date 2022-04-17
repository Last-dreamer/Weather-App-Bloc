
class WeatherException implements Exception {
  String message;

  WeatherException([this.message = "Something is wrong"]){
    message = "Weather Exception: $message";
  }


  @override
  String toString() => 'WeatherException(message: $message)';
}
