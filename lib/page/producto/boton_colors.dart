import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nova_sport_app/page/rutaApi/globals.dart';

class Colores extends StatefulWidget {
  const Colores({super.key});

  @override
  _ColoresState createState() => _ColoresState();
}

class _ColoresState extends State<Colores> {
  List<ColorModel> _colors = [];
  bool _isLoading = true;
  bool _showIcon = false;

  @override
  void initState() {
    super.initState();
    _getColors();
  }

  void _getColors() async {
    final response = await http.get(Uri.parse('${Global.apiUrl}/api/colores'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;

      setState(() {
        _colors = data.map((item) => ColorModel.fromJson(item)).toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Failed to load colors: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          ? CircularProgressIndicator()
          : _colors.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var color in _colors)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                print(color.colorName);
                              },
                              child: Text(""),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(80, 80),
                                shape: CircleBorder(),
                                primary: _getColor(color.colorName),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              : Text('Lo siento, no hay colores disponibles en este momento'),
    );
  }

  Color _getColor(String colorName) {
    switch (colorName) {
      case 'rojo':
        return Colors.red;
      case 'verde':
        return Colors.green;
      case 'azul':
        return Colors.blue;
      case 'amarillo':
        return Colors.yellow;
      case 'negro':
        return Colors.black;
      case 'rosado':
        return Color.fromARGB(255, 255, 0, 149);
      case 'morado':
        return Colors.purple;
      case 'gris':
        return Colors.grey;
      case 'cafe':
        return Color.fromARGB(255, 165, 42, 42);
      case 'naranja':
        return Colors.orange;
      case 'blanco':
        return Colors.white;
      default:
        return Colors.transparent;
    }
  }
}

class ColorModel {
  final int id;
  final String colorName;

  ColorModel({required this.id, required this.colorName});

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    return ColorModel(
      id: json['id'] as int,
      colorName: json['color'] as String,
    );
  }
}
