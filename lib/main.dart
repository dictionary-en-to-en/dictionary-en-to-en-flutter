import 'package:dictionary_en_to_en/src/api/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

import 'src/app.dart';
import 'src/audio/audio_controller.dart';
import 'src/dictionary/dictionary_controller.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  final dictionaryController = DictionaryController(
    DictionaryApi(
      Dio(BaseOptions(connectTimeout: 5000)),
      baseUrl: 'https://dictionary-en-to-en-backend.herokuapp.com/api/v1/',
    ),
  );

  final audioController = AudioController(AudioPlayer());

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(
    MyApp(
      settingsController: settingsController,
      dictionaryController: dictionaryController,
      audioController: audioController,
    ),
  );
}
