## Identificar a melhor abordagem para consumir dados de API.

o 3° é a requisição mais performática, pois utiliza programação assíncrona com aiohttp e asyncio, permitindo múltiplas requisições simultâneas sem bloquear a execução do programa. Especialmente quando é necessário fazer várias chamadas de API ao mesmo tempo.
Após algumas pesquisas as Melhorias comuns que eu encontrei são: Adicionar tratamento de erros, evitar bloqueio síncrono e considerar a escalabilidade para múltiplas requisições.