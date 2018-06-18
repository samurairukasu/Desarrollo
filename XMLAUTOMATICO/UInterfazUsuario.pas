unit UInterfazUsuario;

interface

    uses
        Classes,
        Graphics,
        Buttons,
        StdCtrls,
        RXCtrls,
        ToolEdit,
        RXSpin,
        RXLookup,
        UCEdit,
        Forms,
        Mask,
        CurrEdit,
        RXDBCtrl,
        Spin,
        ComCtrls,
        DBCtrls;


    procedure DestacarControl (aControl : TObject; const aColorBackGround : tColor; const aColorFont: tColor; const bFondoDest: boolean);
    procedure AtenuarControl (aControl : TObject; const bFondoDest: boolean);
    procedure Inicializar_FrmAlturaAnchura (aForm: TForm);
    procedure ActivarDesactivar_Componentes (aForm: TForm; const bActivar: boolean);


implementation

    procedure DestacarControl (aControl : TObject; const aColorBackGround : tColor; const aColorFont: tColor; const bFondoDest: boolean);
    begin

        if  (aControl.ClassType  <> TColorEdit) and (aControl.ClassType  <> TBitBtn)
        then begin
            if aControl.ClassType = TComboBox
            then begin
                TComboBox(aControl).Color := aColorBackGround;
                TComboBox(aControl).Font.Color := aColorFont;

                if bFondoDest then
                begin
                    TComboBox(aControl).Font.Size := TComboBox(aControl).Font.Size  + 1;
                    TComboBox(aControl).Width := TComboBox(aControl).Width  + 20;
                    TComboBox(aControl).Font.Style := [fsBold];
                end;

                TComboBox(aControl).BringToFront;
            end
            else if aControl.ClassType = TRXSpinEdit
            then begin
                TRXSpinEdit(aControl).Color := aColorBackGround;
                TRXSpinEdit(aControl).Font.Color := aColorFont;

                if bFondoDest then
                begin
                    TRXSpinEdit(aControl).Font.Style := [fsBold];
                    TRXSpinEdit(aControl).Height := TRXSpinEdit(aControl).Height + 5
                end;
            end
            else if aControl.ClassType = TCheckBox
            then begin
                TCheckBox(aControl).Color := aColorBackGround;
                TCheckBox(aControl).Font.Color := aColorFont;
            end
            else if aControl.ClassType = TMaskEdit
            then begin
                TMaskEdit(aControl).Color := aColorBackGround;
                TMaskEdit(aControl).Font.Color := aColorFont;
            end
            else if aControl.ClassType = TCurrencyEdit
            then begin
                TCurrencyEdit(aControl).Color := aColorBackGround;
                TCurrencyEdit(aControl).Font.Color := aColorFont;
            end
            else if aControl.ClassType = TEdit
            then begin
                TEdit(aControl).Color := aColorBackGround;
                TEdit(aControl).Font.Color := aColorFont;
            end
            else if aControl.ClassType = TRxDBLookupCombo
            then begin
                TRxDBLookupCombo(aControl).Color := aColorBackGround;
                TRxDBLookupCombo(aControl).Font.Color := aColorFont;

                if bFondoDest then
                begin
                    TRxDBLookupCombo(aControl).Font.Size := TRxDBLookupCombo(aControl).Font.Size  + 1;
                    TRxDBLookupCombo(aControl).Width := TRxDBLookupCombo(aControl).Width  + 20;
                    TRxDBLookupCombo(aControl).Font.Style := [fsBold];
                end;

                TRxDBLookupCombo(aControl).BringToFront;
            end
            else if (aControl.ClassType = TDBDateEdit) or (aControl.ClassType = TDateEdit)
            then begin
                TDBDateEdit(aControl).Color := aColorBackGround;
                //TDBDateEdit(aControl).Font.Color := aColorFont;
            end
            else if aControl.ClassType = TDateTimePicker
            then begin
                TDateTimePicker(aControl).Color := aColorBackGround;
                TDateTimePicker(aControl).Font.Color := aColorFont;
            end
            else if aControl.ClassType = TSpinEdit
            then begin
                TSpinEdit(aControl).Color := aColorBackGround;
                TSpinEdit(aControl).Font.Color := aColorFont;
            end
            else if aControl.ClassType = TDBEdit
            then begin
                TDBEdit(aControl).Color := aColorBackGround;
                TDBEdit(aControl).Font.Color := aColorFont;
            end

        end
    end;


    procedure AtenuarControl (aControl : TObject; const bFondoDest: boolean);
    begin
        if  (aControl.ClassType  <> TColorEdit) and (aControl.ClassType  <> TBitBtn)
        then begin
            if aControl.ClassType = TComboBox
            then begin
                TComboBox(aControl).Color := clWindow;
                TComboBox(aControl).Font.Color := clBlack;

                if bFondoDest then
                begin
                    TComboBox(aControl).Font.Size := TComboBox(aControl).Font.Size  - 1;
                    TComboBox(aControl).Width := TComboBox(aControl).Width  - 20;
                    TComboBox(aControl).Font.Style := [];
                end;
            end
            else if aControl.ClassType = TRXSpinEdit
            then begin
                TRXSpinEdit(aControl).Color := clWindow;
                TRXSpinEdit(aControl).Font.Color := clBlack;
                TRXSpinEdit(aControl).Font.Style := [];

                if bFondoDest then
                   TRXSpinEdit(aControl).Height := TRXSpinEdit(aControl).Height - 5
            end
            else if aControl.ClassType = TCheckBox
            then begin
                TCheckBox(aControl).Color := clBtnFace;
                TCheckBox(aControl).Font.Color := clBlack;
            end
            else if aControl.ClassType = TMaskEdit
            then begin
                TMaskEdit(aControl).Color := clWindow;
                TMaskEdit(aControl).Font.Color := clBlack;
            end
            else if aControl.ClassType = TCurrencyEdit
            then begin
                TCurrencyEdit(aControl).Color := clWindow;
                TCurrencyEdit(aControl).Font.Color := clBlack;
            end
            else if aControl.ClassType = TEdit
            then begin
                TEdit(aControl).Color := clWindow;
                TEdit(aControl).Font.Color := clBlack;
            end
            else if aControl.ClassType = TRxDBLookupCombo
            then begin
                TRxDBLookupCombo(aControl).Color := clWindow;
                TRxDBLookupCombo(aControl).Font.Color := clBlack;

                if bFondoDest then
                begin
                    TRxDBLookupCombo(aControl).Font.Size := TRxDBLookupCombo(aControl).Font.Size  - 1;
                    TRxDBLookupCombo(aControl).Width := TRxDBLookupCombo(aControl).Width  - 20;
                    TRxDBLookupCombo(aControl).Font.Style := [];
                end;
                TRxDBLookupCombo(aControl).BringToFront;
            end
            else if (aControl.ClassType = TDBDateEdit) or (aControl.ClassType = TDateEdit)
            then begin
                TDBDateEdit(aControl).Color := clWindow;
                //TDBDateEdit(aControl).Font.Color := clBlack;
            end
            else if aControl.ClassType = TDateTimePicker
            then begin
                TDateTimePicker(aControl).Color := clWindow;
                TDateTimePicker(aControl).Font.Color := clBlack;
            end
            else if aControl.ClassType = TSpinEdit
            then begin
                TSpinEdit(aControl).Color := clWindow;
                TSpinEdit(aControl).Font.Color := clBlack;
            end
            else if aControl.ClassType = TDBEdit
            then begin
                TDBEdit(aControl).Color := clWindow;
                TDBEdit(aControl).Font.Color := clBlack;
            end

        end
    end;


    procedure Inicializar_FrmAlturaAnchura (aForm: TForm);
    begin
        with aForm do
        begin
            Height := Screen.Height;
            Width := Screen.Width;
        end;
    end;


    procedure ActivarDesactivar_Componentes (aForm: TForm; const bActivar: boolean);
    var
      i: integer; { actúa a modo de índice }
    begin
        for i := 0 to aForm.ComponentCount-1 do
        begin
            if (aForm.Components[i].Tag = 1) then
               TForm(aForm.Components[i]).Enabled := bActivar;
        end;
    end;




end.

