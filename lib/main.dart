import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:pcm_admin/view/sign_in_screen.dart';

const String parse_App_Id = "849F7316D6729D5A14451E65AF5E1";
const String parse_MasterKey = "A2F3518273BE94F51A3BD44CBAC5E";
const String parse_ServerUrl = "https://cup.marketing.dharmatech.in/manage";
const String kParseLiveQueryUrl = "wss://cup.marketing.dharmatech.in";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(
    parse_App_Id,
    parse_ServerUrl,
    masterKey: parse_MasterKey,
    debug: true,
    liveQueryUrl: kParseLiveQueryUrl,
    autoSendSessionId: true,
    coreStore: await CoreStoreSembastImp.getInstance(),
    appName: kIsWeb ? "pcm_admin" : null,
    appVersion: kIsWeb ? "1.0.0+1" : null,
    appPackageName: kIsWeb ? "com.em.pcm_admin" : null,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PCM',
        theme: ThemeData.dark(),
        home: SignIn());
  }
}
