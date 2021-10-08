pragma solidity 0.8.9;

contract CartaoDeVacinacao {
    //autor: Flavio
    string constant public nome = "Jonathas Lisse";
    string public dose = "1 dose";
    string public unid = "Unidade XPTO";
    uint public cnes = 2545501;
    string public date = "07-10-2021";
    uint private lote = 10254662;
    string constant private fabricante = "Pfizer";
    string public medico = "Dr XPTO - CRM 55555-SP";
    bool public imunizado = false;
    address private wallet = 0x8E660aC844045D9Acd96f7583D7f24DB8079e243;
}
