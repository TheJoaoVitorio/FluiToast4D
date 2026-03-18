# FluiToast4D

<div align="center">
  <img src="assets/FLUI-logo.png" alt="Checkmark" width="350">
</div>

O **FluiToast4D** é um componente moderno e altamente customizável para exibição de notificações (Toasts) não intrusivas no Delphi. Projetado para oferecer uma experiência de usuário rica, ele permite tanto o uso no padrão visual (Design-Time via *Object Inspector*) quanto o uso via código através de uma poderosa e limpa **Interface Fluente (Fluent API)**.

## ✨ Características e Recursos

- **Design Moderno:** Renderização suavizada com GDI+ e cantos perfeitamente arredondados.
- **Responsivo:** A altura do Toast se adapta dinamicamente ao tamanho do texto da mensagem. Se não houver mensagem, o título é elegantemente centralizado na vertical.
- **Suporte a Imagens:** Permite a exibição de ícones/imagens (PNG, JPEG, etc.) no lado esquerdo do Toast.
- **Empilhamento Inteligente:** Múltiplos Toasts podem ser exibidos simultaneamente sem se sobrepor, independente de seus tamanhos variáveis.
- **Personalização Total:** Controle completo sobre cores, fontes, bordas e tempos de duração.
- **Callbacks:** Suporte a ações personalizadas ao clicar no Toast.

---

## 🚀 Como Usar

O FluiToast4D pode ser usado de duas formas: instanciando um componente no Form ou gerando Toasts dinâmicos via código.

### 1. Via Código (Fluent API)

A Fluent API é ideal para criar alertas dinâmicos e rápidos durante a execução do sistema.

```delphi
uses
  FluiToast, FluiToast.Types;

procedure TForm1.ShowSuccessToast;
begin
  TFluiToast.New
    .Title('Salvo com êxito')
    .Message('O registro foi gravado no banco de dados com sucesso.')
    .ToastType(ftSuccess)
    .Position(ftpBottomRight)
    .Duration(4000) // 4 segundos
    .Show;
end;

procedure TForm1.ShowToastWithImage(MyImage: TImage);
begin
  TFluiToast.New
    .Title('Novo E-mail')
    .Message('Você tem uma nova mensagem na sua caixa de entrada.')
    .Image(MyImage) // Aceita tanto um TImage quanto um TPicture (MyImage.Picture)
    .Show;
end;
```

### 2. Via Componente (Object Inspector)

Você pode arrastar o componente `TFluiToast` para o seu formulário. Configure as propriedades visuais (como Cores, Fontes, e a Imagem Padrão) pelo **Object Inspector**.

No código, você só precisa chamar:
```delphi
procedure TForm1.ButtonShowClick(Sender: TObject);
begin
  // Usa as configurações pré-definidas no Object Inspector
  FluiToast1.Show;
  
  // Ou você pode sobrescrever as propriedades antes de mostrar:
  // FluiToast1.Title('Aviso Customizado').Show;
end;
```

---

## ⚙️ Propriedades e Métodos

Abaixo estão listadas as propriedades disponíveis no **Object Inspector** e seus métodos equivalentes na **Fluent API**.

| Object Inspector | Fluent API | Descrição |
| :--- | :--- | :--- |
| `DefaultTitle` | `.Title(Value: string)` | Define o título principal do Toast. Fica centralizado verticalmente caso não exista mensagem. |
| `DefaultMessage` | `.Message(Value: string)` | O texto descritivo. Se for longo, terá quebra de linha e expandirá a altura do Toast. |
| `DefaultType` | `.ToastType(Value: TFluiToastType)` | Aplica paletas de cores prontas. Valores: `ftCustom`, `ftInfo`, `ftSuccess`, `ftWarning`, `ftError`. |
| `DefaultPosition` | `.Position(Value: TFluiToastPosition)` | Define em qual canto o Toast vai aparecer (`ftpTopRight`, `ftpTopLeft`, `ftpBottomRight`, `ftpBottomLeft`, `ftpTopCenter`, `ftpBottomCenter`). |
| `DefaultDuration` | `.Duration(Value: Integer)` | Tempo de exibição em milissegundos (Ex: 3000 para 3 segundos). |
| `DefaultRounding` | `.Rounding(Value: Integer)` | Raio de arredondamento das bordas do Toast. |
| `DefaultBackgroundColor` | `.BackgroundColor(Value: TColor)` | Cor de fundo do Toast (Aplicado apenas quando Type = `ftCustom`). |
| `DefaultTitleColor` | `.TitleColor(Value: TColor)` | Cor da fonte do Título. |
| `DefaultMessageColor`| `.MessageColor(Value: TColor)` | Cor da fonte da Mensagem. |
| `DefaultBorderColor` | `.BorderColor(Value: TColor)` | Cor da linha de borda externa. |
| `DefaultFontName` | `.FontName(Value: string)` | Nome da fonte utilizada nos textos (Ex: `'Segoe UI'`, `'Inter'`). |
| `DefaultImage` | `.Image(Value: TImage ou TPicture)` | Imagem/Ícone a ser renderizado no lado esquerdo. Suporta transparência PNG. |
| *(Apenas via código)* | `.OnClick(Value: TFluiToastAction)` | Executa uma *procedure* anônima quando o usuário clica no Toast. |
| *(Ação final)* | `.Show` | Exibe o componente na tela com as opções informadas e ajusta a fila visual automaticamente. |

## 🛠️ Exemplo Avançado (Callback)

```delphi
TFluiToast.New
  .Title('Atualização Disponível')
  .Message('Clique aqui para reiniciar o sistema.')
  .ToastType(ftInfo)
  .OnClick(
    procedure
    begin
      ShowMessage('Reiniciando o sistema...');
    end
  )
  .Show;
```
