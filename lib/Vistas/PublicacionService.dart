// PublicacionService.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Publicacion.dart';

class PublicacionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> agregarPublicacion(Publicacion publicacion) async {
    try {
      await _firestore.collection('publicaciones').add({
        'contenido': publicacion.contenido,
        'autor': publicacion.correo,
        'fecha': publicacion.fecha,
      });
    } catch (e) {
      print('Error al agregar publicación: $e');
    }
  }
}