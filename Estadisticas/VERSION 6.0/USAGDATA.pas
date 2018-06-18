unit USAGDATA;

interface

    uses
        Classes,db,
        variants,
        DBClient,
        Provider,
        FMTBcd,
        DBXpress,
        SqlExpr,
        SimpleDS;

    type


        TSagData = class(TObject)
        protected
            fSQL : TStringList;
            fColumnas : string;
            fKeyField : TStringList;
            fTableName : string;
            fCursor : string;
            fFilter : string;
            fFieldLink : string;
            fFieldRequired : string;
            fSequenceName : string;
            fReferenceFieldLink : string;
            fUpdating: boolean;
            fSagBD : TSQLConnection;
            fSagDataset : TSQLDataset;
            fSagProvider : TDatasetProvider;
            fSagQuery : TClientDataSet;
            fMasterSource : TDataSource;
            FDefaultColumnas : boolean;
            fDefaultNulls: TStringList;
            fLockedTable : boolean;
            procedure AfterInsert(aDataSet: TDataSet); virtual;
            procedure AfterScroll(aDataSet: TDataSet); virtual;
            procedure AfterClose(aDataSet: TDataSet); virtual;
            procedure AfterOpen(aDataSet: TDataSet); virtual;
            procedure AfterPost(aDataSet: TDataSet); virtual;
            procedure BeforePost(aDataSet: TDataSet); virtual;
            procedure BeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean); Virtual;
            procedure AfterUpdateRecord(Sender: TObject; SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind); Virtual;
            procedure BeforeApplyUpdates(Sender: TObject; var OwnerData: OleVariant); virtual;
            procedure AfterApplyUpdates(Sender: TObject; var OwnerData: OleVariant); virtual;
            procedure AddCursor; virtual;
            procedure AddCursorAg; virtual;
            function IsKey(const aField: string) : boolean; virtual;
            function GetActive : boolean;
            function GetFieldsNamesAG : string;
            function GetFieldsNames : string;
            function GetIsNew : boolean;
            function GetFiltered: boolean;
            function GetMastered: boolean;
            function GetValueByName (Index: string) : string;
            function GetCalculatedValueByName (Index: string) : string; virtual;
            function GetValueByIndex (Index: integer) : string;
            function GetFieldKey : TStringList;
            function GetRecordCount : integer;
            function GetFieldRequired : string;
            function GetSequenceName : string; virtual;
            function GetInsertValues : string; virtual;
            function GetUpdateValues : string;
            function GetKeyField : string;
            function GetPureDateTime : tDateTime;
            function GetEof: Boolean;
            function GetBof: Boolean;
            procedure SetLockTable (aValue : boolean);
            procedure SetFilter(const aValue: string); virtual;
            procedure SetValueByName (Index: string; const aValue: string);
            procedure SetValueByIndex (Index: integer; const aValue: string);
            procedure SetColumnas(Value: string);
            procedure SetMasterSource(aMasterSource : TDataSource);
            procedure SetMastering(aValue : string);
            procedure SetFieldLink(aValue: string);
            function GetValueKey (const aFieldName : string) : string; Virtual;
            procedure ChangeMasterData(Sender: TObject; Field: TField);
            procedure SetDefaultActiveInsertValues;
            Procedure LoadDefaultNulls;
            Function ValidateFieldsData: Boolean; Virtual;
            procedure Insert(Trans: Boolean = False);
            procedure Update(Trans: Boolean = False);
            Function GetCommandText : string;
           // CreateFromDataBaseAG

        public
            function ConjuntoRowIds: string;
            procedure Close;
            procedure Open; Virtual;
            procedure Post(Apply: Boolean = False; Trans: boolean = False); virtual;
            procedure Append;
            procedure Refresh;
            procedure Cancel;
            procedure First;
            procedure Last;
            procedure Next;
            procedure Prior;
            procedure START; virtual;
            procedure COMMIT; virtual;
            procedure ROLLBACK; virtual;
            function Edit: Boolean;
            function GetValorSecuenciador : integer;
            function Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Boolean;
            // Pone una máscara a un campo. Devuelve True si ha logrado ponérsela
            function SetMask (const aCampo, aMascara, aVisualizada: string): boolean;
            constructor CreateFromDataBase(const aBD : TSQLConnection; const aTable : string; aFilter: string);
            constructor CreateFromDataBaseAG(const aBD : TSQLConnection; const aTable : string; aFilter: string);
            constructor CreateFromColumns(const aBD : TSQLConnection; const aTable : string; aColumns: string; aFilter: String);Virtual;
            constructor CreateFromDataLink(const aBD : TSQLConnection; const aTable : string; aMasterSource: TDataSource; aFieldLink: string; aReferenceFieldLink: string);
            constructor CreateFromSagData(aSagData: TObject);
            destructor Destroy; Override;
            property DataBase : TSQLConnection read fSagBD;
            property Active: boolean read GetActive;
            property IsNew: boolean read GetIsNew;
            property DataSet : TClientDataset read fSagQuery;
            property Filter : string read fFilter write SetFilter;
            property Filtered : boolean read GetFiltered;
            property Mastered : Boolean read GetMastered;
            property SequenceName : string read fSequenceName;
            property RecordCount : integer read GetRecordCount;
            property ValueByName[index : string] : string read GetValueByName  write SetValueByName;
            property ValueByIndex[index: integer]: string read GetValueByIndex write SetValueByIndex;
            property Columnas : string read FColumnas write SetColumnas;
            property DefaultColumnas : Boolean read FDefaultColumnas write FDefaultColumnas;
            property MasterSource : TDataSource read fMasterSource write SetMasterSource;
            property FieldLink : string read fFieldLink write SetFieldLink;
            property ReferenceFieldLink : string read fReferenceFieldLink write fReferenceFieldLink;
            property Eof : Boolean read GetEof;
            property Bof : Boolean read GetBof;
            property KeyField : string read GetKeyfield ;
            property FieldRequired : string read GetFieldRequired;
            property LockedTable : boolean read fLockedTable write SetLockTable;
            Function ExecuteFunction(FunctionName: String;Parameters: Variant):String;
        end;

        TSagGlobal = class(TSagData);
        TSagKernel = class(TSagData);
        TSagHistorico = class(TSagData);
        TSagParameters = class(TSagData);

  TClassSagData = class of TSagData;


    resourcestring

        FILE_NAME = 'USAGDATA.PAS';
        M_NIL = 'Nil';
        FIELD_ROWID = 'ROWID';
        FIELD_FECHALTA = 'FECHALTA';

implementation

    uses
        Globals,
       // ULogs,
        UtilOracle,
        Forms,
        SysUtils;


    Function TSagData.Edit:Boolean;
    var
        aRowId: String;
    begin
        //Ponel el dataset en edicion y devuelve si puede realizarlo

        Result:=True;
        If not(fSagQuery.CanModify)
        then begin
            Result:=FalsE;
            aRowId:=ValueByName[FIELD_ROWID];
            With fSagQuery do
            begin
                Filter:=Format('WHERE A.%S = ''%S''',[FIELD_ROWID,aRowID]);
            end;
            If fSagQuery.CanModify Then Result:=True;
        end
        else If Not(fSagQuery.State In [dsInsert,dsEdit]) Then begin
            fSagQuery.Edit;
        end;
    end;

    procedure TSagData.AfterScroll(aDataSet: TDataSet);
    begin
        //controla movimientos en fSagQuery
    end;

    procedure TSagData.AfterClose(aDataSet: TDataSet);
    begin
      //controla el cierre en fSagQuery
      Dec(Cursores);
      {$IFDEF TRAZAS}
//    fIncidencias.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'DISMINUYO CURSOR '+inttostr(cursores)+' max '+inttostr(MaxCursores)+' '+copy(fsagquery.text,pos('FROM',fsagquery.Text)+5,12));
//    fIncidencias.PonComponente(TRAZA_SQL,1,FILE_NAME,fSagQuery);
      {$ENDIF}
    end;

    procedure TSagData.AfterOpen(aDataSet: TDataSet);
    var
      ii: Integer;
    begin
      //controla la apertura en fSagQuery
      Inc(Cursores);
      {$IFDEF TRAZAS}
//    fIncidencias.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'INCREMENTO CURSOR '+inttostr(cursores)+' max '+inttostr(MaxCursores)+' '+copy(fsagquery.text,pos('FROM',fsagquery.Text)+5,12));
//    fIncidencias.PonComponente(TRAZA_SQL,1,FILE_NAME,fSagQuery);
      {$ENDIF}

      if Cursores>MaxCursores Then MaxCursores:=Cursores;
      //DEFINE QUE CAMPOS SON REQUERIDOS, NO PERMITEN NULOS
      If fDefaultNulls.Count=0 Then Exit;
      For ii:=1 To fSagQuery.FieldCount-1 do
      begin
        fSagQuery.Fields[ii].Required := (fDefaultNulls[ii]='N');
      end;
      SetMask(FIELD_FECHALTA,'DD/MM/YYYY','DD/MM/YYYY');
    end;               

    procedure TSagData.AfterInsert(aDataSet: TDataSet);
    begin
        //controla la apertura en fSagQuery
    end;

    procedure TSagData.AfterPost(aDataSet: TDataSet);
    begin
        //controla la apertura en fSagQuery
    end;

    procedure TSagData.BeforePost(aDataSet: TDataSet);
    begin
        //Compobaciones previas al post
    end;

    function TSagData.GetEof: Boolean;
    begin
        Result := fSagQuery.Eof;
    end;

    function TSagData.GetBof: Boolean;
    begin
        Result := fSagQuery.Bof;
    end;

    Procedure TSagData.First;
    begin
        If fSagQuery.IsEmpty Then Exit;
        fSagQuery.First;
    end;

    Procedure TSagData.Last;
    begin
        If fSagQuery.IsEmpty Then Exit;
        fSagQuery.Last;
    end;

    Procedure TSagData.Next;
    begin
        If fSagQuery.IsEmpty Then Exit;
        fSagQuery.Next;
        If fSagQuery.EOF Then
          fSagQuery.Last;
    end;

    Procedure TSagData.Prior;
    begin
        If fSagQuery.IsEmpty Then Exit;
        fSagQuery.Prior;
        If fSagQuery.BOF Then
          fSagQuery.First;
    end;

    Procedure TSagData.SetMastering(aValue : String);
    begin
        //Selecciona según el filtro que necesite
        If fReferenceFieldLink='' then ReferenceFieldLink := FieldLink;
        If fFilter = ''
        then begin
            if fSql.Count > 1
            then fSql[1] := Format('WHERE %S = %S',[fReferenceFieldLink,FieldQueryValue(fMasterSource.DataSet.FieldByName(fFieldLink).DataType,aValue)])
            else fSql.Add(Format('WHERE %S = %S',[fReferenceFieldLink,FieldQueryValue(fMasterSource.DataSet.FieldByName(fFieldLink).DataType,aValue)]));
            fSagQuery.CommandText := GetCommandText;
        end
        else begin
            if Pos('ORDER BY', fFilter) <> 0
            then begin
                    if Pos('WHERE', fFilter) <> 0
                    then begin
                        if fSql.Count > 1
                        then fSql[1]:= Format('%S And %S = %S %S',[Copy(fFilter,1,Pos('ORDER BY',fFilter) -1),fReferenceFieldLink,FieldQueryValue(fMasterSource.DataSet.FieldByName(fFieldLink).DataType,aValue),Copy(fFilter,Pos('ORDER BY',fFilter), Length(fFilter))])
                        else fSql.Add(Format('%S And %S = %S %S',[Copy(fFilter,1,Pos('ORDER BY',fFilter) -1),fReferenceFieldLink,FieldQueryValue(fMasterSource.DataSet.FieldByName(fFieldLink).DataType,aValue),Copy(fFilter,Pos('ORDER BY',fFilter), Length(fFilter))]));
                        fSagQuery.CommandText := GetCommandText;
                    end
                    else begin
                        if fSql.Count > 1
                        then fSql[1]:= Format('WHERE %S = %S %S',[fReferenceFieldLink,FieldQueryValue(fMasterSource.DataSet.FieldByName(fFieldLink).DataType,aValue),Copy(fFilter,Pos('ORDER BY',fFilter), Length(fFilter))])
                        else fSql.Add(Format('WHERE %S = %S %S',[fReferenceFieldLink,FieldQueryValue(fMasterSource.DataSet.FieldByName(fFieldLink).DataType,aValue),Copy(fFilter,Pos('ORDER BY',fFilter), Length(fFilter))]));
                        fSagQuery.CommandText := GetCommandText;
                    end
            end
            else begin
                if fSql.Count > 1
                then fSql[1]:= Format('%S And %S = %S %S',[fFilter,fReferenceFieldLink,FieldQueryValue(fMasterSource.DataSet.FieldByName(fFieldLink).DataType,aValue )])
                else fSql.Add(Format('%S And %S = %S %S',[fFilter,fReferenceFieldLink,FieldQueryValue(fMasterSource.DataSet.FieldByName(fFieldLink).DataType,aValue )]));
                fSagQuery.CommandText := GetCommandText;
            end;
        end
    end;

    procedure TSagData.ChangeMasterData(Sender: TObject; Field: TField);
    begin
        //Actualización de los datos con los del master
        if (fUpdating) or
           (fSagQuery.state in [dsEdit, dsInsert]) or
           (Sender <> fMasterSource) or
           (FieldLink = '') or
           ( (fSagQuery.Active) and (ValueByName[ReferenceFieldLink] = fMasterSource.DataSet.FieldByName(fFieldLink).AsString))
        then Exit;

        try
            if Field=nil
            then begin
                if fMasterSource.State = dsInactive
                then fSagQuery.Close
                else begin
                    fSagQuery.Close;
                    if not (fMasterSource.DataSet.FieldByName(fFieldLink).IsNull)
                    then begin
                        SetMastering(fMasterSource.DataSet.FieldByName(FieldLink).AsString);

                        {$IFDEF TRAZAS}
                        fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Apertura de un master detail');
                        fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,fSagQuery);
                        {$ENDIF}

                        (fSagQuery As TClientDataset).Open;
                    end
                end;
            end;
        finally
            fUpdating := FALSE;
        end;
    end;

    procedure TSagData.SetMasterSource(aMasterSource : TDataSource);
    var
        i: integer;
    begin
        //Vincula un clase TSagData como Master de la clase que ahora es un detalle de esta
        If aMasterSource<>nil
        then begin
            fMasterSource:=aMasterSource;
            aMasterSource.OnDataChange:=ChangeMasterData;
            ChangeMasterData(fMasterSource,nil);
        end
        else begin
            if fUpdating
            then Exit;
            try
                fMasterSource.OnDataChange := nil;
                fMasterSource := nil;
                fUpdating := TRUE;
                fSagQuery.Close;

                if fFilter <> ''
                then Filter := fFilter
                else begin
                    for i:= 1 to (fSQL.Count - 1) do
                    begin
                        fSql.Delete(i);
                    end
                end;
                fSagQuery.CommandText := GetCommandText;
                Open;

            finally
                fUpdating := FALSE;
            end;
        end;
    end;

    Function TSagData.Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Boolean;
    begin
        Result:= fSagQuery.Locate(Keyfields,KeyValues,Options);
    end;

    Procedure TSagData.SetColumnas(Value: String);
    begin
        //Escribe la propiedad Columns
        If not FDefaultColumnas then FColumnas:= Value else Raise Exception.Create('Wrong Definition Columns');
    end;

    function TSagData.GetKeyField : string;
    begin
        result := fKeyField.Strings[0];
    end;

    function TSagData.IsKey (const aField: string): boolean;
    var
        i : integer;
        bIs : boolean;
    begin
        bIs := FALSE;
        try
            for i := 0 to fKeyField.Count - 1 do
            begin
                bIs := (UpperCase(aField) = UpperCase(fKeyField.Strings[i]));
                if bIs
                then break
            end
        finally
            result := bIs;
        end;
    end;

    function TSagData.GetFieldsNames : string;
    var
        Valor: Variant;
    begin
        result := '';
        If fDefaultNulls=nil
        then begin
            fDefaultNulls.Free;
            fDefaultNulls:=nil;
        end;
        fDefaultNulls:=TStringList.Create;
        fDefaultNulls.add('N');
        with TUser_Tab_Columns do
        begin
            First;
            //IndexFieldNames:='TABLE_NAME';
            Valor:=fTableName;
            If Locate('TABLE_NAME',Valor,[]){Findkey([fTableName])}
            Then begin
                while ((FieldByName('TABLE_NAME').AsString=fTableName) and (not EOF)) do
                begin
                    {$IFDEF TRAZAS}
                    fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME,TUser_Tab_Columns);
                    {$ENDIF}
                    if result <> ''
                    then result := result + ',';
                    result := result + 'A.'+FieldByName('COLUMN_NAME').AsString;
                    fDefaultNulls.add(FieldByName('NULLABLE').AsString);
                    Next;
                end;
            end;
        end;
    end;

    function TSagData.GetFieldsNamesAG : string;
    var
        Valor: Variant;
    begin
        result := '';
        If fDefaultNulls=nil
        then begin
            fDefaultNulls.Free;
            fDefaultNulls:=nil;
        end;
        fDefaultNulls:=TStringList.Create;
        fDefaultNulls.add('N');
        with TAGEVA_Tab_Columns do
        begin
            First;
            //IndexFieldNames:='TABLE_NAME';
            Valor:=fTableName;
            If Locate('TABLE_NAME',Valor,[]){Findkey([fTableName])}
            Then begin
                while ((FieldByName('TABLE_NAME').AsString=fTableName) and (not EOF)) do
                begin
                    {$IFDEF TRAZAS}
                    fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME,TUser_Tab_Columns);
                    {$ENDIF}
                    if result <> ''
                    then result := result + ',';
                    result := result + 'A.'+FieldByName('COLUMN_NAME').AsString;
                    fDefaultNulls.add(FieldByName('NULLABLE').AsString);
                    Next;
                end;
            end;
        end;
    end;

    function TSagData.GetUpdateValues : string;
    var
        i: integer;
    begin
        result := '';
        for i := 1 to fSagQuery.FieldCount - 1 do
        begin
            if result <> ''
            then result := result + ',';
            result := result + fSagQuery.Fields[i].FieldName +' = '+FieldQueryValue(fSagQuery.Fields[i].DataType,fSagQuery.Fields[i].Value);
        end;
    end;

    function TSagData.GetPureDateTime : tDateTime;
    var
        aQ : TsqlQuery;
    begin
        try
             aQ := TSQLQuery.Create(Application);
             with aQ do
             try
                 SQLConnection := fSagBD;

        { TODO -oran -ctransacciones : Ver tema transactiondesc }

                 SQL.ADD ('SELECT SYSDATE FROM DUAL');
                 {$IFDEF TRAZAS}
                 fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Fecha en formato puro de la BD');
                 fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aQ);
                 {$ENDIF}
                 Open;
                 result := Fields[0].AsDateTime;
                 {$IFDEF TRAZAS}
                 fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME, aQ);
                 {$ENDIF}
             finally
                 aQ.Close;
                 aQ.Free
             end;
        except
            on E: Exception do
            begin
                Result := Now;
              //  fAnomalias.PonAnotacionFmt(TRAZA_FLUJO,1,FILE_NAME, 'Error obteniendo la Fecha en formato puro: %s',[E.message]);
            end;
        end;
    end;

    procedure TSagData.SetFieldLink(aValue: string);
    begin
        if aValue = ''
        then begin
            fFieldLink := '';
            fReferenceFieldLink := '';
        end
        else begin
            fFieldLink := aValue;
            if fReferenceFieldLink = ''
            then fReferenceFieldLink := aValue;
        end
    end;

    function TSagData.GetValueKey (const aFieldName : string) : string;
    begin
        if Pos(aFieldName,SequenceName) <> 0
        then result := IntToStr(GetValorSecuenciador)
        else begin
            if fSagQuery.FieldByName(aFieldName).IsNull
            then result := ''
            else result := fSagQuery.FieldByName(aFieldName).AsString
        end
    end;

    procedure TSagData.SetDefaultActiveInsertValues;
    var
        i: integer;
        aux : string;
    begin
        for i := 1 to fSagQuery.FieldCount - 1 do
            if IsKey(fSagQuery.Fields[i].FieldName)
            then
            begin
              aux := GetValueKey(fSagQuery.Fields[i].FieldName);
              fSagQuery.FieldByName(fSagQuery.Fields[i].FieldName).AsString := aux;
            end
            else if fSagQuery.Fields[i].FieldName = 'FECHALTA'
                then fSagQuery.FieldByName('FECHALTA').AsDateTime := GetPureDateTime
    end;


    function TSagData.GetInsertValues : string;
    var
        i : integer;
    begin
        result := '';
        for i := 1 to fSagQuery.FieldCount - 1 do
        begin
            if result <> ''
            then result := result + ',';
            if fSagQuery.Fields[i].FieldName = 'FECHALTA'
            then result := result + 'SYSDATE'
            else if IsKey(fSagQuery.Fields[i].FieldName)
                then result := result + GetValueKey(fSagQuery.Fields[i].FieldName)
                else result := result + FieldQueryValue(fSagQuery.Fields[i].DataType,fSagQuery.Fields[i].Value);
        end;
    end;

    procedure TSagData.Insert(Trans: Boolean = False);
    var
      aQ : TSQLQuery;
      sValores : string;
      bOK : Boolean;
    begin
      bOK := False;
      aQ := TSQLQuery.Create(Application);
      with aQ do
      begin
        try
          SQLConnection :=  fSagBD;
          sValores := GetInsertValues;
          SQL.Add(Format('INSERT INTO %S (%S) VALUES (%S)',[fTableName,fColumnas,sValores]));

          If Trans Then
            self.START;
          ExecSql;
          {$IFDEF TRAZAS}
          fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Inserción de nuevo registro.');
          fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aQ);
          {$ENDIF}
          bOK := True;
        finally
          If Trans Then
          begin
            If bOK then
              self.COMMIT
            Else
              self.ROLLBACK;
          End;
          If Assigned(aQ) Then
          begin
            aQ.Close;
            FreeAndNil(aQ);
          End;
        End;
      end;
    end;

    procedure TSagData.Update(Trans: Boolean = False);
    var
      aQ : TSQLQuery;
      sValores : string;
      bOK : Boolean;
    begin
      bOK := False;
      aQ := TSQLQuery.Create(Application);
      with aQ do
      begin
        try
          SQLConnection :=  fSagBD;
          sValores := GetUpdateValues;
          SQL.Add(Format('UPDATE %S SET %S WHERE ROWID = %S',[fTableName,sValores, GetValueByName('ROWID')]));

          If Trans Then
            self.START;
          ExecSql;
          {$IFDEF TRAZAS}
          fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Actualización de registro.');
          fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aQ);
          {$ENDIF}
          bOK := True;
        finally
          If Trans Then
          begin
            If bOK then
              self.COMMIT
            Else
              self.ROLLBACK;
          End;
          If Assigned(aQ) Then
          begin
            aQ.Close;
            FreeAndNil(aQ);
          End;
        End;
      End;
    End;

    function TSagData.GetIsNew: boolean;
    begin
      if not Active
      then raise Exception.Create('The cursor is closed and dont reconoignize if the record is new')
      else result := fSagQuery.RecordCount = 0
    end;

    function TSagData.GetActive: boolean;
    begin
      result := fSagQuery.Active;
    end;

    procedure TSagData.Cancel;
    begin
      if Active Then begin
        If (fSagQuery.State in [dsInsert,dsEdit]) Then
          fSagQuery.Cancel
        Else If (fSagQuery.UpdateStatus <> usUnmodified) Then
          fSagQuery.Revertrecord;
      End;
    End;

    procedure TSagData.Refresh;  { TODO -oran -cTemas no vistos : Ver }
    var
      aSF : String;
      i : integer;
      SearchCad : Variant;
    begin
      try
        aSF := '';
        If RecordCount > 0 Then
        begin
          if fKeyField.Count > 1 then
            SearchCad := VarArrayCreate([0,fKeyField.Count-1],varVariant);
          for i:= 0 to fKeyField.Count - 1 do
          begin
            if aSF <> '' then
              aSF:=aSF+';';
            aSF := aSF + fKeyField[i];
            if fKeyField.Count > 1 Then
              SearchCad[i]:=ValueByName[fKeyField[i]]
            else
              SearchCad:=ValueByName[fKeyField[i]];
          end;
        end;
        if Active then
        begin
            fSagQuery.Close;
            Filter := fFilter;
            fSagQuery.SetProvider(fSagProvider);
            (fSagQuery As TClientDataset).Open;
             If ((aSf<>'') and (RecordCount>0))
             Then
                if Not fSagQuery.Locate(aSF,SearchCad,[])
                then First;
        end;
      except
         on E: Exception do
         begin
           //fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Falló el refresco en %s por: %s',[fTableName, E.message]);
           raise Exception.CreateFmt ('The refresh of %s was wrong: %s',[fTableName, E.message]);
         end;
      end;
    end;

    function TSagData.GetRecordCount : integer;
    begin
        if Active
        then result := fSagQuery.RecordCount
        else result := -1;
    end;

    procedure TSagData.Append;
    var
        i : integer;
    begin
        try
            if fSagQuery.CanModify
            then fSagQuery.Append
            else begin
                fSagQuery.Close;
                if fFilter <> ''
                then for i:= 1 to (fSQL.Count - 1) do fSql.Delete(i);
                fSagQuery.CommandText := GetCommandText;
                Open;
                fSagQuery.Append
            end
        except
            on E: Exception do
            begin
                //fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la inserción nueva en %s por: %s',[fTableName, E.message]);
                raise Exception.CreateFmt ('The append of %s was wrong: %s',[fTableName, E.message]);
            end
        end
    end;

    procedure TSagData.Post(Apply: Boolean = False; Trans: boolean = False);
    begin
        try
            If Not(ValidateFieldsData) then
               raise Exception.Create('¡ Existen Campos Obligatorios Sin Rellenar !')
            else
             begin
              {$IFDEF TRAZAS}
              fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Actualización de Cursor');
              fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,fSagQuery);      }
              {$ENDIF}
              if Active then
              begin
                if fSagQuery.CanModify then
                begin
                  if fSagQuery.UpdateStatus = usInserted then
                    SetDefaultActiveInsertValues;

                  fSagQuery.Post;
                  If (fSagQuery.ChangeCount > 0) Then
                  begin
                    If Apply then
                      If fSagQuery.ApplyUpdates(0) > 0 Then
                      begin
                        SysUtils.Abort;
                        If Trans Then
                          Self.ROLLBACK;
                      End
                      Else If Trans Then
                        Self.COMMIT;
                  End;

                  {$IFDEF TRAZAS}
                  fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Inserción Activa');
                  fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME,fSagQuery);
                  {$ENDIF}

                End
                else begin
                  if IsNew then
                    Insert
                  else
                    Update;
                End;
              End;
            End;
        except
            on E: Exception do
            begin
                //fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la escritura en %s por: %s',[fTableName, E.message]);
                raise Exception.CreateFmt ('The post of %s was wrong: %s',[fTableName, E.message]);
                // Rollback
            end
        end;
    end;

    procedure TSagData.Open;
    begin
      try
        if not Active then
        Begin
          fSagQuery.setprovider(fSagProvider);
          (fSagQuery As TClientDataset).Open;
          {$IFDEF TRAZAS}
          fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Apertura de Cursor');
          fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,fSagQuery);
          {$ENDIF}
        end;
      except
        on E: Exception do
        begin
        //  fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la apertura de %s por: %s',[fTableName, E.message]);
          raise Exception.CreateFmt ('The retrieve of %s was wrong: %s',[fTableName, E.message]);
        end
      end;
    end;

    procedure TSagData.Close;
    begin
      if Active then
      Begin
        fSagQuery.Close;
        {$IFDEF TRAZAS}
        fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Cierre de Cursor');
        fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,fSagQuery);
        {$ENDIF}
      end;
    end;


    function TSagData.GetCalculatedValueByName(Index : string) : string;
    begin
      //redefinir para que vuelva campos calculados
      Result:=M_NIL;
    end;

    function TSagData.GetValueByName(Index : string) : string;
    begin
      If fSagQuery.FindField(Index) <> nil then
      begin
        result := Trim(fSagQuery.FieldByName(Index).AsString)
      end
      else begin
        Result:=GetCalculatedValueByName(Index);
        If Result = M_NIL then
          raise Exception.Createfmt('Error: Field %S Not Found',[Index]);
      end;
    end;

    function TSagData.GetValueByIndex(Index : integer) : string;
    begin
        result := fSagQuery.Fields[Index].AsString
    end;

    procedure TSagData.SetValueByName(Index : string; const aValue : string);
    begin
      if not (fSagQuery.State in [dsEdit, dsInsert]) then Edit;
      fSagQuery.FieldByName(Index).AsString := aValue;
    end;

    procedure TSagData.SetValueByIndex(Index : integer; const aValue: string);
    begin
      if not (fSagQuery.State in [dsEdit, dsInsert]) then Edit;
      fSagQuery.Fields[Index].AsString := aValue;
    end;

    procedure TSagData.AddCursor;
    begin
      If ((FCursor=M_NIL) or (Not(FDefaultColumnas))) then
        FCursor := FColumnas
      else begin
        fCursor := GetFieldsNames;
        fColumnas := fCursor;
      end;
      fCursor := Format ('SELECT A.ROWID, %S FROM %S A',[fCursor, fTableName]);
      fSQL.Clear;
      fSQL.Add(fCursor);
      fSagQuery.CommandText := GetCommandText;
    end;
     procedure TSagData.AddCursorAG;
    begin
      If ((FCursor=M_NIL) or (Not(FDefaultColumnas))) then
        FCursor := FColumnas
      else begin
        fCursor := GetFieldsNamesAG;
        fColumnas := fCursor;
      end;
      fCursor := Format ('SELECT A.ROWID, %S FROM %S A',[fCursor, fTableName]);
      fSQL.Clear;
      fSQL.Add(fCursor);
      fSagQuery.CommandText := GetCommandText;
    end;

    function TSagData.GetMastered: boolean;
    begin
      result := fMasterSource <> Nil;
    end;

    function TSagData.GetFiltered: boolean;
    begin
      result := Filter <> '';
    end;

    procedure TSagData.SetFilter (const aValue: string);
    var
      OldActive : boolean;
    begin
      OldActive := Active;
      try
        if Active then
          fSagQuery.Close;
        fFilter := aValue;
        if fFilter <> '' then
        begin
          if fSQL.Count > 1 then
            fSQL[1] := fFilter
          else
            fSQL.Add(fFilter);
          fSagQuery.CommandText := GetCommandText;
        end
      finally
        if OldActive then begin
          fSagQuery.SetProvider(fSagProvider);
          (fSagQuery As TClientDataset).Open;
        End;
      end;
    end;


    function TSagData.GetFieldKey : TStringList;
    var
      Valor: Variant;
    begin
     result := TStringList.Create;
      with TUser_Ind_Columns do
      begin
        //IndexFieldNames:='INDEX_NAME';
        First;
        Valor:=UpperCase('PRK_'+fTableName);
        If Locate('INDEX_NAME',Valor,[]) then
        begin
          while (UpperCase(FieldByname('INDEX_NAME').AsString) = UpperCase('PRK_'+fTableName)) and (not eof) do
          begin
            {$IFDEF TRAZAS}
            fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME,TUser_Ind_Columns);
            {$ENDIF}
            result.Add(FieldByName('COLUMN_NAME').AsString);
            next;
          end;
        end;
      end;
    end;

    constructor TSagData.CreateFromDataLink(const aBD : TSQLConnection; const aTable : string;
                aMasterSource: TDataSource; aFieldLink: String; aReferenceFieldLink: String);
    begin
      inherited Create;
      fUpdating := FALSE;
      fDefaultNulls:=nil;
      fDefaultColumnas := TRUE;
      fSagBD := aBD;
      fColumnas := '';
      fCursor := '';
      fFilter := '';
      fFieldRequired := '';
      fLockedTable := FALSE;
      fTableName := aTable;
      fKeyField := GetFieldKey;
      fSQL := TStringList.Create;

      fSagDataset := TSQLDataSet.Create(Application);
      fSagDataset.SQLConnection := fSagBD;
      fSagDataset.CommandType := ctQuery;

      fSagProvider := TDataSetProvider.Create(Application);
      fSagProvider.DataSet := fSagDataset;
      fSagProvider.Options := [poIncFieldProps,poAllowCommandText];
      fSagProvider.UpdateMode := upWhereAll;

      fSagQuery := TClientDataSet.Create(application);
      fSagQuery.AfterScroll := AfterScroll;
      fSagQuery.AfterOpen := AfterOpen;
      fSagQuery.AfterClose := AfterClose;
      fSagQuery.AfterPost := AfterPost;
      fSagQuery.BeforePost := BeforePost;
      fSagQuery.AfterInsert := AfterInsert;

      fSequencename := GetSequenceName;
      AddCursor;
      FieldLink := aFieldLink;
      ReferenceFieldLink := aReferenceFieldLink;
      MasterSource := aMasterSource;
    end;

    Procedure TSagData.LoadDefaultNulls;
    var
      Valor: Variant;
    begin
      //Carga los valores para los nulos en caso de columnas definidas por el usuario
      If FDefaultNulls <> nil then
      begin
        FDefaultNulls.Free;
        FDefaultNulls:=nil;
      end;
      FDefaultNulls := TStringList.Create;
      fDefaultNulls.add('N');
      with TUser_Tab_Columns do
      begin
        //IndexFieldNames:='TABLE_NAME';
        First;
        Valor := fTablename;
        If Locate('TABLE_NAME',Valor,[]) Then
        begin
          while ((FieldByName('TABLE_NAME').AsString=fTableName) and (not EOF)) do
          begin
            {$IFDEF TRAZAS}
            fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME,TUser_Tab_Columns);
            {$ENDIF}
            If Pos(FieldByName('COLUMN_NAME').AsString,fColumnas) > 0 Then
              fDefaultNulls.add(FieldByName('NULLABLE').AsString);
            Next;
          end;
        end;
      end;
    end;

    constructor TSagData.CreateFromColumns(const aBD : TSQLConnection; const aTable : string; aColumns: String; aFilter: String);
    begin
      CreateFromDataBase(aBD,aTable,aFilter);
      FDefaultColumnas:=False;
      fColumnas := aColumns;
      LoadDefaultNulls;
      fCursor := M_NIL;
    end;

    constructor TSagData.CreateFromDataBaseAG(const aBD : TSQLConnection; const aTable : string; aFilter: String);
    begin
      inherited Create;
      fUpdating := FALSE;
      fMasterSource := Nil;
      fDefaultNulls:=nil;
      FDefaultColumnas:=True;
      fSagBD := aBD;
      If FCursor <> M_NIL then
      begin
        fColumnas := '';
        fCursor := '';
      end;
      fTableName := aTable;
      fKeyField := GetFieldKey;
      fSQL := TStringList.Create;

      fSagDataset := TSQLDataSet.Create(Application);
      fSagDataset.SQLConnection := fSagBD;
      fSagDataset.CommandType := ctQuery;

      fSagProvider := TDataSetProvider.Create(Application);
      fSagProvider.DataSet := fSagDataset;
      fSagProvider.Options := [poIncFieldProps,poAllowCommandText,poPropogateChanges];
      fSagProvider.UpdateMode := upWhereAll;
      fSagProvider.BeforeUpdateRecord := NIL; // BeforeUpdateRecord;
      fSagProvider.AfterUpdateRecord := AfterUpdateRecord;

      fSagQuery := TClientDataSet.Create(Application);
      fSagQuery.AfterScroll := AfterScroll;
      fSagQuery.AfterOpen := AfterOpen;
      fSagQuery.AfterClose := AfterClose;
      fSagQuery.AfterInsert := AfterInsert;
      fSagQuery.BeforePost := BeforePost;
      fSagQuery.AfterPost := AfterPost;

      fSequencename := GetSequenceName;
      AddCursorAG;
      fFieldLink:='';
      fReferenceFieldLink := '';
      fFieldRequired := '';
      fLockedTable := FALSE;
      fFilter := '';
      If aFilter <> '' then
        Filter := aFilter;
    end;

    constructor TSagData.CreateFromDataBase(const aBD : TSQLConnection; const aTable : string; aFilter: String);
    begin
      inherited Create;
      fUpdating := FALSE;
      fMasterSource := Nil;
      fDefaultNulls:=nil;
      FDefaultColumnas:=True;
      fSagBD := aBD;
      If FCursor <> M_NIL then
      begin
        fColumnas := '';
        fCursor := '';
      end;
      fTableName := aTable;
      fKeyField := GetFieldKey;
      fSQL := TStringList.Create;

      fSagDataset := TSQLDataSet.Create(Application);
      fSagDataset.SQLConnection := fSagBD;
      fSagDataset.CommandType := ctQuery;

      fSagProvider := TDataSetProvider.Create(Application);
      fSagProvider.DataSet := fSagDataset;
      fSagProvider.Options := [poIncFieldProps,poAllowCommandText,poPropogateChanges];
      fSagProvider.UpdateMode := upWhereAll;
      fSagProvider.BeforeUpdateRecord := NIL; // BeforeUpdateRecord;
      fSagProvider.AfterUpdateRecord := AfterUpdateRecord;

      fSagQuery := TClientDataSet.Create(Application);
      fSagQuery.AfterScroll := AfterScroll;
      fSagQuery.AfterOpen := AfterOpen;
      fSagQuery.AfterClose := AfterClose;
      fSagQuery.AfterInsert := AfterInsert;
      fSagQuery.BeforePost := BeforePost;
      fSagQuery.AfterPost := AfterPost;

      fSequencename := GetSequenceName;
      AddCursor;
      fFieldLink:='';
      fReferenceFieldLink := '';
      fFieldRequired := '';
      fLockedTable := FALSE;
      fFilter := '';
      If aFilter <> '' then
        Filter := aFilter;
    end;

    constructor TSagData.CreateFromSagData(aSagData: TObject);
    begin
      inherited Create;
      fUpdating := (aSagData As TSagData).fUpdating;
      fMasterSource := (aSagData As TSagData).fMasterSource;
      fDefaultNulls := (aSagData As TSagData).fDefaultNulls;
      FDefaultColumnas := (aSagData As TSagData).fDefaultColumnas;
      fSagBD := (aSagData As TSagData).fSagBD;
      FCursor := (aSagData As TSagData).fCursor;
      fColumnas := (aSagData As TSagData).fColumnas;
      fTableName := (aSagData As TSagData).fTableName;
      fKeyField := GetFieldKey;
      fSQL := TStringList.Create;
      fSQL.Assign((aSagData As TSagData).fSQL);
      fSagDataset := TSQLDataSet.Create(Application);
      fSagDataset.Assign((aSagData As TSagData).fSagDataset);
      fSagProvider := TDataSetProvider.Create(Application);
      fSagProvider.Assign((aSagData As TSagData).fSagProvider);
     {
      fSagProvider.DataSet := fSagDataset;
      fSagProvider.Options := [poIncFieldProps,poAllowCommandText];
      fSagProvider.UpdateMode := upWhereAll;
     }
      fSagQuery := TClientDataSet.Create(Application);
      fSagQuery.CloneCursor((aSagData As TSagData).fSagQuery,False,False);

      fSagQuery.AfterScroll := AfterScroll;
      fSagQuery.AfterOpen := AfterOpen;
      fSagQuery.AfterClose := AfterClose;
      fSagQuery.AfterInsert := AfterInsert;
      fSagQuery.BeforePost := BeforePost;
      fSagQuery.AfterPost := AfterPost;

      fSequencename := GetSequenceName;
      AddCursor;

      fFieldLink := (aSagData As TSagData).fFieldLink;
      fReferenceFieldLink := (aSagData As TSagData).fReferenceFieldLink;
      fFieldRequired := (aSagData As TSagData).fFieldRequired;
      fLockedTable := (aSagData As TSagData).fLockedTable;
      fFilter := (aSagData As TSagData).fFilter;
    end;

    destructor TSagData.Destroy;
    begin
      fSagQuery.AfterPost := nil;
      fSagQuery.AfterInsert:=nil;
      fSagQuery.BeforePost := nil;
      fSagQuery.AfterOpen:=nil;
      fSagQuery.AfterScroll:=nil;
      fSagQuery.Close;
      fSagQuery.AfterClose:=nil;
      fSagQuery.Free;
      fSagQuery:=nil;
      fSagBd := nil;
      fKeyField.Free;
      fKeyField:=nil;
      fDefaultNulls.Free;
      inherited Destroy;
    end;

    function TSagData.ConjuntoRowIds: string;
    begin
      result := '';
      With fSagQuery do
      begin
        First;
        While not Eof do
        begin
          If Result <> '' then
            Result := Result+',';
          Result := Result + '''' + ValueByName['ROWID'] + '''';
          Next;
        end;
      end;
    end;

    function TSagData.GetSequenceName : string;
    var
      ii: Integer;
    begin
    result := '';
      with TUser_Sequences do
      begin
        First;
        While not Eof do
          begin
            If (pos(fTableName,FieldByName('SEQUENCE_NAME').AsString)>0) then
            begin
              For ii:=0 to fKeyField.Count-1 do
              begin
                If (pos(fKeyField[ii],FieldByName('SEQUENCE_NAME').AsString)>0) Then
                begin
                  result := FieldByName('SEQUENCE_NAME').AsString;
                  {$IFDEF TRAZAS}
                  fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME,TUser_Sequences);
                  {$ENDIF}
                end;
              End;
            end;
            Next;
          end;
        end;
    end;

    function TSagData.GetValorSecuenciador: integer;
    var
      aQ: TSQLQuery;
    begin
      Result := 0;
      aQ := TSQLQuery.Create (nil);
      try
        try
          with aQ do
          begin
            SQLConnection := fSagBD;
            SQL.Add(Format('SELECT %s.NEXTVAL FROM DUAL',[SequenceName]));
            {$IFDEF TRAZAS}
            fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Obtencion de secuencia');
            fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aQ);
            {$ENDIF}
            aQ.Open;
            {$IFDEF TRAZAS}
            fTrazas.PonRegistro(TRAZA_SQL,1,FILE_NAME,aQ);
            {$ENDIF}
            Result := Fields[0].AsInteger;
          end;
        except
          on E: Exception do
          begin
             //fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Error obteniendo un valor de un secuenciador por: %s',[E.message]);
             raise Exception.Create('An error occur when gettin an sequence value');
          end
        end
      finally
        If Assigned(aQ) Then
        Begin
           aQ.Close;
           FreeAndNil(aQ);
        end;
      End;
    end;

    Function TSagData.ValidateFieldsData: Boolean;
    var
      ii : Integer;
    begin
      //Valida que todos los campos de feinidos como Required tienen valor distinto de NULL
      Result:=True;
      For ii:=1 to fSagQuery.Fieldcount-1 do
      begin
        IF (fSagQuery.Fields[ii].Required) and (not IsKey(fSagQuery.Fields[ii].FieldName))
           and (fSagQuery.Fields[ii].FieldName <> 'FECHALTA') Then
        begin
          If ((fSagQuery.Fields[ii].IsNull) or (fSagQuery.Fields[ii].AsString='')) Then
          begin
            Result:=FALSE;
            fFieldRequired := fSagQuery.Fields[ii].FieldName;
            Break;
          end;
        end;
      end;
    end;

    function TSagData.GetFieldRequired: string;
    begin
      if not IsKey(fFieldRequired) Then
        Result := fFieldRequired
      else
        raise Exception.CreateFmt('The Field %s is part of the key',[fFieldRequired]);
    end;

    procedure TSagData.SetLockTable (aValue : boolean);
    var
      aQ : tSQLQuery;
    begin
      if aValue then
      begin
        if not fSagBD.InTransaction then
          raise Exception.Create('A transaction must be active to lock a table')
        else if fLockedTable then
          raise Exception.CreateFmt('The table %s is Locked', [fTableName])
        else begin
          aQ := TSQLQuery.Create(Application);
          with aQ do
          Begin
            try
              try
                SQLConnection := fSagBD;
                SQL.Add(Format('LOCK TABLE %S IN EXCLUSIVE MODE NOWAIT',[fTableName]));
                {$IFDEF TRAZAS}
                fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'Bloqueo de la tabla en modo exclusivo');
                fTrazas.PonComponente(TRAZA_SQL,1,FILE_NAME,aQ);
                {$ENDIF}
                ExecSql;
                fLockedTable := TRUE;
              except
                on E: Exception do
                begin
                  //fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'No pudo bloquear la tabla %s por: %s',[fTableName, E.message]);
                  raise;
                end
              end
            finally
              If Assigned(aQ) Then
              Begin
                aQ.Close;
                FreeAndNil(aQ);
              end;
            end;
          end;
        end;
      end;
    end;

    procedure TSagData.START;
    begin
      if not fSagBD.InTransaction Then
      begin
        {$IFDEF TRAZAS}
        fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'INICIO DE TRANSACCION');
        {$ENDIF}
        fSagBD.STARTTRANSACTION(TD);
      End;
    end;

    procedure TSagData.COMMIT;
    begin
        if not fSagBD.InTransaction then
          raise Exception.Create('The commit was wrong because any transaction is active')
        else begin
          {$IFDEF TRAZAS}
          fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'FINAL DE TRANSACCION POR ---> COMMIT');
          {$ENDIF}
          fSagBD.COMMIT(TD);
          fLockedTable := FALSE;
        end;
    end;

    procedure TSagData.ROLLBACK;
    begin
        if not fSagBD.InTransaction then
          raise Exception.Create('The rollback was wrong because any transaction is active')
        else begin
          {$IFDEF TRAZAS}
          fTrazas.PonAnotacion(TRAZA_FLUJO,1,FILE_NAME, 'FINAL DE TRANSACCION POR ---> ROLLBACK');
          {$ENDIF}
          fSagBD.ROLLBACK(TD);
          fLockedTable := FALSE;
        end
    end;

    function TSagData.SetMask (const aCampo, aMascara, aVisualizada: string): boolean;
    // Pone una máscara a un campo. Devuelve True si ha logrado ponérsela
    begin
        If fSagQuery.FindField(aCampo)<>nil
        then begin // El campo existe
            fSagQuery.FieldByName(aCampo).EditMask := aMascara;
            if (fSagQuery.FieldByName(aCampo) is tDateTimeField) then
               (fSagQuery.FieldByName(aCampo) as tDateTimeField).DisplayFormat := aVisualizada;

            result := True
        end
        else begin
            Result := False;
        end;
    end;

    Function TSagData.ExecuteFunction(FunctionName: String; Parameters: Variant):String;
    var
        aQ: TSQLQuery;
        i: Integer;
        Cad: String;
    begin
        Result:='';
        cad:='';
        If VarType(ParaMeters)<>VarNull
        Then begin
            For i:=0 to VarArrayHighBound(Parameters,1) do
            begin
                If Not (VarType(Parameters[i]) In [VarNull,VarEmpty])
                Then Begin
                    If cad<>'' Then Cad:=cad+',';
                    if not (VarType(Parameters[i]) in [VarInteger,VarSmallint, VarDouble])
                    Then
                        cad:=Cad+''''+Parameters[i]+''''
                    else
                        cad:=Cad+IntToStr(Integer(Parameters[i]));
                end;
            end;
        end;
        aQ:=TSQLQuery.Create(Application);
        With aQ do
        Try
            SQLConnection := fSagBD;


            If Cad<>''
            Then
                SQL.Add (Format('SELECT %S(%S) FROM DUAL',[FunctionName,Cad]))
            Else
                SQL.Add (Format('SELECT %S FROM DUAL',[FunctionName]));
            Open;
            Result:=Fields[0].AsString;
        Finally
            Close;
            Free;
        end;

    end;

procedure TSagData.AfterApplyUpdates(Sender: TObject; var OwnerData: OleVariant);
begin
  //
end;

procedure TSagData.BeforeApplyUpdates(Sender: TObject; var OwnerData: OleVariant);
begin
 //
end;

function TSagData.GetCommandText: string;
var i:integer;
begin
  result := '';
  for i := 0 to fSQL.Count-1 do
  begin
    result := result+' '+fSQL[i];
  end;
end;

procedure TSagData.AfterUpdateRecord(Sender: TObject; SourceDS: TDataSet;
  DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind);
begin
//  DeltaDS.FieldByName(self.GetKeyField).NewValue := fSagQuery.FieldByName(self.GetKeyField).Value;
  // fSagProvider.AfterUpdateRecord(Sender,SourceDS,DeltaDS,UpdateKind);
end;

procedure TSagData.BeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
  DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
  var Applied: Boolean);
begin
  // fSagProvider.BeforeUpdateRecord(Sender,SourceDS,DeltaDS,UpdateKind,Applied);
end;

end.//fINAL LA UNIDAD



