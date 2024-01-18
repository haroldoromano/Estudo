# Exercício 1

```
algoritmo "SomaFuncao"
var
   valor1, valor2, resultado: inteiro
   
funcao soma(x, y: inteiro): inteiro
inicio
      retorne x + y
fimfuncao

inicio
      escreva("Digite o primeiro valor: ")
      leia(valor1)
      escreva("Digite o segundo valor: ")
      leia(valor2)
      resultado <- soma(valor1, valor2)
      escreval("A soma entre ", valor1, " e ", valor2, " e igual", resultado)
fimalgoritmo
```
---

# Exercício 2

```
algoritmo "ParImpar"
var
   numero: inteiro
   resposta: caractere

funcao parouimpar(x: inteiro): caractere
inicio
       se(x % 2 = 0) entao
            retorne "PAR"
       senao
            retorne "IMPAR"
       fimse
fimfuncao

inicio
      escreva("Digite um numero: ")
      leia(numero)
      resposta <- parouimpar(numero)
      escreva("O numero ", numero, " e um valor ", resposta)
fimalgoritmo
```
---

# Exercício 3

```
algoritmo "FatorialFuncao"
var
   numero, resposta: inteiro

funcao fatorial (v: inteiro): inteiro
var contador, r: inteiro
inicio
      r <- 1
      para contador <-1 ate v faca
           r <- r * contador
      fimpara
      retorne r
fimfuncao
   
inicio
      escreva("Digite um numero: ")
      leia(numero)
      resposta <- fatorial(numero)
      escreval("O valor de ", numero, "! e igual a ", resposta)
fimalgoritmo
```
---

# Exercício 4

```
algoritmo "funcaoFibonacci"
var
   c, t1, t2, t3: inteiro
funcao proximofibonacci(var a, b: inteiro): inteiro
var c: inteiro
inicio
      c <- a + b
      a <- b
      b <- c
      retorne c
fimfuncao
inicio
      t1 <- 0
      escreval(t1)
      t2 <- 1
      escreval(t2)
      para c <-3 até 10 passo 1 faca
           t3 <- proximofibonacci(t1, t2)
           escreval(t3)
      fimpara
fimalgoritmo
```
---

# Exercício 5

```
algoritmo "AnalisadorStrings"
var
   n: caractere
   contador: inteiro
inicio
      escreva("Digite seu nome: ")
      leia(n)
      escreval("Total de letras do seu nome: ", compr(n))
      escreval("Seu nome em maiusculas e: ", maiusc(n))
      escreval("Seu nome em minusculas e: ", minusc(n))
      escreval("A primeira letras do seu nome e: ", copia(n, 1, 1))
      escreval("A ultima letras do seu nome: ", copia(maiusc(n), compr(n), 1))
      escreval("Seu nome tem a letra A na posicao: ", pos("A", maiusc(n)))
      escreval("O codigo da letra A e: ", asc("A"))
      escreval("A letra de codigo 65 e ", carac(65))
      
      para contador <- compr(n) ate 1 passo -1 faca
           escreva(copia(maiusc(n), contador, 1))
      fimpara
fimalgoritmo
```
---