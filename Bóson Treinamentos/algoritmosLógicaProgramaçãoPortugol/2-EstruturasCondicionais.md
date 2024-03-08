# Condicional simples
~~~php
programa {

  real nota1, nota2, media

  funcao inicio() {
    escreva("Digite a pimeira nota: ")
    leia(nota1)
    escreva("Digite a segunda nota: ")
    leia(nota2)

    media = (nota1 + nota2) /2

    se(media >= 7) {
      escreva("Resultado: Aprovado! \n")
    }
    escreva("Sua média foi: ", media)  
  }
}
~~~
---

# Condicional simples
~~~php
programa {

  real nota1, nota2, media

  funcao inicio() {
    escreva("Digite a pimeira nota: ")
    leia(nota1)
    escreva("Digite a segunda nota: ")
    leia(nota2)

    media = (nota1 + nota2) /2

    se((media >= 5) e (media < 7)) {
      escreva("Resultado: Recuperação \n")
    }
    escreva("Sua média foi: ", media)  
  }
}
~~~
---

# Condicional composta
~~~php
programa {

  real nota1, nota2, media

  funcao inicio() {
    escreva("Digite a pimeira nota: ")
    leia(nota1)
    escreva("Digite a segunda nota: ")
    leia(nota2)

    media = (nota1 + nota2) /2

    se(media >= 7) {
      escreva("Resultado: Aprovado \n")
    }
    senao {
      escreva("Resultado: Reprovado \n")
    }
    escreva("Sua média foi: ", media)  
  }
}
~~~
---

# Desvio condicional encadeado
~~~php
programa {

  real nota1, nota2, media

  funcao inicio() {
    escreva("Digite a primeira nota: ")
    leia(nota1)
    escreva("Digite a segunda nota: ")
    leia(nota2)

    media = (nota1 + nota2) / 2

    se(media >= 7) {
      escreva("Aprovado \n")
    }
    senao se(media >= 5) {
      escreva("Recuperação \n")
    }
    senao {
      escreva("Reprovado \n")
    }
    escreva("Sua média foi: ", media)
  }
}
~~~
---

# Exercício 1
~~~php
programa {

  real nota1, nota2, media
  inteiro falta

  funcao inicio() {
    escreva("Digite a primeira nota: ")
    leia(nota1)
    escreva("Digite a segunda nota: ")
    leia(nota2)
    escreva("Digite o número de faltas: ")
    leia(falta)

    media = (nota1 + nota2) / 2

    se((media >= 7) e (falta < 10)) {
      escreva("Aprovado \n")
    }
    senao se((media >= 5) e (falta < 10)) {
      escreva("Recuperação \n")
    }
    senao {
      escreva("Reprovado \n")
    }
    escreva("Sua média foi: ", media)
  }
}
~~~
---

# Desvio condicional Escolha CASO
~~~php
programa {
  
  caracter opcao

  funcao inicio() {
    escreva("Digite uma letra: ")
    leia(opcao)

    escolha(opcao) {
      caso 'a':
        escreva("Letra digitada: a \n")
        pare
      caso 'b':
        escreva("Letra digitada: b \n")
        pare
      caso contrario:
        escreva("Letra digitada não cadastrada.")
    } 
  }
}
~~~
---