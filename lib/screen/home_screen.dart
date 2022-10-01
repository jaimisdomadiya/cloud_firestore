import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_demo/controller/home_controller.dart';
import 'package:firebase_demo/modal/user_modal.dart';
import 'package:firebase_demo/widegt/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Data"),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.userModalList.length,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        return userInfoWidget(controller.userModalList[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 10);
                      },
                    ),
                  ),
                  controller.isPaginationLoading.value
                      ? const ProgressIndicatorWidget()
                      : const SizedBox.shrink(),
                ],
              ),
      ),
    );
  }

  Widget userInfoWidget(UserModal userModal) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.3)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: userModal.profileImage ?? '',
              height: 40,
              width: 40,
              memCacheHeight: 150,
              memCacheWidth: 200,
              fit: BoxFit.cover,
              placeholder: (BuildContext context, String url) {
                return Container(
                  color: Colors.grey,
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userModal.firstName ?? '',
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                userModal.lastName ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const Spacer(),
          Text(userModal.securityNumber.toString()),
        ],
      ),
    );
  }
}
