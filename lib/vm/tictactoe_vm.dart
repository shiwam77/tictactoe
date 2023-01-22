import 'package:flutter/material.dart';
import 'package:tictactoe/constant/app_string.dart';
import 'package:tictactoe/statemanagement/view_model.dart';

class TicTacToeVm extends ViewModel {

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

  void onGridClick(int index) {

      if (oTurn && !xTurn && !yTurn  && gridValue[index] == '') {
        togglePlayer(index,oTurn: false,xTurn: true,yTurn: false, value: '0');
      } else if (!oTurn && xTurn && !yTurn && gridValue[index] == '') {
        togglePlayer(index,oTurn: false,xTurn: false,yTurn: true, value: 'X');
      }else if(!oTurn && !xTurn && yTurn  && gridValue[index] == ''){
        togglePlayer(index,oTurn: true,xTurn: false,yTurn: false, value: 'Y');
      }
      _checkWinner();
   notifyListeners();
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
      filledGrid = 0;
      notifyListeners();
  }

}