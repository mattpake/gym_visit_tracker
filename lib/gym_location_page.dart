import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:gym_visit_tracker/preferences_service.dart';

import 'home_page.dart';
import 'keys.dart';

class GymLocationPage extends StatefulWidget {
  const GymLocationPage({Key? key}) : super(key: key);

  @override
  _GymLocationPageState createState() => _GymLocationPageState();
}

class _GymLocationPageState extends State<GymLocationPage> {
  final _preferencesService = PreferencesService();
  var pickedAddresses = <String>[];
  PickResult? selectedPlace;

  void _populateFields() async {
    final pickedAddressesSaved = await _preferencesService.getPickedAddresses();
    setState(() {
      pickedAddresses = pickedAddressesSaved!;
    });
  }

  @override
  void initState() {
    _populateFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Page'),
      ),
      body: Column(
        children: [
          Container(
            height: pickedAddresses.isEmpty
                ? MediaQuery.of(context).size.height * 0.4
                : MediaQuery.of(context).size.height * 0.6,
            child: ListView.builder(
              itemCount: pickedAddresses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      trailing: Column(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                pickedAddresses.removeAt(index);
                                _savedPickedAddresses();
                                setState(() {});
                              },
                            ),
                          )
                        ],
                      ),
                      title: Text(
                        pickedAddresses[index].toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
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
                Geolocator.requestPermission();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PlacePicker(
                        apiKey: APIKeys.apiKey,
                        hintText: "Find a place ...",
                        searchingText: "Please wait ...",
                        selectText: "Select place",
                        outsideOfPickAreaText: "Place not in area",
                        initialPosition: HomePage.kInitialPosition,
                        useCurrentLocation: true,
                        selectInitialPosition: true,
                        usePinPointingSearch: true,
                        usePlaceDetailSearch: true,
                        onPlacePicked: (result) {
                          if (pickedAddresses.isEmpty ||
                              !pickedAddresses
                                  .contains(result.formattedAddress)) {
                            if (pickedAddresses.length <= 4) {
                              pickedAddresses
                                  .add(result.formattedAddress.toString());
                              _savedPickedAddresses();
                            } else {
                              const snackBar = SnackBar(
                                content: Text(
                                  'The maximum of Gym locations is five.',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.amber,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        // forceSearchOnZoomChanged: true,
                        // automaticallyImplyAppBarLeading: false,
                        // autocompleteLanguage: "ko",
                        // region: 'au',
                        // pickArea: CircleArea(
                        //   center: HomePage.kInitialPosition,
                        //   radius: 300,
                        //   fillColor: Colors.lightGreen.withGreen(255).withAlpha(32),
                        //   strokeColor: Colors.lightGreen.withGreen(255).withAlpha(192),
                        //   strokeWidth: 2,
                        // ),
                        // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                        //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
                        //   return isSearchBarFocused
                        //       ? Container()
                        //       : FloatingCard(
                        //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                        //           leftPosition: 0.0,
                        //           rightPosition: 0.0,
                        //           width: 500,
                        //           borderRadius: BorderRadius.circular(12.0),
                        //           child: state == SearchingState.Searching
                        //               ? Center(child: CircularProgressIndicator())
                        //               : RaisedButton(
                        //                   child: Text("Pick Here"),
                        //                   onPressed: () {
                        //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                        //                     //            this will override default 'Select here' Button.
                        //                     print("do something with [selectedPlace] data");
                        //                     Navigator.of(context).pop();
                        //                   },
                        //                 ),
                        //         );
                        // },
                        // pinBuilder: (context, state) {
                        //   if (state == PinState.Idle) {
                        //     return Icon(Icons.favorite_border);
                        //   } else {
                        //     return Icon(Icons.favorite);
                        //   }
                        // },
                        // introModalWidgetBuilder: (context,  close) {
                        //   return Positioned(
                        //     top: MediaQuery.of(context).size.height * 0.35,
                        //     right: MediaQuery.of(context).size.width * 0.15,
                        //     left: MediaQuery.of(context).size.width * 0.15,
                        //     child: Container(
                        //       width: MediaQuery.of(context).size.width * 0.7,
                        //       child: Material(
                        //         type: MaterialType.canvas,
                        //         color: Theme.of(context).cardColor,
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(12.0),
                        //         ),
                        //         elevation: 4.0,
                        //         child: ClipRRect(
                        //           borderRadius: BorderRadius.circular(12.0),
                        //           child: Container(
                        //             padding: EdgeInsets.all(8.0),
                        //             child: Column(
                        //               children: [
                        //                 SizedBox.fromSize(size: new Size(0, 10)),
                        //                 Text("Please select your preferred address.",
                        //                   style: TextStyle(
                        //                     fontWeight: FontWeight.bold,
                        //                   )
                        //                 ),
                        //                 SizedBox.fromSize(size: new Size(0, 10)),
                        //                 SizedBox.fromSize(
                        //                   size: Size(MediaQuery.of(context).size.width * 0.6, 56), // button width and height
                        //                   child: ClipRRect(
                        //                     borderRadius: BorderRadius.circular(10.0),
                        //                     child: Material(
                        //                       child: InkWell(
                        //                         overlayColor: MaterialStateColor.resolveWith(
                        //                           (states) => Colors.blueAccent
                        //                         ),
                        //                         onTap: close,
                        //                         child: Row(
                        //                           mainAxisAlignment: MainAxisAlignment.center,
                        //                           children: [
                        //                             Icon(Icons.check_sharp, color: Colors.blueAccent),
                        //                             SizedBox.fromSize(size: new Size(10, 0)),
                        //                             Text("OK",
                        //                               style: TextStyle(
                        //                                 color: Colors.blueAccent
                        //                               )
                        //                             )
                        //                           ],
                        //                         )
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 )
                        //               ]
                        //             )
                        //           ),
                        //         ),
                        //       ),
                        //     )
                        //   );
                        // },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _savedPickedAddresses() {
    _preferencesService.savePickedAddresses(pickedAddresses);
  }
}
