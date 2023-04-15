// ignore_for_file: non_constant_identifier_names

import 'package:nova_sport_app/page/rutaApi/globals.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nova_sport_app/page/producto/detalle_producto.dart';
import 'package:nova_sport_app/page/producto/carrito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nova_sport_app/page/producto/cart.dart';

class Producta {
  final int id;
  final int idmarca;
  final int idcategoria;
  final int id_color1;
  final int id_talla1;
  final String nombre;
  final String descripcion;
  final double precio;
  final int stock;
  final String rutaimagen;
  final bool activo;
  final String fecharegistro;
  bool isLiked;
  String? selectedColor; // Nuevo atributo para guardar el color elegido
  String? selectedSize; // Nuevo atributo para guardar la talla elegida

  Producta({
    required this.id,
    required this.idmarca,
    required this.idcategoria,
    required this.id_color1,
    required this.id_talla1,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.stock,
    required this.rutaimagen,
    required this.activo,
    required this.fecharegistro,
    this.isLiked = false,
    this.selectedColor, // Agregamos los atributos al constructor
    this.selectedSize,
  });

  factory Producta.fromJson(Map<String, dynamic> json) {
    return Producta(
      id: json['id'],
      idmarca: json['idmarca'],
      idcategoria: json['idcategoria'],
      id_color1: json['id_color1'],
      id_talla1: json['id_talla1'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: json['precio'].toDouble(),
      stock: json['stock'],
      rutaimagen: json['rutaimagen'],
      activo: json['activo'],
      fecharegistro: json['fecharegistro'],
      selectedColor: null,
      // Establecemos los valores iniciales de los atributos a null
      selectedSize: null,
    );
  }
}

class ProductLista extends StatefulWidget {
  final int id;

  const ProductLista({Key? key, required this.id}) : super(key: key);

  @override
  _ProductListaState createState() => _ProductListaState();
}

class _ProductListaState extends State<ProductLista> {
  List<Producta> _products = [];
  bool _isLoading = true;

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

  Future<List<Producta>> fetchProducts() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('${Global.apiUrl}/api/productos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': ' $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _products = (jsonData as List<dynamic>)
            .map((item) => Producta.fromJson(item))
            .where((product) => product.idcategoria == widget.id)
            .toList();
      });
      return _products;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

//Aqui trabajo lo que se mostrara en mi carrito Global
//tipo favoritos

  List<Producta> selectedProducts = Cart().selectedProducts;
  Cart cart = Cart();
  // cart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Productos'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(8.0),
        childAspectRatio: 0.7,
        children: _products.map((product) {
          final isProductSelected = selectedProducts.any((selectedProduct) {
            return selectedProduct.nombre == product.nombre;
          });
          return SizedBox(
            width: 300,
            height: 400,
            child: Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                        product: product,
                        cart: cart,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isProductSelected) {
                              selectedProducts.remove(product);
                            } else {
                              selectedProducts.add(product);
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              isProductSelected
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: isProductSelected ? Colors.green : null,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              'Añadir al Carrito',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: isProductSelected ? Colors.green : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Image.network(
                          product.rutaimagen,
                          fit: BoxFit.contain,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: Center(
                                child: Text(
                                  'No se pudo cargar la imagen',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.nombre,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.blue),
                          ),
                          Text(
                            product.descripcion,
                            style: const TextStyle(fontSize: 16.0),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "MXN ${product.precio}",
                                style: const TextStyle(fontSize: 13.0),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SelectedProductsPage(
                                        selectedProducts: selectedProducts,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.shopping_cart),
                                color: const Color.fromARGB(255, 1, 1,
                                    1), // Aquí defines el color del ícono
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
