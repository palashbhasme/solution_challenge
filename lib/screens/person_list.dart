import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge/models/person_details.dart';
import 'package:solution_challenge/widgets/personal_list_card.dart';

class PersonList extends StatefulWidget {
  const PersonList({Key? key}) : super(key: key);

  @override
  State<PersonList> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  int _selectedIndex = 0;

  List<PersonDetails> DetailsList = [
    PersonDetails(
      imageLink:
          'https://www.shutterstock.com/image-photo/boy-blond-10-years-old-600nw-2044917728.jpg',
      name: 'Rithik',
      age: 7,
      address: 'Sattur Colony, Dharwad',
      height: 109.2,
      weight: 28.0,
    ),
    PersonDetails(
      imageLink:
          'https://t4.ftcdn.net/jpg/01/25/81/99/360_F_125819936_tApB7Z7bviuNjyXbpT0x1UOkOPUHIEh1.jpg',
      name: 'Roshan',
      age: 9,
      address: 'Dharavi, Mumbai',
      height: 88.9,
      weight: 22.0,
    ),
    PersonDetails(
      imageLink:
          'https://static.toiimg.com/photo/99340969.cms',
      name: 'Anya',
      age: 4,
      address: 'Old Police Colony, Cuttack',
      height: 60.2,
      weight: 33.2,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffedffe4),
      body: CustomScrollView(

        slivers: [
          SliverAppBar(
            backgroundColor: Color(0xFFEDFFE4),
            expandedHeight: 100.0,
            // Adjust the height of the SliverAppBar
            floating: false,
            pinned: false,
            centerTitle: false,
            title: Text(
              'Person List',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Inter-VariableFont',
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PersonalListCard(
                    imageLink: DetailsList[index].imageLink,
                    name: DetailsList[index].name,
                    age: DetailsList[index].age,
                    address: DetailsList[index].address,
                    height: DetailsList[index].weight,
                    weight: DetailsList[index].weight
                  ),
                );
              },
              childCount: DetailsList.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {

          _selectedIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'form',
          ),
        ],
        selectedItemColor: Colors.orange,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Add logic to handle tab selection (e.g., navigate to different screens)
    });
  }
}
