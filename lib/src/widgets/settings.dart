import 'package:flutter/material.dart';
import 'package:office_sports_android/src/modals/profile_modal.dart';
import '../shared/constants.dart';
import '../models/settings_option.dart';
import '../models/player_model.dart';

class Settings extends StatelessWidget {
  const Settings({super.key, required this.player});
  final Player player;

  @override
  Widget build(context) {
    final List<SettingsOption> options = [
      SettingsOption(Icons.star_outline, 'Season results'),
      SettingsOption(
        Icons.person_outline,
        'Update profile',
        ProfileModal(player),
      ),
      SettingsOption(Icons.checklist_outlined, 'Preferences'),
      SettingsOption(Icons.info_outline, 'About'),
      SettingsOption(Icons.logout, 'Sign out'),
    ];

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, right: 15.0),
        child: IconButton(
          icon: const Icon(
            Icons.settings,
            size: 30.0,
            color: Constants.secondaryTextColor,
          ),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Container(
                    height: 300,
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (_, int index) {
                        return ListTile(
                          onTap: () {
                            showModalBottomSheet<void>(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return options[index].setting!;
                                });
                          },
                          leading: Icon(
                            options[index].icon,
                            size: 30.0,
                            color: Constants.secondaryTextColor,
                          ),
                          title: Text(
                            options[index].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Constants.secondaryTextColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}