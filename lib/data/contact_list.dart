import 'package:agenda_contatos/data/dummy_data.dart';
import 'package:agenda_contatos/models/contact.dart';
import 'package:flutter/material.dart';

class ContactList with ChangeNotifier {
  List<Contact> _contacts = dummyContacts;
  bool _showFavoriteOnly = false;

  List<Contact> get contacts {
    List<Contact> copyContacts = [..._contacts];
    copyContacts.sort(((a, b) => a.name.compareTo(b.name)));

    return copyContacts;
  }

  List<Contact> get favoriteContacts =>
      _contacts.where((ctto) => ctto.isFavorite).toList();

  void addContactOld(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void addContact({required String name, required String phone}) {
    final newContact = Contact(
      id: _contacts.length + 1,
      name: name,
      phone: phone,
    );
    _contacts.add(newContact);
    notifyListeners();
  }

  void removeContact(Contact contact) {
    _contacts.remove(contact);
    notifyListeners();
  }

  bool updateContact(Contact contact, int id) {
    int index = _contacts.indexWhere((c) => c.id == contact.id);

    if (index >= 0) {
      _contacts[index] = contact;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
