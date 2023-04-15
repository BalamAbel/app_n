import 'package:flutter/material.dart';
import 'formulario_pago.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pago con tarjeta'),
          backgroundColor: Colors.yellow,
        ),
        body: const FormCard(),
      ),
    );
  }
}