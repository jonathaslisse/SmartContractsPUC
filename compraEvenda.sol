pragma solidity 0.8.9;

contract CompraEvenda {
    
    address public comprador;
    address public vendedor;
    
    string public matricula;
    string public cartorio;
    
    
    uint public dataVencimento;
    
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
        string memory _cartorio,
        address _vendedor
        
        ) 
        
        {
        vendedor = _vendedor;
        valorTotal = _valorTotal;
        valorEntrada = _valorEntrada;
        qtdParcelas = _qtdParcelas;
        matricula = _matricula;
        cartorio = _cartorio;
        valorEmAberto = valorTotal;
        valorParcela = funcaovalorDaParcela();
        
    }
    
    
    
    function pagarEntrada(uint _valorPagamento) public returns (uint, string memory){
        require (_valorPagamento == valorEntrada, "valor entrada incorreto");
        require(valorEmAberto == valorTotal, "valor da entrada ja paga");
        comprador = msg.sender;
        valorEntrada = _valorPagamento;
        valorEmAberto = valorTotal - _valorPagamento;
        dataVencimento = block.timestamp + 31 * 86400;
        return(valorEmAberto, "Valor em Aberto");
    }
    
    function pagarParcela(uint _valorParcela) public returns (uint, string memory) {
        require(_valorParcela == valorParcela, "valor da parcela incorreto");
        require(valorEmAberto <= valorTotal-valorEntrada, "Valor da entrada nao foi paga");
        require(comprador == msg.sender, "Obrigado, mas somente o comprador pode realizar o pagamento");
        require(block.timestamp <= dataVencimento, "Parcela com data de vencimento vencida");
        dataVencimento = dataVencimento + 31 * 86400;
        valorEmAberto = valorEmAberto - _valorParcela;
        return(valorEmAberto, "valor em Aberto");
        
            }
    
    function funcaovalorDaParcela() public view returns (uint) {
        uint calculoValorParcela = (valorTotal-valorEntrada)/qtdParcelas;
        return(calculoValorParcela);
        
    }
    
    function porcentagemDaMulta(uint _valorDaMulta) public view returns (uint, string memory) {
        require(comprador == msg.sender || vendedor == msg.sender, "Apenas o comprador ou vendedor podem executar");
        _valorDaMulta = porcentagemMulta*valorTotal/100;
        return(_valorDaMulta, "valor da multa");
        
    }
    
    
    
}
