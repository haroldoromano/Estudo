# Declaração de Vetor
~~~php
programa {
  real nota[3] //Declaração de um vetor: TIPO NOME_VETOR[Quantidade de posições]

  funcao inicio() {
    escreva("Digite a primeira nota: ")
    leia(nota[0])
    escreva("Digite a segunda nota: ")
    leia(nota[1])

    nota[2] = (nota[0] + nota[1]) / 2

    escreva("Sua média é: ", nota[2])  
  }
}

~~~
---

# Vetor com laço PARA
~~~php
programa {
  real nota[4]
  real media, soma
  inteiro contador

  funcao inicio() {
    soma = 0
    para(contador = 0; contador <= 3; contador++) {
      escreva("Digite a ", contador + 1, "ª nota: ")
      leia(nota[contador])
      
      soma += nota[contador] //O operador += subistitui a expressão (media = media +nota[contador])
    }
    media = soma / contador
    escreva("A média é " + media + "\n")
  }
}
~~~
---

# Toca de valores usando Vetor
~~~php
programa {
  inteiro valor[3]

  funcao inicio() {
    escreva("Digite o primeiro número: ")
    leia(valor[1])
    escreva("Digite o segundo número: ")
    leia(valor[2])

    valor[0] = valor[1]
    valor[1] = valor[2]
    valor[2] = valor[0]

    escreva("O primeiro número agora vale: ", valor[1], "\n")
    escreva("O segundo número agora vale: ", valor[2], "\n")
  }
}
~~~
---

# Algoritmo para ordenar vetores
~~~php
programa {
  inteiro contador1, contador2, auxiliar
  inteiro valor[5]

  funcao inicio() {
    para(contador1 = 0; contador1 <= 4; contador1++) {
      escreva("Digite um número: ")
      leia(valor[contador1])
    }

    para(contador1 = 0; contador1 <=4; contador1++) {
      para(contador2 = contador1 + 1; contador2 <= 4; contador2++ ){
        se(valor[contador1] > valor[contador2]) {
          auxiliar = valor[contador1]
          valor[contador1] = valor[contador2]
          valor[contador2] = auxiliar
        }
      }
    }
    para(contador1 = 0; contador1 <=4; contador1++) {
      escreva(valor[contador1], " ")
    }
  }
}
~~~
---

# Pesquisa linear em um vetor
~~~php
programa {
  inclua biblioteca Util

  inteiro numero, posicao, contador
  inteiro vet[3]

  funcao inicio() {
    posicao = 0

    //Preenchimento do vetor
    para(contador = 0; contador < 3; contador++) {
      vet[contador] = Util.sorteia(0, 10)
    }

    //Valor para pesquisar
    escreva("Digite um valor para pesquisar entre 0 e 10: ")
    leia(numero)

    //Pesquisa do vetor
    enquanto((posicao < 2) e (vet[posicao] != numero)) {
      posicao++
    }

    se(vet[posicao] == numero) {
      escreva("Número encontrado na posição ", posicao, " do vetor")
    }
    senao {
      escreva("Número não encontrado no vetor.")
    }
  }
}
~~~
---

# Pesquisa binária em vetores
~~~php
programa {

  inclua biblioteca Util

  inteiro contador1, contador2, contador3, auxiliar
  inteiro vet[10]

  funcao inicio() {
    
    preencher(vet) //Chama a funcão peencher

    //Verifica conteúdo e ordena vetor.
    //para(contador2 = 0; contador2 <= 9; contador2++) {
    //  escreva(vet[contador2], " ")
    //}

    //Pesquisa Binária
    inteiro inicial = 0
    inteiro final = 9
    inteiro meio, busca
    logico encontrado = falso

    escreva("\nDigite o valor para pesquisar: ")
    leia(busca)

    enquanto((inicial <= final) e (nao encontrado)) {
      meio = (inicial + final) / 2
      se(vet[meio] == busca) {
        encontrado = verdadeiro
      }
      senao se(vet[meio] > busca) {
        final = meio - 1
      }
      senao {
        inicial = meio + 1
      }
    }
    se(encontrado == verdadeiro) {
      escreva("Valor encontrado no vetor. \n")
    }
    senao {
      escreva("Valor inextente. .\n")
    }
  }

  //Função preencher
  funcao preencher(inteiro vetor[]) {
  //Preenche vetor
    para(contador1 = 0; contador1 <= 9; contador1++) {
      vetor[contador1] = Util.sorteia(1, 20)
    }
  //Ordena vetor
    para(contador2 = 0; contador2 <= 9; contador2++) {
      para(contador3 = contador2 + 1; contador3 <= 9; contador3++) {
        se(vetor[contador2] > vetor[contador3]) {
          auxiliar = vet[contador3]
          vetor[contador3] = vetor[contador2]
        }
      }
    }
  }
}
~~~
---