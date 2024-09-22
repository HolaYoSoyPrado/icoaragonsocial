//main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase Core
import 'app.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegura que los widgets de Flutter estén inicializados

  // Inicializa Firebase
  await Firebase.initializeApp(
    // Aquí debes proporcionar las opciones de inicialización de Firebase, como appId, apiKey, etc.
    // Asegúrate de reemplazar los valores con los de tu propio proyecto
    options: FirebaseOptions(
      appId: "1:1010091783028:android:ffb6002951bfc72f033221",
      apiKey: "AIzaSyDxnI-ovZTJj-Cee_AA-U4ikpseSMpIjBo",
      projectId: "icoaragonsocial",
      messagingSenderId:
          "1010091783028", // Reemplaza con tu ID de remitente de mensajes
    ),
  );

  runApp(const ICOAragonSocial());
}
