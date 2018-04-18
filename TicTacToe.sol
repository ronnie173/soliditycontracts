pragma solidity ^0.4.19;

contract TicTacToe {
    uint constant public gameCost = 0.1 ether;

    uint8 public boardSize = 3;
    uint8 movesCounter;
    bool gameActive;
    address[3][3] board;
    address public player1;
    address public player2;
    uint balanceToWithdrawPlayer1;
    uint balanceToWithdrawPlayer2;
    address activePLayer;
    event PlayerJoined(address player,string message);
    event NextPlayer(address player,string message);
    event GameOverWithWin(address winner);
    event GameOverWithDraw();
    event PayoutSuccess(address receiver, uint amountInWei);
constructor()
public
payable{
player1 = msg.sender;
require(msg.value == gameCost);
}

function joinGame()
public
payable{
assert(player2 == address(0));
gameActive = true;

require(msg.value == gameCost);
player2 = msg.sender;
emit PlayerJoined(player2,"PLayer Has Jooined");
if(block.number % 2 == 0){
activePLayer = player2;
}else{
activePLayer = player1;
}


emit NextPlayer(activePLayer,"Player has joined");
}

function getBoard()
public
view returns(address[3][3]){
return board;
}

function setWinner(address player)
private {
gameActive = false;
//emit an event
emit GameOverWithWin(player);
//transfer money to the winner
if (player.send(this.balance) != true){
if(player == player1){
balanceToWithdrawPlayer1 = this.balance;
}else{
balanceToWithdrawPlayer2 = this.balance;

}
} else{
PayoutSuccess(player,this.balance);
}

}

function withdrawWin()
public {
if(msg.sender == player1){
require(balanceToWithdrawPlayer1 > 0);
balanceToWithdrawPlayer1 = 0;
player1.transfer(balanceToWithdrawPlayer1);
PayoutSuccess(player1,balanceToWithdrawPlayer1);
}else{
require(balanceToWithdrawPlayer2 > 0);
balanceToWithdrawPlayer2 = 0;
player1.transfer(balanceToWithdrawPlayer2);
PayoutSuccess(player2,balanceToWithdrawPlayer2);

}
}

function setDraw()
private {
gameActive = false;
emit GameOverWithDraw();
}

function setStone(uint8 x, uint8 y)
public {

require(board[x][y] == address(0));
assert(gameActive);
assert(x < boardSize);
assert(y < boardSize);
require(msg.sender == activePLayer);
board[x][y] = msg.sender;
movesCounter++;
for(uint8 i =0; i < boardSize; i++){
if(board[i][y] != activePLayer){
break;
}
//win
if(i == boardSize -1){
//winner
setWinner(activePLayer);
return;
}
}

for(i =0; i < boardSize; i++){
if(board[x][i] != activePLayer){
break;
}
//win
if(i == boardSize -1){
//winner
setWinner(activePLayer);
return;

}
}
//check to see if diagonal
if(x == y){
for(i =0; i < boardSize; i++){
if(board[i][i] != activePLayer){
break;
}
//win
if(i == boardSize -1){
//winner
setWinner(activePLayer);
return;
}
}
}

//check for anti diagonal
if((x+y) == boardSize -1){
for(i =0; i < boardSize; i++){
if(board[i][(boardSize -1) -i] != activePLayer){
break;
}
//win
if(i == boardSize -1){
//winner
setWinner(activePLayer);
return;
}
}
}

//draw
if(movesCounter == (boardSize**2)){
//a draw
setDraw();
return;
}

if(activePLayer == player1){
activePLayer = player2;
}else{
activePLayer = player1;
}
}

}
