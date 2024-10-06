import 'package:flutter/material.dart';
import 'package:marvel/helpers/constants.dart';
import 'package:marvel/helpers/get_size.dart';
import 'package:marvel/widgets/icons/custome_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: Size.zero,
            child: Divider(
              color: mainColor.withOpacity(0.1),
            )),
        title: Image.asset(
          "assets/marvelLogo.png",
          width: getSize(context).width * 0.2,
        ),
        centerTitle: true,
        actions: [
          SizedBox(width: 16),
          CustomIconButton(
              asset: "assets/icons/FavoriteButton.png", onTap: () {}),
          SizedBox(width: 8),
          CustomIconButton(asset: "assets/icons/InboxIcon.png", onTap: () {}),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
