import 'package:flutter/material.dart';
import 'package:intellensense/Pages/PartyFilterscreen.dart';

import '../../TRS Screens/MLAsTrsScreen.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color(0xffd2dfff),
        child: ListView(children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xffd2dfff),
            ),
            child: Image.asset(
                'assets/icons/IntelliSense-Logo-Finall_01022023_A.gif'),
          ),
          ListTile(
            leading: Image(
              image: AssetImage('assets/icons/Home-Iocn.png'),
              height: 25,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ExpansionTile(
              title: Text('Political Science'),
              leading: Image.asset(
                'assets/icons/Candidature Analysis.png',
                height: 25,
              ),
              childrenPadding: EdgeInsets.only(left: 15),
              children: [
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/icons/Candidature Analysis.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Candidature Analysis'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PartyFilterScreen(),
                        ));
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/icons/location.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Constituency Analysis'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/icons/communicationChannel.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Communication channel'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/icons/Form.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Electoral Analysis'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/icons/faceEmotiondxp.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Emotional AI'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/icons/compareIconB.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Command Center'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/icons/ScoreCard.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Score Cards'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/icons/whatsapp.png',
                    ),
                    height: 25,
                  ),
                  title: Text('WhatsApp'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/icons/sentiAnalysis.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Sentiment Analysis'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/icons/comparative.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Configurator'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ]),
          ListTile(
            leading: Image(
              image: AssetImage('assets/icons/iTransform ETL.png'),
              height: 25,
            ),
            title: const Text('Data Integration'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Image(
              image: AssetImage(
                'assets/icons/Data-Analytics-icon.png',
              ),
              height: 25,
            ),
            title: const Text('Data Analytics'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ]));
  }
}
