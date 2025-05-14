import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:instgram_sample/screen/addpost_text.dart';

import '../util/imagepicker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final List<Widget> _mediaList = [];
  final List<File> path = [];
  File? _file;
  int currentPage = 0;
  int? lastPage;
  @override
  _fetchNewMedia() async {
    lastPage = currentPage;
    File _imagefilee = await ImagePickerr().uploadImage('gallery');
    setState(() {
      _file = _imagefilee;
    });
    // if (ps.isAuth) {
    //   List<AssetPathEntity> album =
    //   await PhotoManager.getAssetPathList(type: RequestType.image);
    //   List<AssetEntity> media =
    //   await album[0].getAssetListPaged(page: currentPage, size: 60);
    //
    //   for (var asset in media) {
    //     if (asset.type == AssetType.image) {
    //       final file = await asset.file;
    //       if (file != null) {
    //         path.add(File(file.path));
    //         _file = path[0];
    //       }
    //     }
    //   }
    //   List<Widget> temp = [];
    //   for (var asset in media) {
    //     temp.add(
    //       FutureBuilder(
    //         future: asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.done)
    //             return Container(
    //               child: Stack(
    //                 children: [
    //                   Positioned.fill(
    //                     child: Image.memory(
    //                       snapshot.data!,
    //                       fit: BoxFit.cover,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             );
    //
    //           return Container();
    //         },
    //       ),
    //     );
    //   }
    //   setState(() {
    //     _mediaList.addAll(temp);
    //     currentPage++;
    //   });
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchNewMedia();
  }

  int indexx = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'New Post',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddPostTextScreen(_file!),
                  ));
                },
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async{
                    File _imagefilee = await ImagePickerr().uploadImage('gallery');
                    setState(() {
                      _file = _imagefilee; //?????????????????????????
                    });
                  },
                child: SizedBox(

                      width: 375.h,
                      height: 375.h,
                      child: _file == null
                          ? Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.image, size: 100, color: Colors.grey),
                      )
                          : Image.file(_file!, fit: BoxFit.cover),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 40.h,
                  color: Colors.white,
                  child: Row(
                    children: [
                      SizedBox(width: 10.w),
                      Text(
                        'Recent',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: _mediaList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          indexx = index;
                          _file = path[index];
                        });
                      },
                      child: _mediaList[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}