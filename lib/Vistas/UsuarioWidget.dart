//UsuarioWidget.dart
import 'package:flutter/material.dart';

class UsuarioWidget extends StatelessWidget {
  final String correo;
  final String nombreUsuario;

  const UsuarioWidget({
    required this.correo,
    required this.nombreUsuario,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.blue[900] ?? Colors.blue; // Color primario
    final secondaryColor = Colors.grey; // Color secundario

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        leading: CircleAvatar(
          backgroundColor: primaryColor, // Color primario para el fondo del avatar
          child: Icon(
            Icons.person,
            color: Colors.white, // Texto blanco para el icono del avatar
          ),
        ),
        title: Text(
          correo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor, // Color primario para el texto del correo
          ),
        ),
        subtitle: Text(
          nombreUsuario,
          style: TextStyle(
            color: secondaryColor, // Color secundario para el texto del nombre de usuario
          ),
        ),
        onTap: () {
          // Acción al hacer clic en el usuario (opcional)
        },
      ),
    );
  }
}
