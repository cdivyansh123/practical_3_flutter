// Importing packages
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// Entry point of the application
void main() {
  // Runs the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MaterialApp widget provides various UI components to the app
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // Sets MyHomePage widget as the app's home page
      home: const MyHomePage(title: 'API data'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  // Creates a State object for this StatefulWidget
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // variable to store the API response data
  var jsonlist;

  @override
  void initState() {
    // Calls the getData method when the state is initialized
    getData();
    super.initState();
  }

  // Fetches data from the API
  void getData() async {
    try {
      // Sends a GET request to the API
      var response = await Dio().get('https://reqres.in/api/users?page=1');
      if (response.statusCode == 200) {
        // If the request is successful, update the UI with the response data
        setState(() {
          jsonlist = response.data['data'] as List;
        });
      } else {
        // Prints the error status code if the request fails
        print(response.statusCode);
      }
    } catch (e) {
      // Prints any exceptions that occur during the request
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Builds the UI
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            // Generates a Card with a CircleAvatar and text for each item in the API
            return Card(
              shadowColor: Colors.blue.shade900,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(jsonlist[index]['avatar']),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Column(
                      children: [
                        Text("ID: ${jsonlist[index]['id']}"),
                        Text("First Name: ${jsonlist[index]['first_name']}"),
                        Text("Last Name: ${jsonlist[index]['last_name']}"),
                        Text("Email: ${jsonlist[index]['email']}"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: jsonlist == null ? 0 : jsonlist.length,
        ));
  }
}
