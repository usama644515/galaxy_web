import 'package:flutter/material.dart';

import '../../responsive.dart';


class TeamCard extends StatelessWidget {
  final teamMember;

  TeamCard({required this.teamMember});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: Responsive.isMobile(context)
                          ? 115: 150,
            height:Responsive.isMobile(context)
                          ? 115: 150,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(teamMember.get('img')),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            teamMember.get('name'),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            teamMember.get('role'),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}