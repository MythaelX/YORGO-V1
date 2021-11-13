import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
/* ValueNotifier<GeoPoint> notifier = ValueNotifier(null); */

class LocalizationInput1 extends StatefulWidget {
  final String? texte;
  final Icon? icon;
  const LocalizationInput1({
    Key? key,
    this.texte,
    this.icon,
  }) : super(key: key);

  @override
  State<LocalizationInput1> createState() => _LocalizationInput1State();
}

class _LocalizationInput1State extends State<LocalizationInput1> {
  String? address;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
            ),
            hintText: address == null ? this.widget.texte : address,
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            icon: widget.icon,
            suffixIcon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            )),
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.8),
              offset: Offset(3, 1),
              blurRadius: 30,
            ),
          ],
        ),
        onSaved: (newValue) {},
        onTap: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          var position = await Navigator.pushNamed(context, "/search");
          if (position != null) {
            GeoPoint localization = position as GeoPoint;
            List<Placemark> placemarks = await placemarkFromCoordinates(
                localization.latitude, localization.longitude);
            address = placemarks.first.locality.toString();
          }
        });
  }
}
