import 'package:get/get.dart';
import 'package:morningmagic/pages/meditation/components/menu.dart';

class AudioMenuController {
  RxInt currentPage = MenuItems.music.obs;

  void changePage(int i) {
    print('menu audio changePage to $i');
    currentPage.value = i;
  }
}
