//Muhammad Noman Riaz
//21-Arid-4010

import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class SetWallPaper extends StatefulWidget {
  const SetWallPaper({super.key, required this.imageLink});
  final String imageLink;

  @override
  State<SetWallPaper> createState() => _SetWallPaperState();
}

class _SetWallPaperState extends State<SetWallPaper> {
  Future<void> setBackGroundWallPaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageLink);
    final Future<bool> result =
        WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(
                  widget.imageLink,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setBackGroundWallPaper();
              },
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.pink,
                child: const Center(
                  child: Text(
                    'Set As WallPaper',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
