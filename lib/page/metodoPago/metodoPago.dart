import 'package:flutter/material.dart';
import 'package:nova_sport_app/page/agregarTarjeta/formulario_pago.dart';
import 'package:nova_sport_app/page/qr/qr.dart';


class Metodopage extends StatelessWidget {
  const Metodopage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material app',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('NOVASPORT'),
          backgroundColor: Colors.yellow,
          
        ),
        
        body: Center(
          
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'SELECCIONE SU METODO DE PAGO',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,
                  ),
                ),
              SizedBox(
                height: 250,
                width: 250,
                child: Image.network(
                  'https://d31dn7nfpuwjnm.cloudfront.net/images/valoraciones/0034/7801/diferencia-tarjeta-credito-debito.png?1565359275'
                )
                  ),
                ElevatedButton(
                  onPressed: () {
                          
           Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormCard()),
    );
                  },
                  style: TextButton.styleFrom(
                    primary: Color.fromARGB(255, 0, 0, 0),
                    backgroundColor: Colors.yellow),
                  child: Text("AGREGAR TARJETA")
                ),
              SizedBox(
                height: 200,
                width: 200,
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Oxxo_Logo.svg/1200px-Oxxo_Logo.svg.png'
                )
              ),
              ElevatedButton(
                 onPressed: () {
                          
           Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => qrpage()),
    );
                  },
                style: TextButton.styleFrom(
                  primary: Color.fromARGB(255, 0, 0, 0),
                  backgroundColor: Colors.yellow),
                child: Text("GENERAR QR")
              )
            ],
          ),
        ),
      )
    );
  }
}
