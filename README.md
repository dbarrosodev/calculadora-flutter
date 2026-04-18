# Calculadora Flutter - Projeto de Aprendizado

Este projeto é uma calculadora funcional desenvolvida em **Flutter**, criada como parte de um processo de aprendizado intensivo de uma semana. O foco do projeto foi dominar o gerenciamento de estados, lógica de programação em Dart e a criação de interfaces responsivas.

## 🚀 Funcionalidades

- **Operações Básicas**: Soma, subtração, multiplicação e divisão.
- **Funções Especiais**:
  - Cálculo de Raiz Quadrada (√) com arredondamento.
  - Botão AC (All Clear) para resetar todo o estado.
  - Botão CE (Clear Entry) para limpar o visor atual.
- **Interface Responsiva**:
  - Layout que se adapta a diferentes tamanhos de tela.
  - Uso de `Expanded` e `RoundedRectangleBorder` para botões flexíveis.
  - Visor com alinhamento à direita e estilo moderno.
- **Lógica de Estado**: Implementação robusta utilizando `StatefulWidget` e `setState` para controlar a memória da calculadora (primeiro número, operador e segundo número).

## 🛠️ Tecnologias Utilizadas

- **Dart**: Linguagem de programação base.
- **Flutter**: Framework para desenvolvimento cross-platform.
- **Dart:Math**: Biblioteca utilizada para cálculos matemáticos avançados (Raiz Quadrada).

## 📱 Demonstração de Layout

O projeto utiliza uma `Column` principal que organiza o visor (`Screen`) e as fileiras de botões (`ButtonRow`), garantindo que os elementos ocupem o espaço de forma proporcional.

## 🧠 Aprendizados Chave

1. **Gerenciamento de Estado**: Transição de `Stateless` para `StatefulWidget` para permitir interatividade.
2. **Callbacks**: Passagem de funções como parâmetros entre widgets pais e filhos.
3. **Conversão de Tipos**: Manipulação de `String` para `double` e vice-versa para cálculos e exibição.
4. **Responsividade**: Uso de widgets flexíveis para evitar erros de transbordamento de pixels (overflow).

## ✒️ Autor

Desenvolvido por **Daniel**, estudante focado em programação e desenvolvimento de jogos.