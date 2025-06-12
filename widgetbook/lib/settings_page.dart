import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SettingsPageMockup)
Widget buildCoolButtonUseCase(BuildContext context) {
  return SettingsPageMockup();
}

class SettingsPageMockup extends StatefulWidget {
  const SettingsPageMockup({super.key});

  @override
  _SettingsPageMockupState createState() => _SettingsPageMockupState();
}

class _SettingsPageMockupState extends State<SettingsPageMockup> {
  final _settingsFormKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Logger settingsLogger = Logger('LOGIN_PAGE');

  void _showResetPasswordDialogue(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Reset password'),
            content: const Text('project is underway'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close')),
            ],
          );
        });
  }

  void _showEditAccountDialogue(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit Account'),
            content: const Text('project is underway'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Settings'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: const CircleAvatar(
                            radius: 96,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          flex: 1,
                          child: Text(
                            'username', //replace
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, bottom: 2.0),
                          child: const Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: Icon(Icons.account_circle),
                            title: const Text('Username'),
                            trailing: const Text('test123'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: Icon(Icons.alternate_email_rounded),
                            title: const Text('Email'),
                            trailing: const Text('test@gmail.com'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: Icon(Icons.phone),
                            title: const Text('Phone'),
                            trailing: const Text('123456.'),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, bottom: 2.0),
                          child: const Text(
                            'Account',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: InkWell(
                            onTap: () {
                              _showEditAccountDialogue(context);
                            },
                            child: ListTile(
                              leading: Icon(Icons.person_add_alt_rounded),
                              title: const Text('edit account'),
                            ),
                          ),
                        ),
                        Card(
                          child: InkWell(
                            onTap: () {
                              _showResetPasswordDialogue(context);
                            },
                            child: ListTile(
                              leading: Icon(Icons.lock),
                              title: const Text('password reset'),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.red.shade400,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(12.0),
                            child: ListTile(
                              title: const Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: const Icon(
                                Icons.exit_to_app_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
