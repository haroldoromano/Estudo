# Exercício 1

```
algoritmo "ConteAte10"
var
   contador: inteiro
inicio
      contador <- 0
      enquanto (contador <= 10) faca
               escreval(contador)
               contador <- contador + 1
      fimenquanto
      escreval("terminei de contar")
fimalgoritmo
```
---

# Exercício 2

```
algoritmo "ContarUsuario"
var
   valor, contador: inteiro
inicio
      contador <- 0
      escreva("Quer contar ate quanto? ")
      Leia(valor)
      enquanto (contador <= valor) faca
               escreval(contador)
               contador <- contador + 1
      fimenquanto
      escreval("Terminei de contar")
fimalgoritmo
```
---

# Exercício 3

```
algoritmo "ContarUsuario"
var
   valor, contador, salto: inteiro
inicio
      contador <- 0
      escreva("Quer contar ate quanto? ")
      leia(valor)
      escreva("Qual o valor do salto? ")
      leia (salto)
      enquanto (contador <= valor) faca
               escreval(contador)
               contador <- contador + salto
      fimenquanto
      escreval("Terminei de contar")
fimalgoritmo
```
---

# Exercício 4

```
algoritmo "SomadorNumerico"
var
   contador, soma, numero: inteiro
inicio
      contador <- 0
      soma <- 0
      enquanto (contador <= 5) faca
               escreva("Digite o ", contador, "o. valor: ")
               leia (numero)
               soma <- soma + numero
               contador <- contador + 1
      fimenquanto
      escreva("A soma de todos os valores foi: ", soma)
fimalgoritmo
```
---

# Exercício 5

```
algoritmo "SomadorNumericoMaior"
var
   contador, soma, numero, maior: inteiro
inicio
      contador <- 1
      soma <- 0
      enquanto (contador <= 5) faca
               escreva("Digite o ", contador, "o. valor: ")
               leia (numero)
               se (numero > maior) entao
                  maior <- numero
               fimse
               soma <- soma + numero
               contador <- contador + 1
      fimenquanto
      escreval("A soma de todos os valores foi: ", soma)
      escreval("O maior valor digitado foi: ", maior)
fimalgoritmo
```
---

# Exercício 6

```
algoritmo "ConversorMoedasFixo"
var
   reais, dolar: real
   contador: inteiro
inicio
      contador <- 1
      enquanto (contador <= 4) faca
               escreva("Qual o valor em R$? ")
               leia(reais)
               dolar <- reais / 2.20
               escreval("O valor convertido em US$ ", dolar:5:2)
               Escreval("")
               contador <- contador + 1
      fimenquanto
fimalgoritmo
```
---

# Exercício 7

```
algoritmo "ConversorMoedasVariavel"
var
   reais, dolar: real
   contador, quantidade: inteiro
inicio
      contador <- 1
      escreva("Quantas vezes você quer converter? ")
      leia(quantidade)
      enquanto (contador <= quantidade) faca
               escreva("Qual o valor em R$? ")
               leia(reais)
               dolar <- reais / 2.20
               escreval("O valor convertido em US$ ", dolar:5:2)
               Escreval("")
               contador <- contador + 1
      fimenquanto
fimalgoritmo
```
---

# Exercício 8

```
algoritmo "ContadorInteligente"
var
   comeco, fim, contador: inteiro
inicio
      escreval("CONTAGEM INTELIGENTE")
      escreval("--------------------")
      escreval("")
      escreva("Inicio: ")
      leia(comeco)
      escreva("Fim: ")
      leia(fim)
      escreval("")
      escreval("--------------------")
      escreval("   C O N T A N D O  ")
      escreval("--------------------")
      se (comeco < fim) entao
         contador <- comeco
         enquanto (contador <= fim) faca
                  escreva(contador, ".. ")
                  contador <- contador + 1
         fimenquanto
      senao
         contador <- comeco
         enquanto (contador >= fim) faca
                  escreva(contador, ".. ")
                  contador <- contador - 1
         fimenquanto
      fimse
fimalgoritmo
```
---

# Exercício 8

```
algoritmo "MelhorAluno"
var
   alunos, contador: inteiro
   nota, maior: real
   nome, nomemaior: caractere
inicio
      contador <- 1
      maior <- 0
      escreval("----------------------")
      escreval("Escola Santa Paciencia")
      escreval("----------------------")
      escreval("")
      escreva("Quantos alunos a turma tem? ")
      leia(alunos)
      escreval("")
      enquanto (contador <= alunos) faca
               escreval("-------------------")
               escreval("ALUNO ", contador)
               escreva("Nome do aluno: ")
               leia(nome)
               escreva("Nota de ", nome, ": ")
               leia(nota)
               se (maior < nota) entao
                  maior <- nota
                  nomemaior <- nome
               fimse
               contador <- contador +1
      fimenquanto
      escreva("O melhor aproveitamento foi de ", nomemaior, " com a nota ", maior)
      escreval("")
fimalgoritmo
```
---