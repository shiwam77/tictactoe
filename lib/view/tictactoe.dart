import 'package:flutter/material.dart';
import 'package:tictactoe/constant/app_colors.dart';
import 'package:tictactoe/constant/app_string.dart';
import 'package:tictactoe/statemanagement/mvvm_builder.widget.dart';
import 'package:tictactoe/statemanagement/views/stateless.view.dart';
import 'package:tictactoe/vm/tictactoe_vm.dart';
import 'package:tictactoe/widget.dart';



class TicTacVmView extends StatelessWidget {

  const TicTacVmView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MVVM<TicTacToeVm>(
      view: (context, vmodel) => const TicTacView(),
      viewModel: TicTacToeVm()
    );
  }
}

class TicTacView extends  StatelessView<TicTacToeVm> {
  const TicTacView({Key? key}) : super(key: key);


  @override
  Widget render(BuildContext context, TicTacToeVm vm) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  PlayerContainer(turn: vm.oTurn, score: vm.oScore, playerName: AppString.playerO),
                  PlayerContainer(turn: vm.xTurn, score: vm.xScore, playerName: AppString.playerX),
                  PlayerContainer(turn: vm.yTurn, score: vm.yScore, playerName: AppString.playerY)
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                  itemCount: vm.gridValue.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if(vm.winner == null){
                          vm.onGridClick(index);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Text(
                            vm.gridValue[index],
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
                    vm.winner != null ?  Text(
                        "Winner is Player ${vm.winner}",
                        style: const TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor)) : const SizedBox(),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: (){
                        vm.clearBoard();
                      },
                      child: const Text(AppString.clearScoreBoard,style: TextStyle(color:  Colors.black,)),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}


