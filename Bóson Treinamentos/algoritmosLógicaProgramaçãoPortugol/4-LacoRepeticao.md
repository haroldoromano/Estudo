# Enquanto
~~~php
programa {

  inteiro numero

  funcao inicio() {
    numero = 1

    enquanto(numero <= 10) { //O laço enquanto não ser executado, caso o teste condicional seja falso.
      escreva(numero, "\n")
      numero++
    }  
  }
}
~~~
---

# Enquanto
~~~php
programa {

  cadeia nome

  funcao inicio() {
    enquanto(nome != "x") {
      escreva("Digite seu nome ou x para sair. \n")
      leia(nome)
    }
    escreva("Até logo!")
  }
}

~~~
---

# Para
~~~php
programa {
  
  inteiro contador

  funcao inicio() {
    para(contador = 1; contador <= 10; contador++) { //Laço para deve ser usado quando se sabe o numero exato de repetições que ele executará.
      escreva(contador, "\n")
    }  
  }
}

~~~
---

# Para
~~~php
programa {
  
  inclua biblioteca Util

  inteiro contador, numero, vezes

  funcao inicio() {

    escreva("Gerar números da loteria. \n")
    escreva("Digite quantos números deseja gerar: ")
    leia(vezes)

    para(contador = 1; contador <= vezes; contador++) { //Laço para deve ser usado quando se sabe o numero exato de repetições que ele executará.
      numero = Util.sorteia(1, 50)
      escreva(numero, " ")
    }
  }
}
~~~
---

# Laço encadeado
~~~php
programa {

  inteiro contador1, contador2

  funcao inicio() {
    para(contador1 = 1; contador1 <= 3; contador1++) {
      escreva("Contador1: ", contador1, "\n")
      para(contador2 = 1; contador2 <= 3; contador2++) {
        escreva("   Contador2: ", contador2, "\n")
      }
    }  
  }
}

~~~
---

# Laço encadeado
~~~php
programa {

  inclua biblioteca Util

  inteiro contador, valor

  funcao inicio() {
    escreva("Para sair do programa digite 0 \n")
    enquanto(verdadeiro) {
      escreva("\nQuantos valores deseja gerar? ")
      leia(valor)
      se(valor == 0) {
        pare
      }
      para(contador = 1; contador <= valor; contador++) {
        escreva(Util.sorteia(1, 1000), " - ")
      }
    }  
  }
}
~~~
---