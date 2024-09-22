//app.dart
import 'package:flutter/material.dart';
import 'Navegador.dart';

class ICOAragonSocial extends StatelessWidget {
  const ICOAragonSocial({super.key});

  // Este widget es la raíz de tu aplicación.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ICOAragonSocial',
      theme: ThemeData(
        // Este es el tema de tu aplicación.
        //
        // PRUEBA ESTO: Intente ejecutar su aplicación con "flutter run". Verás
        // la aplicación tiene una barra de herramientas de color violeta. Luego, sin salir de la aplicación,
        // intenta cambiar el color de semilla en el esquema de colores a continuación a Colors.green
        // y luego invocar "recarga en caliente" (guarde sus cambios o presione el botón "recarga en caliente"
        // botón recargar" en un IDE compatible con Flutter, o presione "r" si usó
        // la línea de comando para iniciar la aplicación).
        //
        // Observe que el contador no se restableció a cero; la aplicación
        // el estado no se pierde durante la recarga. Para restablecer el estado, use hot
        // reiniciar en su lugar.
        //
        // Esto también funciona para el código, no sólo para los valores: la mayoría de los cambios en el código se pueden realizar
        // probado con solo una recarga en caliente.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent
        ),
        useMaterial3: true,
      ),
      home: const Navegador(
      ),
    );
  }
}