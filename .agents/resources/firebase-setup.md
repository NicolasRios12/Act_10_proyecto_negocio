# 📚 Guía de Configuración Firebase (Data Focused)

Pasos para configurar Firebase en **Dog Club**.

1. **FlutterFire CLI**:
   - `flutterfire configure`
   - Esto creará `lib/firebase_options.dart`.

2. **Reglas de Firestore**:
   - Accede a Firestore Database > Reglas.
   - Configura para acceso restringido:
   ```javascript
   service cloud.firestore {
     match /databases/{database}/documents {
       match /{document=**} {
         allow read, write: if request.auth != null;
       }
     }
   }
   ```
