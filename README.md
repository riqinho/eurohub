# 📱 Eurohub (Frontend Flutter)

O **Eurohub** é um aplicativo desenvolvido em **Flutter** como parte de um projeto acadêmico em parceria com a Eurofarma.  
O objetivo é criar uma plataforma digital para fortalecer **cultura** e **engajamento** dos colaboradores, com foco em inovação e experiências gamificadas.

Este repositório contém **apenas o frontend em Flutter**.

---

## ✨ Funcionalidades implementadas

- **Autenticação visual**  
  - Tela de login estilizada com campos `TextField` arredondados.  
  - Botão de login principal e opções de login social (Google, Facebook, Apple).  

- **Onboarding / Splash**  
  - Logo e header customizado com `Stack` e curvas em SVG.  
  - Controle de exibição de telas de introdução usando `SharedPreferences`.  

- **Home**  
  - Saudação com nome do usuário e avatar.  
  - Barra de busca “pill” arredondada.  
  - **Minha Jornada**: card com progresso de nível (`LinearProgressIndicator` arredondado).  
  - **Conquistas recentes**: ícones circulares.  
  - **Minhas contribuições**: cards listando ideias/desafios do colaborador.  

- **Navegação por rotas nomeadas**  
  - `/login` → Tela de autenticação  
  - `/home` → Home principal  
  - `/ideas` → Ideias do colaborador  
  - `/challenges` → Desafios disponíveis  
  - `/profile` → Perfil  
  - `/admin` → Área do gestor (protótipo)

---

## 🛠️ Tecnologias

- **Flutter** (SDK 3.x)
- **Dart**
- **flutter_svg** (para renderizar SVGs)
- **SharedPreferences** (armazenar preferências locais)
- Estrutura modular por **screens/**, **widgets/** e **theme/**

---

## 🚀 Como rodar

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/eurohub-flutter.git
   cd eurohub-flutter

2. Instale as dependências:
   ```bash
   flutter oub get

3. Rode no emulador ou dispositivo físico:
   ```bash
   flutter run

---

## 📌 Status do projeto
- Protótipo funcional (Frontend)
- Integração com backend (Java + Oracle SQL) ainda não implementada
- Próximos passos: fluxo de submissão de ideias, dashboards do gestor e IA simulada
