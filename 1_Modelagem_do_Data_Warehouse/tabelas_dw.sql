----------------------------------------------------
------ SQL COM A ESTRUTURA DAS TABELAS DO DW -------
----------------------------------------------------


CREATE TABLE Dim_Cliente (
    id_cliente INT PRIMARY KEY,
    nome_cliente VARCHAR(255),
    email VARCHAR(255),
    telefone VARCHAR(20),
    cidade VARCHAR(100),
    estado VARCHAR(50),
    data_cadastro DATE
);

CREATE TABLE Dim_Produto (
    id_produto INT PRIMARY KEY,
    nome_produto VARCHAR(255),
    categoria VARCHAR(100),
    preco DECIMAL(10,2),
    estoque_disponivel INT,
    data_cadastro DATE
);

CREATE TABLE Dim_Tempo (
    id_tempo INT PRIMARY KEY,
    data DATE,
    dia INT,
    mes INT,
    ano INT,
    trimestre INT
);

CREATE TABLE Dim_Pagamento (
    id_pagamento INT PRIMARY KEY,
    metodo_pagamento VARCHAR(50),
    status_pagamento VARCHAR(50)
);

CREATE TABLE Fato_Vendas (
    id_venda INT PRIMARY KEY,
    id_cliente INT REFERENCES Dim_Cliente(id_cliente),
    id_produto INT REFERENCES Dim_Produto(id_produto),
    id_tempo INT REFERENCES Dim_Tempo(id_tempo),
    id_pagamento INT REFERENCES Dim_Pagamento(id_pagamento),
    quantidade INT,
    valor_total DECIMAL(10,2)
);