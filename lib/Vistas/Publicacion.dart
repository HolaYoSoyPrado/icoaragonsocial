// Publicacion.dart
class Publicacion {
  final String id;
  final String contenido;
  final String correo;
  final DateTime fecha;
  int likes;
  bool likedByCurrentUser; // Agregamos el campo likedByCurrentUser

  Publicacion({
    required this.id,
    required this.contenido,
    required this.correo,
    required this.fecha,
    this.likes = 0,
    this.likedByCurrentUser = false, // Valor predeterminado de likedByCurrentUser es false
  });
}
