# Exercício 1

```
algoritmo "Aluno"
var
   nota1, nota2, media: real
inicio
      escreva("Primeira nota: ")
      leia(nota1)
      escreva("Segunda nota: ")
      leia(nota2)
      media <- (nota1 + nota2) / 2
      escreval("A media do aluno foi ", media:4:2)
      se (media >= 7) entao
         escreval("ALUNO APROVADO")
      senao
           se (media >= 5) e (media < 7) entao
              escreva("ALUNO EM RECUPERACAO")
           senao
                escreva("ALUNO REPROVADO")
           fimse
      fimse
fimalgoritmo
```
---

# Exercício 2

```
algoritmo "CalculoIMC"
var
   massa, altura, imc: real
inicio
      escreva("Massa(kg): ")
      leia(massa)
      escreva("Altura(m): ")
      leia(altura)
      imc <- massa / (altura ^ 2)
      escreval("IMC: ", imc:5:2)
        se (imc < 17) entao
            escreval("Muito abaixo do peso")
        senao
            se (imc >= 17) e (imc < 18.5) entao
                escreval("Abaixo do peso")
            senao
                se (imc >= 18.5) e (imc < 25) entao
                    escreval("Peso ideal")
                senao
                    se (imc >= 25) e (imc < 30) entao
                        escreval("Sobrepeso")
                    senao
                        se (imc >= 30) e (imc < 35) entao
                            escreval("Obesidade")
                        senao
                            se (imc >= 35) e (imc < 40) entao
                                escreval("Obesidade severa")
                            senao
                                escreval("Obesidade morbida")
                            fimse
                        fimse
                    fimse
                fimse
            fimse
        fimse
fimalgoritmo
```
---

# Exercício 3

```
algoritmo "CriancaEsperanca"
var
   opcao: inteiro
   doacao: real
inicio
      escreval("-------------------")
      escreval(" CRIANCA ESPERANCA ")
      escreval("-------------------")
      escreval("Muito obrigado por ajudar")
      escreval("[1] para doar R$10")
      escreval("[2] para doar R$25")
      escreval("[3] para doar R$50")
      escreval("[4] para doar outros valores")
      escreval("[5] para cancelar")
      leia (opcao)
      escolha opcao
              caso 1
                   doacao <- 10
              
              caso 2
                   doacao <- 25
              
              caso 3
                   doacao <- 50
              
              caso 4
                   escreval("")
                   escreva("Qual o valor da doacao? R$")
                   leia(doacao)
              
              caso 5
                   doacao <- 0
      fimescolha
      escreval("")
      escreval("----------------------------")
      escreval("SUA DOACAO FOI DE R$", doacao)
      escreval("MUITO OBRIGADO!")
      escreval("----------------------------")
fimalgoritmo
```
---

# Exercício 4

```
algoritmo "DependentesFuncionario"
var
   nome: caractere
   salario, novosalario: real
   dependente: inteiro
inicio
      escreva("Qual o nome do funcionaro? ")
      leia(nome)
      escreva("Qual o salario do funcionario? R$ ")
      leia (salario)
      escreva("Qual e a quantidade de dependentes? ")
      leia (dependente)
      escolha dependente
              caso 0
                   novosalario <- salario + (salario * 5 / 100)

              caso 1, 2, 3
                   novosalario <- salario + (salario * 10 / 100)

              caso 4, 5, 6
                   novosalario <- salario + (salario * 15 / 100)

              outrocaso
                   novosalario <- salario + (salario * 18 / 100)
      fimescolha
      escreval("O novo salario de ", nome, " sera de R$", novosalario:5:2)
fimalgoritmo
```
---

# Exercício 5

```
algoritmo "Escola"
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
      
      media <- (nota1 + nota2) / 2
      
      escreval("")
      escreval("---------------------")
      escreval("MEDIA: ", media:4:2)
      
      se (media > 9) entao
         escreval("Aproveitamento: A")
      senao
           se (media <= 9) e (media > 8) entao
              escreval("Aproveitamento: B")
           senao
                se (media <= 8) e (media > 7) entao
                   escreval("Aproveitamento: C")
                senao
                     se (media <= 7) e (media > 6) entao
                        escreval("Aproveitamento: D")
                     senao
                          se (media <= 6) e (media > 5) entao
                             escreval("Aproveitamento: E")
                          senão
                               escreval("Aproveitamento: F")
                          fimse
                     fimse
                fimse
           fimse
      fimse
      escreval("---------------------")
fimalgoritmo
```
---

# Exercício 6

```
algoritmo "JogoFutebol"
var
   time1, time2, gols: inteiro
inicio
      escreval("")
      escreval("BANGU X MADUREIRA")
      escreval("")
      escreval("-----------------")
      escreva("Quantos gosls do BANGU? ")
      leia(time1)
      escreva("Quantos gosls do MADUREIRA? ")
      leia(time2)
      escreval("-----------------")
      escreval("")
      se (time1 > time2) entao
         gols <- time1 - time2
      senao
           gols <- time2 - time1
      fimse
          escreval("DIFERENCA: ", gols)
      se (gols = 0) entao
         escreval("STATUS: EMPATE")
      senao
           se (gols > 0) e (gols <= 4) entao
              escreval("STATUS: JOGO NORMAL")
           senao
                escreval("STATUS: GOLEADA")
           fimse
      fimse
      escreval("-----------------")
fimalgoritmo
```
---

# Exercício 7

```
algoritmo "JogoFutebol"
var
   time1, time2, gols: inteiro
inicio
      escreval("")
      escreval("BANGU X MADUREIRA")
      escreval("")
      escreval("-----------------")
      escreva("Quantos gosls do BANGU? ")
      leia(time1)
      escreva("Quantos gosls do MADUREIRA? ")
      leia(time2)
      escreval("-----------------")
      escreval("")
      se (time1 > time2) entao
         gols <- time1 - time2
      senao
           gols <- time2 - time1
      fimse
      escreval("DIFERENCA: ", gols)
      escolha gols
              caso 0
                   escreval("STATUS: EMPATE")

              caso 1, 2, 3, 4
                   escreval("STATUS: JOGO NORMAL")
              outrocaso
                   escreval("STATUS: GOLEADA")
      fimescolha
      escreval("-----------------")
fimalgoritmo
```
---