import 'package:flutter/material.dart';
import 'package:tictactoe/widget.dart';

import 'constant/app_colors.dart';
import 'constant/app_string.dart';

class TicTacView extends StatefulWidget {
  const TicTacView({Key? key}) : super(key: key);

  @override
  State<TicTacView> createState() => _TicTacViewState();
}

class _TicTacViewState extends State<TicTacView> {

  bool oTurn = true;
  bool xTurn = false;
  bool yTurn = false;
  List<String> gridValue = [];
  int oScore = 0;
  int xScore = 0;
  int yScore = 0;
  int filledGrid = 0;
  String? winner;

  @override
  void initState() {
    for(int i = 0; i < 16; i++){
      gridValue.add('');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 PlayerContainer(turn: oTurn, score: oScore, playerName: AppString.playerO),
                 PlayerContainer(turn: xTurn, score: xScore, playerName: AppString.playerX),
                 PlayerContainer(turn: yTurn, score: yScore, playerName: AppString.playerY)
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                  itemCount: gridValue.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if(winner == null){
                          onGridClick(index);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Text(
                            gridValue[index],
                            style: TextStyle(color: Colors.black, fontSize: 35),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
                child: Column(
                  children: <Widget>[
                   winner != null ?  Text(
                        "Winner is Player $winner",
                        style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor)) : const SizedBox(),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: (){
                        clearBoard();
                      },
                      child: Text(AppString.clearScoreBoard,style: TextStyle(color:  Colors.black,)),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void onGridClick(int index) {
    setState(() {
      if (oTurn && !xTurn && !yTurn  && gridValue[index] == '') {
        togglePlayer(index,oTurn: false,xTurn: true,yTurn: false, value: '0');
      } else if (!oTurn && xTurn && !yTurn && gridValue[index] == '') {
        togglePlayer(index,oTurn: false,xTurn: false,yTurn: true, value: 'X');
      }else if(!oTurn && !xTurn && yTurn  && gridValue[index] == ''){
        togglePlayer(index,oTurn: true,xTurn: false,yTurn: false, value: 'Y');
      }
      _checkWinner();
    });
  }

  void _checkWinner() {

    // Checking rows
    checkRow(0);
    checkRow(1);
    checkRow(4);
    checkRow(5);
    checkRow(8);
    checkRow(9);
    checkRow(12);
    checkRow(13);

    // // Checking Column
    checkColumn(0);
    checkColumn(1);
    checkColumn(2);
    checkColumn(3);
    checkColumn(4);
    checkColumn(5);
    checkColumn(6);
    checkColumn(7);

    // Checking Diagonal
    checkDiagonalByFive(0);
    checkDiagonalByFive(5);
    checkDiagonalByThree(3);
    checkDiagonalByThree(6);
    checkDiagonalByThree(2);
    checkDiagonalByThree(7);
    checkDiagonalByFive(1);
    checkDiagonalByFive(4);
     if (filledGrid == 16) {
          _showDrawDialog();
        }
  }

  void togglePlayer(int index,{required bool oTurn,required bool xTurn,required bool yTurn,required String value}){
    this.oTurn = oTurn;
    this.xTurn = xTurn;
    this.yTurn = yTurn;
    gridValue[index] = value;
    filledGrid++;
  }

  void checkColumn(int num){
    checkMatch(firstIndex: num, secondIndex: num + 4, thirdIndex: num + 8);
  }

  void checkRow(int num){
    checkMatch(firstIndex: num, secondIndex: num + 1, thirdIndex: num + 2);
  }

  void checkDiagonalByThree(int num){
    checkMatch(firstIndex: num, secondIndex: num + 3, thirdIndex: num + 6);
  }

  void checkDiagonalByFive(int num){
    checkMatch(firstIndex: num, secondIndex: num + 5, thirdIndex: num + 10);
  }

  void checkMatch({required int firstIndex,required int secondIndex, required int thirdIndex}){
    if (gridValue[firstIndex] == gridValue[secondIndex] &&
        gridValue[firstIndex] == gridValue[thirdIndex] &&
        gridValue[firstIndex] != '') {
      winner = gridValue[firstIndex];

    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(AppString.draw),
            actions: [
              ElevatedButton(
                child: const Text(AppString.playAgain),
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void clearBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      yScore = 0;
      oTurn = true;
      xTurn = false;
      yTurn = false;
      winner = null;
      for (int i = 0; i < gridValue.length; i++) {
        gridValue[i] = '';
      }
    });
    filledGrid = 0;
  }
}
