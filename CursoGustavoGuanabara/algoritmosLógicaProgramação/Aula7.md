# Exercício 1

```
algoritmo "CalculoIdade"
var
   ano, nasc, idade: inteiro
inicio
      escreva("Em que ano estamos? ")
      leia(ano)
      escreva("Em que ano voce nasceu? ")
      leia(nasc)
      idade <- ano - nasc
      escreva("Em ", ano, " voce tera ", idade, " anos")
      se (idade >= 21) então
         escreval(" e ja tera atingido a maioridade.")
      fimse
fimalgoritmo
```
---

# Exercício 2

```
algoritmo "ParOuImpar"
var
   n: inteiro
inicio
      escreva("Digite um numero qualquer: ")
      leia(n)
      se(n % 2 = 0) entao
           escreval("O numero ", n, " e par")
      senao
           escreval("O numero ", n, " e impar")
      fimse
fimalgoritmo
```
---

# Exercício 3

```
algoritmo "CalculoIMC"
var
m, a, IMC: real
inicio
      escreva("Massa (kg): ")
      leia(m)
      escreva("Altura (m): ")
      leia(a)
      imc <- m / (a ^ 2)
      escreval("IMC: ", imc:5:2)
      se (imc >= 18.5) e (imc < 25) entao
         escreva("Parabens! Voce esta no seu peso ideal.")
      senao
           escreva("Voce não esta na faixa de peso ideal")
      fimse
fimalgoritmo
```
---

# Exercício 4

```
algoritmo "motorista"
var
   ano, nascimento, idade: inteiro
inicio
      escreval("------------------------")
      escreval("DEPARTAMENTO DE TRANSITO")
      escreval("------------------------")
      escreval("")
      escreva("Ano atual (YYYY): ")
      leia(ano)
      escreva("Ano de Nascimento (YYYY): ")
      leia(nascimento)
      idade <- ano - nascimento
      escreval("")
      escreval("---------STATUS---------")
      escreval("IDADE: ", idade, " ANOS")
      se (idade > 18) entao
         escreval("APTO A TIRAR CARTEIRA")
      senao
           escreval("INAPTO A TIRAR CARTEIRA")
      fimse
      escreval("------------------------")
fimalgoritmo
```
---

# Exercício 5

```
algoritmo "escola"
var
   nota1, nota2, media: real
inicio
   escreval("---------------------")
   escreval("ESCOLA JAVALI CANSADO")
   escreval("---------------------")
   escreval("")
   escreva("Primeira nota: ")
   leia(nota1)
   escreva("Segunda nota: ")
   leia(nota2)
   escreval("")
   escreval("---------------------")
   media <- (nota1 + nota2) / 2
   escreval("")
   escreval("MEDIA: ", media:4:2)
   se (media >= 7) então
      escreval("ALUNO APROVADO")
   senao
        escreval("ALUNO REPROVADO")
   fimse
   escreval("")
   escreval("---------------------")
```
---