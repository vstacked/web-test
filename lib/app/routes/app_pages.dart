import 'package:get/route_manager.dart';
import 'package:test_203version/app/modules/home/home_binding.dart';
import 'package:test_203version/app/modules/home/home_view.dart';
import 'package:test_203version/app/modules/test_page/test_page_view.dart';

class AppPages {
  static const INITIAL = '/';

  static final routes = [
    GetPage(
      name: '/',
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/test-page',
      page: () => TestPageView(),
    ),
  ];
}
