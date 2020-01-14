import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(PMTWebView());

class PMTWebView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PMTWebViewState();
  }
}

class _PMTWebViewState extends State<PMTWebView> {
  checkPermissions() async {
    PermissionStatus pStatus = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    if (pStatus != PermissionStatus.granted) {
      debugPrint("Permission Status: " + pStatus.toString());
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.location]);
      debugPrint("Permission Status2: " + permissions.toString());
    } else {
      debugPrint("Permission Status: " + pStatus.toString());
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      debugPrint("Position: (${position.latitude}, ${position.longitude})");
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff2b7a78),
        ),
        title: 'Twiga PMT App',
        home: WebviewScaffold(
          appBar: PreferredSize(
            child: Container(),
            preferredSize: Size.fromHeight(0.0),
          ),
          url: "https://pmt.nezatech.co.tz/",
          geolocationEnabled: true,
          supportMultipleWindows: true,
          withJavascript: true,
          debuggingEnabled: true,
          resizeToAvoidBottomInset: true,
        ));
  }
}
