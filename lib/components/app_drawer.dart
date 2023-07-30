import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  Widget _createItem(IconData icon, String label, Function() onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Menu'),
          ),
          const Divider(),
          _createItem(
            Icons.screen_share,
            'Principal',
            () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          _createItem(
            Icons.screen_share,
            'Novo Contato',
            () => Navigator.of(context).pushReplacementNamed('/new_contact'),
          ),
          const Divider(),
          _createItem(
            Icons.settings,
            'Sobre',
            () => Navigator.of(context).pushReplacementNamed('/sobre'),
          ),
        ],
      ),
    );
  }
}
