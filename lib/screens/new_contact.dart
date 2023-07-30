import 'package:agenda_contatos/data/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewContact extends StatefulWidget {
  const NewContact({Key? key}) : super(key: key);

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  final _nameFocus = FocusNode();
  final _contactFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

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

    Provider.of<ContactList>(context, listen: false).addContact(
      name: _formData['name'] as String,
      phone: _formData['phone'] as String,
    );
    Navigator.of(context).pushNamed('/');
  }

  Future _exitDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: const Text('Deseja realmente sair?'),
                content: const Text('Todos os dados serão perdidos'),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar')),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pushNamed('/'),
                      child: const Text('Sair')),
                ]));
  }

  @override
  Widget build(BuildContext context) {
    final availableWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _exitDialog(context),
            icon: const Icon(Icons.close),
          ),
        ],
        title: const Text('Novo Contato'),
      ),
      body: Card(
        elevation: 5,
        margin: const EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_contactFocus);
                  },
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
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  onFieldSubmitted: (_) => _submitForm(),
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
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: availableWidth > 260 ? availableWidth / 3 : 200,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Salvar'),
                      ),
                    ),
                    SizedBox(
                      width: availableWidth / 3,
                      child: ElevatedButton(
                        onPressed: () => _exitDialog(context),
                        child: Text('Cancelar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
