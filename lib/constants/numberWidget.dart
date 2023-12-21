import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_numbers/constants/constants.dart';

import '../customWidgets/customAppBar.dart';

class NumberController extends GetxController {
  RxBool isHolding = false.obs;
  RxBool isPrime = false.obs;
}

class NumberWidget extends StatelessWidget {
  final CustomAppBarController appBarController =
      Get.find<CustomAppBarController>();
  final GlobalKey widgetKey = GlobalKey();
  final int number;
  final NumberController controller = NumberController();

  NumberWidget({required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: widgetKey,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
      child: GestureDetector(
        onTapDown: (_) {
          controller.isHolding.value = true;
        },
        onTapUp: (_) {
          controller.isHolding.value = false;
          if (controller.isPrime.value != true) {
            controller.isPrime.value = AppConstants.isPrime(number);
            final RenderBox renderBox =
                widgetKey.currentContext!.findRenderObject() as RenderBox;
            final Offset widgetPosition = renderBox.localToGlobal(Offset.zero);

            if (controller.isPrime.value) {
              AppConstants.showAnimatedText(
                context,
                appBarController,
                widgetPosition,
                Offset(MediaQuery.of(context).size.width * 0.8,
                    MediaQuery.of(context).size.height * 0.05),
              );
            }
          }
        },
        onPanUpdate: (details) {
          final RenderBox renderBox =
              widgetKey.currentContext!.findRenderObject() as RenderBox;
          final Offset localPosition =
              renderBox.globalToLocal(details.globalPosition);

          if (localPosition.dx < 0 ||
              localPosition.dx > renderBox.size.width ||
              localPosition.dy < 0 ||
              localPosition.dy > renderBox.size.height) {
            controller.isHolding.value = false;
          }
        },
        child: Obx(() => Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: controller.isHolding.value
                    ? Colors.white
                    : (controller.isPrime.value
                        ? Colors.green
                        : AppConstants.appbarColor.withOpacity(0.5)),
                border: Border.all(color: Colors.white),
              ),
              child: Center(
                child: Text(
                  number.toString(),
                  style: TextStyle(
                    color: controller.isHolding.value
                        ? Colors.black
                        : Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
