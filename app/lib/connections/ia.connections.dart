import '../helpers/exports.dart';
import 'package:http/http.dart' as http;

class IaConnections {
  String pathIA = "/api/generate/ai";
  String generalServer = "http://localhost:1337";

  generateIA(modelo, message) async {
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 591d9f4f0ce46bd2778a4d0b165aff6703592d76e723c5d7c0f5d5e4a72dce5bdb30ec483661ca4897fb037030b1dc0e84d1b9e94f0d695833b6cb4a74fb44253e8c13b405e781d09eeadc31829c23bd1fe1db13d54b68f86b8a531d98f04803ffba3b12fbedc2fed16c21be9dda0eb9628b2d352737b9c4ea87b7b31cd89dd6'
      };
      final Map<String, dynamic> data = {
        'modelo': modelo,
        'message': message,
      };
      var response = await http.post(Uri.parse("$generalServer$pathIA"),
          headers: headers, body: json.encode(data));
      var decodeData = json.decode(response.body);
      return decodeData['data'];
    } catch (e) {
      print(e);
    }
  }
}
