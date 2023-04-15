// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:nova_sport_app/page/rutaApi/globals.dart';

// class TallasScreen extends StatefulWidget {
//   const TallasScreen({super.key});

//   @override
//   _TallasScreenState createState() => _TallasScreenState();
// }

// class _TallasScreenState extends State<TallasScreen> {
//   bool _isLoading = true;
//   List<Talla> _tallas = [];

//   Future<List<Talla>> _fetchTallas() async {
//     final response = await http.get(
//       Uri.parse('${Global.apiUrl}/api/tallas'),
//     );

//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       setState(() {
//         _tallas = (jsonData as List<dynamic>)
//             .map((item) => Talla.fromJson(item))
//             .toList();
//         _isLoading = false;
//       });
//       return _tallas;
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//       throw Exception('Failed to fetch tallas');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchTallas();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: _isLoading
//           ? CircularProgressIndicator()
//           : _tallas.isNotEmpty
//               ? SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       for (var talla in _tallas)
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               top: 5, right: 10, bottom: 5),
//                           child: SizedBox(
//                             width: 80,
//                             height: 50,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 print(talla.tipo);
//                               },
//                               child: Text(talla.tipo),
//                               style: ElevatedButton.styleFrom(
//                                 minimumSize: Size(80, 80),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 //primary: Colors.grey[300],
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 )
//               : Text('Lo siento, no hay tallas en este momento'),
//     );
//   }
// }

// class Talla {
//   final int id;
//   final String tipo;

//   Talla({
//     required this.id,
//     required this.tipo,
//   });

//   factory Talla.fromJson(Map<String, dynamic> json) {
//     return Talla(
//       id: json['id'],
//       tipo: json['tipo'],
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nova_sport_app/page/login/login.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<dynamic> _allUsers = [];
  List<dynamic> _validUsers = [];
  bool _isLoading = true; // Nuevo estado para indicar si se está cargando

  Future<void> _loadUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');

    if (token != null) {
      final response = await http.get(
        Uri.parse(
            'https://api-novasport-production.up.railway.app/api/auth/usuarios'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          _allUsers = jsonResponse;
          _isLoading =
              false; // Establecer isLoading en false una vez que se han cargado los datos
        });
        // Validar los usuarios
        _validUsers.clear();
        for (var user in _allUsers) {
          if (user['correo'] == email) {
            _validUsers.add(user);
          }
        }
      } else {
        throw Exception('Failed to load users');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _isLoading // Mostrar el indicador de carga si isLoading es verdadero
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _validUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = _validUsers[index];
                    return Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 230,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                            ),

                            // Positioned(
                            //   top: 30,
                            //   left: 20,
                            //   //left: 20,
                            //   child: Text(
                            //     'Bienvenido',
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 30,
                            //         color: Color.fromARGB(162, 0, 0, 0)),
                            //   ),
                            // ),
                            Positioned(
                              top: 140,

                              //left: 20,
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  '${user['nombres']}${user['apellido_p']} ${user['apellido_m']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color.fromARGB(162, 0, 0, 0)),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 165,

                              //left: 20,
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  '${user['correo']}',
                                  style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color.fromARGB(162, 0, 0, 0)),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 30,
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      Color.fromARGB(69, 129, 130, 129),
                                  backgroundImage: NetworkImage(
                                    "https://cdn.pixabay.com/photo/2014/12/12/19/45/lion-565820_640.jpg",
                                  ),
                                ),
                              ),
                            ),
                            // Text('ID: ${users[index]['id']}'),
//                   // Text('Nombres: ${users[index]['nombres']}'),
//                   // Text('Apellido Paterno: ${users[index]['apellido_p']}'),
//                   // Text('Apellido Materno: ${users[index]['apellido_m']}'),
//                   // Text('Correo: ${users[index]['correo']}'),
//                   // Text('Contraseña: ${users[index]['contraseña']}'),
//                   // Text('Es Administrador: ${users[index]['esadministrador']}'),
//                   // Text('Activo: ${users[index]['activo']}'),
//                   // Text('Fecha de Creación: ${users[index]['createdAt']}'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRow(Icons.home, 'Domicilio',
                                  user['domicilio']['domicilio']),
                              _buildRow(Icons.location_city, 'Población',
                                  user['domicilio']['entidad']['poblacion']),
                              _buildRow(
                                  Icons.mail_outline,
                                  'Código Postal',
                                  user['domicilio']['entidad']['zona']
                                          ['codigo_postal']
                                      .toString()),
                            ],
                          ),
                        ),
                        Card(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              Icon(Icons.account_box),
                              SizedBox(width: 16.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Cuenta",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("Activa"),
                                ],
                              ),
                            ],
                          ),
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.logout),
                              onPressed: () {
                                // Navega a la pantalla de inicio de sesión
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const LoginPage()));
                              },
                            ),
                            Text("Cerrar sesion"),
                          ],
                        )
                      ],
                    );
                  },
                ),
    );
  }
}

Widget _buildRow(IconData icon, String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Row(
      children: [
        Icon(icon),
        SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(value),
          ],
        ),
      ],
    ),
  );
}
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserScreen extends StatefulWidget {
//   @override
//   _UserScreenState createState() => _UserScreenState();
// }

// class _UserScreenState extends State<UserScreen> {
//   List<dynamic> users = [];

//   Future<void> _loadUsers() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');

//     if (token != null) {
//       final response = await http.get(
//         Uri.parse(
//             'https://api-novasport-production.up.railway.app/api/auth/usuarios'),
//         headers: {'Authorization': 'Bearer $token'},
//       );

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         setState(() {
//           users = jsonResponse;
//         });
//       } else {
//         throw Exception('Failed to load users');
//       }
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadUsers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (BuildContext context, int index) {
//           if (users.isEmpty) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (users[index]['correo'] == 'kevin@gmail.com') {
//             return Stack(
//                 clipBehavior: Clip.none,
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     height: 140,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.yellow, // Color de fondo del contenedor
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(
//                             20.0), // Radio de las esquinas inferiores del contenedor
//                         bottomRight: Radius.circular(20.0),
//                       ),
//                       // border: Border.all(
//                       //   color: Colors.grey[400], // Color del borde del contenedor
//                       //   width: 2.0, // Ancho del borde del contenedor
//                       // ),
//                     ),
//                     // child: const Image(
//                     //   image: NetworkImage(
//                     //     'https://cdn.pixabay.com/photo/2022/11/14/10/49/mountains-7591326_960_720.jpg',
//                     //   ),
//                     //   fit: BoxFit.cover,
//                     // ),
//                   ),
//                   Positioned(
//                     top: 30,
//                     left: 20,
//                     //left: 20,
//                     child: Text(
//                       'Bienvenido',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           color: Color.fromARGB(162, 0, 0, 0)),
//                     ),
//                   ),
//                   Positioned(
//                     top: 60,
//                     left: 20,
//                     //left: 20,
//                     child: Text(
//                       '${users[index]['nombres']} ${users[index]['apellido_p']}${users[index]['apellido_m']}',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           color: Color.fromARGB(162, 0, 0, 0)),
//                     ),
//                   ),
//                   // Text('ID: ${users[index]['id']}'),
//                   // Text('Nombres: ${users[index]['nombres']}'),
//                   // Text('Apellido Paterno: ${users[index]['apellido_p']}'),
//                   // Text('Apellido Materno: ${users[index]['apellido_m']}'),
//                   // Text('Correo: ${users[index]['correo']}'),
//                   // Text('Contraseña: ${users[index]['contraseña']}'),
//                   // Text('Es Administrador: ${users[index]['esadministrador']}'),
//                   // Text('Activo: ${users[index]['activo']}'),
//                   // Text('Fecha de Creación: ${users[index]['createdAt']}'),
//                   // Text('Domicilio: ${users[index]['domicilio']['domicilio']}'),
//                   // Text(
//                   //     'Población: ${users[index]['domicilio']['entidad']['poblacion']}'),
//                   // Text(
//                   //     'Código Postal: ${users[index]['domicilio']['entidad']['zona']['codigo_postal']}'),
//                 ]);
//             // return Padding(
//             //   padding: EdgeInsets.all(10.0),
//             //   child: Column(
//             //     crossAxisAlignment: CrossAxisAlignment.start,
//             //     children: [
//             //       Text('ID: ${users[index]['id']}'),
//             //       Text('Nombres: ${users[index]['nombres']}'),
//             //       Text('Apellido Paterno: ${users[index]['apellido_p']}'),
//             //       Text('Apellido Materno: ${users[index]['apellido_m']}'),
//             //       Text('Correo: ${users[index]['correo']}'),
//             //       Text('Contraseña: ${users[index]['contraseña']}'),
//             //       Text('Es Administrador: ${users[index]['esadministrador']}'),
//             //       Text('Activo: ${users[index]['activo']}'),
//             //       Text('Fecha de Creación: ${users[index]['createdAt']}'),
//             //       Text('Domicilio: ${users[index]['domicilio']['domicilio']}'),
//             //       Text(
//             //           'Población: ${users[index]['domicilio']['entidad']['poblacion']}'),
//             //       Text(
//             //           'Código Postal: ${users[index]['domicilio']['entidad']['zona']['codigo_postal']}'),
//             //     ],
//             //   ),
//             // );
//           } else {
//             return SizedBox.shrink();
//           }
//         },
//       ),
//     );
//   }
// }
