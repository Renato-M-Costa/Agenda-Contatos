import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/contact_list.dart';
import '../models/contact.dart';

class EditContactForm extends StatefulWidget {
  final Contact contact;

  EditContactForm({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  State<EditContactForm> createState() => _EditContactFormState();
}

class _EditContactFormState extends State<EditContactForm> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  final _nameFocus = FocusNode();
  final _contactFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.contact.name;
    phoneController.text = widget.contact.phone;
  }

  @override
  void dispose() {
    super.dispose();
    _nameFocus.dispose();
    _contactFocus.dispose();
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();
    final newContact = Contact(
      id: widget.contact.id ?? -1,
      name: _formData['name'] as String,
      phone: _formData['phone'] as String,
      isFavorite: widget.contact.isFavorite,
    );
    print(
        "id: ${newContact.id} - name: ${newContact.name} - phone: ${newContact.phone}");

    print("widget.contact.id: ${widget.contact.id}");
    Provider.of<ContactList>(context, listen: false)
        .updateContact(newContact, widget.contact.id!);
    //Navigator.of(context).pop(context);
    Navigator.of(context).pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  hintText: widget.contact.name,
                ),
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_contactFocus);
                },
                //validação
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (_name) {
                  final name = _name ?? null;

                  if (name!.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }

                  if (name.trim().length < 3) {
                    return 'Mínimo 3 letras';
                  }
                  return null;
                },
                //fim validação
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  hintText: widget.contact.phone,
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.phone,
                onFieldSubmitted: (_) => _submitForm(),
                //validação
                onSaved: (phone) => _formData['phone'] = phone ?? '',
                validator: (_phone) {
                  final phone = _phone ?? null;

                  if (phone!.trim().isEmpty) {
                    return 'Telefone é obrigatório';
                  }

                  if (phone.trim().length < 11 || phone.trim().length > 14) {
                    return 'Deve ter entre 11 e 14 dígitos';
                  }
                  return null;
                },
                //fim validação
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/'),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: _submitForm,
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
