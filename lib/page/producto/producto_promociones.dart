import 'package:nova_sport_app/page/producto/producto.dart';
import 'package:nova_sport_app/page/rutaApi/globals.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nova_sport_app/page/producto/detalle_producto.dart';
import 'package:nova_sport_app/page/producto/carrito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nova_sport_app/page/producto/cart.dart';

class ProductListaP extends StatefulWidget {
  final int id;

  const ProductListaP({Key? key, required this.id}) : super(key: key);

  @override
  _ProductListaPState createState() => _ProductListaPState();
}

class _ProductListaPState extends State<ProductListaP> {
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

  List<Producta> selectedProducts = [];
  Cart cart = Cart(); // cart

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      padding: EdgeInsets.all(8.0),
      childAspectRatio: 0.7,
      children: _products.map((product) {
        final isProductSelected = selectedProducts.any((selectedProduct) {
          return selectedProduct.nombre == product.nombre;
        });
        return Card(
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
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        product.isLiked = !product.isLiked;
                        if (product.isLiked) {
                          selectedProducts.add(product);
                        } else {
                          selectedProducts.remove(product);
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 35,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              //border: Border.all(
                              //  //color: Colors.black,
                              //  width: 2,
                              //),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                '-50%',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),

                          //Icon(
                          //  product.isLiked
                          //      ? Icons.favorite
                          //      : Icons.favorite_border,
                          //  color: Colors.red,
                          //),
                        ],
                      ),
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
                                  builder: (context) => SelectedProductsPage(
                                    selectedProducts: selectedProducts,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons
                                .shopping_cart), // Aquí defines el ícono que se mostrará en el botón
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
        );
      }).toList(),
    );
  }
}
