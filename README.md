# Docker IRPF 2021

[![hub.docker.coms](https://img.shields.io/docker/cloud/build/samiraguiar/irpf)](https://hub.docker.com/r/samiraguiar/irpf/builds)

## Introdução

Este repositório contém imagens de containeres Docker para o Programa IRPF (Imposto sobre a Renda de Pessoas Físicas) desde a versão 2019. Até a versão 2020 as imagens eram baseadas em uma imagem do JDK no Alpine, mas esta deixou de ser atualizada. A partir de 2021, para evitar problemas de compatibilidade ou dificuldade de atualização, a imagem base foi alterada para uma versão slim baseada em Ubuntu tão pequena quanto o Alpine, e agora é utilizado o arquivo `.bin` fornecido pela Receita Federal que já contém todo o runtime Java necessário (evitando dependências a mais).

## Executando

- Para executar a última versão disponível no Docker Hub:
```bash
docker run \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME:/home/irpf \
    samiraguiar/irpf
```

Note que a montagem de volume (`-v $HOME:/home/irpf`) é opcional e pode ser alterada para outros diretórios caso desejado.

## Construindo

- Para construir a imagem manualmente:

```bash
docker build . -t <tag>
```

Onde `<tag>` é o nome desejado para a imagem.

- Caso queria construir a imagem com uma versão diferente do programa IRPF, utilize a variável `INSTALLER_URL`. Por exemplo, para construir uma imagem com a versão 1.0 do IRPF 2019:

```bash
docker build . \
    -t <tag> \
    --build-arg INSTALLER_URL=https://downloadirpf.receita.fazenda.gov.br/irpf/2019/irpf/arquivos/IRPF2019Linux-x86_64v1.0.bin
```

### Nota
Este projeto é apenas uma prova de conceito e não substitui o programa oficial disponibilizado pela Receita Federal, além de não estar associado de forma alguma a este órgão. O autor não se responsabiliza por quaisquer erros na declaração e possíveis problemas com o fisco causados pela utilização desta imagem.
