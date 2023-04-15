// // TODO Implement this library..

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:nova_sport_app/page/login/registro.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // class Producta {
//   final int id;
//   final int idmarca;
//   final int idcategoria;
//   final int id_color1;
//   final int id_talla1;
//   final String nombre;
//   final String descripcion;
//   final double precio;
//   final int stock;
//   final String rutaimagen;
//   final bool activo;
//   final String fecharegistro;
//   bool isLiked;

//   Producta({
//     required this.id,
//     required this.idmarca,
//     required this.idcategoria,
//     required this.id_color1,
//     required this.id_talla1,
//     required this.nombre,
//     required this.descripcion,
//     required this.precio,
//     required this.stock,
//     required this.rutaimagen,
//     required this.activo,
//     required this.fecharegistro,
//     this.isLiked = false,
//   });

//   factory Producta.fromJson(Map<String, dynamic> json) {
//     return Producta(
//       id: json['id'],
//       idmarca: json['idmarca'],
//       idcategoria: json['idcategoria'],
//       id_color1: json['id_color1'],
//       id_talla1: json['id_talla1'],
//       nombre: json['nombre'],
//       descripcion: json['descripcion'],
//       precio: json['precio'].toDouble(),
//       stock: json['stock'],
//       rutaimagen: json['rutaimagen'],
//       activo: json['activo'],
//       fecharegistro: json['fecharegistro'],
//     );
//   }
// }

// class ProductLista extends StatefulWidget {
//   final String descripcion;

//   const ProductLista({Key? key, required this.descripcion}) : super(key: key);

//   @override
//   _ProductListaState createState() => _ProductListaState();
// }

// class _ProductListaState extends State<ProductLista> {
//   List<Producta> _products = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   Future<String> _getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token') ?? '';
//     return token;
//   }

//   Future<List<Producta>> fetchProducts() async {
//     final token = await _getToken();
//     final response = await http.get(
//       Uri.parse('http://192.168.0.5:3000/api/productos'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': ' $token',
//       },
//     );
//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       setState(() {
//         _products = (jsonData as List<dynamic>)
//             .map((item) => Producta.fromJson(item))
//             .where((product) => product.nombre == widget.descripcion)
//             .toList();
//       });
//       return _products;
//     } else {
//       throw Exception('Failed to fetch products');
//     }
//   }

//   List<Producta> selectedProducts = []; // cart

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product List'),
//       ),
//       body: GridView.count(
//         crossAxisCount: 2,
//         padding: EdgeInsets.all(8.0),
//         childAspectRatio: 0.7,
//         children: _products.map((product) {
//           final isProductSelected = selectedProducts.any((selectedProduct) {
//             return selectedProduct.nombre == product.nombre;
//           });
//           return SizedBox(
//             width: 300,
//             height: 400,
//             child: Card(
//               margin: const EdgeInsets.all(8.0),
//               elevation: 2.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ProductDetailsPage(
//                         product: product,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             product.isLiked = !product.isLiked;
//                             if (product.isLiked) {
//                               selectedProducts.add(product);
//                             } else {
//                               selectedProducts.remove(product);
//                             }
//                           });
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Icon(
//                               product.isLiked
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                               color: Colors.red,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Center(
//                         child: Image.network(
//                           product.rutaimagen ?? '',
//                           fit: BoxFit.contain,
//                           errorBuilder: (BuildContext context, Object exception,
//                               StackTrace? stackTrace) {
//                             return Container(
//                               color: Colors.grey[300],
//                               child: Center(
//                                 child: Text(
//                                   'No se pudo cargar la imagen',
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             product.nombre,
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 2,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18.0,
//                             ),
//                           ),
//                           Text(
//                             product.descripcion,
//                             style: const TextStyle(fontSize: 16.0),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const SizedBox(height: 8.0),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "MXN ${product.precio}",
//                                 style: const TextStyle(fontSize: 13.0),
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           SelectedProductsPage(
//                                               selectedProducts:
//                                                   selectedProducts),
//                                     ),
//                                   );
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(2),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Icon(
//                                         Icons.shopping_cart,
//                                         size: 15, // reducir tamaño del icono
//                                       ),
//                                       //SizedBox(width: 5),
//                                       //Text('Agregar',
//                                       //    style: const TextStyle(
//                                       //        fontSize:
//                                       //            8)), // reducir tamaño del texto
//                                     ],
//                                   ),
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30.0),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }


// class ProductDetailsPage extends StatelessWidget {
//   final Producta product;

//   ProductDetailsPage({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(product.nombre),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.shopping_cart),
//             onPressed: () {
//               // Acción al presionar el botón de búsqueda
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 100),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Container(
//                     constraints: BoxConstraints(
//                       minHeight: 300,
//                       maxHeight: 400,
//                     ),
//                     child: Image.network(
//                       product.rutaimagen ?? '',
//                       fit: BoxFit.cover,
//                       errorBuilder: (BuildContext context, Object exception,
//                           StackTrace? stackTrace) {
//                         return Container(
//                           color: Colors.grey[300],
//                           child: Center(
//                             child: Text(
//                               'No se pudo cargar la imagen',
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           product.nombre,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 24.0,
//                           ),
//                         ),
//                         const SizedBox(height: 8.0),
//                         const Text(
//                           "Descripcion",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15.0,
//                               color: Colors.amber),
//                         ),
//                         const SizedBox(height: 8.0),
//                         Text(
//                           product.descripcion,
//                           style: const TextStyle(fontSize: 18.0),
//                         ),
//                         const SizedBox(height: 16.0),
//                         const Text(
//                           "Colores",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15.0,
//                               color: Colors.amber),
//                         ),
//                         const SizedBox(height: 16.0),
//                         Row(
//                           children: [
//                             _buildDot(Color.fromARGB(255, 0, 81, 255)),
//                             const SizedBox(height: 16.0),
//                             _buildDot(Color.fromARGB(255, 255, 0, 0)),
//                             const SizedBox(height: 16.0),
//                             _buildDot(Color.fromARGB(255, 255, 9, 169)),
//                             const SizedBox(height: 16.0),
//                             _buildDot(Color.fromARGB(255, 0, 0, 0)),
//                             const SizedBox(height: 16.0),
//                             _buildDot(Color.fromARGB(255, 151, 151, 151)),
//                             const SizedBox(height: 16.0),
//                             _buildDot(Color.fromARGB(255, 0, 255, 8)),
//                           ],
//                         ),
//                         const SizedBox(height: 16.0),
//                         const Text(
//                           "Tallas",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15.0,
//                               color: Colors.amber),
//                         ),
//                         const SizedBox(height: 16.0),
//                         Row(
//                           children: [
//                             _buildButton("ch", Colors.grey[300]!),
//                             const SizedBox(width: 16.0),
//                             _buildButton("G", Colors.grey[300]!),
//                             const SizedBox(width: 16.0),
//                             _buildButton("M", Colors.grey[300]!),
//                           ],
//                         ),
//                         // SizedBox(height: 50),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: SizedBox(
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: Text(
//                   "Agregar",
//                   style: TextStyle(fontSize: 24.0),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 70),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget _buildDot(Color color) {
//   return Container(
//     width: 30.0,
//     height: 30.0,
//     decoration: BoxDecoration(
//       color: color,
//       shape: BoxShape.circle,
//     ),
//     margin: const EdgeInsets.only(right: 8.0),
//   );
// }

// Widget _buildButton(String text, Color color) {
//   return Expanded(
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: ElevatedButton(
//         onPressed: () {},
//         child: Text(
//           text,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18.0,
//           ),
//         ),
//         style: ElevatedButton.styleFrom(
//           primary: color,
//           padding: const EdgeInsets.all(16.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//         ),
//       ),
//     ),
//   );
// }
// // TODO Implement this library..

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:nova_sport_app/page/login/registro.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Producta {
//   final int id;
//   final int idmarca;
//   final int idcategoria;
//   final int id_color1;
//   final int id_talla1;
//   final String nombre;
//   final String descripcion;
//   final double precio;
//   final int stock;
//   final String rutaimagen;
//   final bool activo;
//   final String fecharegistro;

//   Producta({
//     required this.id,
//     required this.idmarca,
//     required this.idcategoria,
//     required this.id_color1,
//     required this.id_talla1,
//     required this.nombre,
//     required this.descripcion,
//     required this.precio,
//     required this.stock,
//     required this.rutaimagen,
//     required this.activo,
//     required this.fecharegistro,
//   });

//   factory Producta.fromJson(Map<String, dynamic> json) {
//     return Producta(
//       id: json['id'],
//       idmarca: json['idmarca'],
//       idcategoria: json['idcategoria'],
//       id_color1: json['id_color1'],
//       id_talla1: json['id_talla1'],
//       nombre: json['nombre'],
//       descripcion: json['descripcion'],
//       precio: json['precio'].toDouble(),
//       stock: json['stock'],
//       rutaimagen: json['rutaimagen'],
//       activo: json['activo'],
//       fecharegistro: json['fecharegistro'],
//     );
//   }
// }

// class ProductLista extends StatefulWidget {
//   @override
//   _ProductListaState createState() => _ProductListaState();
// }

// class _ProductListaState extends State<ProductLista> {
//   List<Producta> _products = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   Future<String> _getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token') ?? '';
//     return token;
//   }

//   Future<List<Producta>> fetchProducts() async {
//     final token = await _getToken();
//     print(token);
//     final response = await http.get(
//       Uri.parse('http://192.168.0.3:3300/api/productos'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': ' $token',
//       },
//     );
//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       setState(() {
//         _products = (jsonData as List<dynamic>)
//             .map((item) => Producta.fromJson(item))
//             .toList();
//       });
//       return _products;
//     } else {
//       throw Exception('Failed to fetch products');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: StreamBuilder<Object>(
//           stream: null,
//           builder: (context, snapshot) {
//             return Column(
//               children: _products.map((product) {
//                 return SizedBox(
//                   width: 200,
//                   height: 200,
//                   child: Card(
//                     margin: const EdgeInsets.all(8.0),
//                     elevation: 2.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             product.descripcion,
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 2,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18.0,
//                             ),
//                           ),
//                           const SizedBox(height: 8.0),
//                           Text(
//                             product.fecharegistro,
//                             style: const TextStyle(fontSize: 16.0),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             );
//           }),
//     );
//   }
// }
