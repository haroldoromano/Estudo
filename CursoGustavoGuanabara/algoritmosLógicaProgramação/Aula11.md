# Exercício 1

```
algoritmo "Contador1a10"
var
   contador: inteiro
inicio
      para contador <- 1 ate 10 passo 1 faca
           escreva(contador)
      fimpara
      escreval("")
      para contador <- 10 ate 1 passo -1 faca
           escreva(contador)
      fimpara
fimalgoritmo
```
---

# Exercício 2

```
algoritmo "ValoresPares"
var
   contador, valor: inteiro
inicio
      escreva("Digite um valor: ")
      leia(valor)
      para contador <- 0 ate valor passo 2 faca
           escreva(contador, " ")
      fimpara
fimalgoritmo
```
---

# Exercício 3

```
algoritmo "ValoresPares"
var
   contador, valor: inteiro
inicio
      escreva("Digite um valor: ")
      leia(valor)
      se (valor % 2 = 1) entao
         valor <- valor -1
      fimse
      para contador <- valor ate 0 passo -2 faca
           escreva(contador, " ")
      fimpara
fimalgoritmo
```
---

# Exercício 4

```
algoritmo "QuantosEntre0e10"
var
   contador, valor, total, impar: inteiro
inicio
      total <- 0
      impar <- 0
      para  contador <- 1 ate 6 faca
            escreva("Digite um valor: ")
            leia(valor)
            se (valor >= 0) e (valor <= 10) entao
               total <- total + 1
               se (valor % 2 = 1) entao
                  impar <- impar + valor
               fimse
            fimse
      fimpara
      escreval("Ao todo foram ", total, " valores entre 0 e 10")
      escreval("Nesse intervalo, a soma de impares foi ", impar)
fimalgoritmo
```
---

# Exercício 3

```
algoritmo "Combinacoes"
var
   contador1, contador2: inteiro
inicio
      para contador1 <- 1 ate 3 passo 1 faca
           para contador2 <- 1 ate 3 passo 1 faca
                escreval (contador1, " -", contador2)
           fimpara
      fimpara
fimalgoritmo
```
---

# Exercício 4

```
algoritmo "SequenciaFibonacci"
var
   contador, numero1, numero2, numero3: inteiro
inicio
      numero1 <- 0
      numero2 <- 1
      numero3 <- 0
      para contador <- 1 ate 14 passo 1 faca
           escreval(numero2)
           numero1 <- numero2 + numero3
           numero3 <- numero2
           numero2 <- numero1
      fimpara
fimalgoritmo
```
---

# Exercício 5

```
algoritmo "AnalisadorDeValores"
var
   valor, soma, media, par: real
   contador, dividido, nulo: inteiro
inicio
      para contador <- 1 ate 5 passo 1 faca
           escreva("Digite o ", contador,"o. Valor: ")
           leia(valor)
           soma <- valor + soma
           se (valor % 5 = 0) entao
           dividido <- dividido + 1
           fimse
           se (valor = 0) entao
              nulo <- nulo + 1
           fimse
           se (valor % 2 = 0) entao
              par <- par + valor
           fimse
           
      fimpara
      media <- soma / 5
      escreval("A soma entre os valores e: ", soma)
      escreval("A media entre os valores e: ", media)
      escreval("valores divisiveis por cinco: ", dividido)
      escreval("Valores nulos: ", nulo)
      escreval("A soma dos valores pares e: ", par)
fimalgoritmo
```
---