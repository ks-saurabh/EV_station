import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:log_in/Users%20servies/login.dart';
import 'package:log_in/Maps/mapPage2.dart';

class SimpleMap extends StatefulWidget {
  @override
  _SimpleMapState createState() => _SimpleMapState();
}

class _SimpleMapState extends State<SimpleMap> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kInitialPosition = CameraPosition(
      target: LatLng(23.25941, 77.41225),
      zoom: 4,
      tilt: 0,
      bearing: 0);

  signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const MyLogin(),
      ),
    );
  }
  mapsat() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => SimpleMap1(),
      ),
    );
     
  }

  final List<Marker> myMarker = [];
  final List<Marker> markerList = [
  ];

  @override
  void initState() {
    super.initState();
    myMarker.addAll(markerList);
    packdata();
  }

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('error$error');
    });

    return await Geolocator.getCurrentPosition();
  }

  packdata() {
    getUserLocation().then((value) async {
      // print('My Location');
      // print('${value.latitude} ${value.longitude}');

      myMarker.add(Marker(
          markerId: MarkerId('Second'),
          position: LatLng(value.latitude, value.longitude),
          
          infoWindow: const InfoWindow(
            title: 'Current Location',
            
          )));
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 15,
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {});
    });

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'EV Charging station',
            style:TextStyle(letterSpacing: 1.5, fontSize: 20, color: Colors.red)
          ),
          elevation: 0,
          backgroundColor: Color.fromRGBO(250, 226, 131, 1),
        ),
        
        drawer: Drawer(
          child: ListView(
            children: [
              //  Container(
              //   child: Text(
              //     "MENU",
              //     style: TextStyle(
              //         fontSize: 30,
              //         fontWeight: FontWeight.bold,
              //         color: Color.fromARGB(255, 15, 15, 15)),
              //     ),
              //     color: Color.fromRGBO(250, 226, 131, 1),
              //     padding: EdgeInsets.only(left: 8.0),
                  
                
              //   ),

            Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top, bottom: 20),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 52,
                  child: const Icon(Icons.person_2_rounded),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Pradhumn Jadhav",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 61, 41, 218)),
                ),
                Text(
                  "pradhumnpj1237@gmail.com",
                  style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 61, 41, 218)),
                ),
            ],
            
          )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              TextButton(
                onPressed: () {
                  mapsat();
                },
                child: Text(
                  
                  'Satellite',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.red,
                      fontSize: 23),
                ),
                style: ButtonStyle(),
              ),
              TextButton(
                onPressed: () {
                  signOut();
                },
                child: Text(
                  
                  'Sign Out',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.red,
                      fontSize: 23),
                ),
                style: ButtonStyle(),
              ),
            ],
          ),
          ],
          ),
          backgroundColor: Color.fromRGBO(189, 237, 190, 1),
          
        ),
        
        body: Stack(children: [
          GoogleMap(
            initialCameraPosition: _kInitialPosition,
            mapType: MapType.normal,
            markers: Set<Marker>.of(myMarker),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Container(
                padding: EdgeInsets.fromLTRB(8.0, 700, 0, 0),
                child: FloatingActionButton(
                  
                  onPressed: () {
                    packdata();
                  },
                  child: const Icon(Icons.radio_button_checked_sharp),
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
        ]
      )
      
    );
  }
}