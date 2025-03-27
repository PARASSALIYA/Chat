import 'package:chat_app/model/user.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/wallpaper_controller.dart';

class WallpaperPage extends StatefulWidget {
  const WallpaperPage({super.key});

  @override
  State<WallpaperPage> createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  UserModel user = Get.arguments;
  var wallpaperController = Get.put(WallpaperController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallpaper"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 5 / 6,
          ),
          itemCount: wallpaperController.images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                wallpaperController.changeImage(index, user);

                Get.back();
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(
                      wallpaperController.images[index],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
