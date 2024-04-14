import 'package:custom_social_share/custom_social_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:snapkit/snapkit.dart';
import 'package:social_share/social_share.dart';

import '../main.dart';

class Share{
  static void share() async{
    String path = '/Users/vivekmaddineni/Library/Developer/CoreSimulator/Devices/42468630-B54E-47EA-B59D-6C1B4C1BB7BD/data/Containers/Data/Application/505A0EAF-598F-499D-92FF-44B25DC7FAA2/tmp/image_picker_867F7E91-AFBB-4024-BBBE-1E7D71608279-70510-0000145B356B1656.jpg';

    CustomSocialShare().to(ShareWith.sms, "Hii from new plugin https://www.google.com with link");

    final List<ShareWith> list = await CustomSocialShare().getInstalledAppsForShare();
    print(list);
  }
}