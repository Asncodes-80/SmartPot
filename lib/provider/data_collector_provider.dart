import 'package:flutter/foundation.dart';
import 'package:shahjump/api/api_access.dart';
import 'package:shahjump/config/main.dart';
import 'package:shahjump/enums/load_task_manager.dart';

class DataCollector with ChangeNotifier {
  LoadTaskManager _loadTaskManager = LoadTaskManager.init;
  dynamic data = {};

  DataCollector() {
    _getData();
  }

  LoadTaskManager get loadDataIndicate => _loadTaskManager;
  Future get fetchData => _getData();

  Future<void> _getData() async {
    ApiAccess api = ApiAccess(hardToken);
    _loadTaskManager = LoadTaskManager.loading;

    try {
      // Get data from API, That will return {"humidity": 12}
      Future.delayed(const Duration(seconds: 1));
      final rawData =
          await api.requestHandler(uri: "/getData", method: "GET", data: {});
      data = rawData;

      _loadTaskManager = LoadTaskManager.loaded;
    } catch (e) {
      // print("Data pot catch with: $e");
      _loadTaskManager = LoadTaskManager.error;
    }

    notifyListeners();
  }
}
