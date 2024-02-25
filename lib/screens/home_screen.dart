import 'package:flutter/material.dart';
import 'package:solution_challenge/common/global_variables.dart';
import 'package:solution_challenge/screens/chat_bot.dart';
import 'package:solution_challenge/screens/main_navigation_bar.dart';
import 'package:solution_challenge/screens/map_screen.dart';
import 'package:solution_challenge/widgets/custom_rectangular_card.dart';
import 'package:solution_challenge/widgets/custom_square_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 110,
              backgroundColor: GlobalVariables.secondary_color,
              expandedHeight: 80.0,
              title: Padding(
                padding: const EdgeInsets.fromLTRB(1.0, 18.0, 8.0, 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo.png'),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                              radius: 23,
                              backgroundImage: AssetImage(
                                  'assets/images/stock_profile.jpg')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverAppBar(
              toolbarHeight: 100,
              backgroundColor: GlobalVariables.secondary_color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 1.0, 8.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcom back,',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Meow 👋",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamedAndRemoveUntil(
                                context, MainNavigationBar.routeName, (route) => false);
                          },
                          child: CustomSquareCard(

                            image: 'assets/images/track_health.png',
                            text: 'Track Health',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CustomRectangularCard(
                          image: 'assets/images/know_your_food.png',
                          text: 'Know your Food',
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, ChatBot.routeName, (route) => false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CustomRectangularCard(
                            image: 'assets/images/nutriAI.png',
                            text: 'Nutri.AI',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamedAndRemoveUntil(context, MapScreen.routeName, (route) => false,);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CustomSquareCard(
                            image: 'assets/images/g8.png',
                            text: 'Find Care Near You',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
