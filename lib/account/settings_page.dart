import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_ui_flutter/account/account_model.dart';
import 'package:todo_app_ui_flutter/account/account_service.dart';
import 'package:todo_app_ui_flutter/store/account_store.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Logger settingsLogger = Logger('SETTINGS_LOGGER');
  Future editAccount() async {
    final accountStore = Provider.of<AccountStore>(context, listen: false);
    final AccountEditModel account = AccountEditModel(
        username: usernameController.text, password: passwordController.text);

    final response = await AccountService.editAccount(account, accountStore.id);
    final decodedResponse = jsonDecode(response);
    settingsLogger.info('account_id: ${decodedResponse['data']['account_id']}');
    return response;
  }

  void _showResetPasswordDialogue(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Reset password'),
            content: const Text('project is underway'),
            actions: [
              ElevatedButton(onPressed: () {}, child: const Text('Close')),
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
              ElevatedButton(onPressed: () {}, child: const Text('Close')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AccountStore>(context, listen: false);
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<AccountStore>(
            builder: (context, value, child) {
              return Column(
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
                          flex: 1,
                          child: const CircleAvatar(
                            radius: 32,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            account.username ?? 'loading...', //replace
                            style: TextStyle(
                              color: Colors.indigo,
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
              );
            },
          )),
    );
  }
}
