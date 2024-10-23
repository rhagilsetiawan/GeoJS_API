import 'dart:convert';
import 'package:http/http.dart' as http;

class GeoService {
  final String _baseUrl = 'https://get.geojs.io/v1/ip/geo.json';

  Future<Map<String, dynamic>> fetchLocation() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load location');
    }
  }
}
