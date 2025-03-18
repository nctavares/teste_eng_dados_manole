import pandas as pd
import random
from datetime import datetime, timedelta

# Criando dados fictícios para os arquivos CSV

# Gerando clientes (500 clientes)
clientes = [
    {
        "id_cliente": i,
        "nome_cliente": f"Cliente {i}",
        "email": f"cliente{i}@email.com",
        "telefone": f"(11)9{random.randint(1000,9999)}-{random.randint(1000,9999)}",
        "cidade": random.choice(["São Paulo", "Rio de Janeiro", "Belo Horizonte", "Curitiba", "Porto Alegre", "Brasília"]),
        "estado": random.choice(["SP", "RJ", "MG", "PR", "RS", "DF"]),
        "data_cadastro": (datetime(2020, 1, 1) + timedelta(days=random.randint(0, 1460))).strftime('%Y-%m-%d')
    }
    for i in range(1, 501)
]

# Gerando produtos (500 produtos)
produtos = [
    {
        "id_produto": i,
        "nome_produto": f"Produto {i}",
        "categoria": random.choice(["Eletrônico", "Moda", "Casa", "Esporte", "Beleza", "Automotivo"]),
        "preco": round(random.uniform(10, 5000), 2),
        "estoque_disponivel": random.randint(0, 500),
        "data_cadastro": (datetime(2020, 1, 1) + timedelta(days=random.randint(0, 1460))).strftime('%Y-%m-%d')
    }
    for i in range(1, 501)
]

# Gerando vendas (5000 vendas)
vendas = []
start_date = datetime(2023, 1, 1)
for i in range(1, 5001):
    id_cliente = random.randint(1, 500)
    id_produto = random.randint(1, 500)
    preco_produto = next(item["preco"] for item in produtos if item["id_produto"] == id_produto)
    quantidade = random.randint(1, 5)
    
    venda = {
        "id_venda": i,
        "id_cliente": id_cliente,
        "id_produto": id_produto,
        "quantidade": quantidade,
        "valor_total": round(preco_produto * quantidade, 2),
        "data_venda": (start_date + timedelta(days=random.randint(0, 365))).strftime('%Y-%m-%d'),
        "metodo_pagamento": random.choice(["Cartão", "Boleto", "Pix"]),
        "status": random.choice(["Pago", "Pendente", "Cancelado"])
    }
    vendas.append(venda)

# Criando DataFrames
df_clientes = pd.DataFrame(clientes)
df_produtos = pd.DataFrame(produtos)
df_vendas = pd.DataFrame(vendas)

# Salvando como CSV
df_clientes.to_csv("clientes.csv", index=False)
df_produtos.to_csv("produtos.csv", index=False)
df_vendas.to_csv("vendas.csv", index=False)

print("Arquivos CSV gerados com sucesso!")
