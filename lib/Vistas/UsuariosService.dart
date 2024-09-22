//Usuarios.Service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UsuariosService {
  final CollectionReference<Map<String, dynamic>> _usuariosCollection =
  FirebaseFirestore.instance.collection('usuarios');

  Future<List<Map<String, dynamic>>> getUsuarios() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _usuariosCollection.get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error al obtener usuarios: $e');
      return [];
    }
  }
}
