import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dart_goole_maps_markers/model/infowindow.dart';
import 'package:flutter_dart_goole_maps_markers/widgets/custom_infowindow.dart';
import 'package:provider/provider.dart';
import 'screens/add_parking_place_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => InfoWindowModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      // ignore: missing_return
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('snapshot.hasError');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return HomePage();
        }
        // Otherwise, show something whilst waiting for initialization to complete
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomInfoWindow(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddParkingPlaceScreen())),
          tooltip: 'Add New Parking Place',
          child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
