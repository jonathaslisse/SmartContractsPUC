//SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

contract TokenizacaoImobiliaria {
    
    string cartorio;
    string condominio;
    address incorporador;
    address estado;
    
    struct Lote {
        uint numeroDaMatricula;
        uint numeroDaCasa;
        uint valorDoLote;
        uint areaPrivativa;
        address proprietario;
        bool disponivel;
        bool negociavel;
    }
    
    mapping(uint => Lote) public loteamento; // chave = uint numeroDaMatricula
    mapping(uint => bool) public listaDeNumeroDasCasas; // chave = uint numeroDaCasa
    
    constructor(
        string memory _nomeDoCartorio,
        string memory _nomeDoCondominio,
        address _walletDoEstado
        )
    {
        cartorio = _nomeDoCartorio;
        condominio = _nomeDoCondominio;
        incorporador = msg.sender;
        estado = _walletDoEstado;
    }
    
    function criarLote(
        uint _numeroDaMatricula,
        uint _numeroDaCasa,
        uint _valorDoLote,
        uint _areaPrivativa,
        address _primeiroProprietario,
        bool _negociavel
        ) public {
        require(msg.sender == incorporador, "Apenas o incorporador pode criar um lote");
        require(loteamento[_numeroDaMatricula].numeroDaMatricula == 0, "Essa matricula ja esta registrada.");
        require(listaDeNumeroDasCasas[_numeroDaCasa] == false, "Essa casa ja esta registrada");
    }
}
