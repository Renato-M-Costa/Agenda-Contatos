import 'package:flutter/material.dart';
import 'package:agenda_contatos/screens/sobre.dart';
import 'package:agenda_contatos/screens/new_contact.dart';
import 'package:agenda_contatos/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'data/contact_list.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContactList(),
      child: MaterialApp(
        title: 'Agenda',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        //home: Home(),
        routes: {
          AppRoutes.HOME: (ctx) => Home(),
          AppRoutes.NEW_CONTACT: (ctx) => NewContact(),
          AppRoutes.SOBRE: (ctx) => Sobre(),
        },
      ),
    );
  }
}
