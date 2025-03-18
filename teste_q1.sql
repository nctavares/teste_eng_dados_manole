-- Tabela de Clientes (Fonte Transacional)
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome_cliente VARCHAR(255),
    email VARCHAR(255),
    telefone VARCHAR(20),
    cidade VARCHAR(100),
    estado VARCHAR(50),
    data_cadastro DATE
);

-- Tabela de Produtos (Fonte Transacional)
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome_produto VARCHAR(255),
    categoria VARCHAR(100),
    preco DECIMAL(10,2),
    estoque_disponivel INT,
    data_cadastro DATE
);

-- Tabela de Vendas (Fonte Transacional)
CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente),
    id_produto INT REFERENCES produtos(id_produto),
    quantidade INT,
    valor_total DECIMAL(10,2),
    data_venda DATE,
    metodo_pagamento VARCHAR(50),
    status VARCHAR(50) -- Ex: Pago, Pendente, Cancelado
);

-- Tabela de Pagamentos (Fonte Transacional)
CREATE TABLE pagamentos (
    id_pagamento INT PRIMARY KEY,
    id_venda INT REFERENCES vendas(id_venda),
    valor_pago DECIMAL(10,2),
    data_pagamento DATE,
    metodo_pagamento VARCHAR(50),
    status_pagamento VARCHAR(50) -- Ex: Confirmado, Pendente, Rejeitado
);
