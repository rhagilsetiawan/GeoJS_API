import 'package:flutter/material.dart';
import 'geo_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoJS Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GeoScreen(),
    );
  }
}

class GeoScreen extends StatefulWidget {
  @override
  _GeoScreenState createState() => _GeoScreenState();
}

class _GeoScreenState extends State<GeoScreen> {
  Map<String, dynamic>? locationData;
  bool isLoading = false;

  final GeoService _geoService = GeoService();

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await _geoService.fetchLocation();
      setState(() {
        locationData = data;
      });
    } catch (e) {
      print('Error fetching location: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeoJS Location'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : locationData != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('IP Address: ${locationData!['ip']}'),
                      SizedBox(height: 8),
                      Text('Country: ${locationData!['country']}'),
                      SizedBox(height: 8),
                      Text('City: ${locationData!['city']}'),
                      SizedBox(height: 8),
                      Text('Latitude: ${locationData!['latitude']}'),
                      SizedBox(height: 8),
                      Text('Longitude: ${locationData!['longitude']}'),
                    ],
                  ),
                )
              : Center(child: Text('Failed to load location')),
    );
  }
}
