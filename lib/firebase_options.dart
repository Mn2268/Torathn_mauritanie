import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Web not supported yet.');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError('This platform is not supported.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHrREyakH2GvBLxOmgDzqJgvzpeKQabS4',
    appId: '1:577738206634:android:fa686970f2e61a348bcfd3',
    messagingSenderId: '577738206634',
    projectId: 'tourathne-2e423-46802',
    storageBucket: 'tourathne-2e423-46802.firebasestorage.app',
  );
}
