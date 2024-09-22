//Usuarios.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'UsuarioWidget.dart'; // Importar el nuevo widget de Usuario

class Usuarios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Usuarios',
          style: TextStyle(color: Colors.white), // Texto blanco
        ),
        backgroundColor: Colors.blue[900] ?? Colors.blue, // Azul oscuro
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('usuarios').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: Colors.red), // Texto rojo para el error
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final correo = document['correo'] ?? '';
              final nombreUsuario = document['nombre_usuario'] ?? '';
              return UsuarioWidget(
                correo: correo,
                nombreUsuario: nombreUsuario,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
