import 'producto.dart';

//aqui mantengo los productos , de todas las categorias
//solo es funcion
class Cart {
  static final Cart _singleton = Cart._internal();

  List<Producta> _selectedProducts = [];

  factory Cart() {
    return _singleton;
  }

  Cart._internal();

  void addProduct(Producta product) {
    _selectedProducts.add(product);
  }

  void removeProduct(Producta product) {
    _selectedProducts.remove(product);
  }

  List<Producta> get selectedProducts {
    return _selectedProducts;
  }

  void addItem(Producta product) {
    _selectedProducts.add(product);
  }
}
