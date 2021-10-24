pragma solidity 0.8.9;

contract CompraEvenda {
    
    address public comprador;
    address public vendedor;
    
    string public matricula;
    string public cartorio;
    
    
    string dataVencimento;
    
    bool quitado = false;
    
    uint public valorTotal;
    uint public valorEntrada;
    
    uint public valorParcela;
    uint public qtdParcelas;
    uint public porcentagemMulta;
    uint public ValorMulta;
    
    uint public valorEmAberto;
    
    constructor(
        uint _valorTotal,
        uint _valorEntrada,
        uint _qtdParcelas,
        string memory _matricula,
        string memory _cartorio
        
        ) 
        {
        valorTotal = _valorTotal;
        valorEntrada = _valorEntrada;
        qtdParcelas = _qtdParcelas;
        matricula = _matricula;
        cartorio = _cartorio;
        valorEmAberto = valorTotal;
        valorParcela = funcaovalorDaParcela();
        
    }
    
    
    
    function pagarEntrada(uint _valorPagamento) public returns (uint, string memory){
        valorEntrada = _valorPagamento;
        valorEmAberto = valorTotal - _valorPagamento;
        return(valorEmAberto, "Valor em Aberto");
    }
    
    function pagarParcela(uint _valorParcela) public returns (uint, string memory) {
        valorEmAberto = valorEmAberto - _valorParcela;
        return(valorEmAberto, "valor em Aberto");
        
            }
    
    function funcaovalorDaParcela() public view returns (uint) {
        uint calculoValorParcela = (valorTotal-valorEntrada)/qtdParcelas;
        return(calculoValorParcela);
        
    }
    
    function porcentagemDaMulta(uint _valorDaMulta) public view returns (uint, string memory) {
        _valorDaMulta = porcentagemMulta*valorTotal/100;
        return(_valorDaMulta, "valor da multa");
        
    }
    
    
    
}
