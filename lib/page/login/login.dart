// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nova_sport_app/page/home/home.dart';

import 'package:nova_sport_app/page/login/registro.dart';
import 'package:nova_sport_app/page/rutaApi/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  String? _errorMessage;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      //final email = _emailController.text;
      //final password = _passwordController.text;
      //print(email);
      //print(password);
      setState(() {
        _isLoading = true;
      });
      final response = await http.post(
        Uri.parse('${Global.apiUrl}/api/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "correo": _emailController.text,
          "contraseña": _passwordController.text
        }),
      );
      setState(() {
        _isLoading = false;
      });
      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)['token'];
        await _saveToken(token);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => BottomNavBar()));
      } else {
        setState(() {
          _errorMessage = 'Correo o contraseña inválidos';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SizedBox(
              height: 50.0,
              child: Center(
                child: Text(
                  _errorMessage.toString(),
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('email', _emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    double paddingValue = isPortrait ? 100.0 : 30.0;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            Image(
              image: const NetworkImage(
                  'https://i.pinimg.com/564x/3d/5d/52/3d5d526b829991eaee5288736d0aeb5a.jpg'),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: paddingValue),
              child: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "NOVASPORT",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Correo',
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(174, 255, 255, 255),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Este campo no puede estar vacío';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: 'Contraseña',
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(174, 255, 255, 255),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Este campo no puede estar vacío';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 250),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistroPage()),
                              );
                            },
                            child: const Text(
                              'Registrarse',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration
                                    .underline, // agregar subrayado para indicar que es clickable
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 170),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Olvide mi contraseña',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 12),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {}
                                _login();
                                //  Navigator.push(
                                // context,
                                // MaterialPageRoute(builder: (context) => const ListViewPage()),
                                // );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: const Text(
                                  "Iniciar Sesión",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // acción a realizar cuando se presiona el botón
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .yellow, // establecer el color de fondo del botón
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical:
                                          5.0), // establecer el relleno del botón
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        25.0), // hacer los bordes circulares
                                  ),
                                ),
                                child: const Icon(
                                  Icons.abc,
                                  size: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .yellow, // establecer el color de fondo del botón
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical:
                                          5.0), // establecer el relleno del botón
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        25.0), // hacer los bordes circulares
                                  ),
                                ),
                                child: const Icon(
                                  Icons.abc,
                                  size: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // acción a realizar cuando se presiona el botón
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .yellow, // establecer el color de fondo del botón
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical:
                                          5.0), // establecer el relleno del botón
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        25.0), // hacer los bordes circulares
                                  ),
                                ),
                                child: const Icon(
                                  Icons.facebook,
                                  size: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
