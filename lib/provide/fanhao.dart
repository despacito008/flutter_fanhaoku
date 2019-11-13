import 'package:flutter/cupertino.dart';

class Fanhao with ChangeNotifier {
  int value = 0;
  bool isOpened=false;
  setShow(){
    isOpened=true;
    notifyListeners();
  }
  setHide(){
    isOpened=false;
    notifyListeners();
  }
  add() {
    value++;
    notifyListeners();
  }

  subtract() {
    value--;
    notifyListeners();
  }
}
