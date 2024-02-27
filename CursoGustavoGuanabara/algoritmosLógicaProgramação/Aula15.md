# Exercício 1

```
algoritmo "LerMatriz"
var
   mat: vetor[1..3, 1..2] de inteiro
   l, c: inteiro
inicio
      para l <- 1 ate 3 passo 1 faca
           para c <- 1 ate 2 passo 1 faca
                escreva("Digite um numero na posicao [", l, ", ", c, "]: ")
                leia(mat[l, c])
           fimpara
      fimpara
      
      para l <- 1 ate 3 passo 1 faca
           para c <- 1 ate 2 passo 1 faca
                escreva(mat[l, c]:5)
           fimpara
                  escreval("")
      fimpara
fimalgoritmo
```
---

# Exercício 2

```
algoritmo "MatrizPar"
var
   valores: vetor[1..3, 1..3] de inteiro
   linha, coluna, totalpar: inteiro
inicio
      para linha <- 1 ate 3 passo 1 faca
           para coluna <- 1 ate 3 passo 1 faca
                escreva("Digite o valor da posicao [", linha, ", ", coluna, "]: ")
                leia(valores[linha, coluna])
           fimpara
      fimpara
      
      escreval("")
      escreval("MATRIZ")
      escreval("-------------------")
      totalpar <- 0
      para linha <- 1 ate 3 passo 1 faca
           para coluna <- 1 ate 3 passo 1 faca
                se(valores[linha, coluna] % 2 = 0) entao
                     escreva("{", valores[linha, coluna]:1, "}")
                     totalpar <- totalpar + 1
                senao
                     escreva(valores[linha, coluna]:4)
                fimse
           fimpara
           escreval("")
      fimpara
      escreval("")
      escreva("Ao todo foram digitados ", totalpar, " valores PARES.")
fimalgoritmo
```
---

# Exercício 3

```
algoritmo "MatrizIdentidade"
var
   mid: vetor[1..3, 1..3] de inteiro
   linha, coluna: inteiro
inicio
      para linha <- 1 ate 3 passo 1 faca
           para coluna <- 1 ate 3 passo 1 faca
                se (linha = coluna)entao
                   mid[linha, coluna] <- 1
                senao
                     mid[linha, coluna] <- 0
                fimse
           fimpara
      fimpara
      
      para linha <- 1 ate 3 passo 1 faca
           para coluna <- 1 ate 3 passo 1 faca
                escreva(mid[linha, coluna]:3)
           fimpara
           escreval("")
      fimpara
fimalgoritmo
```
---

# Exercício 4

```
algoritmo "ValoresMatriz"
var
   m: vetor[1..4, 1..4] de inteiro
   linha, coluna, somadiagonal, produto, maior: inteiro
inicio
      somadiagonal <- 0
      produto <- 1
      
      para linha <- 1 ate 4 passo 1 faca
           para coluna <- 1 ate 4 passo 1 faca
                escreva("Digite o valor da poaicao [", linha, ",", coluna, "]: ")
                leia(m[linha, coluna])
                se(linha = coluna) entao
                         somadiagonal <- somadiagonal + m[linha, coluna]
                fimse
           fimpara
      fimpara
      
      para linha <- 1 ate 4 faca
           para coluna <- 1 ate 4 faca
                escreva(m[linha, coluna]:4)
           fimpara
           escreval()
      fimpara
      
      para coluna <- 1 ate 4 passo 1 faca
           produto <- produto * m[2, coluna]
      fimpara
      
      para linha <- 1 ate 4 passo 1 faca
           se(m[linha, 3] > maior) entao
                       maior <- m[linha, 3]
           fimse
           
      fimpara
      
      escreval("A soma dos valores da diagonal principal e ", somadiagonal)
      escreval("O produto dos valores da segunda linha e ", produto)
      escreval("O maior valor da terceira coluna e ", maior)
fimalgoritmo
```
---

# Exercício 5

```
algoritmo "DissecandoMatrizes"
var
   mat: vetor[1..4, 1..4] de inteiro
   opcao, linha, coluna: inteiro

inicio
      para linha <- 1 ate 4 passo 1 faca
           para coluna <- 1 ate 4 passo 1 faca
                aleatorio 1, 10
                //escreva("Digite o valor para a posicao [", linha, ", ", coluna, "]: ")
                leia(mat[linha, coluna])
                aleatorio off
           fimpara
      fimpara
      
      enquanto (opcao <> 5) faca
               limpatela
               escreval("MENU DE OPCOES")
               escreval("==============")
               escreval("[1] Mostrar a Matriz")
               escreval("[2] Diagonal Principal")
               escreval("[3] Triangulo Superior")
               escreval("[4] Triangulo Inferior")
               escreval("[5] Sair")
               escreva("===== OPCAO: ")
               leia(opcao)

               escolha(opcao)
                             caso 1
                                  para linha <- 1 ate 4 passo 1 faca
                                       para coluna <- 1 ate 4 passo 1 faca
                                            escreva(mat[linha, coluna]:5)
                                       fimpara
                                       escreval()
                                  fimpara
                             caso 2
                                  escreva("2")
                             caso 3
                                  escreva("3")
                             caso 4
                                  escreva("4")
                             caso 5
                                  escreva("5")
               fimescolha
      fimenquanto


fimalgoritmo
```
---