# Exercício 1

```
algoritmo "DetectorPesado"
var
   contador: inteiro
   nome, pesado: caractere
   peso, mais: real

procedimento topo()
inicio
      limpatela
      escreval("-----------------------------------")
      escreval("D E T E C T O R   D E   P E S A D O")
      escreval("Maior peso ate agora: ", mais, "Kg")
      escreval("-----------------------------------")
fimprocedimento

inicio
      topo()
      para contador <- 1 ate 5 passo 1 faca
           escreva("Digite o nome: ")
           leia(nome)
           escreva("Digite o peso de ", nome, ": ")
           leia(peso)
           se (peso > mais) entao
              mais <- peso
              pesado <- nome
           fimse
           topo ()
      fimpara
      topo ()
      escreval("A pessoa mais pesada foi ", pesado, ", com ", mais, "Kg")
fimalgoritmo
```
---

# Exercício 2

```
algoritmo "FazSomaProcedimento"
var
   numero1, numero2: inteiro

procedimento soma(a, b: inteiro)
inicio
             escreval("Recebi o valor: ", a)
             escreval("Recebi o valor: ", b)
             escreval("A soma entre os dois e ", a + b)
fimprocedimento

inicio
      numero1 <- 5
      numero2 <- 3
      soma(numero1, numero2)
fimalgoritmo
```
---

# Exercício 3

```
algoritmo "ParOuImparProcedimento"
var
   numero: inteiro
   
procedimento parouimpar(v: inteiro)
inicio
      se(v % 2 = 0) entao
           escreval("O numero ", v, " e PAR")
      senão
           escreval("O numero ", v, " e IMPAR")
      fimse
fimprocedimento

inicio
      escreva("Digite um numero: ")
      leia(numero)
      parouimpar(numero)
fimalgoritmo
```
---

# Exercício 4

```
algoritmo "SomaParametrosReferencia"
var
   x, y: inteiro
   
procedimento soma(a, b: inteiro)
inicio
      a <- a + 1
      b <- b + 1
      escreval("Valor de A = ", a)
      escreval("Valor de B = ", b)
      escreval("Soma A + B = ", a + b)
fimprocedimento
inicio
      x <- 4
      y <- 8
      soma(x, y)
      escreval("Valor de X = ", x)
      escreval("Valor de Y = ", y)
fimalgoritmo
```
---

# Exercício 5

```
algoritmo "SomaParametrosValor"
var
   x, y: inteiro
   
procedimento soma(var a, b: inteiro)
inicio
      a <- a + 1
      b <- b + 1
      escreval("Valor de A = ", a)
      escreval("Valor de B = ", b)
      escreval("Soma A + B = ", a + b)
fimprocedimento
inicio
      x <- 4
      y <- 8
      soma(x, y)
      escreval("Valor de X = ", x)
      escreval("Valor de Y = ", y)
fimalgoritmo
```
---

# Exercício 6

```
algoritmo "ProcedimentoFibonacci"
var
   c, t1, t2, t3: inteiro
procedimento proximofibonacci(var a, b: inteiro)
var c: inteiro
inicio
      c <- a + b
      escreva(c)
      a <- b
      b <- c
fimprocedimento
inicio
      t1 <- 0
      escreva(t1)
      t2 <- 1
      escreva(t2)
      para c <-3 até 10 passo 1 faca
           proximofibonacci(t1, t2)
      fimpara
fimalgoritmo
```
---

