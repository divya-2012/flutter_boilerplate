import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart'; // keep this from your starter pack

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FCM Token Viewer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FcmTokenScreen(),
    );
  }
}

class FcmTokenScreen extends StatefulWidget {
  const FcmTokenScreen({super.key});

  @override
  State<FcmTokenScreen> createState() => _FcmTokenScreenState();
}

class _FcmTokenScreenState extends State<FcmTokenScreen> {
  String? _fcmToken;

  @override
  void initState() {
    super.initState();
    _loadFcmToken();
  }

  Future<void> _loadFcmToken() async {
    await FirebaseMessaging.instance.requestPermission();
    final token = await FirebaseMessaging.instance.getToken();
    setState(() {
      _fcmToken = token;
    });
    print("🔥 FCM Token: $_fcmToken");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FCM Token")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SelectableText(
            _fcmToken ?? 'Fetching FCM token...',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
