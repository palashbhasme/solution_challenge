import 'package:flutter/material.dart';
import 'package:solution_challenge/common/global_variables.dart';
import 'package:solution_challenge/models/child_model.dart';
import 'package:solution_challenge/widgets/person_list_card.dart';

import '../widgets/custom_search_bar.dart';

class PersonList extends StatefulWidget {
  const PersonList({Key? key}) : super(key: key);

  @override
  State<PersonList> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  int _currentIndex = 0;

  List<ChildModel> DetailsList = [
    ChildModel(
      image:
          'https://www.shutterstock.com/image-photo/boy-blond-10-years-old-600nw-2044917728.jpg',
      name: 'Rithik',
      address: 'Sattur Colony, Dharwad',
      height: 109.2,
      weight: 28.0,
      bloodType: 'O+ve',
      gender: 'Male',
      isMalnourished: 'Yes',
      dob: "7",
      allergies: 'none'
    ),
    ChildModel(
      image:
          'https://t4.ftcdn.net/jpg/01/25/81/99/360_F_125819936_tApB7Z7bviuNjyXbpT0x1UOkOPUHIEh1.jpg',
      name: 'Roshan',
      address: 'Dharavi, Mumbai',
      height: 88.9,
      weight: 22.0,
      bloodType: 'O+ve',
      gender: 'Male',
      isMalnourished: 'Yes',
      dob: '7',
        allergies: 'none'

    ),
    ChildModel(
      image: 'https://static.toiimg.com/photo/99340969.cms',
      name: 'Anya',
      address: 'Old Police Colony, Cuttack',
      height: 60.2,
      weight: 33.2,
      bloodType: 'O+ve',
      gender: 'Male',
      isMalnourished: 'Yes',
      dob: '7',
        allergies: 'none'

    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffedffe4),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Color(0xFFEDFFE4),
            expandedHeight: 100.0,
            floating: false,
            pinned: false,
            centerTitle: false,
            title: Padding(
              padding: EdgeInsets.only(top: 32.0),
              child: Text(
                'Person List',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter-VariableFont',
                ),
              ),
            ),
          ),
          SliverAppBar(
            collapsedHeight: 60,
            backgroundColor: Color(0xFFEDFFE4),
            expandedHeight: 80.0,
            pinned: true,
            title: CustomSearchBar(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PersonalListCard(
                      imageLink: DetailsList[index].image,
                      name: DetailsList[index].name,
                      age: DetailsList[index].dob,
                      address: DetailsList[index].address,
                      height: DetailsList[index].height,
                      weight: DetailsList[index].weight),
                );
              },
              childCount: DetailsList.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 80,
            ),
          )
        ],
      ),
    );
  }
}
