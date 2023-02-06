import 'dart:convert';
import 'package:http/http.dart';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    Response response = await get(Uri.parse(url));
    print(response);
    if (response.statusCode == 200) {
      String data = response.body;
      var decoded = jsonDecode(data);

      return decoded;
    } else {
      print(response.statusCode);
    }
  }
}
