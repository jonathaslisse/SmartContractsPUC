// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

contract MeuContrato {
    
    address public vendedor;
    uint public preco;
    uint internal balance;
    
    constructor(uint _preco) {
        vendedor = msg.sender;
        preco = _preco;
        // preco = _preco * 1 ether;
    }
    
    function pagar() public payable {
        require(msg.value == preco, "Valor incorreto");
        payable(vendedor).transfer(msg.value);
    }
    
    function depositar() public payable {
        require(msg.value == preco, "Valor incorreto");
        balance = balance + msg.value;
    }
    
    function sacar(uint value) public {
        require(value <= balance, "Saldo Insuficiente");
        balance = balance - value;
        payable(vendedor).transfer(value);
    }
    
    function verSaldo() public view returns(uint){
        return(balance);
    }
    
}
