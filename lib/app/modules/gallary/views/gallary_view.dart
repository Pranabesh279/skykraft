import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:super_cupertino_navigation_bar/models/super_appbar.model.dart';
import 'package:super_cupertino_navigation_bar/models/super_large_title.model.dart';
import 'package:super_cupertino_navigation_bar/models/super_search_bar.model.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../controllers/gallary_controller.dart';

class GallaryView extends GetView<GallaryController> {
  const GallaryView({super.key});
  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      appBar: SuperAppBar(
        backgroundColor: kBackgroundColor,
        height: 0,
        searchBar: SuperSearchBar(enabled: false),
        largeTitle: SuperLargeTitle(
            largeTitle: 'Gallary',
            textStyle: const TextStyle(
              color: kTitleColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            actions: []),
      ),
      body: Obx(() =>
          // grid view builder
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: controller.posts.value.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(controller.posts.value[index].url!),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          )),
    );
  }
}
