# Medições

Data: 22/11/2026
Ambiente: Windows 11 + WSL2 (Ubuntu), Docker version 29.9.2, build a82e528

## 1. Tamanho das imagens

Comando: `docker images --format "{{.Repository}}:{{.Tag}}  {{.Size}}"`

| Imagem | Tamanho |
|---|---|
| `python:3.12` (completa) | 1,62 GB |
| `python:3.12-slim-trixie` (a que usamos) | 180 MB |
| `python:3.12-alpine` | 74,8 MB |
| A nossa imagem (`slim` + make + pytest, pytest-cov, ruff) | 249 MB |

Nota: os valores são o espaço ocupado em disco, que é maior do que o tamanho do download; servem para comparar as imagens entre si.

Interpretação: Como podemos ver, as imagens têm todas tamanhos diferentes, sendo a mais pesada a completa com 1,62 GB. Esta é tão pesada devido aos compiladores e ferramentas extras que traz mas que não são necessárias de todo ao nosso projeto, pelo que esse espaço extra da imagem seria desnecessário. Para além disso, quanto mais ficheiros e pacotes existirem, maior a probabilidade de haver erros ou falhas de segurança, pelo que não escolhemos essa versão da imagem.
A imagem mais leve é a da alpine, porém esta usa a biblioteca de C musl em vez de glibc, e como a maioria dos pacotes do Python já vêm compilados para glibc, seria muito mais complexo recompilar alguns pacotes, pelo que também não usámos esta versão.
A slim-trixie é como se fosse o meio termo, nem é muito pesada nem muito leve em que abdique de certas funcionalidades para poupar no espaço. A nossa imagem possui mais 69 MB que a slim pois são provenientes do make e das ferramentas, como o pytest, ruff, etc. que já estão na imagem, pelo que é o preço a pagar por ter tudo dentro do contentor, preço esse que aceitámos sem qualquer problema.

## 2. Capacidades Linux e privilégios

Comando: `grep -E "CapEff|NoNewPrivs" /proc/self/status` dentro de cada contentor

| Contentor | CapEff | NoNewPrivs | Utilizador |
|---|---|---|---|
| Contentor normal (`docker run python:3.12-slim-trixie`) | `00000000a80425fb` | 0 | root |
| O nosso (`docker compose run dev`) | `0000000000000000` | 1 | `uid=1000(developer)` |

Interpretação: O CapEff é uma lista em hexadecimal onde constam os poderes especiais do kernel. O valor a80425fb corresponde às 14 capacidades que o docker dá por default. Estas capacidades podem variar entre mudar o dono de ficheiros até ignorar permissões, sendo um possível problema de segurança.
Posto isto no nosso contentor, através de cap_drop: ALL em compose.yaml e ao contentor correr em developer (logo não é root), conseguimos atingir o zero o que significa que o docker não dá nenhuma dessas capacidades, evitando algum possível problema que pudesse surgir devido ao contentor ter esses "poderes".
O NoNewPrivs, proveniente de security_opt: no-new-privileges:true em compose.yaml é como se fosse um interruptor no qual decidimos se possibilitamos que algum processo no contentor adquira algum poder especial após arrancar. Ao estar em 1, todos os processos ficam impossibilitados de adquirir algum tipo de capacidade extra, sendo a probabilidade de imprevistos muito menor e a segurança maior.
Para além disso o nosso contentor também corre como developer, pois o Dockerfile define USER developer em vez do root que vem na imagem oficial.

## 3. Dono dos ficheiros criados no bind mount

| Teste | Resultado |
|---|---|
| Ficheiro criado por um contentor normal (root) | dono `root`; o utilizador do anfitrião não consegue escrever nele (`Permission denied`) |
| Ficheiro criado pelo nosso contentor | dono `joaopinheiro69` (o utilizador do anfitrião) |
| O nosso contentor forçado a root (`--user root`) | não consegue criar o ficheiro (`Permission denied`) |

Interpretação: No Linux, o dono de um ficheiro é guardado como UID e não como um nome.