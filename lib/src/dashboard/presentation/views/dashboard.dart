import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:klontong_app/core/common/widgets/button_background.dart';
import 'package:provider/provider.dart';
import '../../../../core/common/widgets/custom_container_clipper.dart';
import '../../../../core/res/colours.dart';
import '../../../../core/res/media_res.dart';
import '../providers/dashboard_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardController>().getScreens();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardController>(builder: (_, controller, __) {
      return Scaffold(
        body: IndexedStack(
          index: controller.currentIndex,
          children: controller.screens,
        ),
        bottomNavigationBar: Stack(
          children: [
            ClipPath(
              clipper: CustomContainerClipper(
                topLeftOffset: 50,
                topRightOffset: 25,
                bottomLeftOffset: 0,
                bottomRightOffset: 0,
              ),
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  gradient: Colours.darkLinearGradient(opacity: 1),
                ),
                child: Container(
                  color: Colours.primaryColour.withOpacity(0.4),
                ),
              ),
            ),
            SafeArea(
              child: SizedBox(
                height: 120,
                child: BottomNavigationBar(
                  currentIndex: controller.currentIndex,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  onTap: controller.changeIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: ButtonBackround(
                        width: 80,
                        height: 60,
                        active: controller.currentIndex == 0,
                        child: Container(
                          padding: controller.currentIndex == 0
                              ? const EdgeInsets.only(
                                  top: 16, left: 8, right: 8, bottom: 16)
                              : const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                          child: SvgPicture.asset(
                            controller.currentIndex == 0
                                ? MediaRes.homeBold
                                : MediaRes.homeLight,
                            height: 32,
                            width: 32,
                            colorFilter: ColorFilter.mode(
                              controller.currentIndex == 0
                                  ? Colors.white
                                  : Colours.primaryDisabledColour,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: ButtonBackround(
                        width: 80,
                        height: 60,
                        active: controller.currentIndex == 1,
                        child: Container(
                          padding: controller.currentIndex == 1
                              ? const EdgeInsets.only(
                                  top: 16, left: 8, right: 8, bottom: 16)
                              : const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                          child: SvgPicture.asset(
                            controller.currentIndex == 1
                                ? MediaRes.addBold
                                : MediaRes.addLight,
                            height: 32,
                            width: 32,
                            colorFilter: ColorFilter.mode(
                              controller.currentIndex == 1
                                  ? Colors.white
                                  : Colours.primaryDisabledColour,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      label: 'Add',
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
