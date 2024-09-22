// PantallaPrincipal.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Publicacion.dart';
import 'PublicacionWidget.dart';
import 'Usuarios.dart'; // Importar la nueva pantalla de Usuarios

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _selectedIndex = 0;
  TextEditingController _estadoController = TextEditingController();

  final CollectionReference publicacionesCollection =
      FirebaseFirestore.instance.collection('publicaciones');

  Future<void> _publicarEstado() async {
    String estado = _estadoController.text;
    String correo = FirebaseAuth.instance.currentUser!.email ?? '';

    await publicacionesCollection.add({
      'contenido': estado,
      'correo': correo,
      'fecha': DateTime.now(),
    });

    _estadoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pantalla Principal',
          style: TextStyle(color: Colors.white), // Texto blanco
        ),
        backgroundColor: Colors.blue[900] ?? Colors.blue, // Azul oscuro
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: _estadoController,
              decoration: InputDecoration(
                hintText: '¿Qué estás pensando?',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200] ?? Colors.grey, // Fondo gris claro
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _publicarEstado,
            child: Text(
              'Publicar',
              style: TextStyle(color: Colors.white), // Texto blanco
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900] ?? Colors.blue, // Azul oscuro
            ),
          ),
          SizedBox(height: 20),
          Divider(color: Colors.grey),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: StreamBuilder(
                stream: publicacionesCollection
                    .orderBy('fecha', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.red), // Texto rojo
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var doc = snapshot.data!.docs[index];
                      return PublicacionWidget(
                        publicacion: Publicacion(
                          id: doc.id,
                          contenido: doc['contenido'],
                          correo: doc['correo'],
                          fecha: doc['fecha'].toDate(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            // Navegar a la pantalla de Inicio
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Usuarios()),
            );
          } else if (index == 2) {
            _cerrarSesion(context); // Cerrar sesión
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Usuarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Cerrar Sesión',
          ),
        ],
        selectedItemColor: Colors.blue[900] ?? Colors.blue, // Azul oscuro
        unselectedItemColor: Colors.grey[800] ?? Colors.grey, // Gris oscuro
        backgroundColor: Colors.grey[200] ?? Colors.grey, // Fondo gris claro
      ),
    );
  }

  Future<void> _cerrarSesion(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }
}
