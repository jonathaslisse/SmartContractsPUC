pragma solidity 0.8.9;


contract CompraVendaVeiculos {
    
    
    address public comprador;
    address public vendedor;
    
    string public placaVeiculo;
    uint public renavanVeiculo;
    string public estadoVeiculo;
    
    bool quitado = false;
    
    uint public valorTotal;
    uint public valorEntrada;
    uint public valorFinanciado;
    uint public valorParcela;
    uint public qtdParcelas;
    
    uint public juros;
    uint public correcaoMonetaria;
    uint public porcentagemMulta;
    uint public valorMulta;
    uint public jurosMora;
    
    uint public saldoAberto;
    
    
    constructor(
        
        uint _valorTotal,
        uint _valorEntrada,
        uint _qtdParcelas,
        uint _juros,
        uint _correcaoMonetaria,
        
        string memory _placaVeiculo,
        uint _renavanVeiculo,
        string memory _estadoVeiculo,
        
        address _vendedor
        
        )
        {
    
        vendedor = _vendedor;
        valorTotal = _valorTotal;
        valorEntrada = _valorEntrada;
        qtdParcelas = _qtdParcelas;
        placaVeiculo = _placaVeiculo;
        renavanVeiculo = _renavanVeiculo;
        estadoVeiculo = _estadoVeiculo;
        juros = _juros;
        correcaoMonetaria = _correcaoMonetaria;
        saldoAberto = valorTotal;
        valorFinanciado = valorTotal - valorEntrada;
        
        
        //valorParcela = funcaoValorDaParcela;
        
        }
        
    // essa função abaixo calcula juros e correcao com base no valor valorFinanciado
    
   // function calculoValorDaParcela() public returns (uint, string memory) {
   //   uint jurosMensais = valorFinanciado * juros/100;
   //   uint correcaoMonetariaMensal = valorFinanciado * correcaoMonetaria / 100;
  //    valorParcela = (valorFinanciado / qtdParcelas) + jurosMensais + correcaoMonetariaMensal;
  //   return(valorParcela, "Valor Mensal da Parcela");
 //}
    
    
    function calculoValorDaParcela() public returns (uint, string memory) {
        uint jurosMensais = saldoAberto * juros / 100;
        uint correcaoMonetariaMensal = saldoAberto * correcaoMonetaria / 100;
        valorParcela = (valorFinanciado/qtdParcelas) + jurosMensais + correcaoMonetariaMensal;
        return(valorParcela, "Valor Mensal da Parcela");
        
    }   
    
    function pagarEntrada (uint _valorPagamento) public returns (uint, string memory) {
        valorEntrada = _valorPagamento;
        saldoAberto = valorTotal - _valorPagamento;
        return (saldoAberto, "Saldo em Aberto");
        
    }
    
    function pagarParcela (uint _valorParcela) public returns (uint, string memory) {
        saldoAberto = saldoAberto - _valorParcela;
        return(saldoAberto, "Saldo em Aberto");
        
        
    }
    
}


