pragma solidity 0.8.9;

contract CompraEvenda {
    
    string comprador;
    string vendedor;
    string matricula;
    string cartorio;
    string dataVencimento;
    bool quitado = false;
    uint valorTotal;
    uint valorEntrada;
    uint valorEmAberto;
    uint valorParcela;
    uint qtdParcelas;
    uint porcentagemMulta;
    
    function pagarEntrada(uint _valorPagamento) public returns (uint, string memory){
        valorEntrada = _valorPagamento;
        valorEmAberto = valorTotal - _valorPagamento;
        return (valorEmAberto, "Valor em Aberto");
    }
    
    
    
}
