create database padaria;

CREATE TABLE Produto (
    idProduto INTEGER PRIMARY KEY,
    nomeProduto VARCHAR,
    descricaoProduto VARCHAR,
    categoriaProduto VARCHAR,
    precoVendaProduto FLOAT,
    custoProducaoProduto FLOAT,
    unidadeMedidaProduto INTEGER,
    quantidadeEstoqueProduto INTEGER,
    statusProduto VARCHAR(20) CHECK (statusProduto IN (
        'disponível',
        'em preparo',
        'esgotado',
        'fora de linha',
        'sob encomenda'
    )));

    
CREATE TABLE Venda (
    idVenda INTEGER PRIMARY KEY,
    dataHoraVenda TIMESTAMP,
    
    formaPagamentoVenda VARCHAR(20) CHECK (formaPagamentoVenda IN (
        'disponível',
        'em preparo',
        'esgotado',
        'fora de linha',
        'sob encomenda'
    )),
    statusVenda VARCHAR(20) CHECK (statusVenda IN (
        'em andamento',
        'concluída',
        'cancelada'
)),
valorTotalVenda FLOAT
);

CREATE TABLE ItemVenda (
    idItemVenda INTEGER PRIMARY KEY,
    quantidadeItemVenda INTEGER,
    precoUnitarioItemVenda FLOAT,
    observacaoItemVenda VARCHAR
);

CREATE TABLE Cliente (
    idCliente INTEGER PRIMARY KEY,
    nomeCliente VARCHAR,
    telefoneCliente VARCHAR,
    enderecoCliente VARCHAR,
    dataCadastroCliente DATE
);

CREATE TABLE Funcionario (
    statusFuncionario VARCHAR(20) CHECK (statusFuncionario IN (
    'ativo',
    'inativo',
    'afastado',
    'demitido'
)),
    salarioFuncionario FLOAT,
    cargoFuncionario VARCHAR(50) CHECK (cargoFuncionario IN (
    'padeiro',
    'confeiteiro',
    'atendente',
    'caixa',
    'gerente'
)),
    cpfFuncionario VARCHAR,
    nomeFuncionario VARCHAR,
    idFuncionario INTEGER PRIMARY KEY,
    dataAdmissaoFuncionario DATE
);

CREATE TABLE Ingrediente (
    idIngrediente INTEGER PRIMARY KEY,
    nomeIngrediente VARCHAR,
    descricaoIngrediente VARCHAR,
    quantidadeIngrediente INTEGER,
    unidadeMedidaIngrediente INTEGER,
    custoUnitarioIngrediente INTEGER,
    statusIngrediente VARCHAR(20) CHECK (statusIngrediente IN (
    'disponível',
    'em falta',
    'em compra',
    'inativo'
))
);

CREATE TABLE Fornecedor (
    idFornecedor INTEGER PRIMARY KEY,
    nomeFornecedor VARCHAR,
    cnpjFornecedor VARCHAR,
    telefoneFornecedor VARCHAR,
    enderecoFornecedor VARCHAR,
    tipoProdutoFornecedor VARCHAR(50) CHECK (tipoProdutoFornecedor IN (
    'matéria-prima',
    'embalagem',
    'limpeza',
    'outros'
)),
    statusFornecedor VARCHAR(20) CHECK (statusFornecedor IN (
    'ativo',
    'inativo',
    'em negociação'
))
);

CREATE TABLE CompraIngrediente (
    idCompraIngrediente INTEGER PRIMARY KEY,
    dataCompraCompraIngrediente DATE,
    valorTotaoCompraIngrediente FLOAT,
    formaPagamentoCompraIngrediente VARCHAR(20) CHECK (formaPagamentoCompraIngrediente IN (
    'dinheiro',
    'boleto',
    'cartão',
    'pix'
)),
    statusCompraIngrediente VARCHAR(20) CHECK (statusCompraIngrediente IN (
    'pendente',
    'recebido',
    'cancelado'
))
);

CREATE TABLE ItemCompraIngrediente (
    idItemCompraIngrediente INTEGER PRIMARY KEY,
    quantidadeItemCompraIngrediente INTEGER,
    precoUnitarioItemCompraIngrediente FLOAT
);

CREATE TABLE Compoe (
    fk_Produto_idProduto INTEGER,
    fk_ItemVenda_idItemVenda INTEGER
);

CREATE TABLE Refere (
    fk_Venda_idVenda INTEGER,
    fk_ItemVenda_idItemVenda INTEGER
);

CREATE TABLE Realiza (
    fk_Venda_idVenda INTEGER,
    fk_Cliente_idCliente INTEGER
);

CREATE TABLE Fabricar (
    fk_Funcionario_idFuncionario INTEGER,
    fk_Produto_idProduto INTEGER
);

CREATE TABLE Registra (
    fk_Venda_idVenda INTEGER,
    fk_Funcionario_idFuncionario INTEGER
);

CREATE TABLE Utiliza (
    fk_Produto_idProduto INTEGER,
    fk_Ingrediente_idIngrediente INTEGER
);

CREATE TABLE Indica (
    fk_Ingrediente_idIngrediente INTEGER,
    fk_ItemCompraIngrediente_idItemCompraIngrediente INTEGER
);

CREATE TABLE Contem (
    fk_ItemCompraIngrediente_idItemCompraIngrediente INTEGER,
    fk_CompraIngrediente_idCompraIngrediente INTEGER
);

CREATE TABLE Fornecer (
    fk_CompraIngrediente_idCompraIngrediente INTEGER,
    fk_Fornecedor_idFornecedor INTEGER
);
 
ALTER TABLE Compoe ADD CONSTRAINT FK_Compoe_1
    FOREIGN KEY (fk_Produto_idProduto)
    REFERENCES Produto (idProduto)
    ON DELETE NO ACTION;
 
ALTER TABLE Compoe ADD CONSTRAINT FK_Compoe_2
    FOREIGN KEY (fk_ItemVenda_idItemVenda)
    REFERENCES ItemVenda (idItemVenda)
    ON DELETE NO ACTION;
 
ALTER TABLE Refere ADD CONSTRAINT FK_Refere_1
    FOREIGN KEY (fk_Venda_idVenda)
    REFERENCES Venda (idVenda)
    ON DELETE NO ACTION;
 
ALTER TABLE Refere ADD CONSTRAINT FK_Refere_2
    FOREIGN KEY (fk_ItemVenda_idItemVenda)
    REFERENCES ItemVenda (idItemVenda)
    ON DELETE SET NULL;
 
ALTER TABLE Realiza ADD CONSTRAINT FK_Realiza_1
    FOREIGN KEY (fk_Venda_idVenda)
    REFERENCES Venda (idVenda)
    ON DELETE NO ACTION;
 
ALTER TABLE Realiza ADD CONSTRAINT FK_Realiza_2
    FOREIGN KEY (fk_Cliente_idCliente)
    REFERENCES Cliente (idCliente)
    ON DELETE NO ACTION;
 
ALTER TABLE Fabricar ADD CONSTRAINT FK_Fabricar_1
    FOREIGN KEY (fk_Funcionario_idFuncionario)
    REFERENCES Funcionario (idFuncionario)
    ON DELETE NO ACTION;
 
ALTER TABLE Fabricar ADD CONSTRAINT FK_Fabricar_2
    FOREIGN KEY (fk_Produto_idProduto)
    REFERENCES Produto (idProduto)
    ON DELETE NO ACTION;
 
ALTER TABLE Registra ADD CONSTRAINT FK_Registra_1
    FOREIGN KEY (fk_Venda_idVenda)
    REFERENCES Venda (idVenda)
    ON DELETE NO ACTION;
 
ALTER TABLE Registra ADD CONSTRAINT FK_Registra_2
    FOREIGN KEY (fk_Funcionario_idFuncionario)
    REFERENCES Funcionario (idFuncionario)
    ON DELETE NO ACTION;
 
ALTER TABLE Utiliza ADD CONSTRAINT FK_Utiliza_1
    FOREIGN KEY (fk_Produto_idProduto)
    REFERENCES Produto (idProduto)
    ON DELETE NO ACTION;
 
ALTER TABLE Utiliza ADD CONSTRAINT FK_Utiliza_2
    FOREIGN KEY (fk_Ingrediente_idIngrediente)
    REFERENCES Ingrediente (idIngrediente)
    ON DELETE NO ACTION;
 
ALTER TABLE Refere ADD CONSTRAINT FK_Refere_1
    FOREIGN KEY (fk_Ingrediente_idIngrediente)
    REFERENCES Ingrediente (idIngrediente)
    ON DELETE NO ACTION;
 
ALTER TABLE Refere ADD CONSTRAINT FK_Refere_2
    FOREIGN KEY (fk_ItemCompraIngrediente_idItemCompraIngrediente)
    REFERENCES ItemCompraIngrediente (idItemCompraIngrediente)
    ON DELETE NO ACTION;
 
ALTER TABLE Contem ADD CONSTRAINT FK_Contem_1
    FOREIGN KEY (fk_ItemCompraIngrediente_idItemCompraIngrediente)
    REFERENCES ItemCompraIngrediente (idItemCompraIngrediente)
    ON DELETE NO ACTION;
 
ALTER TABLE Contem ADD CONSTRAINT FK_Contem_2
    FOREIGN KEY (fk_CompraIngrediente_idCompraIngrediente)
    REFERENCES CompraIngrediente (idCompraIngrediente)
    ON DELETE NO ACTION;
 
ALTER TABLE Fornecer ADD CONSTRAINT FK_Fornecer_1
    FOREIGN KEY (fk_CompraIngrediente_idCompraIngrediente)
    REFERENCES CompraIngrediente (idCompraIngrediente)
    ON DELETE NO ACTION;
 
ALTER TABLE Fornecer ADD CONSTRAINT FK_Fornecer_2
    FOREIGN KEY (fk_Fornecedor_idFornecedor)
    REFERENCES Fornecedor (idFornecedor)
    ON DELETE NO ACTION;
