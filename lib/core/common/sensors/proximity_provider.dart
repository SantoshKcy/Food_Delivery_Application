import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

class ProximityProvider extends ChangeNotifier {
  bool _isNear = false;
  bool get isNear => _isNear;

  late StreamSubscription<bool> _proximitySubscription; // ✅ Use StreamSubscription<bool>

  ProximityProvider() {
    _listenToProximity();
  }

  void _listenToProximity() {
    _proximitySubscription = ProximitySensor.events.map((int event) => event > 0).listen((bool isNear) {
      _isNear = isNear;
      notifyListeners(); // ✅ Notify UI to update
    });
  }

  @override
  void dispose() {
    _proximitySubscription.cancel();
    super.dispose();
  }
}
