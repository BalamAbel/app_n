import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:nova_sport_app/page/login/product.dart';
import 'package:nova_sport_app/page/producto/producto.dart';

class Categorias {
  final int id;
  final String descripcion;
  final bool activo;
  final String fecharegistro;

  Categorias({
    required this.id,
    required this.descripcion,
    required this.activo,
    required this.fecharegistro,
  });

  factory Categorias.fromJson(Map<String, dynamic> json) {
    return Categorias(
      id: json['id'],
      descripcion: json['descripcion'],
      activo: json['activo'],
      fecharegistro: json['fecharegistro'],
    );
  }
}

class Categoria extends StatelessWidget {
  Categoria({
    Key? key,
    required List<Categorias> products,
  })  : _products = products,
        super(key: key);

  final List<Categorias> _products;

  final List<String> _imageUrls = [
    'https://img.ltwebstatic.com/gspCenter/goodsImage/2023/1/14/9373105612_1044742/E545D8F5CD635E824AD530BD1ACBCA62_thumbnail_600x.jpg',
    'https://img.ltwebstatic.com/images3_pi/2023/03/08/167826177672b0c95b35d95feb0534014859abfba8_thumbnail_405x.webp',
    'https://img.ltwebstatic.com/images3_pi/2022/12/08/1670482493d1b0890a4aaade2d165eed579d7f333f_thumbnail_600x.webp',
    'https://img.ltwebstatic.com/images3_pi/2023/02/08/167582551190253765f12a5ae22975e88daf0bf75d_thumbnail_600x.webp',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _buildCards(context),
      ),
    );
  }

  List<Widget> _buildCards(BuildContext context) {
    List<Categorias> productList = _products.take(4).toList();
    Map<int, Categorias> productMap = productList.asMap();

    return productMap.entries.map((entry) {
      final int index = entry.key;
      final Categorias product = entry.value;
      return SizedBox(
          //height: 200,
          width: 130,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductLista(id: product.id),
                ),
              );
              // Aquí puedes definir la función que se ejecutará cuando el usuario presione la tarjeta.
              // Por ejemplo, puedes mostrar más información sobre el producto en una nueva pantalla.
            },
            child: Card(
              //margin: const EdgeInsets.all(12),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        _imageUrls[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    product.descripcion,
                    overflow: TextOverflow.ellipsis,
                    //maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ));
    }).toList();
  }
}
// TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ProductLista(
//                                   descripcion: product.descripcion),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           'Ver',
//                           style: TextStyle(
//                             fontSize: 15.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       )