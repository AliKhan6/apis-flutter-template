import 'package:antonx_flutter_template/core/models/other_models/onboarding.dart';
import 'package:antonx_flutter_template/core/services/local_storage_service.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../../core/others/base_view_model.dart';
import '../../../locator.dart';

class OnboardingViewModel extends BaseViewModel {
  final Logger log = Logger();
  late int currentPageIndex;
  late List<Onboarding> onboardingList;
  final _localStorageService = locator<LocalStorageService>();
  late CarouselController controller = CarouselController();

  OnboardingViewModel(this.currentPageIndex, this.onboardingList);

  updatePage(index) {
    log.d('@updateOnboarding page with index: $index');
    this.currentPageIndex = index;
    _localStorageService.onBoardingPageCount = index;
    notifyListeners();
  }
}
