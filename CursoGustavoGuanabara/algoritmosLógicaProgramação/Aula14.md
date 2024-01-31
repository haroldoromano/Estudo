# Exercício 1

```
algoritmo "TesteVetor"
var
   v: vetor[1..6] de inteiro
   c: inteiro
inicio
      para c <- 1 ate 6 passo 1 faca
           escreva("Digite o ", c, "o. valor: ")
           leia(v[c])
      fimpara
      
      para c <- 1 ate 6 passo 1 faca
           escreva("{", v[c], "}")
      fimpara
fimalgoritmo
```
---

# Exercício 2

```
algoritmo "ValoresPares"
var
   numero: vetor[1..7] de inteiro
   contador, par: inteiro
inicio
      par <- 0
      para contador <- 1 ate 7 passo 1 faca
           escreva("Digite o. ", contador, "o. valor: ")
           leia(numero[contador])
      fimpara

      para contador <- 1 ate 7 passo 1 faca
          se (numero[contador] % 2 =0) entao
              par <- par + 1
              escreval("Valor PAR na posicao ", contador)
           fimse
      fimpara
      escreval("O total de pares foi ", par)
fimalgoritmo
```
---

# Exercício 3

```
algoritmo "Turma"
var
   nome: vetor[1..4] de caractere
   nota1: vetor[1..4] de real
   nota2: vetor[1..4] de real
   media: vetor[1..4] de real
   somamedia, totalmedia: real
   contador, acimamedia: inteiro
   
inicio
      para contador <- 1 ate 4 passo 1 faca
           escreval("ALUNO n.", contador)
           escreva("Nome: ")
           leia(nome[contador])
           escreva("Primeira nota: ")
           leia(nota1[contador])
           escreva("Segunda nota: ")
           leia(nota2[contador])
           media[contador] <- (nota1[contador] + nota2[contador]) / 2
           somamedia <- somamedia + media[contador]
      fimpara
      
      totalmedia <- somamedia / 4
      limpatela
      escreval("LISTAGEM DE ALUNOS")
      escreval("------------------")
      para contador <- 1 ate 4 passo 1 faca
           escreval(Nome[contador]:15, media[contador]:4:1)
           se media[contador] > totalmedia entao
              acimamedia <- acimamedia + 1
           fimse
      fimpara
      
      escreval("Ao todo temos ", acimamedia, " alunos acima da media da turma que e ", totalmedia:4:1)
fimalgoritmo
```
---

# Exercício 3

```
algoritmo "SoComC"
var
   nome: caractere
   soc: vetor[1..10] de caractere
   contador, total: inteiro
inicio

      total <- 0
      para contador <- 1 ate 10 passo 1 faca
           escreva("Digite o ", contador, " nome: ")
           leia(nome)
           se (copia(maiusc(nome), 1, 1) = "C") entao
              total <- total + 1
              soc[total] <- nome
           fimse
      fimpara
      
      limpatela
      escreval("LISTAGEM FINAL")
      para contador <- 1 ate total passo 1 faca
           escreval(soc[contador])
      fimpara
fimalgoritmo
```
---

# Exercício 3

```
algoritmo "OrdenarVetor"
var
   vet: vetor[1..4] de inteiro
   i, j, aux: inteiro
inicio
      para i <- 1 ate 4 passo 1 faca
           escreva("Digite um valor: ")
           leia(vet[i])
      fimpara
      
      para i <- 1 ate 3 passo 1 faca
           para j <- i + 1 ate 4 passo 1 faca
                se (vet[i] > vet[j]) entao
                   aux <- vet[i]
                   vet[i] <- vet[j]
                   vet[j] <- aux
                fimse
           fimpara
      fimpara
      
      para i <- 1 ate 4 passo 1 faca
           escreva("{", vet[i], "}")
      fimpara
fimalgoritmo
```
---

# Exercício 4

```
algoritmo "CampeonatoFutebol"
var
   time: vetor[1..3] de caractere
   contador1, contador2: inteiro

procedimento menu1()
inicio
      limpatela
      escreval("------------------")
      escreval("CAMPEONATO FUTEBOL")
      escreval("------------------")
fimprocedimento

procedimento menu2()
inicio
      limpatela
      escreval("------------------")
      escreval("TABELA DE PARTIDAS")
      escreval("------------------")
fimprocedimento

inicio
      menu1
      
      para contador1 <- 1 ate 3 passo 1 faca
           escreva("Nome do ", contador1, "o. time: ")
           leia(time[contador1])
      fimpara
      
      menu2

      para contador1 <- 1 ate 3 passo 1 faca
           para contador2 <- 1 ate 3 passo 1 faca
                se (contador1 <> contador2) então
                     escreval(time[contador1]," [ ] X [ ] ", time[contador2])
                fimse
           fimpara
      fimpara
fimalgoritmo
```
---

# Exercício 5

```
algoritmo "CorrigindoProvas"
var
   gabarito: vetor[1..5] de caractere
   nome: vetor[1..3] de caractere
   resposta: vetor[1..5] de caractere
   nota: vetor[1..3] de real
   media, notatotal: real
   contador1, contador2: inteiro
   
//Inicio Procedimentos
procedimento menu1
inicio
      limpatela
      escreval("PASSO 1 - Cadastro de Gabarito")
      escreval("------------------------------")
fimprocedimento

procedimento menu2
inicio
      limpatela
      escreval("---------")
      escreval("ALUNO ", contador1)
      escreval("---------")
fimprocedimento

procedimento menu3
inicio
      limpatela
      escreval("   NOTAS FINAIS   ")
      escreval("------------------")
fimprocedimento
//Fim Procedimentos

inicio
      menu1
      para contador1 <- 1 ate 5 passo 1 faca
             escreva("Questao ", contador1, ": ")
             leia(gabarito[contador1])
      fimpara
      
      para contador1 <- 1 ate 3 passo 1 faca
           menu2
           escreva("Nome: ")
           leia(nome[contador1])
           escreval("RESPOSTAS DADAS")
           para contador2 <- 1 ate 5 passo 1 faca
                escreva("Questao ", contador2, ": ")
                leia(resposta[contador2])
                se (resposta[contador2] = gabarito[contador2]) entao
                   nota[contador1] <- nota[contador1] + 2
                fimse
           fimpara
      fimpara

      menu3
      para contador1 <- 1 ate 3 passo 1 faca
           escreval(nome[contador1]:15, " ", nota[contador1]:4:1)
      fimpara
      escreval("------------------")
      
      para contador1 <- 1 ate 3 passo 1 faca
           notatotal <- notatotal + nota[contador1]
      fimpara
      media <- notatotal / contador1
      escreval("Media da turma: ", media:4:1)
fimalgoritmo
```
---

# Exercício 6

```
algoritmo "ReservandoEspacos"
var
   reserva: vetor[1..10] de logico
   resposta: caractere
   contador, cadeira: inteiro
inicio
      repita
            limpatela
            para contador <- 1 ate 10 passo 1 faca
            se (reserva[contador] <> VERDADEIRO) entao
               escreva("[B", contador, "]")
            senao
                 escreva("[---]")
            fimse
            fimpara
            
            escreval("")
            escreval("---------------------------------------------")
            escreva("Reservar a cadeira: B")
            leia(cadeira)
            
            se (reserva[cadeira] = VERDADEIRO) entao
               escreval("ERRO: Lugar Ocupado!")
            senao
               escreval("Cadeira B", cadeira, " RESERVADA!")
            fimse
            
            para contador <- 1 ate 10 passo 1 faca
                 se (cadeira = contador) entao
                    reserva[contador] <- VERDADEIRO
                 fimse
            fimpara

            escreva("Deseja reservar outro lugar? [S/N]")
            leia(resposta)
      ate(resposta = "n") ou (resposta = "N")
fimalgoritmo
```
---