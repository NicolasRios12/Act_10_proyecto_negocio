import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_buttons.dart';
import 'read_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Gestión Dog Club"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ReadScreen(collection: 'cuidadores'),
                ),
              ),
              text: "Gestionar Cuidadores",
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReadScreen(collection: 'usuarios'),
                ),
              ),
              text: "Gestionar Usuarios",
            ),
          ],
        ),
      ),
    );
  }
}
