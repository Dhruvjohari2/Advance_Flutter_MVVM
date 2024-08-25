import 'package:advance_mvvm/app/app_prefs.dart';
import 'package:advance_mvvm/app/di.dart';
import 'package:advance_mvvm/data/data_source/local_data_source.dart';
import 'package:advance_mvvm/presentation/resources/routes_manager.dart';
import 'package:advance_mvvm/presentation/resources/strings_manager.dart';
import 'package:advance_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title: Text(AppStrings.changeLanguage, style: Theme.of(context).textTheme.headlineLarge),
          leading: Icon(Icons.language),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        ListTile(
          title: Text(AppStrings.contactUs, style: Theme.of(context).textTheme.headlineLarge),
          leading: Icon(Icons.contact_page),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        ListTile(
          title: Text(AppStrings.inviteYourFriends, style: Theme.of(context).textTheme.headlineLarge),
          leading: Icon(Icons.share),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            _inviteFriends();
          },
        ),
        ListTile(
          title: Text(
            AppStrings.logout,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          leading: Icon(Icons.logout),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            _logout();
          },
        ),
      ],
    );
  }

  void _changeLanguage() {}
  void _contactUs() {}
  void _inviteFriends() {}
  void _logout() {
    _appPreferences.logout();
    _localDataSource.clearCache();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
