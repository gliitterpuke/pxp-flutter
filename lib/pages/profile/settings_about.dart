import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pxp_flutter/pages/ig/components/app_widgets/app_widgets.dart';
import 'package:pxp_flutter/pages/profile/settings_account.dart';
import 'package:pxp_flutter/pages/profile/appbar_widget.dart';
import 'package:pxp_flutter/pages/edit_profile_page.dart';

import 'package:pxp_flutter/widgets/table-cell.dart';
import 'package:share_plus/share_plus.dart';

class AboutSettings extends StatefulWidget {
  const AboutSettings({Key? key}) : super(key: key);

  @override
  _AboutSettingsState createState() => _AboutSettingsState();
}

class _AboutSettingsState extends State<AboutSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "About PxP",
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
            child: Column(
              children: [
                TableCellSettings(
                  title: "Privacy",
                  onTap: () =>
                      Navigator.of(context).push(EditProfilePage.route),
                ),
                TableCellSettings(
                    title: "Terms of Use",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AccountSettings()))),
                TableCellSettings(
                    title: "Code of Conduct",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AccountSettings()))),
                TableCellSettings(
                    title: "Content Guidelines",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AccountSettings()))),
              ],
            ),
          ),
        )));
  }
}

void _onShare(BuildContext context) async {
  final box = context.findRenderObject() as RenderBox?;

  await Share.share('Read and write more at http://pxp.fan',
      subject: 'Check out PxP!',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
}
