# Imagens Docker para o Programa IRPF 2021 (Imposto sobre a Renda de Pessoas Físicas)

**Para executar:**
```bash
docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME:/home/irpf samiraguiar/irpf
```

Note que a montagem de volume (`-v $HOME:/home/irpf`) é opcional e pode ser alterada para outros diretórios caso desejado.

**Para usar outra versão:**
Se quiser fazer o build da imagem do docker com outra versão, é só passar um valor diferente para a variável `INSTALLER_URL`:

```bash
docker build . -t <tag> --build-arg INSTALLER_URL=https://downloadirpf.receita.fazenda.gov.br/irpf/2021/irpf/arquivos/IRPF2021Linux-x86_64v1.0.bin
```

**Nota:**
Este projeto é apenas uma prova de conceito e não substitui o programa oficial disponibilizado pela Receita Federal, além de não estar associado de forma alguma a este órgão. O autor não se responsabiliza por quaisquer erros na declaração e possíveis problemas com o fisco causados pela utilização desta imagem.
