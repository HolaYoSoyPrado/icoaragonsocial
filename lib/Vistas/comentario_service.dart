// comentario_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'comentario.dart';

class ComentarioService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> agregarComentario(String publicacionId, Comentario comentario) async {
    try {
      await _firestore.collection('publicaciones').doc(publicacionId).collection('comentarios').add({
        'contenido': comentario.contenido,
        'correo': comentario.correo,
        'fecha': comentario.fecha,
      });
    } catch (e) {
      print('Error al agregar comentario: $e');
    }
  }
}

