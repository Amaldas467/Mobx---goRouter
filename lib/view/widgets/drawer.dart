import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:skincare_app/utilities/color_constants.dart';

class Homescreen_drawer extends StatelessWidget {
  const Homescreen_drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorConstants.buttonColor,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRy5zKoI_m0hy7V1711x_xYAGJesoMf7jwyhQ&s'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User name',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '+91 7012265597',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(IconsaxPlusBold.profile),
            title: Text('Profile'),
            onTap: () {
              //context.pushNamed('/profilepage');
            },
          ),
          ListTile(
            leading: Icon(IconsaxPlusBold.setting_2),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(IconsaxPlusBold.message_2),
            title: Text('Need Help'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(IconsaxPlusBold.people),
            title: Text('Invite & Earn'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(IconsaxPlusBold.wallet),
            title: Text('Link Wallet'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(IconsaxPlusBold.lock_circle),
            title: Text('View Privacy Policy'),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              '  Are You in Ecommerce Buiness ?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(IconsaxPlusBold.additem),
            title: Text('List Your Products'),
            //subtitle: Text(),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(IconsaxPlusBold.logout),
            title: Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
