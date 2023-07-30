import 'package:agenda_contatos/components/contact_item.dart';
import 'package:agenda_contatos/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/contact_list.dart';

class ListOfContacts extends StatefulWidget {
  final bool showFavoriteOnly;

  ListOfContacts({
    required this.showFavoriteOnly,
    Key? key,
  }) : super(key: key);

  @override
  State<ListOfContacts> createState() => _ListOfContactsState();
}

class _ListOfContactsState extends State<ListOfContacts> {
  bool _refreshFavorites(bool favoriteActive) {
    if (favoriteActive) {
      setState(() {
        showFavoriteOnly:
        ContactItem(
          showFavoriteOnly: true,
        );
      });
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContactList>(context);
    final List<Contact> loadedContacts =
        widget.showFavoriteOnly ? provider.favoriteContacts : provider.contacts;

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: loadedContacts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedContacts[i],
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: ContactItem(
            showFavoriteOnly: widget.showFavoriteOnly,
            favoriteOnlySelected: _refreshFavorites,
          ),
        ),
      ),
    );
  }
}
