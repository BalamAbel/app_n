import 'package:flutter/material.dart';
import 'package:nova_sport_app/page/producto/producto.dart';

class SelectedProductsPage extends StatelessWidget {
  final List<Producta> selectedProducts;
  

  SelectedProductsPage({required this.selectedProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Products'),
      ),
      body: ListView.builder(
        itemCount: selectedProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(selectedProducts[index].nombre),
              subtitle: Text(selectedProducts[index].descripcion),
              trailing: Text('MXN ${selectedProducts[index].precio}'),
            ),
          );
        },
      ),
    );
  }
}
