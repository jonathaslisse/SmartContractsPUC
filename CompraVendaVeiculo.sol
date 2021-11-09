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
    
    event PagamentoEntrada(address _comprador, uint _valorPagamento);
    event PagamentoParcela(address _comprador, uint _valorPagamento);
    
    
    constructor(
        
        uint _valorTotal,
        uint _valorEntrada,
        uint _qtdParcelas,
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
        juros = 1;
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
    
    function pagarEntrada (uint _valorEntrada) public payable returns (uint, string memory) {
        require(msg.value == valorEntrada, "valor entrada incorreto");
        require(saldoAberto == valorTotal, "valor da entrada ja paga");
        comprador = msg.sender;
        saldoAberto = valorTotal - msg.value;
        payable(vendedor).transfer(msg.value);
        dataVencimento = block.timestamp + 31 * 86400;
        emit PagamentoEntrada(comprador, msg.value);
        return (saldoAberto, "Saldo em Aberto");
        
    }
    
    function pagarParcela (uint _valorParcela) public payable returns (uint, string memory) {
        require(_valorParcela == valorParcela, "valor da parcela incorreto");
        require(saldoAberto <= (valorTotal - valorEntrada), "valor da entrada nao foi paga");
        require(comprador == msg.sender, "Pagamento nao efetuado. Somente comprador pode realizar o pagamento");
        require(block.timestamp <= dataVencimento, "parcela vencida");
        dataVencimento = dataVencimento + 31 *86400;
        saldoAberto = saldoAberto - _valorParcela;
        
        if (saldoAberto == 0){
            quitado = true;
        } else {
            quitado = false;
        }
     
        emit PagamentoParcela(comprador, msg.value);
        return(saldoAberto, "Saldo em Aberto");
     
    }
    
    
    function pagamentoMulta (uint) public view returns (uint){
        require(comprador == msg.sender || vendedor == msg.sender, "Apenas o comprador ou vendedor podem executar essa funcao");
        uint multa;
        if (block.timestamp > dataVencimento + 31 * 86400 && dataVencimento != 0){
            multa = porcentagemMulta*valorTotal/100;
        } else {
                multa = 0;
            }
            return(multa);
        
    }
    
}


