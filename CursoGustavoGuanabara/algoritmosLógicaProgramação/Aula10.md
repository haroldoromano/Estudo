# Exercício 1

```
algoritmo "Somador"
var
   numero, soma: inteiro
   resposta: caractere
inicio
      soma <- 0
      repita
            escreva("Digite o ", "o. valor ==> ")
            leia(numero)
            soma <- soma + numero
            escreva("Voce quer continuar? [s/n]")
            leia(resposta)
      ate(resposta = "n")
      escreval("A soma de todos os valores digitados e ", soma)
fimalgoritmo
```
---

# Exercício 2

```
algoritmo "Conta1a10"
var
   contador: inteiro
inicio
      contador <- 1
      repita
            escreval(contador)
            contador <- contador + 1
      ate(contador > 10)
fimalgoritmo
```
---

# Exercício 3

```
algoritmo "Tabuada"
var
   contador, numero, resultado: inteiro
inicio
      contador <- 1
      escreva("Quer ver a tabuada de qual numero? ")
      leia(numero)
      repita
            resultado <- numero * contador
            escreval(numero, " X ", contador, " = ", resultado)
            contador <- contador + 1
      ate(contador > 10)
fimalgoritmo
```
---

# Exercício 4

```
algoritmo "ContaNegativos"
var
   numero, contador, negativos: inteiro
inicio
      contador <- 1
      negativos <- 0
      repita
            escreva("Digite um numero: ")
            leia(numero)
            se (numero < 0) entao
               negativos <- negativos + 1
            fimse
            contador <- contador + 1
      ate(contador > 5)
      escreval("Foram digitados ", negativos, " valores negativos.")
fimalgoritmo
```
---

# Exercício 5

```
algoritmo "Fatorial"
var
   contador, numero, fatorial: inteiro
inicio
      escreva("Digite um numero: ")
      leia(numero)
      contador <- numero
      fatorial <- 1
      repita
            fatorial <- fatorial * contador
            contador <- contador - 1
      ate(contador < 1)
      escreva("O valor do fatorial de ", numero, " e igual a ", fatorial)
fimalgoritmo
```
---

# Exercício 6

```
algoritmo "Fatorial2"
var
   contador, numero, fatorial: inteiro
   resposta: caractere
inicio
      repita
            escreva("Digite um numero: ")
            leia(numero)
            contador <- numero
            fatorial <- 1
            repita
                  fatorial <- fatorial * contador
                  contador <- contador - 1
            ate(contador < 1)
            escreval("O valor do fatorial de ", numero, " e igual a ", fatorial)
            escreva("Quer continuar? [s/n]")
            leia(resposta)
            limpatela
      ate(resposta = "n")
fimalgoritmo
```
---

# Exercício 7

```
algoritmo "NumeroPrimo"
var
   contador, numero, primo: inteiro
inicio
      contador <- 1
      primo <- 0
      escreva("Digite um numero: ")
      leia(numero)
      repita
            se (numero % contador = 0) entao
               primo <- primo + 1
            fimse
            contador <- contador + 1
      ate (contador > numero)
      escreval("")
      se(primo > 2) entao
           escreval("O valor ", numero, " nao e primo!")
      senao
           escreval("O valor ", numero, " e primo!")
      fimse
fimalgoritmo
```
---

# Exercício 8

```
algoritmo "SuperContador"
var
   resposta, contador: inteiro
inicio
      repita
            escreval("=================")
            escreval("|    M E N U    |")
            escreval("=================")
            escreval("| [1] De 1 a 10 |")
            escreval("| [2] De 10 a 0 |")
            escreval("| [3] Sair      |")
            escreval("=================")
            leia(resposta)
            escreval("")
            escolha(resposta)
                caso 1
                     contador <- 1
                     repita
                           escreva(contador, ".. ")
                           contador <- contador + 1
                     ate(contador > 10)
                caso 2
                     contador <- 10
                     repita
                           escreva(contador, ".. ")
                           contador <- contador - 1
                     ate(contador < 1)
            fimescolha
            escreval("")
      ate(resposta = 3)
      
fimalgoritmo
```
---

# Exercício 9

```
algoritmo "SelecionandoPessoas"
var
   sexo, resposta: caractere
   idade, cabelo, homem, mulher: inteiro
inicio
      repita
            escreval("======================")
            escreval("  SELETOR DE PESSOAS  ")
            escreval("======================")
            escreval("")
            escreva("Qual o sexo? [m/f] ")
            leia(sexo)
            escreva("Qual a idade? ")
            leia(idade)
            escreval("Qual a cor do cabelo? ")
            escreval("---------------------")
            escreval("[1]Preto")
            escreval("[2]Castanho")
            escreval("[3]Loiro")
            escreval("[4]Ruivo")
            leia(cabelo)
            
            se (sexo = "m") e (idade > 18) e (cabelo = 2) entao
               homem <- homem + 1
            fimse
            se (sexo = "f") e (idade >= 25) e (idade <= 30) e (cabelo = 3) entao
               mulher <- mulher + 1
            fimse
            escreva("Quer continuar? [s/n]")
            leia(resposta)
            limpatela
      ate(resposta = "n")
      escreval("Total de homens com mais de 18 e cabelos castanhos: ", homem)
      escreval("Total de mulheres entre 25 e 30 e cabelos loiros: ", mulher)
fimalgoritmo
```
---