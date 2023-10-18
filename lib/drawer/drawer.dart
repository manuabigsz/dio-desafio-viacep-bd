import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../pages/consulta_cep_page.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0033CC), Color(0xFF1976D2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Text(
                'Projeto consulta CEP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Color(0xFF0033CC), // Az
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.search,
                color: Color(0xFF0033CC), // Az
              ),
              title: const Text('Consulta CEP'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/consulta_cep');
              },
            ),
          ],
        ),
      ),
    );
  }
}
