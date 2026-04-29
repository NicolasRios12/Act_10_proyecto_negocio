import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_buttons.dart';
import '../services/firestore_service.dart';
import '../models/cuidador_model.dart';
import '../models/usuario_model.dart';

class CreateScreen extends StatefulWidget {
  final String collection;

  const CreateScreen({super.key, required this.collection});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _nombre = TextEditingController();
  final _campo2 = TextEditingController(); // Dirección o Usuario
  final _campo3 = TextEditingController(); // Teléfono o Correo
  final _campo4 = TextEditingController(); // Correo (Solo Cuidadores)
  final _pass = TextEditingController(); // Contraseña (Solo Usuarios)

  final FirestoreService _firestoreService = FirestoreService();

  void guardar() async {
    if (widget.collection == 'cuidadores') {
      var cuidador = CuidadorModel(
        id: '',
        nombre: _nombre.text,
        direccion: _campo2.text,
        telefono: _campo3.text,
        correo: _campo4.text,
      );
      await _firestoreService.addCuidador(cuidador);
    } else {
      var usuario = UsuarioModel(
        id: '',
        nombre: _nombre.text,
        usuario: _campo2.text,
        correo: _campo3.text,
      );
      await _firestoreService.addUsuario(usuario, _pass.text);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Crear Registro"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombre,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: _campo2,
              decoration: InputDecoration(
                labelText: widget.collection == 'cuidadores'
                    ? "Dirección"
                    : "Usuario",
              ),
            ),
            TextField(
              controller: _campo3,
              decoration: InputDecoration(
                labelText: widget.collection == 'cuidadores'
                    ? "Teléfono"
                    : "Correo",
              ),
            ),
            if (widget.collection == 'cuidadores')
              TextField(
                controller: _campo4,
                decoration: const InputDecoration(labelText: "Correo"),
              ),
            if (widget.collection == 'usuarios')
              TextField(
                controller: _pass,
                decoration: const InputDecoration(labelText: "Contraseña"),
                obscureText: true,
              ),
            const SizedBox(height: 30),
            CustomButton(
              onPressed: guardar,
              text: "Guardar",
            ),
          ],
        ),
      ),
    );
  }
}
