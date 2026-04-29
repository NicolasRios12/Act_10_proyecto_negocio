class UsuarioModel {
  final String id;
  final String nombre;
  final String usuario;
  final String correo;

  UsuarioModel({
    required this.id,
    required this.nombre,
    required this.usuario,
    required this.correo,
  });

  factory UsuarioModel.fromMap(Map<String, dynamic> map, String id) {
    return UsuarioModel(
      id: id,
      nombre: map['nombre'] ?? '',
      usuario: map['usuario'] ?? '',
      correo: map['correo'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'usuario': usuario,
      'correo': correo,
    };
  }
}
