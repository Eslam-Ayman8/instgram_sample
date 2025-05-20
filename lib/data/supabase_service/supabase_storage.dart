import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:typed_data';

class Supabase_Storage_Method{

  final supabase = Supabase.instance.client;
  Future<String> uploadImageToStorage(String puid, File filec) async{


    final bytes = await filec.readAsBytes();
    await supabase.storage.from('images').uploadBinary('/$puid.jpg', bytes);
    final String publicUrl = supabase.storage
        .from('images')
        .getPublicUrl('/$puid.jpg');

    return publicUrl;
}

  Future downloadImage(String puid) async{


    final List  file = await supabase.storage.from('images').download(
        puid,
    );

    return file;
  }

}