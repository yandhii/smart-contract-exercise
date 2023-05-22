// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract todoList{
    struct Todo{
        string text;
        bool completed;
    }

    Todo[] public Todos;

    function initialize() public{
        Todos.push(Todo(
            {text:"Hi",
            completed:false}
        ));
    }

    error indexOutofBoundError(uint index, uint arrLen);

    // 2945 gas
    function get1(uint _index) public view returns (Todo memory){
        require(_index < Todos.length, "Array index out of bound");
        return Todos[_index];
    }

    // 2991 gas
    function get2(uint _index) public view returns (Todo memory){
        if(_index >= Todos.length){
            revert indexOutofBoundError(_index, Todos.length);
        }
        return Todos[_index];
    }

    // 34604 gas
    function set1(uint _index,string calldata _text, bool _completed) external{
        Todos[_index].text = _text;
        Todos[_index].completed = _completed;
    }
    // 34327 gas
     function set2(uint _index,string calldata _text, bool _completed) external{
        Todo storage todo = Todos[_index];
        todo.text = _text;
        todo.completed = _completed;
    }
}
