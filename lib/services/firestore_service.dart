import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cuidador_model.dart';
import '../models/usuario_model.dart';
import '../utils/crypto_helper.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- MÉTODOS PARA CUIDADORES ---

  Stream<List<CuidadorModel>> getCuidadores() {
    return _db.collection('cuidadores').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => CuidadorModel.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> addCuidador(CuidadorModel cuidador) async {
    await _db.collection('cuidadores').add(cuidador.toMap());
  }

  Future<void> updateCuidador(String id, Map<String, dynamic> data) {
    return _db.collection('cuidadores').doc(id).update(data);
  }

  Future<void> deleteCuidador(String id) {
    return _db.collection('cuidadores').doc(id).delete();
  }

  // --- MÉTODOS PARA USUARIOS ---

  Stream<List<UsuarioModel>> getUsuarios() {
    return _db.collection('usuarios').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => UsuarioModel.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> addUsuario(UsuarioModel usuario, String password) async {
    Map<String, dynamic> data = usuario.toMap();
    if (password.isNotEmpty) {
      data['contraseña'] = encriptarPassword(password);
    }
    await _db.collection('usuarios').add(data);
  }

  Future<void> updateUsuario(String id, Map<String, dynamic> data, String? newPassword) async {
    if (newPassword != null && newPassword.isNotEmpty) {
      data['contraseña'] = encriptarPassword(newPassword);
    }
    return _db.collection('usuarios').doc(id).update(data);
  }

  Future<void> deleteUsuario(String id) {
    return _db.collection('usuarios').doc(id).delete();
  }
}
