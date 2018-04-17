pragma solidity ^0.4.19;

contract TicTacToe {
    uint8 public boardSize = 3;
    uint8 movesCounter;
    bool gameActive;
    address[3][3] board;
    address public player1;
    address public player2;
    address activePlayer;

constructor()
public {
player1 = msg.sender;
}

function joinGame()
public {
assert(player2 == address(0));
gameActive = true;
player2 = msg.sender;
activePLyer = player2;
}

function getBoard()
public
view returns (address[3][3]){
return board;
}

function setWinner(address player)
private {
gameActive = false;
//emit an event
//transfer money to the winner
}

function setDraw()
private {
gameActive = false;
}

function setStone(uint8 x, uint8 y)
public {
require(board[x][y] == address(0));
assert(gameActive);
assert(x < boardSize);
assert(y < boardSize);
require(msg.sender == activePLyer);
board[x][y] = msg.sender;
movesCounter++;
for(uint8 i = 0; i < boardSize; i++){
if (board[i][y] != activePLyer){
break;
}
//win
if (i == boardSize - 1){
//winner
setWinner(activePLyer);
}
}

for (i = 0; i < boardSize; i++){
if (board[x][i] != activePLyer){
break;
}
//win
if (i == boardSize - 1){
//winner
setWinner(activePLyer);
}
}
//check to see if diagonal
if (x == y){
for (i = 0; i < boardSize; i++){
if (board[i][i] != activePLyer){
break;
}
//win
if (i == boardSize - 1){
//winner
setWinner(activePLyer);

}
}
}

//check for anti diagonal
if ((x + y) == boardSize -1){
for (i = 0; i < boardSize; i++){
if (board[i][(boardSize -1) - i] != activePLyer){
break;
}
//win
if (i == boardSize - 1){
//winner
setWinner(activePLyer);
}
}
}

//draw
if (movesCounter == (boardSize ** 2)){
//a draw
setDraw();
}

if (activePLyer == player1){
activePLyer = player2;
}else{
activePLyer = player1;
}
}

}
