import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:consulin_mobile_dev/app/modules/signup_psychologst/controllers/signup_psychologst_controller.dart';
import 'package:consulin_mobile_dev/widgets/signup/signup_psychologst/first_step.dart';
import 'package:consulin_mobile_dev/widgets/signup/signup_psychologst/five_step.dart';
import 'package:consulin_mobile_dev/widgets/signup/signup_psychologst/four_step.dart';
import 'package:consulin_mobile_dev/widgets/signup/signup_psychologst/second_step.dart';
import 'package:consulin_mobile_dev/widgets/signup/signup_psychologst/third_step.dart';
import 'package:consulin_mobile_dev/widgets/ui/button_back.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPsychologstView extends GetView<SignupPsychologstController> {
  const SignupPsychologstView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return LinearProgressIndicator(
                  color: primaryColor,
                  value: (controller.step.value + 1) / controller.steps.length,
                  minHeight: 10,
                );
              }),
              ButtonBack(
                onBackPressed: () {
                  if (controller.step.value == 0) {
                    Get.back();
                  } else {
                    controller.step.value -= 1;
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign up",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        "Become part of our platform and connect with individuals seeking mental health support")
                  ],
                ),
              ),
              Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      // Menampilkan step aktif berdasarkan controller.step.value
                      Obx(() {
                        if (controller.step.value == 0) {
                          return FirstStep(controller: controller);
                        } else if (controller.step.value == 1) {
                          return SecondStep(controller: controller);
                        } else if (controller.step.value == 2) {
                          return FiveStep(controller: controller);
                        } else if (controller.step.value == 3) {
                          return ThirdStep(controller: controller);
                        } else if (controller.step.value == 4) {
                          return FourStep(controller: controller);
                        }

                        return const SizedBox();
                      }),
                      const SizedBox(height: 20),
                      Obx(() {
                        bool isLastStep = controller.step.value ==
                            controller.steps.length - 1;

                        return SizedBox(
                          width: width,
                          child: ElevatedButton(
                            onPressed: isLastStep &&
                                    !controller.isLastStepValid()
                                ? null // Disable tombol jika di langkah terakhir dan validasi gagal
                                : controller
                                    .goToNextStep, // Lanjutkan jika validasi berhasil
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isLastStep &&
                                      !controller.isLastStepValid()
                                  ? Colors
                                      .grey // Warna tombol jika di langkah terakhir dan tidak valid
                                  : primaryColor, // Warna tombol jika valid
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                            ),
                            child: Text(
                              isLastStep ? "Sign Up" : "Next",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
