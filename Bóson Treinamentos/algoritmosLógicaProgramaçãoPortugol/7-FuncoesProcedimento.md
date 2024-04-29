# Escreve mensagem na tela
~~~php
programa {
  funcao inicio() {
    mostraMensagem()
  }

  //Criação de uma rotina simples
  funcao mostraMensagem() {
    escreva("Função que escreve uma mensagem na tela. \n")
  }
}
~~~
---

# Realiza um cálculo
~~~php
programa {
  inteiro valor

  funcao inicio() {
    escreva("Digite um valor para calcular: ")
    leia(valor)

    calculaCubo(valor)
  }
  funcao calculaCubo(inteiro numero) {
    escreva("Cálculo do cubo de um número.\n")
    inteiro calculo = numero * numero *numero
    escreva("O resultado é ", calculo)
  }
}

~~~
---

# Realiza um cálculo e retorna um valor para o programa principal
~~~php
programa {
  funcao inicio() {
    real largura, comprimento, total
    
    escreva("Qual a largura do terreno? ")
    leia(largura)
    escreva("Qual o comprimento do terreno? ")
    leia(comprimento)

    total = calculoArea(largura, comprimento)

    escreva("A área total do terreno é ", total)    
  }

  funcao calculoArea(real l, real c) {
    real area = 0.0
    area = l * c
    retorne area
  }
}
~~~
---

# Passando vários parametros para uma função
~~~php
programa {
  inteiro inicial, final

  funcao inicio() {
    escreva("Digite o valor inicial: ")
    leia(inicial)
    escreva("Digite o valor final: ")
    leia(final)

    contar(inicial, final)
  }
  
  funcao contar(inteiro x, inteiro y) {
    para(inteiro i = x; i <= y; i++) {
      escreva(i, " ")
    }    
  }
}
~~~
---

# Função para retornara valores
~~~php
programa {
  inclua biblioteca Matematica

  real raio, total

  funcao inicio() {
    escreva("Qual o raio do circulo, em cm? ")
    leia(raio)

    total = calculaArea(raio)
    
    escreva("A área do círculo é ", total, "cm2.")
  }

  funcao calculaArea(real r) {
    real areaCirculo = 0.0
    areaCirculo = Matematica.PI * r * raio
    retorne areaCirculo
  }
}
~~~
---

# Algoritmo para validar CPF
~~~php
programa {
  inclua biblioteca Texto
  inclua biblioteca Tipos

  cadeia cpf
  inteiro digito1, digito2
  inteiro cpfDigito[11]
  logico resposta = falso

  funcao inicio() {
    escreva("Digite o CPF para validar: ")
    leia(cpf)

    para(inteiro i = 0; i < 11; i++) {
      cpfDigito[i] = Tipos.caracter_para_inteiro(Texto.obter_caracter(cpf, i))
    }

    resposta = validarCpf(cpfDigito)

    se(resposta == verdadeiro) {
      escreva("CPF válido!")
    }
    senao {
      escreva("CPF inválido!")
    }
   }

  funcao logico validarCpf(inteiro numero[]) {
    inteiro contador1, contador2, soma, resto, digiVerifica1, digiVerifica2

    //Dígito verificador 1
    soma = 0
    contador2 = 10

    para(contador1 = 0; contador1 < 9; contador1 ++) {
      soma = soma + numero[contador1] * contador2
      contador2 = contador2 - 1
    }

    resto = soma % 11

    se(resto < 2) {
      digiVerifica1 = 0
    }
    senao {
      digiVerifica1 = 11 - resto
    }

    //Dígito verificador 2
    soma = 0
    contador2 = 11

    para(contador1 = 0; contador1 < 10; contador1++) {
      soma = soma + numero[contador1] * contador2
      contador2 = contador2 - 1
    }

    resto = soma % 11

    se(resto < 2) {
      digiVerifica2 = 0      
    }
    senao {
      digiVerifica2 = 11 - resto
    }

    se((numero[9] == digiVerifica1) e (numero[10] == digiVerifica2)) {
      retorne verdadeiro
    }
    senao {
      retorne falso
    }
  }
}
~~~
---

# Algoritmo para gerar CPF
~~~php
programa {
  inclua biblioteca Util

  inteiro gerado[11]
  inteiro geradigito[11]
  inteiro contador, auxiliar = 0, soma = 0, verificador = 0

  funcao inicio() {
    //Gera os 9 digitos aleatóriamente.
    para(contador = 0; contador < 9; contador++) {
      gerado[contador] = Util.sorteia(0, 9)
    }

    //Processo para obter o primeiro digito verificador.
    //Faz a multiplicação dos valores: posição 0 * 10, posição 1 * 9... no final soma o resultado de todas as multiplicações.
    para(contador = 0; contador < 9; contador++) {
      geradigito[contador] = gerado[contador] * (10 - contador)
        soma = soma + geradigito[contador]
    }

    //Extrai o módulo (resto da divisão inteira)
    auxiliar = soma % 11
    //Subtrai 11 do resultado anterior e o resultado é digito verificador.
    verificador = 11 - auxiliar
    //O digito verificador um é inserido na posião 9 do vetor.
    gerado[9] = verificador
    //Zera as variáveis
    soma = 0
    auxiliar = 0
    verificador = 0

    //para obter o segundo digito verificador.
    //Faz a multiplicação dos valores: posição 0 * 11, posição 1 * 10... no final soma o resultado de todas as multiplicações.
    para(contador = 0; contador < 10; contador++) {
      geradigito[contador] = gerado[contador] * (11 - contador)
       soma = soma + geradigito[contador]
    }
    
    //Extrai o módulo (resto da divisão inteira)
    auxiliar = soma % 11
    //Subtrai 11 do resultado anterior e o resultado é digito verificador.
    verificador = 11 - auxiliar
    //O digito verificador dois é inserido na posião 10 do vetor.
    gerado[10] = verificador
    
    //Mostra um CPF válido
    escreva("\nCPF completo: ")
    para(contador = 0; contador < 11; contador++) {
      escreva(gerado[contador], " ")
    }
  }
}
~~~
---
l