# 💻 Skill de Código

Estándares para **Dog Club**.

## Arquitectura

- **UI**: Screens y Widgets.
- **Services**: Lógica Firestore (`Cuidadores` y `Usuarios`).
- **Models**: `UsuarioModel`, `CuidadorModel` (inmutables).

## CRUD Operations

- ✅ CREATE - Nuevo registro en Firestore.
- ✅ READ - StreamBuilder de colección (Cuidadores/Usuarios).
- ✅ UPDATE - Actualización dinámica vía formulario.
- ✅ DELETE - Eliminación de registros.

## Reglas

- Archivos en `snake_case`.
- Clases en `PascalCase`.
- Encriptación obligatoria para contraseñas de Usuarios antes de guardar en Firestore.
