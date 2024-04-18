# Criação de Matriz
~~~php
programa {
  inteiro matriz[5][3]

  funcao inicio() {
    matriz[0][0] = 60

    escreva("Valor: ", matriz[0][0], "\n")  
  }
}
~~~
---

# Matriz com laço PARA
~~~php
programa {
  inteiro linha, coluna
  inteiro matriz[3][3]

  funcao inicio() {
    para(linha = 0; linha <= 2; linha++) {
      para(coluna = 0; coluna <= 2; coluna++) {
        escreva("Digite um número: ")
        leia(matriz[linha][coluna])   
      }
    }  
    escreva("\n")
    
    para(linha = 0; linha <= 2; linha++) {
      para(coluna = 0; coluna <= 2; coluna++) {
        escreva(matriz[linha][coluna], " ")
      }
      escreva("\n")
    }  
  }
}
~~~
---

# Exercício 1
~~~php
programa {
  inclua biblioteca Util

  inteiro linha, coluna, soma
  inteiro matriz[10][10]

  funcao inicio() {
    soma = 0

    //Preenchimento da matriz
    para(linha = 0; linha <= 9; linha++) {
      para(coluna = 0; coluna <= 9; coluna++) {
        matriz[linha][coluna] = Util.sorteia(0, 100)
        soma = soma + matriz[linha][coluna]
      }
    }
    //Exibição da matriz
    para(linha = 0; linha <= 9; linha++) {
      para(coluna = 0; coluna <= 9; coluna++) {
        escreva(matriz[linha][coluna], " \t") //O comando /t faz uma tabulação.
      }
      escreva("\n")
    }

    escreva("A soma de todos os valores da Matriz é ", soma)
  }
}
~~~
---