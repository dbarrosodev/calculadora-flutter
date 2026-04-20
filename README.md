# Calculadora em Flutter 🧮

Um projeto de uma calculadora interativa, colorida e robusta desenvolvida com o *framework* Flutter. A aplicação apresenta um design intuitivo com um ecrã que simula os mostradores digitais clássicos (LCD) e teclas organizadas por cores para facilitar a usabilidade.

## ✨ Funcionalidades

A calculadora vai além do básico, incluindo funções avançadas de memória e tratamentos de erro para garantir uma excelente experiência de utilização sem *crashes* inesperados.

### Operações Suportadas
* **Básicas:** Adição (`+`), Subtração (`-`), Multiplicação (`×`) e Divisão (`÷`). (Inclui proteção contra divisão por zero).
* **Avançadas:** Raiz Quadrada (`√`) com aviso de "Erro" para números negativos, e Percentagem (`%`).
* **Gestão de Memória:** * `M+`: Adiciona o valor atual do ecrã à memória.
    * `M-`: Subtrai o valor atual do ecrã da memória.
    * `MRC`: Apresenta o valor guardado na memória.
* **Limpeza e Correção:**
    * `AC`: (*All Clear*) Limpa todo o estado da calculadora (ecrã, memória, totais).
    * `CE`: (*Clear Entry*) Limpa apenas o valor atual introduzido no ecrã.
    * `->`: (*Backspace*) Apaga o último dígito introduzido.
* **Especiais:**
    * `GT`: (*Grand Total*) Regista e soma todos os resultados calculados ao carregar no botão `=`.
    * Tratamento inteligente do ponto decimal (impede a introdução de múltiplos pontos, ex: `3.5.2`) e suporte ao botão de duplo zero (`00`).

## 🎨 Design e Interface (UI/UX)

* **Tipografia Personalizada:** Utiliza o pacote `google_fonts` para um aspeto retro/tecnológico (`Share Tech Mono` no ecrã) e moderno nas teclas (`Varela Round`).
* **Layout Responsivo:** Desenvolvido com *widgets* como `Expanded`, `FittedBox` e `AspectRatio`, garantindo que a calculadora se adapta de forma fluida a diferentes tamanhos de ecrã.
* **Esquema de Cores:** Botões categorizados por cores (Laranja, Verde, Amarelo, Rosa, Roxo e Ciano) para facilitar a navegação visual.

## 🛠️ Tecnologias Utilizadas

* **[Flutter](https://flutter.dev/):** *Framework* principal para o desenvolvimento da interface.
* **[Dart](https://dart.dev/):** Linguagem de programação.
* **[Google Fonts](https://pub.dev/packages/google_fonts):** Pacote externo para a gestão das fontes tipográficas.

## 🚀 Como Correr o Projeto

### Pré-requisitos
Certifique-se de que tem o ambiente Flutter instalado e configurado na sua máquina.

### Passos
1. Faça o clone deste repositório ou descarregue o código fonte.
2. Abra o terminal na pasta raiz do projeto.
3. Obtenha as dependências necessárias (neste caso, o `google_fonts`):
   ```bash
   flutter pub get
   ```
4. Execute a aplicação num emulador ou dispositivo físico:
   ```bash
   flutter run
   ```

## 📁 Estrutura do Código

* `_MainAppState`: Gere toda a lógica de estado, atualizações do visor, conversão segura de números (`double.tryParse`) e os cálculos matemáticos.
* `Screen`: O *widget* responsável pela renderização do mostrador superior com o fundo esverdeado estilo LCD.
* `ButtonRow`: Um *widget* reutilizável que desenha e organiza as linhas de botões circulares da calculadora de forma proporcional.

*** *Desenvolvido em Flutter com foco na robustez e na experiência de utilizador.*