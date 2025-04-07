import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerr{
  Future<File> uploadImage(String inputSource) async{
    //final picker = ImagePickerr();
    final ImagePicker picker = ImagePicker();
    // final XFile? pickerImage =  await picker.pickImage(
    //   source: inputSource=='cammera'? ImageSource.camera : ImageSource.gallery,
    // );
    final XFile? pickerImage = await picker.pickImage(source: inputSource=='cammera' ? ImageSource.camera : ImageSource.gallery,);
    // final XFile? pickerImage = await picker.pickImage(source: ImageSource.gallery);
    File imageFile = File(pickerImage!.path);
    return imageFile;
  }

}