import '../helpers/exports.dart';
import 'package:http/http.dart' as http;

class AuthConnections {
  String pathLogin = "/api/auth/local";

  String pathRegister = "/api/auth/local/register";
  String generalServer = "http://localhost:1337";

  login({email, password}) async {
    final String url = '$generalServer$pathLogin';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> data = {
      'identifier': email,
      'password': password,
    };
    try {
      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(data));
      var decodeData = json.decode(response.body);
      if (response.statusCode != 200) {
        return [false, decodeData['error']['message']];
      } else {
        localStorage!.setString("jwt", decodeData['jwt']);
        localStorage!.setInt("id", decodeData['user']['id']);
        localStorage!.setString("email", decodeData['user']['email']);
        return [true, ""];
      }
    } catch (e) {
      return [false, e.toString()];
    }
  }

  Future registerUser({mail, password}) async {
    final String url = '$generalServer$pathRegister';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> data = {
      'username': mail,
      'email': mail,
      'password': password,
    };
    try {
      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(data));
      var decodeData = json.decode(response.body);
      if (response.statusCode != 200) {
        return [false, decodeData['error']['message']];
      } else {
        localStorage!.setString("jwt", decodeData['jwt']);
        localStorage!.setInt("id", decodeData['user']['id']);
        localStorage!.setString("email", decodeData['user']['email']);
        return [true, ""];
      }
    } catch (e) {
      return [false, e.toString()];
    }
  }
}
