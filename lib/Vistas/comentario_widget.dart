// comentario_widget.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'comentario.dart';

class ComentarioWidget extends StatefulWidget {
  final Comentario comentario;

  const ComentarioWidget({Key? key, required this.comentario}) : super(key: key);

  @override
  _ComentarioWidgetState createState() => _ComentarioWidgetState();
}

class _ComentarioWidgetState extends State<ComentarioWidget> {
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
              widget.comentario.contenido,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Comentado por: ${widget.comentario.correo}',
                  style: TextStyle(fontSize: 8, fontStyle: FontStyle.italic),
                ),
                Text(
                  'Fecha: ${DateFormat('dd/MM/yyyy').format(widget.comentario.fecha)}',
                  style: TextStyle(fontSize: 8, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
