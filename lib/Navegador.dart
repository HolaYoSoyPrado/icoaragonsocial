//Navegador.dart
import 'package:flutter/material.dart';
import 'Vistas/Bienvenida.dart';
import 'Vistas/login.dart'; // Importamos la vista de inicio de sesión

class Navegador extends StatefulWidget {
  const Navegador({Key? key}) : super(key: key);

  @override
  State<Navegador> createState() => _NavegadorState();
}

class _NavegadorState extends State<Navegador> {
  int _indice = 0;
  final _cuerpo = [
    const Login(
      titulo: "Iniciar Sesión", // Asignamos el título para la vista de inicio de sesión
    ),
    const Bienvenida(
      titulo: "Bienvenida",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cuerpo[_indice],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indice,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (value) {
          setState(() {
            _indice = value;
          });
          print(_indice);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: "Iniciar Sesión", // Añadimos el ícono y la etiqueta para la vista de inicio de sesión
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info), // Cambiamos el icono a Icons.info
            label: "Bienvenida",
          ),
        ],
      ),
    );
  }
}