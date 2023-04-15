import 'package:flutter/material.dart';
import 'package:nova_sport_app/page/producto/producto.dart';
import 'package:nova_sport_app/page/producto/cart.dart';

// aqui hago modificaciones de la vista del carrito
//este es el carrito good

class SelectedProductsPage extends StatelessWidget {
  final List<Producta> selectedProducts;

  SelectedProductsPage({required this.selectedProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
      ),
      body: ListView.builder(
        itemCount: selectedProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Image.network(
                    selectedProducts[index].rutaimagen,
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
                Expanded(
                  flex: 4,
                  child: ListTile(
                    title: Text(selectedProducts[index].nombre),
                    subtitle: Text(selectedProducts[index].descripcion),
                    trailing: Text('MXN ${selectedProducts[index].precio}'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ElevatedButton(
          onPressed: () {
            // Mostrar dialogo de confirmación
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Compra realizada con éxito'),
                  content: Text('Gracias por tu compra'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cerrar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Comprar'),
        ),
      ),
    );
  }
}
