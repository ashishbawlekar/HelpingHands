// import 'dart:io';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
class UserImageCrop extends StatelessWidget {
  final _cropKey = GlobalKey<CropState>();
  File img;
  UserImageCrop({Key key, this.img}): super(key : key);
  @override
  Widget build(BuildContext context) {
    return 
        Column(
          children: <Widget>[
            Container(
              width: 500.0,
              height : 500.0,
              color: Colors.black,
              padding: const EdgeInsets.all(20.0),
              child: Crop(
              key: _cropKey,
              image: Image.file(img).image,
              aspectRatio: 1.0,
              ),
              ),

        
        Container(
          width: 100.0,
          height: 100.0,
          child: RaisedButton(
            child: Text("Crop"),
            onPressed: () async {
              final crop = _cropKey.currentState;
              ImageCrop.sampleImage(
                file: img,
                preferredHeight: (1024 / crop.scale).round(),
                preferredWidth: (4096 / crop.scale).round(),
              ).then((sampledFile){
                ImageCrop.cropImage(
                file: sampledFile,
                area: crop.area
              ).then((croppedImage){
                  Navigator.pop(context, croppedImage);
              });
            });
           }
          )
        )
          ],
        );
  }

}
