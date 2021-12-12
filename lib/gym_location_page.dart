import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class GymLocationPage extends StatefulWidget {
  const GymLocationPage({Key? key}) : super(key: key);

  @override
  _GymLocationPageState createState() => _GymLocationPageState();
}

class _GymLocationPageState extends State<GymLocationPage> {
  List<String>? gymAdresses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Page'),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            child: ListView.builder(
              itemCount: (gymAdresses == null) ? 1 : gymAdresses!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            gymAdresses == null
                                ? "You don't have any Gym Location"
                                : gymAdresses![index],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text("Add Gym Location"),
              onPressed: () {
                // showPlacePicker();
              },
            ),
          ),
        ],
      ),
    );
  }
  //
  // void showPlacePicker() async {
  //   LocationResult result = await Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => PlacePicker("AIzaSyAaGmvhnCBPs-7HD7iyh5gSuX_BAQkWQos")));
  //
  //   // Handle the result in your way
  //   print(result);
  // }

}
