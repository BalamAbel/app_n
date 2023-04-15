import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nova_sport_app/page/rutaApi/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Aqui esta el codigo pero para enviar los datos Http
class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;

  String? _errorMessage;

  void _registro() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final response = await http.post(
        Uri.parse('${Global.apiUrl}/api/auth/registro'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "correo": _emailController.text,
          "nombres": _usernameController.text,
          "contraseña": _passwordController.text
        }),
      );
      setState(() {
        _isLoading = false;
      });
      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)['token'];
        await _saveToken(token);
        await _saveUserInformation();
        Navigator.pop(context);
      } else {
        setState(() {
          _errorMessage = 'Ha ocurrido un error durante el registro';
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
  }

  Future<void> _saveUserInformation() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('password', _passwordController.text);
  }

//Apartir de aqui comienza el codigo de la parte visual de la aplicacion movil
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://i.pinimg.com/564x/3d/5d/52/3d5d526b829991eaee5288736d0aeb5a.jpg"),
                fit: BoxFit.cover)),
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
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: "Email",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: "Nombre de usuario",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: "Contraseña",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: 'Confirmar tu contraseña',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
              child: Center(
                child: InkWell(
                  onTap: () {
                    // Define una función que se llamará cuando se presione el botón
                    void _registrarse() async {
                      // Obtiene los datos que el usuario ingresó en los campos de texto
                      String nombres = _usernameController.text;
                      String correo = _emailController.text;
                      String contrasena = _passwordController.text;

                      // Envía los datos al servidor
                      var response = await http.post(
                          Uri.parse('${Global.apiUrl}/auth/registro'),
                          body: {
                            'nombres': nombres,
                            'correo': correo,
                            'contraseña': contrasena,
                          });

                      // Si la respuesta del servidor es exitosa, muestra un mensaje de éxito
                      if (response.statusCode == 200) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Registro exitoso'),
                              content:
                                  Text('Los datos se enviaron correctamente.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Si la respuesta del servidor es un error, muestra un mensaje de error
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content:
                                  Text('Hubo un error al enviar los datos.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }

                    // Llama la función _registrarse cuando se presione el botón
                    _registrarse();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: const Text(
                      "Registrarse",
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
            SizedBox(
              height: 30,
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
                    child: Icon(
                      Icons.abc,
                      size: 20.0,
                      color: Colors.black,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .yellow, // establecer el color de fondo del botón
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0), // establecer el relleno del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            25.0), // hacer los bordes circulares
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // acción a realizar cuando se presiona el botón
                    },
                    child: Icon(
                      Icons.abc,
                      size: 20.0,
                      color: Colors.black,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .yellow, // establecer el color de fondo del botón
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0), // establecer el relleno del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            25.0), // hacer los bordes circulares
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // acción a realizar cuando se presiona el botón
                    },
                    child: Icon(
                      Icons.abc,
                      size: 20.0,
                      color: Colors.black,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .yellow, // establecer el color de fondo del botón
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0), // establecer el relleno del botón
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            25.0), // hacer los bordes circulares
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
