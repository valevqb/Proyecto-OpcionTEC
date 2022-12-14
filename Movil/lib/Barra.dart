import 'package:flutter/material.dart';
import 'Pez1_Screen.dart';
import 'Mas/vistas/mas_inicio.dart';
import 'Carreras/vistas/carrera_inicio.dart';
import 'Inicio/vistas/inicio_start.dart';
import 'Servicios/vistas/servicio_inicio.dart';
import 'Admision/vistas/Admision_inicio.dart';
import 'Estilos/Estilos.dart';

class PrototipoBarra extends StatefulWidget {
  State<StatefulWidget> createState() => _PrototipoBarra();
}


class _PrototipoBarra extends State<PrototipoBarra> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    //Plantilla(),
    //Plantilla2(),
    Inicio(),
    InicioAdmision(),
    InicioCarrera(),
    InicioServicio(),
    InicioMas(),
    PezPading(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pez Prueba",
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: pantallaPrincipal, //titulo mas grande
          titleMedium: titulosTipos, //tipos de carreras, etc
          titleSmall: tituloContenedor, //el titulo principal de las cartas
          bodyLarge: titulosCuerpo, //subtitulos de carreras, servicios, ect
          bodySmall: descripciones
        )
      ),
      //ThemeData(primarySwatch: Colors.cyan),
      home: Scaffold(
        /*
        appBar: AppBar(
          title: Text("Pez pantalla 2"),
        ),*/
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          selectedItemColor: Colors.cyan,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "Inicio"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: "Admision"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.school), label: "Carreras"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.volunteer_activism_outlined), label: "Servicios"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.dehaze_rounded), label: "Mas"
            ),
          ],
        ),
      ), //),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
