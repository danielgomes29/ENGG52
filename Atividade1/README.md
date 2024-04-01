# Módulo Robô

## Descrição
O módulo `Robo` é uma implementação em Verilog de um controle simples para um robô. Ele recebe sinais de entrada representando sensores de cabeça e esquerda, um sinal de clock e um sinal de reset, e fornece sinais de saída para controlar o avanço e a rotação do robô.

## Entradas
- `head`: Sinal de entrada que representa o estado do sensor de cabeça.
- `left`: Sinal de entrada que representa o estado do sensor da esquerda.
- `clock`: Sinal de clock para sincronização.
- `reset`: Sinal de reset para inicializar o sistema.

## Saídas
- `avancar`: Sinal de saída para controlar o movimento para frente do robô.
- `girar`: Sinal de saída para controlar a rotação do robô.

## Funcionamento
O módulo utiliza um registrador de estado e uma máquina de estados finitos (FSM) para controlar o comportamento do robô. O estado do robô é atualizado com base nos sinais de entrada, e as saídas são determinadas de acordo com o estado atual e os sinais de entrada.

## Implementação
O módulo consiste em três estados principais:
1. `procurandoMuro`: Estado em que o robô está procurando por uma parede.
2. `Rotacionando`: Estado em que o robô está rotacionando.
3. `AcompanhandoMuro`: Estado em que o robô está acompanhando uma parede.
