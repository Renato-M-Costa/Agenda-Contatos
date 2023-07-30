//import 'dart:html';

import 'package:agenda_contatos/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/contact_list.dart';
import 'edit_contact_form.dart';

class ContactItem extends StatelessWidget {
  //TESTE
  final bool showFavoriteOnly;
  final void Function(bool)? favoriteOnlySelected;

  ContactItem({
    Key? key,
    required this.showFavoriteOnly,
    this.favoriteOnlySelected,
  }) : super(key: key);

  Future _contactAlert(BuildContext context, Contact contact) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Contato'),
        content: const Text('Deseja alterar ou excluir o contato?'),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar')),
          ElevatedButton(
              //onPressed: () => Navigator.pop(context),
              onPressed: () => _openEditContactForm(context, contact),
              child: const Text('Alterar')),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Exculir ${contact.name}?'),
                    content:
                        Text('Tem certeza que seja excluir ${contact.name}?'),
                    actions: [
                      ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar')),
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<ContactList>(context, listen: false)
                              .removeContact(contact);
                          //Navigator.pop(context);
                          Navigator.of(context).pushReplacementNamed('/');
                        },
                        child: const Text('Excluir'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Excluir')),
        ],
      ),
    );
  }

  _openEditContactForm(BuildContext context, Contact contact) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return EditContactForm(contact: contact);
        });
  }

  @override
  Widget build(BuildContext context) {
    //print('showFavoriteOnly: ${showFavoriteOnly}');
    final contact = Provider.of<Contact>(context, listen: false);
    return Card(
      //color: Colors.grey,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onLongPress: () => _contactAlert(context, contact),
              child: Ink(
                //color: Colors.amber,
                child: SizedBox(
                  width: 280,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Text('${contact.id.toString()} - ${contact.name}'),
                      Text(contact.name),
                      Text(contact.phone),
                    ],
                  ),
                ),
              ),
            ),
            //SizedBox(width: 10),
            Consumer<Contact>(
              builder: (ctx, contact, _) => IconButton(
                onPressed: () {
                  contact.toogleFavorite();
                  //Caso esteja exibindo apenas favoritos, atualiza a exibição para remover contato dos favoritos
                  if (showFavoriteOnly == true) {
                    favoriteOnlySelected!(true);
                  }
                  // else if (showFavoriteOnly == false) {
                  //   print('showFavoriteOnly é false');
                  // } else {
                  //   print('showFavoriteOnly é null');
                  // }
                },
                icon: Icon(contact.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
