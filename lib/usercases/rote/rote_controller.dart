import 'package:flutter/material.dart';
import 'package:software_quality/scope/view/list_scenery/list_scope_view.dart';
import 'package:software_quality/usercases/rote/rote.dart';

class RoteController with ChangeNotifier {
  static RoteController? _instance;

  RoteController._internal();

  static RoteController get instance {
    _instance ??= RoteController._internal();
    return _instance!;
  }

  Rote _child = Rote(const ListScopeView(), true);

  Rote get child => _child;

  set child(Rote value) {
    _child = value;
    notifyListeners();
  }
}
