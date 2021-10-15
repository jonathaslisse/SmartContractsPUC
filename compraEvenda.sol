pragma solidity 0.8.9;

contract CompraEvenda {
    
    string comprador;
    string vendedor;
    string matricula;
    string cartorio;
    string dataVencimento;
    bool quitado = false;
    uint public valorTotal = 10000;
    uint public valorEntrada;
    uint public valorEmAberto;
    uint public valorParcela;
    uint public qtdParcelas;
    uint public porcentagemMulta;
    
    function pagarEntrada(uint _valorPagamento) public returns (uint, string memory){
        valorEntrada = _valorPagamento;
        valorEmAberto = valorTotal - _valorPagamento;
        return (valorEmAberto, "Valor em Aberto");
    }
    
    
    
}
