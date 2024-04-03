# Utilizando bibliotecas
~~~php
programa {

  inclua biblioteca Matematica //Comando para incluir bibliotecas no Portugol
  inclua biblioteca Texto --> t //Crindo apelidos para bibliotecas
  inclua biblioteca Calendario
  inclua biblioteca Util

  cadeia nome
  inteiro contador

  funcao inicio() {
    escreva(Matematica.PI, "\n") //Nome da biblioteca + função
    escreva("Digite seu nome: ")
    leia(nome)
    escreva(t.caixa_alta(nome), "\n") //Apelido biblioteca + função
    escreva("Estamos no ano de ", Calendario.ano_atual(), "\n")

    para(contador = 0; contador <= 10; contador++) {
      escreva(contador, "\n")
      Util.aguarde(1000)
    }
  }
}

~~~
---

# Gerando númeoros aleatórios
~~~php
programa {
  inclua biblioteca Util

  inteiro  numero, contador

  funcao inicio() {
    escreva("Gerar um número aleatório \n")
    numero = Util.sorteia(1, 10) //Função para gerar um número aleatório usando a biblioteca Util.
    escreva("Número gerado: ", numero, "\n") 

    escreva("Gerar vários números aleatórios \n")
    para(contador = 1; contador <= 10; contador++) {
      numero = Util.sorteia(1, 100)
      escreva("O ", contador, "º número gerado foi: ", numero, "\n")
    }
  }
}
~~~
--- 