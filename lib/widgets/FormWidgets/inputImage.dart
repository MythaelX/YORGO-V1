import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final void Function(File?)? onSaved;
  final String? initialValue;
  const ImageInput({
    Key? key,
    this.onSaved,
    this.initialValue,
  }) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? image = null;

  @override
  Widget build(BuildContext context) {
    if (widget.initialValue != null && image == null) {
      //widget.onSaved!(Image.network(widget.initialValue!));
    }
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                spreadRadius: 5,
                offset: Offset(2, 2),
              )
            ],
          ),
          child: ClipOval(
            child: Material(
              child: Ink.image(
                image: getImage(),
                fit: BoxFit.cover,
                width: 200,
                height: 200,
                child: InkWell(
                  onTap: () => pickImage(),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 4,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 13.0,
                  spreadRadius: 0.5,
                  offset: Offset(1, 1),
                )
              ],
            ),
            child: buildCircle(
              all: 3,
              color: Colors.white,
              child: buildCircle(
                color: Color.fromRGBO(73, 165, 216, 1),
                all: 7,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  ImageProvider<Object> getImage() {
    if (image != null) {
      return FileImage(image!);
    } else if (widget.initialValue != null) {
      return Image.network(widget.initialValue!).image;
    } else {
      return AssetImage(
        "assets/images/jogging.jpg",
      );
    }
  }

  Widget buildCircle({Color? color, double? all, Widget? child}) {
    return ClipOval(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.all(all!),
        child: child,
      ),
    );
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);

    setState(() {
      this.image = imageTemporary;
      widget.onSaved!(imageTemporary);
    });
  }
}
