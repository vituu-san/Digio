# Digio
Projeto desenvolvido para candidatura à vaga de Desenvolvedor iOS na Iventis.

Este projeto foi desenvolvido em Swift 4.2, seguindo a arquitetura MVVM (Model-View-ViewModel). O projeto utiliza `URLSession` para chamadas de rede, `SnapKit` para criação de layouts programáticos, e `SwiftLint` para garantir a qualidade do código. O deployment target está definido para iOS 12.

## Requisitos

- Xcode 10.2 ou superior
- Swift 4.2
- iOS 12.0 ou superior

## Estrutura do Projeto
O projeto está organizado seguindo o padrão MVVM:

- **Model**: Contém as estruturas de dados e lógica de negócio.
- **View**: Contém a UI, construída programaticamente usando `SnapKit`.
- **ViewModel**: Contém a lógica de apresentação e manipulação dos dados para as Views.

## Dependências
As dependências do projeto são gerenciadas via Swift Package Manager (SPM):

- **SnapKit**: Utilizado para criar layouts programaticamente.
- **SwiftLint**: Utilizado para manter o estilo de código consistente.

### Adicionando Dependências com Swift Package Manager

1. Abra o projeto no Xcode.
2. No menu superior, vá para `File` > `Swift Packages` > `Add Package Dependency`.
3. Adicione as seguintes dependências:

- **SnapKit**:
    - URL: [https://github.com/SnapKit/SnapKit]
    - Versão: `5.0.0` ou mais recente
- **SwiftLint**:
    - URL: [https://github.com/realm/SwiftLint]
    - Versão: `0.43.0` ou mais recente

## Configuração do SwiftLint
Para garantir um código limpo e organizado, o SwiftLint foi integrado ao projeto. 

### Instalação do SwiftLint
Se ainda não tiver o SwiftLint instalado, siga os passos abaixo:

- Via Homebrew: (Se você não tem o Homebrew instalado. Visite [esta página](https://brew.sh/) para instalá-lo)

```bash
brew install swiftlint
```

### Integrando o SwiftLint ao Projeto
Um script de execução foi adicionado nas fases de build do Xcode:

1. No Xcode, selecione o target do projeto.
2. Vá para a aba Build Phases.
3. Clique no + e selecione New Run Script Phase.
3. Adicione o seguinte script:

```bash
if which swiftlint >/dev/null; then
  swiftlint
else
  echo "warning: SwiftLint não está instalado. Instale com 'brew install swiftlint' ou adicione ao PATH."
fi
```

5. Posicione essa fase após a fase de "Compile Sources".

### Configuração do SwiftLint
Um arquivo .swiftlint.yml foi adicionado na raiz do projeto para configurar as regras de linting.

**OBS:** Exemplo abaixo.

```yml
disabled_rules: # Regras desativadas
    - trailing_whitespace
    - line_length

opt_in_rules: # Regras optativas ativadas
    - force_unwrapping

included: # Incluir os diretórios
    - Source

excluded: # Excluir os diretórios
    - Pods

line_length: 120
```

OBS: Para mais detalhes sobre o SwiftLint, visite [este repositório](https://github.com/realm/SwiftLint?tab=readme-ov-file#swiftlint).

## Como Executar

1. Clone este repositório.
2. Abra o projeto no Xcode.
3. Compile e execute o projeto no simulador ou em um dispositivo.

### Funcionamento
O projeto consiste em uma simples aplicação que faz uma requisição HTTP utilizando URLSession e exibe os dados em uma tela. Os layouts foram criados programaticamente utilizando SnapKit.

## Deployment Target
Este projeto tem como deployment target o iOS 12. Certifique-se de que suas dependências e o código estejam compatíveis com esta versão.

## Contribuições
Contribuições são bem-vindas! Sinta-se à vontade para abrir pull requests e issues.

## Licença
Este projeto é licenciado sob os termos da MIT License.