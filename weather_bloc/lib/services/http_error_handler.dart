import 'package:http/http.dart' as http;

String httpErrorHandler(http.Response res) {
 final statusCode = res.statusCode;
 final resPhrase = res.reasonPhrase;

 final String errorMessage = 'Request failed\n Status Code: $statusCode\n Reason $resPhrase';
 return errorMessage;
}