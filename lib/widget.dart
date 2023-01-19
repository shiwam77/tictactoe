

import 'package:flutter/material.dart';
import 'package:tictactoe/constant/app_colors.dart';

class PlayerContainer extends StatelessWidget {
  final bool turn;
  final int score;
  final String playerName;
  const PlayerContainer({Key? key,required this.turn,required this.score,required this.playerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 70,
      width: 90,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
         color: turn ? AppColors.primaryColor : AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            playerName,
            style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                color: turn ? AppColors.white : AppColors.textColor),
          ),
          Text(
            score.toString(),
            style: TextStyle(fontSize: 20,color: turn ? AppColors.white : AppColors.textColor),
          ),
        ],
      ),
    );
  }
}
