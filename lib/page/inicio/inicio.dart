import 'dart:convert';
import 'package:nova_sport_app/page/producto/producto_promociones.dart';
import 'package:nova_sport_app/page/rutaApi/globals.dart';

import 'package:flutter/material.dart';
import 'package:nova_sport_app/page/categorias/categorias.dart';
import 'package:nova_sport_app/page/inicio/carrusel.dart';
import 'package:nova_sport_app/page/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  List<Categorias> _products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return token;
  }

  Future<List<Categorias>> fetchProducts() async {
    final token = await _getToken();
    print(token);
    final response = await http.get(
      Uri.parse('${Global.apiUrl}/api/categorias'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': ' $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _products = (jsonData as List<dynamic>)
            .map((item) => Categorias.fromJson(item))
            .toList();
      });
      return _products;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'NOVA SPORTS',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: 10,
                  ),
                  Carrusel(),
                  //TIYULO CATEGORIA
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: const Text(
                        'Categorias',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  //CATEGORIAS_CARD
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Categoria(products: _products),
                  ),

                  //PRODUCTOS_CARD
                  ProductListaP(id: 5,)
                  // GridView.count(
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   crossAxisCount: 2,
                  //   childAspectRatio: MediaQuery.of(context).size.height / 800,
                  //   children: List.generate(
                  //     10,
                  //     (index) {
                  //       return Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Card(
                  //           child: Column(
                  //             children: [
                  //               //Image.network(
                  //               //  _products[index].imageUrl,
                  //               //  height: 150,
                  //               //  width: double.infinity,
                  //               //  fit: BoxFit.cover,
                  //               //),
                  //               //const SizedBox(height: 10),
                  //               Text(
                  //                 "_products[index].descripcion",
                  //                 style: const TextStyle(
                  //                   fontSize: 18.0,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
