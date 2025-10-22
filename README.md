# 🎮 Jogo de Treino de Tabuada

Aplicativo interativo para treinar a tabuada de multiplicação. O jogo gera multiplicações com números aleatórios de 1 a 10 e ajusta o tempo limite das respostas com base no desempenho do jogador, tornando o desafio progressivamente mais interessante.

---

## 📱 Funcionalidades

- Geração aleatória de multiplicações (1 a 10).  
- Timer dinâmico adaptado ao desempenho do jogador.  
- Registro de acertos, erros e pontuação.  
- Armazenamento do score com **SharedPreferences**.  
- Feedback instantâneo sobre respostas corretas e incorretas.  

---

## 🧩 Estrutura do Projeto

Embora não siga uma arquitetura formal como MVVM, o código é organizado em camadas para melhor manutenção:

- **models/** → Modelos de dados (ex: jogador, resultado).  
- **services/** → Lógica do jogo e controle de pontuação.  
- **views/** → Telas principais e de resultado.  
- **widgets/** → Componentes reutilizáveis da interface.  

---

## 🛠️ Tecnologias Utilizadas

- **Linguagem:** Dart  
- **Framework:** Flutter  
- **Persistência local:** SharedPreferences  
- **Gerenciamento de estado:** `setState` simples  
- **Geração de desafios:** Random API nativa do Dart  

---

## 🚀 Execução

1. Clone o repositório:
   ```bash
   git clone https://github.com/seuusuario/jogo-tabuada.git
2. Instale as dependências:
   ```bash
   flutter pub get
3. Execute o App:
   ```bash
   flutter run

## 👨‍💻 Autor

Regis Ferreira
Aluno do curso de Tecnologia em Sistemas para Internet
Universidade Tecnológica Federal do Paraná (UTFPR)
Disciplina: Desenvolvimento Mobile 2
