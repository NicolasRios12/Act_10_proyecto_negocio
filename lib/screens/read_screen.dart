import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/list_cards.dart';
import '../services/firestore_service.dart';

import 'create_screen.dart';
import 'update_screen.dart';
import 'delete_screen.dart';

class ReadScreen extends StatelessWidget {
  final String collection;
  final FirestoreService _firestoreService = FirestoreService();
  
  ReadScreen({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Lista: $collection"),
      body: StreamBuilder(
        stream: collection == 'cuidadores'
            ? _firestoreService.getCuidadores()
            : _firestoreService.getUsuarios(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          
          var items = snapshot.data as List<dynamic>;
          
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              var itemData = item.toMap();
              
              return ListCard(
                title: item.nombre.isEmpty ? 'Sin nombre' : item.nombre,
                onEdit: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UpdateScreen(
                      collection: collection,
                      docId: item.id,
                      initialData: itemData,
                    ),
                  ),
                ),
                onDelete: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DeleteScreen(
                      collection: collection,
                      docId: item.id,
                      data: itemData,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CreateScreen(collection: collection),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
