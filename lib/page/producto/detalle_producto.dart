import 'package:flutter/material.dart';
import 'package:nova_sport_app/page/producto/boton_colors.dart';
import 'package:nova_sport_app/page/producto/boton_tallas.dart';
import 'package:nova_sport_app/page/producto/producto.dart';
import 'package:nova_sport_app/page/producto/cart.dart';
import 'package:nova_sport_app/page/producto/carrito.dart';

class ProductDetailsPage extends StatelessWidget {
  final Producta product;
  final Cart cart;
  String? selectedColor; // Variable para guardar el color seleccionado
  String? selectedSize; // Variable para guardar la talla seleccionada

  ProductDetailsPage({
    required this.product,
    required this.cart,
    this.selectedColor,
    this.selectedSize,
  });
// Agregamos las nuevas variables como argumentos opcionales

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.nombre),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectedProductsPage(
                    selectedProducts: Cart().selectedProducts,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //imagen
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 300,
                      maxHeight: 400,
                    ),
                    child: Image.network(
                      product.rutaimagen,
                      fit: BoxFit.cover,
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
                  //todos los datos
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.nombre,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          "Descripcion",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.amber),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          product.descripcion,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          "Colores",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.amber),
                        ),
                        const SizedBox(height: 16.0),
                        Colores(),
                        const SizedBox(height: 16.0),
                        const Text(
                          "Tallas",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.amber),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      TallasScreen(),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  cart.addItem(product);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('El producto ha sido agregado al carrito'),
                  ));
                },
                child: Text(
                  "Agregar",
                  style: TextStyle(fontSize: 24.0),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 70),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildDot(Color color) {
  return Container(
    width: 30.0,
    height: 30.0,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
    margin: const EdgeInsets.only(right: 8.0),
  );
}

Widget _buildButton(String text, Color color) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
          padding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    ),
  );
}
