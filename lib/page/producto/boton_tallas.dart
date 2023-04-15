import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nova_sport_app/page/rutaApi/globals.dart';

class TallasScreen extends StatefulWidget {
  const TallasScreen({super.key});

  @override
  _TallasScreenState createState() => _TallasScreenState();
}

class _TallasScreenState extends State<TallasScreen> {
  bool _isLoading = true;
  List<Talla> _tallas = [];

  Future<List<Talla>> _fetchTallas() async {
    final response = await http.get(
      Uri.parse('${Global.apiUrl}/api/tallas'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _tallas = (jsonData as List<dynamic>)
            .map((item) => Talla.fromJson(item))
            .toList();
        _isLoading = false;
      });
      return _tallas;
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to fetch tallas');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTallas();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          ? CircularProgressIndicator()
          : _tallas.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (var talla in _tallas)
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, right: 10, bottom: 5),
                          child: SizedBox(
                            width: 80,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                print(talla.tipo);
                              },
                              child: Text(talla.tipo),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(80, 80),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                primary: Colors.yellow
                                    .shade300, //comentar para tener el mismo color amarillo
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              : const Text('Lo siento, no hay tallas en este momento'),
    );
  }
}

class Talla {
  final int id;
  final String tipo;

  Talla({
    required this.id,
    required this.tipo,
  });

  factory Talla.fromJson(Map<String, dynamic> json) {
    return Talla(
      id: json['id'],
      tipo: json['tipo'],
    );
  }
}
