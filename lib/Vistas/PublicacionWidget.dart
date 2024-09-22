// PublicacionWidget.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Publicacion.dart';
import 'comentario.dart';
import 'comentario_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';


class PublicacionWidget extends StatefulWidget {
  final Publicacion publicacion;

  const PublicacionWidget({Key? key, required this.publicacion}) : super(key: key);

  @override
  _PublicacionWidgetState createState() => _PublicacionWidgetState();
}

class _PublicacionWidgetState extends State<PublicacionWidget> {
  bool _liked = false;
  int _currentLikes = 0;
  late SharedPreferences _prefs; // SharedPreferences para almacenar el estado de "me gusta"
  late TextEditingController _comentarioController; // Controlador para el campo de texto del comentario

  @override
  void initState() {
    super.initState();
    _initPreferences();
    _comentarioController = TextEditingController(); // Inicializar el controlador
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    // Comprobar si el usuario ha dado "me gusta" a esta publicación y actualizar el estado
    setState(() {
      _liked = _prefs.containsKey(widget.publicacion.id) && _prefs.getBool(widget.publicacion.id)!;
      _currentLikes = widget.publicacion.likes; // Corregido para que el número de likes inicial sea el correcto
      if (_liked) {
        _currentLikes++; // Incrementar el número de likes si ya se ha dado "me gusta"
      }
    });
  }

  // Método para obtener los comentarios de la publicación
  Widget _buildComentarios(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('publicaciones')
          .doc(widget.publicacion.id)
          .collection('comentarios')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
            final comentario = Comentario(
              id: document.id,
              contenido: document['contenido'],
              correo: document['correo'],
              fecha: document['fecha'].toDate(),
            );
            return ComentarioWidget(comentario: comentario);
          }).toList(),
        );
      },
    );
  }

  // Método para enviar un comentario
  Future<void> _enviarComentario(BuildContext context) async {
    String comentario = _comentarioController.text;
    String correo = FirebaseAuth.instance.currentUser!.email ?? ''; // Obtener el correo electrónico del usuario actual

    // Agregar el comentario a Firestore
    await FirebaseFirestore.instance
        .collection('publicaciones')
        .doc(widget.publicacion.id)
        .collection('comentarios')
        .add({
      'contenido': comentario,
      'correo': correo,
      'fecha': DateTime.now(),
    });

    // Limpiar el campo de texto después de enviar el comentario
    _comentarioController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.publicacion.contenido,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Publicado por: ${widget.publicacion.correo}',
                  style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
                ),
                Text(
                  'Fecha: ${DateFormat('dd/MM/yyyy').format(widget.publicacion.fecha)}',
                  style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _liked ? Icons.favorite : Icons.favorite_border,
                    color: _liked ? Colors.red : null,
                  ),
                  onPressed: () async {
                    setState(() {
                      _liked = !_liked;
                      if (_liked) {
                        _currentLikes++;
                      } else {
                        _currentLikes = _currentLikes > 0 ? _currentLikes - 1 : 0;
                      }
                    });
                    // Actualizar el estado de "me gusta" en SharedPreferences
                    _prefs.setBool(widget.publicacion.id, _liked);
                    // Actualizar el número de "me gusta" en Firestore
                    FirebaseFirestore.instance.collection('publicaciones').doc(widget.publicacion.id).update({
                      'likes': _currentLikes,
                    });
                  },
                ),
                Text(
                  '$_currentLikes',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildComentarios(context),
            SizedBox(height: 20),
            TextField(
              controller: _comentarioController,
              decoration: InputDecoration(
                hintText: 'Escribe un comentario...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _enviarComentario(context);
              },
              child: Text('Enviar comentario'),
            ),
          ],
        ),
      ),
    );
  }
}
