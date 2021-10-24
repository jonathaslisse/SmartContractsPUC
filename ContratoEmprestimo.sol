pragma solidity 0.8.9;

contract Emprestimo {
    
    address public credor;
    address public devedor;
    
    bool quitado = false;
    
    string dataVencimento;
    
    uint public valorTotal;
    uint public qtdParcelas;
    uint public valorEmprestimo;
    
    uint public juros = 2;
    uint public jurosMensais;
    uint public porcentagemMulta = 10;
    
    uint public valorParcela;
    uint public valorMulta;
    uint public saldoEmAberto;
    
   
    constructor (
        uint _valorEmprestimo,
        uint _qtdParcelas
        )
        
        {
            
        valorEmprestimo = _valorEmprestimo;
        qtdParcelas = _qtdParcelas;
        
        }
    
    function valorDaParcela() public returns (uint, string memory) {
        jurosMensais = (valorEmprestimo/qtdParcelas)*juros/100;
        valorParcela = (valorEmprestimo/qtdParcelas) + jurosMensais;
        return(valorParcela, "valor da parcela");
        
    }
    
    function valorTotalDoEmprestimoComJuros() public returns (uint, string memory) {
        valorTotal = valorParcela*qtdParcelas;
        return(valorTotal, "valor total do emprestimo");
        
        
    }
    
    
    function porcentagemDaMulta () public returns (uint, string memory) {
        valorMulta = porcentagemMulta*valorTotal/100;
        return (valorMulta, "valor da multa");
        
    }
    
    
    function pagarParcela (uint _pagarParcela) public returns (uint, string memory) {
        saldoEmAberto = valorTotal - _pagarParcela;
        return (saldoEmAberto, "Saldo em Aberto");
    
    }
    
    function prazoTotalParaPagamento () public view returns (uint, string memory) {
        uint prazoTotalPagamento = qtdParcelas;
        return(prazoTotalPagamento, "Prazo Maximo para Pagamento em meses");
    }
    
}
