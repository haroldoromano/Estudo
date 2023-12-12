# Exercício 1

```
algoritmo "creuza1"
var
   ano_atual, ano_nasc, idade: inteiro
inicio
      escreva("Em que ano estamos? ")
      leia(ano_atual)
      escreva("Em que ano eu nasci? ")
      leia(ano_nasc)
      idade <- ano_atual - ano_nasc
      escreva("Minha idade sera ", idade)
fimalgoritmo
```
---

# Exercício 2

```
algoritmo "creuza2"
var
   reais, dolares: real
inicio
      escreva("Quantos Reais eu tenho? R$ ")
      leia(reais)
      dolares <- reais/2.20
      escreva("Posso ter US$ ", dolares)
fimalgoritmo
```
---

# Exercício 3

```
algoritmo "creuza3"
var
   f, c: real
inicio
      escreva("Qual a temperatura aqui? ")
      leia(f)
      c <- (f - 32) / 1.8
      escreva("No brasil estaria ", c:4:1)
fimalgoritmo
```
---

# Exercício 4

```
algoritmo "creuza4"
var
   emprestimo, total: real
   parcela: inteiro
inicio
      escreva("Qual o valor do emprestimo? ")
      leia(emprestimo)
      escreva("Quantas parcelas? ")
      leia(parcela)
      total <- ((emprestimo * 1.20) / parcela)
      escreva("Vou pagar ", parcela, " de R$", total)
fimalgoritmo
```
---