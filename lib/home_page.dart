import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'calendar_page.dart';
import 'gym_location_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String longitudePosition = '';
  String latitudePosition = '';
  var currentAddress = 'My Address';
  PageController _pageController = PageController();
  List<Widget> _screens = [CalendarPage(), GymLocationPage()];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Position currentPosition;

    // Future<Position> _determinePosition() async {
    //   bool serviceEnabled;
    //   LocationPermission permission;
    //
    //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //   if (!serviceEnabled) {
    //     Fluttertoast.showToast(msg: 'Please Keep your location on.');
    //   }
    //
    //   permission = await Geolocator.checkPermission();
    //   if (permission == LocationPermission.denied) {
    //     permission = await Geolocator.requestPermission();
    //
    //     if (permission == LocationPermission.denied) {
    //       Fluttertoast.showToast(msg: 'Location Permission is denied.');
    //     }
    //   }
    //   if (permission == LocationPermission.deniedForever) {
    //     Fluttertoast.showToast(msg: "Permission is denied Forever");
    //   }
    //   Position position = await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.high);
    //   try {
    //     List<Placemark> placemarks = await placemarkFromCoordinates(
    //         position.latitude, position.longitude);
    //     Placemark place = placemarks[0];
    //     setState(
    //       () {
    //         currentPosition = position;
    //         latitudePosition = position.latitude.toString();
    //         longitudePosition = position.longitude.toString();
    //         currentAddress =
    //             '${place.locality}, ${place.postalCode}, ${place.country}';
    //         print(currentAddress);
    //       },
    //     );
    //   } catch (e) {
    //     print('Error: $e');
    //   }
    //   return position;
    // }

    return Scaffold(
      body: Container(
        child: _screens.elementAt(_selectedIndex),
        // controller: _pageController,
        // children: _screens,
        // onPageChanged: _onPageChanged,
        // physics: NeverScrollableScrollPhysics(),
        // children: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: ElevatedButton(
        //       child: const Text("Where am I ?"),
        //       onPressed: () {
        //         _determinePosition();
        //       },
        //     ),
        //   ),
        //   Text(currentAddress),
        //   Text('Longitude = $latitudePosition'),
        //   Text('Longitude = $longitudePosition'),
        // ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: "Location"),
        ],
      ),
    );
  }
}
