import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddParkingPlaceScreen extends StatefulWidget {
  @override
  _AddParkingPlaceScreenState createState() => _AddParkingPlaceScreenState();
}

class _AddParkingPlaceScreenState extends State<AddParkingPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Parking Place"),
        ),
        body: Column(
          children: [MyCustomForm()],
        ));
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration:
                InputDecoration(labelText: 'Enter Latitude & Longtitude'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Latitude & Longtitude';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Enter Name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Name';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Enter Description'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Description';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Enter Rating'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter number from 1 to 5';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
