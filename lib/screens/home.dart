import 'package:agenda_contatos/components/list_of_contacts.dart';
import 'package:flutter/material.dart';
import 'package:agenda_contatos/components/app_drawer.dart';

import '../components/edit_contact_form.dart';

enum FilterOptions {
  Favorite,
  All,
}

createEditDialog(BuildContext context, String name) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(name),
          content: Column(
            children: [
              Text('Editar $name'),
              Text('Excluir $name'),
            ],
          ),
        );
      });
}

class Home extends StatefulWidget {
  Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _showFavoriteOnly = false;
  carregaContatos(FilterOptions selectedValue) {
    setState(() {
      if (selectedValue == FilterOptions.Favorite) {
        _showFavoriteOnly = true;
      } else {
        _showFavoriteOnly = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Agenda Telefônica"),
      actions: [
        PopupMenuButton(
          itemBuilder: (_) => [
            const PopupMenuItem(
              value: FilterOptions.Favorite,
              child: Text('Favoritos'),
            ),
            const PopupMenuItem(
              value: FilterOptions.All,
              child: Text('Todos'),
            ),
          ],
          onSelected: carregaContatos,
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      drawer: const AppDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: availableHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              //padding: const EdgeInsets.all(8.0),
              child: ListOfContacts(
                showFavoriteOnly: _showFavoriteOnly,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
