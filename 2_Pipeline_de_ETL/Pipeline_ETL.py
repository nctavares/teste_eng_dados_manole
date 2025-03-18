import pandas as pd

# PIPELINE DE ETL

# 1- Leitura dos arquivos
def extract():
    df_clientes = pd.read_csv("clientes.csv")
    df_produtos = pd.read_csv("produtos.csv")
    df_vendas = pd.read_csv("vendas.csv")
    return df_clientes, df_produtos, df_vendas

# 2- Tratamento dos dados
def transform(df_clientes, df_produtos, df_vendas):

# Retirando duplicidade
    df_clientes = df_clientes.drop_duplicates(subset=["id_cliente"])
    df_produtos = df_produtos.drop_duplicates(subset=["id_produto"])
    df_vendas = df_vendas.drop_duplicates(subset=["id_venda"])

# Retirando Nulos
    df_clientes = df_clientes.dropna(subset=["id_cliente", "nome_cliente"])
    df_produtos = df_produtos.dropna(subset=["id_produto", "nome_produto"])
    df_vendas = df_vendas.dropna(subset=["id_venda", "id_cliente", "id_produto"])


# Dim_pagamento
    df_pagamento = df_vendas[["metodo_pagamento", "status"]].drop_duplicates().reset_index(drop=True)
    df_pagamento["id_pagamento"] = df_pagamento.index + 1


    df_vendas = pd.merge(df_vendas, df_pagamento, on=["metodo_pagamento", "status"], how="left")

# Fato
    df_fato_vendas = df_vendas[[
        "id_venda", "id_cliente", "id_produto",  "id_pagamento", "quantidade", "valor_total"
    ]]

    return df_clientes, df_produtos, df_pagamento, df_fato_vendas

# Carregando no "DW"
def load(df_clientes, df_produtos,  df_pagamento, df_fato_vendas):
    with pd.ExcelWriter("data_warehouse.xlsx") as writer:
        df_clientes.to_excel(writer, sheet_name="dim_cliente", index=False)
        df_produtos.to_excel(writer, sheet_name="dim_produto", index=False)
        df_pagamento.to_excel(writer, sheet_name="dim_pagamento", index=False)
        df_fato_vendas.to_excel(writer, sheet_name="fato_vendas", index=False)

    print("Dados carregados no DW")

# Executar a ETL
def run_etl():
    df_clientes, df_produtos, df_vendas = extract()
    df_clientes, df_produtos, df_pagamento, df_fato_vendas = transform(df_clientes, df_produtos, df_vendas)
    load(df_clientes, df_produtos, df_pagamento, df_fato_vendas)

    print("Executado Corretamente!")





run_etl()