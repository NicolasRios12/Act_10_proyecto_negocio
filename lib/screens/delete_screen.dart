import 'package:flutter/material.dart';
import '../widgets/custom_buttons.dart';
import '../services/firestore_service.dart';

class DeleteScreen extends StatelessWidget {
  final String collection;
  final String docId;
  final Map<String, dynamic> data;

  final FirestoreService _firestoreService = FirestoreService();

  DeleteScreen({
    super.key,
    required this.collection,
    required this.docId,
    required this.data,
  });

  void eliminar(BuildContext context) async {
    if (collection == 'cuidadores') {
      await _firestoreService.deleteCuidador(docId);
    } else {
      await _firestoreService.deleteUsuario(docId);
    }
    
    // Cerramos la pantalla de eliminación y volvemos a la lista
    if (context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eliminar Registro"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
              size: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              "¿Estás seguro de que deseas eliminar este registro?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nombre: ${data['nombre'] ?? 'Sin nombre'}"),
                    if (collection == 'cuidadores')
                      Text("Dirección: ${data['direccion'] ?? ''}"),
                    if (collection == 'usuarios')
                      Text("Usuario: ${data['usuario'] ?? ''}"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: () => Navigator.pop(context),
                  backgroundColor: Colors.grey,
                  text: "Cancelar",
                ),
                CustomButton(
                  onPressed: () => eliminar(context),
                  backgroundColor: Colors.red,
                  text: "Eliminar",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
