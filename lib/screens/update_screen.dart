import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_buttons.dart';
import '../services/firestore_service.dart';

class UpdateScreen extends StatefulWidget {
  final String collection;
  final String docId;
  final Map<String, dynamic> initialData;

  const UpdateScreen({
    super.key,
    required this.collection,
    required this.docId,
    required this.initialData,
  });

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _nombre = TextEditingController();
  final _campo2 = TextEditingController(); // Dirección o Usuario
  final _campo3 = TextEditingController(); // Teléfono o Correo
  final _campo4 = TextEditingController(); // Correo (Solo Cuidadores)
  final _pass = TextEditingController(); // Contraseña opcional (Solo Usuarios)

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _nombre.text = widget.initialData['nombre'] ?? '';
    _campo2.text =
        widget.initialData[widget.collection == 'cuidadores'
            ? 'direccion'
            : 'usuario'] ??
        '';
    _campo3.text =
        widget.initialData[widget.collection == 'cuidadores'
            ? 'telefono'
            : 'correo'] ??
        '';
    if (widget.collection == 'cuidadores') {
      _campo4.text = widget.initialData['correo'] ?? '';
    }
  }

  void actualizar() async {
    Map<String, dynamic> data = {
      'nombre': _nombre.text,
      widget.collection == 'cuidadores' ? 'direccion' : 'usuario': _campo2.text,
      widget.collection == 'cuidadores' ? 'telefono' : 'correo': _campo3.text,
    };

    if (widget.collection == 'cuidadores') {
      data['correo'] = _campo4.text;
      await _firestoreService.updateCuidador(widget.docId, data);
    } else {
      await _firestoreService.updateUsuario(widget.docId, data, _pass.text);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Editar Registro"),
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
                decoration: const InputDecoration(
                  labelText: "Nueva Contraseña (Opcional)",
                ),
                obscureText: true,
              ),
            const SizedBox(height: 30),
            CustomButton(
              onPressed: actualizar, 
              text: "Actualizar",
            ),
          ],
        ),
      ),
    );
  }
}
