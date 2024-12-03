import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_presensiv3/ui/home/pages/tos_privacy_page.dart';

import '../../../core/core.dart';
import '../../../data/datasources/auth_local_datasource.dart';

import '../../auth/pages/login_screen.dart';
import 'notification_page.dart';
import 'user_password_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 76, 175),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        title: const Text('Setting'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18.0),
        children: [
          const Text(
            'Account',
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
          const SpaceHeight(4.0),

          const Divider(
            color: AppColors.stroke,
            height: 2.0,
          ),
          ListTile(
            onTap: () {
              context.push(const UserPasswordPage());
            },
            title: const Text('Password'),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(
            color: AppColors.stroke,
            height: 2.0,
          ),
          ListTile(
            onTap: () {},
            title: const Text('Language'),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(
            color: AppColors.stroke,
            height: 2.0,
          ),
          const SpaceHeight(40.0),
          const Text(
            'Preferences',
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
          const SpaceHeight(4.0),
          ListTile(
            onTap: () {},
            title: const Text('Theme'),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(
            color: AppColors.stroke,
            height: 2.0,
          ),
          ListTile(
            onTap: () {
              context.push(const NotificationPage());
            },
            title: const Text('Notifications'),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(
            color: AppColors.stroke,
            height: 2.0,
          ),
          // ListTile(
          //   onTap: () {},
          //   title: const Text('Attendance'),
          //   trailing: const Icon(Icons.chevron_right),
          // ),
          // const Divider(
          //   color: AppColors.stroke,
          //   height: 2.0,
          // ),
          const SpaceHeight(40.0),
          const Text(
            'Support',
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
          const SpaceHeight(4.0),
          ListTile(
            onTap: () {
              context.push(const ToSandPrivacyPage());
            },
            title: const Text('Terms of Service & Privacy'),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(
            color: AppColors.stroke,
            height: 2.0,
          ),
          ListTile(
            onTap: () {},
            title: const Text('Clear Cache'),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(
            color: AppColors.stroke,
            height: 2.0,
          ),
          //NavigationBottom Widget
          const SpaceHeight(40.0),
          const Text(
            'Logout',
            style: TextStyle(
              color: AppColors.primary,
            ),
          ),
          const SpaceHeight(4.0),
          ListTile(
            onTap: () {
              // context.read<AuthLocalDatasource>().logout();
              // context.push(const LoginScreen());
              // pop up logout
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Apakah anda yakin ingin logout?'),
                    actions: [
                      TextButton(
                        child: const Text('Batal'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Logout'),
                        onPressed: () {
                          // context.read<AuthLocalDatasource>().logout();
                          // context.push(const LoginScreen());
                        },
                      ),
                    ],
                  );
                },
              );
            },
            title: const Text('Logout'),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(
            color: AppColors.stroke,
            height: 2.0,
          ),
        ],
      ),
    );
  }
}