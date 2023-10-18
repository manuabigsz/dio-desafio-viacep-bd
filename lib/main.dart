import 'package:desafio_consome_cep/drawer/drawer.dart';
import 'package:desafio_consome_cep/pages/consulta_cep_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await initializeDotenv();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Consumindo CEP + BD',
      home: MyHomePage(title: 'Consumindo CEP + BD'),
      routes: {
        '/consulta_cep': (context) => ConsultaCEP(),
        '/home': (context) => MyHomePage(
              title: 'Home page',
            ),
      },
    ),
  );
}

Future<void> initializeDotenv() async {
  await dotenv.load();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumindo CEP + BD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Consumindo CEP + BD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        toolbarHeight: 200,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0077FF),
                Color(0xFF0033CC),
              ],
              stops: [0, 1],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: mediaQuery.size.width * 0.1,
                bottom: mediaQuery.size.height * 0.1,
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Home',
                        style: TextStyle(
                          fontSize: mediaQuery.textScaleFactor * 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bem vindo (a) !',
              style: TextStyle(
                fontSize: mediaQuery.textScaleFactor * 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Esse projeto consiste na consulta do via cep e inserção dos dados no Back4App',
                style: TextStyle(
                  fontSize: mediaQuery.textScaleFactor * 18,
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.size.height * 0.04,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/consulta_cep');
              },
              child: Text('Ir para Consulta de CEP'),
              style: ElevatedButton.styleFrom(
                elevation: 10.0,
                backgroundColor: Color(0xFF0033CC),
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.size.width * 0.1,
                  vertical: mediaQuery.size.height * 0.02,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
