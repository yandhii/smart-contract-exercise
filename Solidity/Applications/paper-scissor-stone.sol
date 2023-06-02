// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;
/* 
    Welcome to the paper-scissor-stone game!
    This game can be played in the following steps:
    1. Use remix or truffle & ganache to deploy the contract. (The following steps are executed on remix.)
    2. Press the "register" button to finish registration of 2 players.
    3. Press the "play" button, enter 0(rock) or 1(paper) or 2(scissor).
    4. When 2 player both already trigger the play() function, do transaction according to game's result (draw = 0, player1 wins = 1, player2 wins = 2). 
       If draw, refund 0.4 ether to both player; if player1/player2 wins, he gets 1 ether.
    5. When game is finished, press the "destroy" button to destroy the contract.

    Some notes are listed as follows:
    1. One player can only register once.
    2. One player can deposit and only deposit 0.5 ether to the contract.
    3. Only when both player registered can play() function be triggered.
    4. Only player1 and player2 can play the game.
    5. One player can only enter 0/1/2 when triggering the play() function.
    6. Only the contract owner can trigger the destroy() function to destroy the contract.
 */
contract PssGame{
    address immutable owner;
    address public player1; // player A iniatialize as address(0x0)
    address public player2; // player B iniatialize as address(0x0)
    bool hasPlayer1MadeChoice = false;
    bool hasPlayer2MadeChoice = false;
    bool hasPlayer1Deposit = false;
    bool hasPlayer2Deposit = false;
    uint player1Choice = 3;  // initialize to a 
    uint player2Choice = 3;
    uint constant stake = 0.5 ether;
    // choice: rock = 0, paper = 1, scissor = 2
    // result: draw = 0, A wins = 1, B wins = 2
    mapping (uint => mapping(uint => uint)) table;
    
    constructor() payable{
        owner = msg.sender;

        // both rock, draw
        table[0][0] = 0;
        // A rock, B paper; B wins
        table[0][1] = 2;
        // A rock, B scissor; A wins
        table[0][2] = 1;
        // A paper, B rock; A wins
        table[1][0] = 1;
        // both paper, draw 
        table[1][1] = 0;
        // A paper, B scissor; B wins
        table[1][2] = 2;
        // A scissor, B rock; B wins
        table[2][0] = 2;
        // A scissor, B paper; A wins
        table[2][1] = 1;
        // both scissor, draw 
        table[2][2] = 0;
    }
    // check if msg.sender is the owner EOA address of contract
    modifier onlyOwner(){
        require(msg.sender == owner,"Only owner!");
        _;
    }

    // check if msg.sender is one of the registered player
    modifier onlyPlayer()
    {
        require(msg.sender == player1 || msg.sender == player2,"Only Player1 and Player2!");
        _;
    }

    // check if there are player not registered
    modifier ifRegistrable(){
        // if player1 or play2 still not registered
        require(player1 == address(0) || player2 == address(0),"Already registered!");
        _;
    }

    // check if 2 player each deposit 0.5 ether to contract
    modifier ifValidDeposit(){
        require(msg.value == stake,"Please deposit and only deposit 0.5 ether!");
        _;
    }

    // check if 2 players are already registered
    modifier alreadyRegistered(){
        require(player1 != address (0x0) && player2 != address(0x0), "Please wait until all players have registered!");
        _;
    }

    // check if player made valid choice
    modifier onlyValidChoice(uint _Choice){
        require(_Choice == 0 || _Choice == 1 || _Choice ==2, "You can only choose 0(rock),1(paper),2(scissor)!");
        _;
    }

    // make sure every player only register once
    modifier onlyRegisterOnce(){
        require((msg.sender != player2 && !hasPlayer1Deposit) || (msg.sender!=player1 && !hasPlayer2Deposit),"One player can't register twice!");
        _;
    }

    // register 2 players if not registered and with 0.5 ether
    function register() public payable ifRegistrable onlyRegisterOnce ifValidDeposit{
        if (player1 == address(0)){
            player1 = msg.sender;
            hasPlayer1Deposit = true;
        }
        // player2 hasn't registered 
        else if (player2 == address(0) && msg.sender != player1){ 
            player2 = msg.sender;
            hasPlayer2Deposit = true;
        }
    }

    // play game
    function play(uint _Choice) public alreadyRegistered onlyPlayer onlyValidChoice(_Choice){
        /* make a choice */
        // if player1 hasn't made choice
        if (msg.sender == player1 && !hasPlayer1MadeChoice){
            hasPlayer1MadeChoice = true;
            player1Choice = _Choice;
        }
        // if player1 hasn't made choice
        else if (msg.sender == player2 && !hasPlayer2MadeChoice){
            hasPlayer2MadeChoice = true;
            player2Choice = _Choice;
        }

        /* evalulate game result when both player made chocie */
        if(hasPlayer1MadeChoice && hasPlayer2MadeChoice){
            // get game result from table
            uint result = table[player1Choice][player2Choice]; 
            // if draw, refund 0.4 ether to each player
            if(result == 0){
                payable(player1).transfer(0.4 ether);
                payable(player2).transfer(0.4 ether);
            }
            // if A wins, send 1 ether to A
            else if(result == 1){
                payable(player1).transfer(1 ether);
            }
            // if B wins, send 1 ether to B
            else{
                payable(player2).transfer(1 ether);
            }
        }
    }
    
}
