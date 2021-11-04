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
    uint public dataVencimento;
    
    
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
    
    function pagarEntrada () public payable returns (uint, string memory) {
        require(msg.value == valorEntrada, "valor entrada incorreto");
        require(saldoAberto == valorTotal, "valor da entrada ja paga");
        comprador = msg.sender;
        saldoAberto = valorTotal - msg.value;
        payable(vendedor).transfer(msg.value);
        dataVencimento = block.timestamp + 31 * 86400;
        return (saldoAberto, "Saldo em Aberto");
        
    }
    
    function pagarParcela (uint _valorParcela) public payable returns (uint, string memory) {
        require(_valorParcela == valorParcela, "valor da parcela incorreto");
        require(saldoAberto <= valorTotal - entrada, "valor da entrada nao foi paga");
        require(comprador == msg.sender, "Pagamento nao efetuado. Somente comprador pode realizar o pagamento");
        require(block.timestamp <= dataVencimento, "parcela vencida");
        dataVencimento = dataVencimento + 31 *86400;
        saldoAberto = saldoAberto - _valorParcela;
        return(saldoAberto, "Saldo em Aberto");
        
        
    }
    
}
