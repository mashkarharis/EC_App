import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  final dynamic data;
  const MapScreen(Key? key, this.data) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String name = "";
  String nic = "";
  String mac = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = "";
    nic = "";
    mac = "";
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data);
    List<Marker> markers = <Marker>[];
    if (widget.data.length > 0) {
      markers.add(Marker(
        point: LatLng(widget.data[0]['homelat'], widget.data[0]['homelon']),
        builder: (ctx) => Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          color: Color.fromARGB(255, 8, 90, 11),
          child: IconButton(
            icon: const Icon(
              Icons.home,
              size: 15,
              color: Colors.white,
            ),
            onPressed: () => {},
          ),
        ),
      ));
    }
    widget.data.forEach((elder) => {
          markers.add(Marker(
            point: LatLng(elder['lat'], elder['lon']),
            builder: (ctx) => Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              color: Colors.red,
              child: IconButton(
                icon: const Icon(
                  Icons.person,
                  size: 15,
                  color: Colors.white,
                ),
                onPressed: () => {
                  setState((() => {
                        name = elder['name'],
                        nic = elder['nic'],
                        mac = elder['mac']
                      }))
                },
              ),
            ),
          )),
        });
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(7.29, 80.63),
                zoom: 8.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: markers,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 100,
            color: Color.fromARGB(255, 3, 45, 80),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Name : " + name,
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              Text("NIC : " + nic,
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              Text("MAC : " + mac,
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ]),
          ),
        ],
      ),
    );
  }
}
