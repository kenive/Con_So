import 'package:flutter/material.dart';
import 'package:game_injoy/screens/home_page/home_page.dart';
import 'package:game_injoy/screens/ratings/rating.dart';
import 'package:game_injoy/screens/setting/setting.dart';
import 'package:game_injoy/themes/app_colors.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:provider/provider.dart';

import 'bottom_navigator/bottom_navigator.dart';
part 'home_logic.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pageList = [
    const HomePage(),
    const Rating(),
    const Setting(),
  ];

  late HomeLogic logic;

  ValueNotifier<bool> checkLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    logic = HomeLogic(context: context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd.dispose();
  }

  late BannerAd bannerAd;

  void loadBannerAd() {
    // ca-app-pub-3940256099942544/6300978111
    // ca-app-pub-1767206191292802/7478526344

    BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
          checkLoading.value = true;
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: logic,
      child: Scaffold(
          extendBody: true,
          backgroundColor: AppColors.backgroundColor,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: logic.pageController,
            children: pageList,
          ),
          bottomNavigationBar: Selector<HomeLogic, int>(
            selector: (p0, p1) => p1.initHome,
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: checkLoading,
                    builder: (context, value, child) {
                      if (!value) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.purpleBlueBold,
                            ),
                          ),
                        );
                      }
                      return SizedBox(
                        width: bannerAd.size.width.toDouble(),
                        height: bannerAd.size.height.toDouble(),
                        child: AdWidget(ad: bannerAd),
                      );
                    },
                  ),
                  BottomNavigation(
                    index: value,
                    onTap: logic.updateBottomTab,
                  ),
                ],
              );
            },
          )),
    );
  }
}
