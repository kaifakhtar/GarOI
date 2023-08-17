 import 'package:firebase_analytics/firebase_analytics.dart';
 
 import 'package:firebase_analytics/observer.dart';
 
  void trackButtonClickedEvent(String tappedItemName,String eventName) async {
      final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    await analytics.logEvent(
      name: 'tapped',
      parameters: <String, dynamic>{
        'button_name': tappedItemName,
      },
    );
  }