import 'package:bwatch_front/providers/data_provider.dart';
import 'package:bwatch_front/utils/image_upload.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImagePick extends StatefulWidget {
  final Function notifyParent;

  const ImagePick({Key? key, required this.notifyParent}) : super(key: key);
  @override
  _ImagePickState createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<DataProvider>(context, listen: false);

    void takePhoto(ImageSource source) async {
      final _pickedFile = await _picker.pickImage(source: source);
      ImageUpload(_pickedFile!.path, globalData.token).then((val) {
        widget.notifyParent();
      });
    }

    return Container(
      color: Colors.white,
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile photo',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
              ),
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.photo_library),
                  label: Text('Gallery')),
            ],
          )
        ],
      ),
    );
  }
}
