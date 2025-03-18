## 1- CTE 
- Na terceira consulta, usei uma CTE para calcular o tempo médio entre compras de um mesmo cliente.
  - A CTE `compras_cliente` armazena as datas de compra e a data da compra anterior para cada cliente. Em seguida, calculei a diferença em dias entre as compras e obtemos a média por cliente.

### Benefícios:
- Simplifica consultas complexas.
- Melhora a organização e leitura do código comparado com Subquerys.

## 2. Window Functions
- Na terceira consulta, usei `LAG` para obter a data da compra anterior de cada cliente:

### Benefícios:
- Permite calcular o tempo entre compras de forma eficiente, sem necessidade de `JOINs` adicionais.
- Reduz a complexidade da consulta.
