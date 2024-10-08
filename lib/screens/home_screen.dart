import 'package:flutter/material.dart';
import 'package:marvel/helpers/constants.dart';
import 'package:marvel/helpers/get_size.dart';
import 'package:marvel/providers/movies_providers.dart';
import 'package:marvel/widgets/cards/movie_card.dart';
import 'package:marvel/widgets/icons/custome_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<MoviesProviders>(context, listen: false).fetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProviders>(builder: (context, movieConsumer, _) {
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
        body: AnimatedSwitcher(
            duration: animatedDuration,
            child: movieConsumer.isFaild
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_outlined,
                        size: getSize(context).width * 0.5,
                        color: mainColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("somthing Went wrong")
                    ],
                  )
                : GridView.builder(
                    padding: EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: movieConsumer.isLoading
                        ? 6
                        : movieConsumer.movies.length,
                    itemBuilder: (context, index) => movieConsumer.isLoading
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Shimmer.fromColors(
                                baseColor: Colors.black12,
                                highlightColor: Colors.white38,
                                child: Container(
                                  color: Colors.white,
                                  height: double.infinity,
                                  width: double.infinity,
                                )),
                          )
                        : MovieCardStack(
                            moviesModel: movieConsumer.movies[index]))),
      );
    });
  }
}
