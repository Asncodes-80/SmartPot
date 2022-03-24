import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shahjump/config/main.dart';
import 'package:shahjump/enums/load_task_manager.dart';
import 'package:shahjump/firebase/messaging/fcm_manager.dart';
import 'package:shahjump/provider/data_collector_provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    final dataCollector = Provider.of<DataCollector>(context);

    getToken() async {
      FCMManager fcm = FCMManager();
      final devToken = await fcm.deviceToken();
      debugPrint(devToken);
    }

    // getToken();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const Text("This is route of root"),
            Builder(builder: (_) {
              if (dataCollector.loadDataIndicate == LoadTaskManager.loading) {
                return const Text("Loading");
              }

              if (dataCollector.loadDataIndicate == LoadTaskManager.error) {
                return const Text("Error");
              }

              return Text(
                "Humidity ${dataCollector.data["humidity"]}",
                style: const TextStyle(
                  fontFamily: enFontFamily,
                ),
              );
            }),
          ]),
        ),
      ),
    );
  }
}
