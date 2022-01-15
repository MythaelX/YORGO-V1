import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';

class LocalizationInput1 extends StatefulWidget {
  final String? texte;
  final Icon? icon;
  final void Function(String?, double?, double?)? onSaved;
  final String? initialValueText;
  final double? initialValueLat;
  final double? initialValueLong;

  const LocalizationInput1({
    Key? key,
    this.texte,
    this.icon,
    this.onSaved,
    this.initialValueText,
    this.initialValueLat,
    this.initialValueLong,
  }) : super(key: key);

  @override
  State<LocalizationInput1> createState() => _LocalizationInput1State();
}

class _LocalizationInput1State extends State<LocalizationInput1> {
  String? address;
  GeoPoint? localization;

  @override
  Widget build(BuildContext context) {
    if (widget.initialValueText != null) {
      address = widget.initialValueText;
      localization = GeoPoint(
          latitude: widget.initialValueLat!,
          longitude: widget.initialValueLong!);
    }
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
        onSaved: (newValue) => {
              if (localization != null)
                {
                  widget.onSaved!(
                      address, localization!.latitude, localization!.longitude)
                }
            },
        onTap: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          var position = await Navigator.pushNamed(context, "/search");
          if (position != null) {
            localization = position as GeoPoint;
            List<Placemark> placemarks = await placemarkFromCoordinates(
                localization!.latitude, localization!.longitude);
            setState(() => address = placemarks.first.locality.toString());
          }
        });
  }
}

class LocalizationInput2 extends StatefulWidget {
  final String? texte;
  final Icon? icon;
  final void Function(String?, double?, double?)? onSaved;
  final String? Function(String?)? validator;
  final String? initialValueText;
  final double? initialValueLat;
  final double? initialValueLong;

  const LocalizationInput2({
    Key? key,
    this.texte,
    this.icon,
    this.onSaved,
    this.initialValueText,
    this.initialValueLat,
    this.initialValueLong,
    this.validator,
  }) : super(key: key);

  @override
  State<LocalizationInput2> createState() => _LocalizationInput2State();
}

class _LocalizationInput2State extends State<LocalizationInput2> {
  String? address;
  GeoPoint? localization;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget.initialValueText != null) {
      address = widget.initialValueText;
      localization = GeoPoint(
          latitude: widget.initialValueLat!,
          longitude: widget.initialValueLong!);
    }
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: this.widget.texte,
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            icon: widget.icon,
            suffixIcon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
            )),
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        onSaved: (newValue) => {
              if (localization != null)
                {
                  widget.onSaved!(
                      address, localization!.latitude, localization!.longitude)
                }
            },
        validator: widget.validator,
        onTap: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          var position = await Navigator.pushNamed(context, "/search");
          if (position != null) {
            localization = position as GeoPoint;
            List<Placemark> placemarks = await placemarkFromCoordinates(
                localization!.latitude, localization!.longitude);
            setState(() {
              address = placemarks.first.locality.toString();
              controller.text = address!;
            });
          }
        });
  }
}
