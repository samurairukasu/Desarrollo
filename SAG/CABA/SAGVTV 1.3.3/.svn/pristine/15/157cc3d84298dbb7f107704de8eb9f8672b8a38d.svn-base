unit Gestion;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, SysUtils, ACCESO, ACCESO1, Menus, ExtCtrls, Dialogs,
  NUSUARIO,NGRSRV, UCEdit;

type
  TUsuariosDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Bevel1: TBevel;
    ListBox1: TListBox;
    Grp: TGroupBox;
    ListBox2: TListBox;
    Serv: TGroupBox;
    ListBox3: TListBox;
    Usr: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    MainMenu1: TMainMenu;
    Nuevo1: TMenuItem;
    Usuario1: TMenuItem;
    Grupo1: TMenuItem;
    Modificar1: TMenuItem;
    Usuario2: TMenuItem;
    Grupo2: TMenuItem;
    Eliminar1: TMenuItem;
    Usuario3: TMenuItem;
    Grupo3: TMenuItem;
    btnAgrupar: TBitBtn;
    btnDeshacer: TBitBtn;
    Edit1: TColorEdit;
    Edit2: TColorEdit;
    Edit3: TColorEdit;
    Edit4: TColorEdit;
    Edit5: TColorEdit;
    Edit6: TColorEdit;
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure ListBox3DblClick(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Usuario1Click(Sender: TObject);
    procedure Usuario3Click(Sender: TObject);
    procedure Usuario2Click(Sender: TObject);
    procedure Grupo1Click(Sender: TObject);
    procedure Servicio1Click(Sender: TObject);
    procedure Grupo2Click(Sender: TObject);
    procedure Servicio2Click(Sender: TObject);
    procedure Grupo3Click(Sender: TObject);
    procedure Servicio3Click(Sender: TObject);
    procedure btnDeshacerClick(Sender: TObject);
    procedure btnAgruparClick(Sender: TObject);
  private
    Gestor: TGestorSeg;
    ClaveSup: String;
    NUsuarios,NGrupos,NServicios: Integer;
    Error: Boolean;

    procedure Refrescar;
  public
    Constructor Crear(Owner: TComponent; Gest: TGestorSeg; Clave:String);
    Function HayError: Boolean;
  end;

var
  UsuariosDlg: TUsuariosDlg;

    procedure DoMantenimientoUsuarios(Gest: TGestorSeg; const iUser: Integer; const sPassword: string);


implementation

{$R *.DFM}
    uses
        UCDIALGS,digitalizaHuella;

procedure DoMantenimientoUsuarios(Gest: TGestorSeg; const iUser: Integer; const sPassword: string);
begin
{ Realiza el mantenimiento de accesos de usuario, si es sólo administrador }
if ((not Gest.HayError) and (iUser = 0)) Then
begin
with TUsuariosDlg.Crear(Application,Gest,sPassword)  do
  try
    if not HayError then
      ShowModal;
  finally
    Free;
  end
End
Else
  MessageDlg ('Gestion de Usuarios','No tiene permisos suficientes para realizar la operación seleccionada.',mtInformation,[mbOk],mbOk,0);
end;


Constructor  TUsuariosDlg.Crear(Owner: TComponent; Gest: TGestorSeg; Clave: String);
Begin
    inherited Create(Owner);
    Gestor := Gest;
    Error := FALSE;
    if Gestor = nil Then
        Error := True
    Else
      Begin
        ClaveSup := Clave;
        if not Gestor.AccesoServicio(0,0,ClaveSup) Then
          Begin
            ShowMessage(Application.Title,'Clave de SuperUsuario Incorrecta');
            Error := TRUE;
          End
        Else
            Refrescar;
      End;
End;

Function TUsuariosDlg.HayError: Boolean;
Begin
    Result:= Error;
End;


procedure TUsuariosDlg.Refrescar;
var
ID,i: Integer;
Nombre, Descripcion,Cadena,clave, ClaveCambio: String;
ConjU,ConjG: TSetInt;
begin
NUsuarios := Gestor.ObtenerNUsuarios;
NGrupos := Gestor.ObtenerNGrupos;
NServicios:= Gestor.ObtenerNServicios;
ListBox1.Items.Clear;
Edit1.Text := '';
Edit2.Text := '';
For i := 1 To NUsuarios Do
  Begin
    Gestor.ObtenerUsuario(i,ID,Nombre,Descripcion,clave, ClaveCambio,ConjG);
    Cadena := IntToStr(ID) + '  ' + Nombre;
    ListBox1.Items.Add(Cadena);
  End;
ListBox2.Items.Clear;
Edit3.Text := '';
Edit4.Text := '';
For i:= 1 To NGrupos Do
  Begin
    Gestor.ObtenerGrupo(i,ID,Nombre,ConjU);
    Cadena := IntToStr(ID) + '  ' + Nombre;
    ListBox2.Items.Add(Cadena);
  End;
ListBox3.Items.Clear;
Edit5.Text := '';
Edit6.Text := '';
For i := 1 To NServicios Do
  Begin
    Gestor.ObtenerServicio(i,ID,Nombre,ConjU,ConjG);
    Cadena := IntToStr(ID) + '  ' + UpperCase(Nombre);
    ListBox3.Items.Add(Cadena);
  end;
end;


procedure TUsuariosDlg.ListBox1Click(Sender: TObject);
Var
    Grupos, Compon, Usuarios,GruposSer: TSetInt;
    IDU,IDG,IDS,i,j: Integer;
    Nombre,Adicional,Cadena, clave, ClaveCambio: String;
begin
    i := ListBox1.ItemIndex;
    if (i >= 0) Then
    Begin
        Cadena := '';
        Gestor.ObtenerUsuario(i+1,IDU,Nombre,Adicional,clave, ClaveCambio, Grupos);
        For j:= 1 To NGrupos Do
        Begin
            Gestor.ObtenerGrupo(j,IDG,Nombre,Compon);
            if (IDG in Grupos) Then
               Cadena := Cadena + ' ' + IntToStr(IDG);
        End;
        Edit1.Text := Cadena;
        Cadena := '';
        For j:= 1 To NServicios Do
        Begin
            Gestor.ObtenerServicio(j,IDS,Nombre,Usuarios,GruposSer);
            if ((IDU in Usuarios) or ((Grupos * GruposSer) <> [])) Then
               Cadena := Cadena + ' ' + IntToStr(IDS);
        End;
        Edit2.Text := Cadena;
    End;
end;


procedure TUsuariosDlg.ListBox2Click(Sender: TObject);
Var
    Grupos, Compon, Usuarios,GruposSer: TSetInt;
    IDU,IDG,IDS,i,j: Integer;
    Nombre,Adicional,Cadena,Clave, ClaveCambio: String;
begin
    i := ListBox2.ItemIndex;
    if (i >= 0) Then
    Begin
        Cadena := '';
        Gestor.ObtenerGrupo(i+1,IDG,Nombre,Compon);
        For j:= 1 To NUsuarios Do
        Begin
            Gestor.ObtenerUsuario(j,IDU,Nombre,Adicional,Clave,ClaveCambio, Grupos);
            if (IDU in Compon) Then
               Cadena := Cadena + ' ' + IntToStr(IDU);
        End;
        Edit3.Text := Cadena;
        Cadena := '';
        For j:= 1 To NServicios Do
        Begin
            Gestor.ObtenerServicio(j,IDS,Nombre,Usuarios,GruposSer);
            if (IDG in GruposSer) Then
               Cadena := Cadena + ' ' + IntToStr(IDS);
        End;
        Edit4.Text := Cadena;
    End;
end;

procedure TUsuariosDlg.ListBox3Click(Sender: TObject);
Var
    Grupos, Compon, Usuarios,GruposSer: TSetInt;
    IDU,IDG,IDS,i,j: Integer;
    Nombre,Adicional,Cadena,Clave,ClaveCambio: String;
begin
    i := ListBox3.ItemIndex;
    if (i >= 0) Then
    Begin
        Cadena := '';
        Gestor.ObtenerServicio(i+1,IDS,Nombre,Usuarios,GruposSer);
        For j:= 1 To NGrupos Do
        Begin
            Gestor.ObtenerGrupo(j,IDG,Nombre,Compon);
            if (IDG in GruposSer) Then
               Cadena := Cadena + ' ' + IntToStr(IDG);
        End;
        Edit6.Text := Cadena;
        Cadena := '';
        For j:= 1 To NUsuarios Do
        Begin
            Gestor.ObtenerUsuario(j,IDU,Nombre,Adicional,Clave,ClaveCambio, Grupos);
            if ((IDU in Usuarios) or ((Grupos * GruposSer) <> [])) Then
               Cadena := Cadena + ' ' + IntToStr(IDU);
        End;
        Edit5.Text := Cadena;
    End;



end;

procedure TUsuariosDlg.ListBox3DblClick(Sender: TObject);
begin
    ListBox3.ItemIndex := -1;
    Edit5.Text := '';
    Edit6.Text := '';
end;

procedure TUsuariosDlg.ListBox2DblClick(Sender: TObject);
begin
    ListBox2.ItemIndex := -1;
    Edit3.Text := '';
    Edit4.Text := '';
end;

procedure TUsuariosDlg.ListBox1DblClick(Sender: TObject);
begin
    ListBox1.ItemIndex := -1;
    Edit1.Text := '';
    Edit2.Text := '';
end;

procedure TUsuariosDlg.Usuario1Click(Sender: TObject);
Var
    NUsuariosDlg: TNUsuarioDlg;
    IDU: Integer;
    Nombre,Clave,Adicional,ClaveCambios: String;
begin
    IDU := Gestor.ObtenerNIDU;
    if (IDU <> -1) Then
      Begin
        NUsuariosDlg := TNUsuarioDlg.Create(Self,0,IDU,'','',Clave,ClaveCambios);
        NUsuariosDlg.Caption := 'Nuevo Usuario';
        NUsuariosDlg.ShowModal;
        if (NUsuariosDlg.ModalResult = mrOK) Then
          Begin
            NUsuariosDlg.ObtenerDatos(IDU,Nombre,Clave,Adicional,ClaveCambios);
            if (IDU <> -1) Then
              Begin
                if not Gestor.AniadirUsuario(IDU,UpperCase(Nombre),Clave,Adicional,ClaveSup,ClaveCambios) Then
                   ShowMessage(Application.Title,'No se pudo crear el Usuario')
                Else
                   refrescar;
                   if Application.MessageBox( '¿Desea digitalizar la huella de este usuario?', 'Application.Title',MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
                   begin
                      SetHuella(IDU);
                   end;
              End;
        End;
        NUsuariosDlg.Destroy;
      End
    else
      ShowMessage(Application.Title,'No se pudo leer la Base de Datos');
end;

procedure TUsuariosDlg.Usuario3Click(Sender: TObject);
Var
     UID,i: Integer;
     Grps: TSetInt;
     Nombre,Info, Clave, ClaveCambio: String;
begin
     i := ListBox1.ItemIndex;
     if (i = -1) Then
         ShowMessage(Application.Title,'Debe seleccionar un usuario')
     else
       Begin
         Gestor.ObtenerUsuario(i+1,UID,Nombre,Info,Clave,ClaveCambio, Grps);
         if (UID <> -1) Then
           Begin
             Info := 'El usuario con ID ' + IntToStr(UID) + ' va a ser Eliminado. ¿Está seguro?';
             if (MessageDlg(Application.Title,Info,mtConfirmation,[mbOK,mbCancel],mbOk,0) = mrOK) Then
             Begin
               try
                 if not Gestor.EliminarUsuario(UID,ClaveSup) Then
                     ShowMessage(Application.Title,'El Usuario no pudo ser eliminado')
                 Else
                     Refrescar;
               except
                 on E:EIntegrity do
                   begin
                     ShowMessage(Application.Title,'El usuario está asignado a algún grupo o servicio. Elimine las asociaciones antes de eliminar el usuario');
                   end;
                 on E:Exception do ShowMessage(Application.Title,'El Usuario no pudo ser eliminado');
               end;
             End;
           End;
       End;


end;

procedure TUsuariosDlg.Usuario2Click(Sender: TObject);
Var
    NUsuariosDlg: TNUsuarioDlg;
    IDU,i: Integer;
    Nombre,Clave,Info,ClaveCambios: String;
    Grps: TSetInt;
begin
     i := ListBox1.ItemIndex;
     if (i = -1) Then
         ShowMessage(Application.Title,'Debe seleccionar un usuario')
     else
      Begin
        Gestor.ObtenerUsuario(i+1,IDU,Nombre,Info,Clave, ClaveCambios, Grps);
        NUsuariosDlg := TNUsuarioDlg.Create(Self,1,IDU,Nombre,Info, Clave, ClaveCambios);
        NUsuariosDlg.Caption := 'Modificar Usuario';
        NUsuariosDlg.ShowModal;
        if (NUsuariosDlg.ModalResult = mrOK) Then
          Begin
            NUsuariosDlg.ObtenerDatos(IDU,Nombre,Clave,Info,ClaveCambios);
            if (IDU <> -1) Then
              Begin
                if not Gestor.ModificarUsuario(IDU,Nombre,Clave,Info,ClaveSup,ClaveCambios) Then
                   ShowMessage(Application.Title,'No se pudo modificar el usuario')
                Else
                   refrescar;
                   if Application.MessageBox( '¿Desea digitalizar la huella de este usuario?', 'Application.Title',MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
                   begin
                      SetHuella(IDU);
                   end;
              End;
        End;
        NUsuariosDlg.Destroy;
      End

end;

procedure TUsuariosDlg.Grupo1Click(Sender: TObject);
Var
    NGrSrvDlg: TNGrSrvDlg;
    ID: Integer;
    Nombre: String;
begin
    ID := Gestor.ObtenerNIDG;
    if (ID <> -1) Then
      Begin
        NGrSrvDlg := TNGrSrvDlg.Create(Self,0,ID,'');
        NGrSrvDlg.Caption := 'Nuevo Grupo';
        NGrSrvDlg.ShowModal;
        if (NGrSrvDlg.ModalResult = mrOK) Then
          Begin
            NGrSrvDlg.ObtenerDatos(ID,Nombre);
            if (ID <> -1) Then
              Begin
                if not Gestor.AniadirGrupo(ID,Nombre,ClaveSup) Then
                   ShowMessage(Application.Title,'No se pudo crear el Grupo')
                Else
                   refrescar;
              End;
        End;
        NGrSrvDlg.Destroy;
      End
    else
      ShowMessage(Application.Title,'No se pudo leer la Base de Datos');

end;

procedure TUsuariosDlg.Servicio1Click(Sender: TObject);
Var
    NGrSrvDlg: TNGrSrvDlg;
    ID: Integer;
    Nombre: String;
begin
    ID := Gestor.ObtenerNIDS;
    if (ID <> -1) Then
      Begin
        NGrSrvDlg := TNGrSrvDlg.Create(Self,0,ID,'');
        NGrSrvDlg.Caption := 'Nuevo Servicio';
        NGrSrvDlg.ShowModal;
        if (NGrSrvDlg.ModalResult = mrOK) Then
          Begin
            NGrSrvDlg.ObtenerDatos(ID,Nombre);
            if (ID <> -1) Then
              Begin
                if not Gestor.AniadirServicio(ID,Nombre,ClaveSup) Then
                   ShowMessage(Application.Title,'No se pudo crear el Grupo')
                Else
                   refrescar;
              End;
        End;
        NGrSrvDlg.Destroy;
      End
    else
      ShowMessage(Application.Title,'No se pudo leer la Base de Datos');
end;

procedure TUsuariosDlg.Grupo2Click(Sender: TObject);
Var
    NGrSrvDlg: TNGrSrvDlg;
    ID,i: Integer;
    Nombre: String;
    Componentes: TSetInt;
begin
     i := ListBox2.ItemIndex;
     if (i = -1) Then
         ShowMessage(Application.Title,'Debe seleccionar un grupo')
     else
      Begin
        Gestor.ObtenerGrupo(i+1,ID,Nombre,Componentes);
        NGrSrvDlg := TNGrSrvDlg.Create(Self,1,ID,Nombre);
        NGrSrvDlg.Caption := 'Modificar Grupo';
        NGrSrvDlg.ShowModal;
        if (NGrSrvDlg.ModalResult = mrOK) Then
          Begin
            NGrSrvDlg.ObtenerDatos(ID,Nombre);
            if (ID <> -1) Then
              Begin
                if not Gestor.ModificarGrupo(ID,Nombre,ClaveSup) Then
                   ShowMessage(Application.Title,'No se pudo modificar el grupo')
                Else
                   refrescar;
              End;
        End;
        NGrSrvDlg.Destroy;
      End
end;

procedure TUsuariosDlg.Servicio2Click(Sender: TObject);
Var
    NGrSrvDlg: TNGrSrvDlg;
    ID,i: Integer;
    Nombre: String;
    Usuarios,Grupos: TSetInt;
begin
     i := ListBox3.ItemIndex;
     if (i = -1) Then
         ShowMessage(Application.Title,'Debe seleccionar un servicio')
     else
      Begin
        Gestor.ObtenerServicio(i+1,ID,Nombre,Usuarios,Grupos);
        NGrSrvDlg := TNGrSrvDlg.Create(Self,1,ID,Nombre);
        NGrSrvDlg.Caption := 'Modificar Servicio';
        NGrSrvDlg.ShowModal;
        if (NGrSrvDlg.ModalResult = mrOK) Then
          Begin
            NGrSrvDlg.ObtenerDatos(ID,Nombre);
            if (ID <> -1) Then
              Begin
                if not Gestor.ModificarServicio(ID,Nombre,ClaveSup) Then
                   ShowMessage(Application.Title,'No se pudo modificar el servicio')
                Else
                   refrescar;
              End;
        End;
        NGrSrvDlg.Destroy;
      End

end;

procedure TUsuariosDlg.Grupo3Click(Sender: TObject);
Var
     ID,i: Integer;
     Compon: TSetInt;
     Nombre, Info: String;
begin
     i := ListBox2.ItemIndex;
     if (i = -1) Then
         ShowMessage(Application.Title,'Debe seleccionar un Grupo')
     else
       Begin
         Gestor.ObtenerGrupo(i+1,ID,Nombre,Compon);
         if (ID <> -1) Then
           Begin
             Info := 'El Grupo con ID ' + IntToStr(ID) + ' va a ser Eliminado. ¿Está seguro?';
             if (MessageDlg('Gestion de Usuarios',Info,mtConfirmation,[mbOK,mbCancel],mbOk,0) = mrOK) Then
             Begin
               try
                 if not Gestor.EliminarGrupo(ID,ClaveSup) Then
                     ShowMessage(Application.Title,'El Grupo no pudo ser eliminado')
                 Else
                     Refrescar;
               except
                 on E:EIntegrity do
                   begin
                     ShowMessage(Application.Title,'Existe algún usuario o servicio asignado al grupo. Elimine las asociaciones antes de eliminar el grupo');
                   end;
                 on E:Exception do ShowMessage(Application.Title,'El Grupo no pudo ser eliminado');
               end;
             End;
           End;
       End;

end;

procedure TUsuariosDlg.Servicio3Click(Sender: TObject);
Var
     ID,i: Integer;
     Usrs,Grps: TSetInt;
     Nombre, Info: String;
begin
     i := ListBox3.ItemIndex;
     if (i = -1) Then
         ShowMessage(Application.Title,'Debe seleccionar un servicio')
     else
       Begin
         Gestor.ObtenerServicio(i+1,ID,Nombre,Usrs,Grps);
         if (ID <> -1) Then
           Begin
             Info := 'El Servicio con ID ' + IntToStr(ID) + ' va a ser Eliminado. ¿Está seguro?';
             if (MessageDlg('Gestion de Usuarios',Info,mtConfirmation,[mbOK,mbCancel],mbOk,0) = mrOK) Then
             Begin
               try
                 if not Gestor.EliminarServicio(ID,ClaveSup) Then
                     ShowMessage(Application.Title,'El Servicio no pudo ser eliminado')
                 Else
                     Refrescar;
               except
                 on E:EIntegrity do
                   begin
                     ShowMessage(Application.Title,'El servicio tiene asociado algún usuario o grupo. Elimine las asociaciones antes de eliminar el servicio');
                   end;
                 on E:Exception do ShowMessage(Application.Title,'El Servicio no pudo ser eliminado');
               end;
             End;
           End;
       End;

end;

procedure TUsuariosDlg.btnDeshacerClick(Sender: TObject);
Var
    Usr,Grp,Serv,UID,SID,GID: Integer;
    Nombre,Adicional,Clave,ClaveCambio:String;
    Compon,Grupos: TSetInt;

begin
    Usr := ListBox1.ItemIndex;
    Grp := ListBox2.ItemIndex;
    Serv := ListBox3.ItemIndex;
    { Asociaciones del Usuario }
    If (Usr >= 0) Then
    Begin
        Gestor.ObtenerUsuario(Usr+1,UID,Nombre,Adicional,Clave,ClaveCambio,Grupos);
        if ((Grp >= 0) and (UID <> -1)) Then
        Begin
            Gestor.ObtenerGrupo(Grp+1,GID,Nombre,Compon);
            If not Gestor.DAsociarUsuarioGrupo(UID,GID,ClaveSup) Then
                ShowMessage(Application.Title,'No se pudo realizar la operación');
        End;
        if ((Serv >= 0) and (UID <> -1)) Then
        Begin
            Gestor.ObtenerServicio(Serv+1,SID,Nombre,Grupos,Compon);
            if not Gestor.DAsociarUsuarioServicio(UID,SID,ClaveSup) Then
                ShowMessage(Application.Title,'No se pudo realizar la operación');
        End;
    End;
    If ((Grp >= 0) and (Serv >= 0)) Then
    Begin
        { Solo interesan los identificadores }
        Gestor.ObtenerGrupo(Grp+1,GID,Nombre,Compon);
        Gestor.ObtenerServicio(Serv+1,SID,Nombre,Compon,Grupos);
        if (GID <> -1) and (SID <> -1) Then
            if not Gestor.DAsociarGrupoServicio(GID,SID,ClaveSup) Then
                ShowMessage(Application.Title,'No se pudo realizar la operación');
    End;
    Refrescar;
end;

procedure TUsuariosDlg.btnAgruparClick(Sender: TObject);
Var
    Usr,Grp,Serv,UID,SID,GID: Integer;
    Nombre,Adicional,Clave,ClaveCambio:String;
    Compon,Grupos: TSetInt;

begin
    Usr := ListBox1.ItemIndex;
    Grp := ListBox2.ItemIndex;
    Serv := ListBox3.ItemIndex;
    { Asociaciones del Usuario }
    If (Usr >= 0) Then
    Begin
        Gestor.ObtenerUsuario(Usr+1,UID,Nombre,Adicional,Clave,ClaveCambio, Grupos); 
        if ((Grp >= 0) and (UID <> -1)) Then
        Begin
            Gestor.ObtenerGrupo(Grp+1,GID,Nombre,Compon);
            If not Gestor.AsociarUsuarioGrupo(UID,GID,ClaveSup) Then
                ShowMessage(Application.Title,'No se pudo realizar la operación');
        End;
        if ((Serv >= 0) and (UID <> -1)) Then
        Begin
            Gestor.ObtenerServicio(Serv+1,SID,Nombre,Grupos,Compon);
            if not Gestor.AsociarUsuarioServicio(UID,SID,ClaveSup) Then
                ShowMessage(Application.Title,'No se pudo realizar la operación');
        End;
    End;
    If ((Grp >= 0) and (Serv >= 0)) Then
    Begin
        { Solo interesan los identificadores }
        Gestor.ObtenerGrupo(Grp+1,GID,Nombre,Compon);
        Gestor.ObtenerServicio(Serv+1,SID,Nombre,Compon,Grupos);
        if (GID <> -1) and (SID <> -1) Then
            if not Gestor.AsociarGrupoServicio(GID,SID,ClaveSup) Then
                ShowMessage(Application.Title,'No se pudo realizar la operación');
    End;
    Refrescar;
end;







end.
