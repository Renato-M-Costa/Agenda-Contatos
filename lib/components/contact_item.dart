//import 'dart:html';

import 'package:agenda_contatos/components/contact_alert.dart';
import 'package:agenda_contatos/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/contact_list.dart';
import 'edit_contact_form.dart';

class ContactItem extends StatefulWidget {
  final bool showFavoriteOnly;
  final void Function(bool)? favoriteOnlySelected;
  bool expanded = false;

  ContactItem({
    Key? key,
    required this.showFavoriteOnly,
    this.favoriteOnlySelected,
  }) : super(key: key);

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  //bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    //print('showFavoriteOnly: ${showFavoriteOnly}');
    final contact = Provider.of<Contact>(context, listen: false);
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.person_rounded,
              ),
            ),
            title: Text(contact.name),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  //_expanded = !_expanded;
                  widget.expanded = !widget.expanded;
                });
              },
            ),
          ),
          if (widget.expanded)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //const SizedBox(width: 1),
                InkWell(
                  onLongPress: () =>
                      ContactAlert().contactAlert(context, contact),
                  child: Ink(
                    //color: Colors.amber,
                    child: SizedBox(
                      width: 230,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(contact.phone),
                        ],
                      ),
                    ),
                  ),
                ),
                Consumer<Contact>(
                  builder: (ctx, contact, _) => IconButton(
                    onPressed: () {
                      contact.toogleFavorite();

                      //Caso esteja exibindo apenas favoritos, atualiza a exibição para remover contato dos favoritos
                      if (widget.showFavoriteOnly == true) {
                        widget.favoriteOnlySelected!(true);
                      }
                    },
                    icon: Icon(contact.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
