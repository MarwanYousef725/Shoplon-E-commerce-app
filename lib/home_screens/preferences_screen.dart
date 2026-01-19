import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cookie preferences')),
      body: ListView(
        children: [
          Preferences(
            selecte: true,
            title: 'Analytics',
            subtitle:
                'Analytics cookies help us improve our application by collecting and reporting information on how you use it. They collect information in a way that does not directly identify anyone.',
          ),
          Divider(),
          Preferences(
            selecte: false,
            title: 'Personalization',
            subtitle:
                'Personalization cookies collect information about your use of this application in order to display contact and experience that are relevant to you.',
          ),
          Divider(),
          Preferences(
            selecte: false,
            title: 'Marketing',
            subtitle:
                'Marketing cookies collect information about your use of this and other apps to enable displaying ads and other marketing that is more relevant to you.',
          ),
          Divider(),
          Preferences(
            selecte: true,
            title: 'Social media cookies',
            subtitle:
                'These cookies are set by a range of social media services that we have added to the site to enable you to share our content with your friends and networks',
          ),
        ],
      ),
    );
  }
}

class Preferences extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selecte;

  const Preferences({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selecte,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SwitchListTile(
        value: selecte,
        onChanged: (value) {},
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}
