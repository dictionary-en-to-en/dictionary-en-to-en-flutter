import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../api/api.dart';

class DictionaryController extends ChangeNotifier {
  final DictionaryApi _api;

  Timer? _timer;
  List<Docs>? _data = [];
  dynamic _error;
  String? _query;

  DictionaryController(this._api);

  List<Docs>? get data => _data;

  String? get error => _error?.toString();

  String get query => _query ?? "";

  void search(String word) {
    _query = word.trim();
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: 500),
      _search,
    );
  }

  void retry() {
    _search();
  }

  void _search() async {
    _data = null;
    _error = null;
    notifyListeners();

    try {
      if (_query == "") {
        _data = [];
        notifyListeners();
        return;
      }

      final response = await _api.search(SearchRequestData(word: _query!));

      if (response.status == true) {
        _data = response.data ?? [];
      } else {
        _error = response.error;
        _error ??= 'Unknown error';
      }
    } on DioError catch (e) {
      if (e.response != null) {
        final response = e.response!.data;
        if (response is SearchResponse) {
          _error = response.error;
        } else {
          _error = e.response;
          _error ??= e.message;
        }
      } else {
        _error = e.message;
      }
      _error ??= 'Unknown error';
    } catch (e) {
      _error = e;
    }

    notifyListeners();
  }
}
