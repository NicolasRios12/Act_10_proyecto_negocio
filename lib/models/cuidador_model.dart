class CuidadorModel {
  final String id;
  final String nombre;
  final String direccion;
  final String telefono;
  final String correo;

  CuidadorModel({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.correo,
  });

  factory CuidadorModel.fromMap(Map<String, dynamic> map, String id) {
    return CuidadorModel(
      id: id,
      nombre: map['nombre'] ?? '',
      direccion: map['direccion'] ?? '',
      telefono: map['telefono'] ?? '',
      correo: map['correo'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
      'correo': correo,
    };
  }
}
