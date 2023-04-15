// import 'package:flutter/material.dart';
// import 'package:nova_sport_app/page/inicio/inicio.dart';
// import 'package:nova_sport_app/page/perfil/perfil.dart';
// import 'package:nova_sport_app/page/producto/boton_colors.dart';

// class Navigation extends StatelessWidget {
//   const Navigation({super.key});

//   //static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: NavigationButton(),
//     );
//   }
// }

// class NavigationButton extends StatefulWidget {
//   const NavigationButton({super.key});

//   @override
//   State<NavigationButton> createState() => _NavigationButtonState();
// }

// class _NavigationButtonState extends State<NavigationButton> {
//   int _selectedIndex = 0;
//   static const List<Widget> _widgetOptions = <Widget>[Inicio(), Colores()];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.yellow,
//         elevation: 10,
//         unselectedItemColor: Color.fromARGB(255, 0, 0, 0).withOpacity(.60),
//         selectedFontSize: 15,
//         unselectedFontSize: 12,
//         //backgroundColor: const Color.fromARGB(255, 11, 72, 122),
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Pedidos',
//             //backgroundColor: Color.fromARGB(255, 11, 72, 122),
//           ),
//           //BottomNavigationBarItem(
//           //  icon: Icon(Icons.transfer_within_a_station_sharp),
//           //  label: 'Viaje',
//           //  //backgroundColor: Color.fromARGB(255, 11, 72, 122),
//           //),
//           // BottomNavigationBarItem(
//           //   icon: Icon(Icons.content_paste),
//           //   label: 'Terminado',
//           //   //backgroundColor: Color.fromARGB(255, 11, 72, 122),
//           // ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Perfil',
//             //backgroundColor: Color.fromARGB(178, 11, 72, 122),
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Color.fromARGB(255, 90, 90, 90),
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:nova_sport_app/page/inicio/inicio.dart';
import 'package:nova_sport_app/page/perfil/perfil.dart';
import 'package:nova_sport_app/page/producto/boton_colors.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 70.0,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.person, size: 30),
          ],
          color: Colors.yellow,
          buttonBackgroundColor: Colors.yellow,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.transparent,
          child: Center(
            child: getPage(_page),
          ),
        ));
  }

  Widget getPage(int page) {
    switch (page) {
      case 0:
        return Inicio();

      case 2:
        return UserScreen();
      default:
        return Container();
    }
  }
}
