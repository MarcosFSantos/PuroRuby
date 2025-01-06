<!-- Logo -->
<br />
<div align="center">
  <a href="https://github.com/MarcosFSantos/PuroRuby">
    <img src="https://github.com/user-attachments/assets/e3e244aa-d658-4809-ae3f-5c64c08af6fe" alt="Logo" width="934" height="345">
  </a>
</div>



<!-- Índice -->
<details>
  <summary>Índice</summary>
  <ol>
    <li><a href="#sobre">Sobre</a></li>
    <li>
      <a href="#o-que-é-um-framework">O que é um Framework?</a>
      <ul>
        <li><a href="#analogia-simples">Analogia Simples</a></li>
      </ul>
    </li>
    <li>
      <a href="#vantagens-de-não-usar-um-framework">Vantagens de não usar um Framework</a>
      <ul>
        <li><a href="#maior-compreensão-da-linguagem">Maior compreensão da linguagem</a></li>
        <li><a href="#controle-total-sobre-o-código">Controle total sobre o código</a></li>
        <li><a href="#maior-aprendizado">Maior aprendizado</a></li>
        <li><a href="#independência-de-ferramentas-específicas">Independência de ferramentas específicas</a></li>
        <li><a href="#demonstrar-habilidades-técnicas">Demonstrar habilidades técnicas</a></li>
      </ul>
    </li>
    <li>
        <a href="#preparação-do-ambiente">Preparação do Ambiente</a>
        <ul>
            <li>
                <a href="#instalação-do-git">Instalação do Git:</a>
                <ul>
                    <li><a href="#debianubuntu">Debian/Ubuntu:</a></li>
                    <li><a href="#macos">macOS:</a></li>
                    <li><a href="#windows">Windows:</a></li>
                </ul>
            </li>
            <li><a href="#clonar-o-repositório">Clonar o repositório:</a></li>
        </ul>
    </li>
    <li>
        <a href="#instalação">Instalação</a>
        <ul>
            <li><a href="#qual-escolher">Qual escolher?</a></li>
            <li>
                <a href="#rodando-com-docker">Rodando com Docker</a>
                <ul>
                    <li><a href="#pré-requisitos">Pré-requisitos:</a></li>
                    <li><a href="#instalação-do-docker-e-docker-compose">Instalação do Docker e Docker Compose:</a></li>
                    <li><a href="#execução-do-projeto">Execução do projeto:</a></li>
                </ul>
            </li>
            <li>
                <a href="#rodando-com-ruby-431-na-máquina">Rodando com Ruby 4.3.1 na máquina</a>
                <ul>
                    <li><a href="#pré-requisitos-1">Pré-requisitos:</a></li>
                    <li><a href="#instalação-do-ruby-431">Instalação do Ruby 4.3.1:</a></li>
                    <li><a href="#execução-do-projeto">Execução do projeto:</a></li>
                </ul>
            </li>
        </ul>
    </li>
  </ol>
</details>

<!-- status -->
<h3 align="center"> 
	🚧  Esse é um projeto em construção...  🚧
</h3>

## Sobre

O PuroRuby é um projeto de aplicação back-end construído apenas com a linguagem Ruby, sem o uso de Frameworks ou bibliotecas externas. O objetivo é mostrar como é possível criar uma solução funcional utilizando apenas os recursos nativos da linguagem.

<div align="center">
  <img src="https://github.com/user-attachments/assets/11f8ccaa-712c-46fd-b572-2313a06944b6" alt="Logo" width="800" height="600">
</div>

## O que é um Framework?

Um Framework é uma coleção de ferramentas, padrões e funcionalidades que ajudam os desenvolvedores a criarem aplicações de forma mais rápida e eficiente. Ele funciona como uma "estrutura pronta" que organiza e simplifica tarefas comuns no desenvolvimento, como:

 - Gerenciar rotas.

 - Acessar bancos de dados.

 - Lidar com segurança.

Em vez de criar tudo do zero, o Framework já oferece soluções padronizadas e testadas. Exemplos populares incluem:

 - Ruby on Rails (Ruby)

 - Django e Flask (Python)

 - Laravel (PHP)

### Analogia Simples:

Pense em um Framework como uma "caixa de ferramentas": ele oferece soluções prontas para a execução de determinadas finalidades.

![toolbox](https://github.com/user-attachments/assets/70f1825e-eee9-4f93-afef-79a619e445e5)

## Vantagens de não usar um Framework

Neste projeto, optei por não usar Frameworks ou bibliotecas externas para demonstrar minha habilidade em trabalhar diretamente com os fundamentos da linguagem Ruby. Aqui estão algumas razões para essa escolha:

### Maior compreensão da linguagem:

Sem Frameworks, é necessário implementar soluções do zero, o que ajuda a entender profundamente como a linguagem funciona.

### Controle total sobre o código:

Não há dependências externas ou "código oculto". Isso permite total controle sobre cada linha de código e facilita customizações.

### Maior aprendizado:

Construir do zero obriga a explorar conceitos fundamentais, como:

 - Gerenciamento de requisições HTTP.

 - Manipulação de dados.

 - Boas práticas de estruturação de código.

### Independência de ferramentas específicas:

Ao dominar a linguagem pura, fico livre para trabalhar com ou sem Frameworks, adaptando-me melhor a diferentes projetos no futuro.

### Demonstrar habilidades técnicas:

Este projeto é uma prova de que é possível construir aplicações robustas apenas com os recursos nativos da linguagem, mostrando minha capacidade técnica e flexibilidade como desenvolvedor.

# Preparação do Ambiente

Antes de rodar o projeto, clone o repositório para um repositório Git local. Para isso o Git deverá está instalado na sua máquina.

Para verificar se o Git está instalado na sua máquina, execute o seguinte comando:

```
git --version
```

Se o retorno mostrar a versão do Git é porque você ja tem o Git instalado na sua máquina e pode proseguir para a [clonagem do repositório](#clonar-o-repositório). Porém se o retorno não foi o esperado, siga a [etapa abaixo](#instalação-do-git) para instalar o Git.

## Instalação do Git:

### Debian/Ubuntu:

 - Abra o Terminal e execute:

```
apt-get install git
```

Para outras distribuições Linux, acesse aqui para ver como instalar: https://git-scm.com/downloads/linux

### macOS:

 - Abra o Terminal e execute:

```
brew install git
```

Para outros terminais, acesse aqui para ver como instalar: https://git-scm.com/downloads/mac

### Windows:

Para windows, acesse aqui para escolher o instalador: https://git-scm.com/downloads/win

## Clonar o repositório:

 - Abra o terminal na pasta que você deseja que o projeto fique.
 - No terminal execute:

```
git clone https://github.com/MarcosFSantos/PuroRuby.git
```

 - Depois execute:

```
cd PuroRuby
```

Pronto! Você esta dentro da pasta do projeto.

# Instalação

Este projeto pode ser executado de duas maneiras:

 - Utilizando Docker e Docker Compose.
 - Utilizando o Ruby 4.3.1 diretamente na sua máquina.

### Qual escolher?

 - __Docker:__
Escolha esta opção se você deseja evitar a instalação de Ruby 4.3.1 na sua máquina. O Docker encapsula todo o ambiente necessário para rodar o projeto, garantindo consistência independente do sistema operacional. Recomendado se você já tem o Docker e Docker Compose instalados.

 - __Ruby 4.3.1 na máquina:__
Escolha esta opção se você já tem o Ruby 4.3.1 instalado ou se prefere configurar seu ambiente local manualmente.

## Rodando com Docker

### Pré-requisitos:

 - Docker
 - Docker Compose

### Instalação do Docker e Docker Compose:

 - __No Ubuntu:__
Para Ubuntu, Acesse aqui e siga as instruções: https://docs.docker.com/desktop/setup/install/linux/ubuntu/

Para outras distribuições Linux, acesse aqui: https://docs.docker.com/desktop/setup/install/linux/

 - __No macOS:__
 Acesse aqui para escolher o instalador: https://www.docker.com/products/docker-desktop/

 - __No Windows:__
 Acesse aqui para escolher o instalador: https://www.docker.com/products/docker-desktop/

### Execução do projeto:

 - Abra o Terminal na pasta do projeto
 - Execute o seguinte comando

```
docker compose up
```

Pronto! O servidor estará rodando na porta 5000, e você pode se conectar a ele usando NetCat para interagir com o projeto. Basta executar o seguinte comando em um novo Terminal para interagir em um chat com o Servidor. Para sair do chat use CTRL+C ou simplesmente feche o Terminal.

```
nc localhost 5000
```

Para parar o Servidor, basta usar CTRL+C no Terminal no qual ele esta rodando.

## Rodando com Ruby 4.3.1 na máquina

### Pré-requisitos:

 - Ruby 4.3.1

### Instalação do Ruby 4.3.1:

 - __No Ubuntu/Debian:__
Instale o gerenciador de versões Ruby (rbenv ou RVM) e instale o Ruby 4.3.1:
```
sudo apt update && sudo apt install curl git -y
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-installer | bash
rbenv install 4.3.1
rbenv global 4.3.1
```

 - __No macOS (com Homebrew):__
```
brew install rbenv
rbenv install 4.3.1
rbenv global 4.3.1
```

 - __No Windows:__ Siga este guia para instalar Ruby: https://rubyinstaller.org/

### Execução do projeto:

 - Abra o Terminal na pasta do projeto
 - Execute o seguinte comando

```
ruby main.rb
```

Pronto! O servidor estará rodando na porta 5000, e você pode se conectar a ele usando NetCat para interagir com o projeto. Basta executar o seguinte comando em um novo Terminal para interagir em um chat com o Servidor. Para sair do chat use CTRL+C ou simplesmente feche o Terminal.

```
nc localhost 5000
```

Para parar o Servidor, basta usar CTRL+C no Terminal no qual ele esta rodando.
