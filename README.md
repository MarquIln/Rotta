# 🏎️ Rotta

**Rotta** é um aplicativo iOS nativo desenvolvido em Swift que oferece informações completas sobre as principais categorias do automobilismo: **Fórmula 2**, **Fórmula 3** e **F1 Academy**. O app fornece calendários de eventos, rankings de pilotos e equipes, além de informações detalhadas sobre componentes dos carros e glossário técnico.

<p align="center">
  <img src="https://img.shields.io/badge/iOS-15.0+-blue.svg" alt="iOS Version">
  <img src="https://img.shields.io/badge/Swift-5.0+-orange.svg" alt="Swift Version">
  <img src="https://img.shields.io/badge/Xcode-15.0+-blue.svg" alt="Xcode Version">
  <img src="https://img.shields.io/badge/CloudKit-Enabled-green.svg" alt="CloudKit">
</p>

## Funcionalidades

### **Calendário de Eventos**
- Visualização de calendário com todos os eventos das três categorias
- Filtragem por fórmula (F2, F3, F1 Academy)
- Detalhes de cada sessão (treinos, classificação, corridas)
- Horários reais de início e fim de cada evento
- Interface interativa com seleção de datas

### **Rankings**
- **Top 3**: Pódio dos melhores pilotos e equipes
- **Ranking Completo**: Lista completa de pilotos com pontuação
- **Equipes**: Classificação das scuderias por pontos
- Atualização em tempo real conforme a fórmula selecionada

### **Informações**
- **Pilotos**: Perfis completos com estatísticas e histórico
- **Equipes**: Detalhes das scuderias e seus resultados
- **Componentes**: Explicações técnicas sobre partes dos carros
- **Glossário**: Termos técnicos do automobilismo
- **Regras**: Regulamentações de cada categoria

### **Tecnologias Utilizadas**
- **Swift** - Linguagem principal
- **UIKit** - Framework de interface
- **CloudKit** - Banco de dados na nuvem
- **Core Data** - Persistência local

### **Services**
- `EventService` - Gerencia eventos
- `DriverService` - Gerencia pilotos
- `ScuderiaService` - Gerencia equipes
- `RuleService` - Gerencia regras
- `FormulaService` - Gerencia fórmulas

## Funcionalidades Técnicas

### **CloudKit Integration**
- Sincronização automática de dados
- Cache local para performance
- Operações assíncronas com async/await
- Tratamento de erros robusto

### **Performance**
- Lazy loading de dados
- Cache de eventos por data
- Pré-carregamento inteligente
- Reuso de células em collection views

## Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

---

<p align="center">
  Desenvolvido com ❤️ para entusiastas do automobilismo
</p>