# Imagens Docker para o Programa IRPF (Imposto sobre a Renda de Pessoas Físicas)

As imagens são baseadas no Alpine, o que diminui consideravelmente o tamanho da imagem final (<100MB).

**Para executar:**
```bash
docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME:/home/irpf samiraguiar/irpf
```

Note que a montagem de volume (`-v $HOME:/home/irpf`) é opcional e pode ser alterada para outros diretórios caso desejado.

**Nota:**
Este projeto é apenas uma prova de conceito e não substitui o programa oficial disponibilizado pela Receita Federal, além de não estar associado de forma alguma a este órgão. O autor não se responsabiliza por quaisquer erros na declaração e possíveis problemas com o fisco causados pela utilização desta imagem.
