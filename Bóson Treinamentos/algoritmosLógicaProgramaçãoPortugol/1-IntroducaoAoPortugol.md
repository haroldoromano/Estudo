# Comando escreva
~~~php
programa {
  funcao inicio() {
    escreva("Olá Mundo!")
  }
}
~~~
---

# Escopo de variáveis
~~~php
programa {
  real numeroglobal = 10.0 //Variável de escopo global, pode ser usada em qualquer lugar do programa.

  funcao inicio() {
    real numerolocal = 12.0 //Variável de escopo local, só pode ser usada dentro da função.
    escreva(numeroglobal, "\n")
    escreva(numerolocal, "\n")
  }
}
~~~
---

# Comando de entrada e saída de dados
~~~php
programa {
  inteiro valor

  funcao inicio() {
    escreva("Digite um valor: ") //Comando para exibir algo na tela, no caso solicitando entrada do usuário.
    leia(valor) //Comando que atribui valor a uma variável.
    escreva(valor) //Comando para exibir algo na tela, no caso o valor de uma variável.  
  }
}
~~~
---

# Operadores matemáticos
~~~php
programa {

  real numero1, numero2, resposta
  funcao inicio() {
    escreva("Digite o primeiro número: ")
    leia(numero1)
    escreva("Digite o segundo número: ")
    leia(numero2)

    resposta = numero1 + numero2 //Operação de soma.
    escreva("A soma entre ", numero1, " e ", numero2, " é igual a ", resposta, "\n")
    resposta = numero1 - numero2 //Operação de subtração.
    escreva("A subtração entre ", numero1, " e ", numero2, " é igual a ", resposta, "\n")
    resposta = numero1 * numero2 //Operação de multiplicação.
    escreva("A multiplicação entre ", numero1, " e ", numero2, " é igual a ", resposta, "\n")
    resposta = numero1 / numero2 //Operação de Divisão.
    escreva("A divisão entre ", numero1, " e ", numero2, " é igual a ", resposta, "\n")
    resposta = numero1 % numero2 //Operação de módulo(resto da divisão).
    escreva("O módulo entre ", numero1, " e ", numero2, " é igual a ", resposta, "\n")
  }
}
~~~
---

# Operadores relacionais
~~~php
programa {

  logico resposta
  inteiro numero1, numero2

  funcao inicio() {
    escreva("Digite o primeiro número: ")
    leia(numero1)
    escreva("Digite p segundo número: ")
    leia(numero2)

    resposta = numero1 == numero2 //Operador de comparação igual.
    escreva("O número ", numero1, " e o número ", numero2, " são iguais? ", resposta, "\n")
    resposta = numero1 != numero2 //Operador de comparação diferente.
    escreva("O número ", numero1, " e o número ", numero2, " são diferentes? ", resposta, "\n")
    resposta = numero1 > numero2 //Operador de comparação maior.
    escreva("O número ", numero1, " é maior que o número ", numero2, "? ", resposta, "\n")
    resposta = numero1 < numero2 //Operador de comparação menor.
    escreva("O número ", numero1, " é menor que o número ", numero2, "? ", resposta, "\n")
    resposta = numero1 >= numero2 //Operador de comparação maior igual
    escreva("O número ", numero1, " é maior ou igual ao número ", numero2, "? ", resposta, "\n")
    resposta = numero1 <= numero2 //Operador de comparação menor igual
    escreva("O número ", numero1, " é menor ou igual ao número ", numero2, "? ", resposta, "\n")
  }
}
~~~
---