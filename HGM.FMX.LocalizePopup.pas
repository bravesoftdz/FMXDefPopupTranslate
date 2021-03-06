unit HGM.FMX.LocalizePopup;

interface

uses
  FMX.Edit.Style, FMX.Memo.Style, FMX.SearchBox.Style, FMX.Menus;

type
  TStyledEditExt = class(TStyledEdit)
    function CreatePopupMenu: TPopupMenu; override;
  end;

  TStyledSearchBoxExt = class(TStyledSearchBox)
    function CreatePopupMenu: TPopupMenu; override;
  end;

  TStyledMemoExt = class(TStyledMemo)
    procedure CreatePopupMenu; override;
  end;

implementation

uses
  FMX.Presentation.Factory, FMX.Presentation.Style, FMX.Edit, FMX.Controls,
  FMX.Memo, FMX.SearchBox;

procedure LocalizeDefPopupMenu(PopupMenu: TPopupMenu);
const
  CutStyleName = 'cut'; //Do not localize
  CopyStyleName = 'copy'; //Do not localize
  PasteStyleName = 'paste'; //Do not localize
  DeleteStyleName = 'delete'; //Do not localize
  SelectAllStyleName = 'selectall'; //Do not localize
var
  i: integer;
begin
  for i := 0 to Pred(PopupMenu.ItemsCount) do
  begin
    if PopupMenu.Items[i].StyleName = CopyStyleName then
      PopupMenu.Items[i].Text := 'Копировать'
    else if PopupMenu.Items[i].StyleName = CutStyleName then
      PopupMenu.Items[i].Text := 'Вырезать'
    else if PopupMenu.Items[i].StyleName = PasteStyleName then
      PopupMenu.Items[i].Text := 'Вставить'
    else if PopupMenu.Items[i].StyleName = DeleteStyleName then
      PopupMenu.Items[i].Text := 'Удалить'
    else if PopupMenu.Items[i].StyleName = SelectAllStyleName then
      PopupMenu.Items[i].Text := 'Выбрать всё';
  end;
end;

function TStyledEditExt.CreatePopupMenu: TPopupMenu;
begin
  Result := inherited;
  LocalizeDefPopupMenu(Result);
end;

{ TStyledMemoExt }

procedure TStyledMemoExt.CreatePopupMenu;
var
  i: Integer;
begin
  inherited;
  for i := 0 to Pred(ComponentCount) do
    if Components[i] is TPopupMenu then
    begin
      LocalizeDefPopupMenu(Components[i] as TPopupMenu);
    end;
end;

{ TStyledSearchBoxExt }

function TStyledSearchBoxExt.CreatePopupMenu: TPopupMenu;
begin
  Result := inherited;
  LocalizeDefPopupMenu(Result);
end;

initialization
  //Edit
  TPresentationProxyFactory.Current.Unregister(TEdit, TControlType.Styled, TStyledPresentationProxy<TStyledEdit>);
  TPresentationProxyFactory.Current.Register(TEdit, TControlType.Styled, TStyledPresentationProxy<TStyledEditExt>);
  //Memo
  TPresentationProxyFactory.Current.Unregister(TMemo, TControlType.Styled, TStyledPresentationProxy<TStyledMemo>);
  TPresentationProxyFactory.Current.Register(TMemo, TControlType.Styled, TStyledPresentationProxy<TStyledMemoExt>);
  //SearchBox
  TPresentationProxyFactory.Current.Unregister(TSearchBox, TControlType.Styled, TStyledPresentationProxy<TStyledSearchBox>);
  TPresentationProxyFactory.Current.Register(TSearchBox, TControlType.Styled, TStyledPresentationProxy<TStyledSearchBoxExt>);

finalization
  //Edit
  TPresentationProxyFactory.Current.Unregister(TEdit, TControlType.Styled, TStyledPresentationProxy<TStyledEditExt>);
  //Memo
  TPresentationProxyFactory.Current.Unregister(TMemo, TControlType.Styled, TStyledPresentationProxy<TStyledMemoExt>);
  //SerachBox
  TPresentationProxyFactory.Current.Unregister(TSearchBox, TControlType.Styled, TStyledPresentationProxy<TStyledSearchBoxExt>);

end.
