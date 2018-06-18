unit imprvlim;
{ Imprime los valores límite de las MOTOCICLETAS, VEHICULOS LIGEROS,
  VEHICULOS PESADOS y REMOLQUES }


{
  Ultima Traza:
  Ultima Incidencia:
  Ultima Anomalia: 1
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, quickrpt, Qrctrls,MTBLMAHA, uUtils;

type
  TfrmImprimirValLim = class(TForm)
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBandTipoVehiculo: TQRBand;
    QRBdetalle: TQRBand;
    QRLblCampo: TQRLabel;
    QRLblCampoOK: TQRLabel;
    QRLblCampoObservacion: TQRLabel;
    QRLblCampoLeve: TQRLabel;
    QRImpValLim: TQuickRep;
    QRLblPeriodoFechas: TQRLabel;
    QRLblTipoVehiculo: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRImage1: TQRImage;
    QRShape1: TQRShape;
    procedure QRImpValLimNeedData(Sender: TObject; var MoreData: Boolean);
  private
    { Private declarations }
    procedure RellenarCampos_TabSheet (var iCampo, iTab: integer);

  public
    { Public declarations }
    iCampoActual: integer; { Almacena qué campo se está rellenando actualmente }
    iCampos_PorTabSheet: integer; { Almacena cuántos campos por TabSheet hay en los
                                    4 primeros Tab Sheets }
    iTabSheet_Actual: integer; { Almacena cual es el tab sheet que se está
                                 rellenando en ese momento }
    iTotal_TabSheets: integer; { Almacena el nº de tab sheets que se van a imprimir }
    aVLForm: TfrmValoresLimite;

    procedure Execute (const iCActual,iC_PorTabSheet,iT_Actual,iT_TabSheets: integer; aForm: TfrmValoresLimite; aTipo: smallint);
  end;

var
  frmImprimirValLim: TfrmImprimirValLim;

implementation

uses
   ULOGS;

{$R *.DFM}

const
    FICHERO_ACTUAL = 'ImprVLim';




procedure TfrmImprimirValLim.RellenarCampos_TabSheet (var iCampo, iTab: integer);
{ Rellena una línea del Tab Sheet actual (iTab) con el campo correspondiente (iCampo).
  Cuando se rellenan los 6 campos de un Tab (de Motocicletas, Vehículos Ligeros,
  Vehículos Pesados y Remolques, entonces se incrementa el tab actual y se inicializa
  iCampo para rellenar el siguiente Tab Sheet. }

begin
    try
       case iTab of
            1: begin
                   QRLblPeriodoFechas.Enabled := False;
                   case iCampo of
                       1: begin
                              ActivarComponentes(true,self,[3]);
                              QRLblTipoVehiculo.Caption := 'Motocicletas';
                              QRLblCampo.Caption := aVLForm.LblNombreCampo1.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDpe.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDpe.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDpe.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       2: begin
                              HeightComponentes(self,[2],-17);
                              MuevoComponentes(self,[1],-16);
                              ActivarComponentes(false,self,[3]);
                              QRLblCampo.Caption := aVLForm.lblDeslizamOtrosEjes.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDoe.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDoe.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDoe.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       3: begin
                              QRLblCampo.Caption := aVLForm.lblEficaciaFrenoEstac.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkEfe.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsEfe.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveEfe.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       4: begin
                              QRLblCampo.Caption := aVLForm.lblEficaciaFrenoServ.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkEfs.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsEfs.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveEfs.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       5: begin
                              QRLblCampo.Caption := aVLForm.lblDeseqFrenosPrimerEje.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDfs1e.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDfs1e.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDfs1e.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       6: begin
                              QRLblCampo.Caption := aVLForm.lblDeseqFrenosOtrosEjes.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDfsoe.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDfsoe.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDfsoe.Text;

                              { incrementamos iTab e inicializamos iCampo }
                              inc (iTab);
                              iCampo := 1;
                       end;
                   end;
            end;
            2: begin
                   case iCampo of
                       1: begin
                              HeightComponentes(self,[2],17);
                              MuevoComponentes(self,[1],16);
                              ActivarComponentes(true,self,[3]);
                              QRLblTipoVehiculo.Caption := 'Vehículos Ligeros';
                              QRLblCampo.Caption := aVLForm.LblDeslPrimerEje.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDpevl.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDpevl.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDpevl.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       2: begin
                              HeightComponentes(self,[2],-17);
                              MuevoComponentes(self,[1],-16);
                              ActivarComponentes(false,self,[3]);
                              QRLblCampo.Caption := aVLForm.lblDeslizOtrosEjes.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDoevl.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDoevl.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDoevl.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       3: begin
                              QRLblCampo.Caption := aVLForm.lblEficFrenoEstac.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkEfevl.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsEfevl.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveEfevl.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       4: begin
                              QRLblCampo.Caption := aVLForm.lblEficFrenoServ.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkEfsvl.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsEfsvl.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveEfsvl.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       5: begin
                              QRLblCampo.Caption := aVLForm.lblDeseqFrenosServ1Eje.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDfs1evl.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDfs1evl.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDfs1evl.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       6: begin
                              QRLblCampo.Caption := aVLForm.lblDeseqFrenosServoEje.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDfsoevl.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDfsoevl.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDfsoevl.Text;

                              { incrementamos iTab e inicializamos iCampo }
                              inc (iTab);
                              iCampo := 1;
                       end;
                   end;
            end;
            3: begin
                   case iCampo of
                       1: begin
                              HeightComponentes(self,[2],17);
                              MuevoComponentes(self,[1],16);
                              ActivarComponentes(true,self,[3]);
                              QRLblTipoVehiculo.Caption := 'Vehículos Pesados';
                              QRLblCampo.Caption := aVLForm.lblDesl1Eje.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDpevp.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDpevp.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDpevp.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       2: begin
                              HeightComponentes(self,[2],-17);
                              MuevoComponentes(self,[1],-16);
                              ActivarComponentes(false,self,[3]);
                              QRLblCampo.Caption := aVLForm.lblDeslizOtrEjes.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDoevp.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDoevp.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDoevp.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       3: begin
                              QRLblCampo.Caption := aVLForm.lblEficFrenEstac.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkEfevp.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsEfevp.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveEfevp.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       4: begin
                              QRLblCampo.Caption := aVLForm.lblEficFrenServ.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkEfsvp.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsEfsvp.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveEfsvp.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       5: begin
                              QRLblCampo.Caption := aVLForm.lblDeseqFrenosSer1Eje.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDfs1evp.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDfs1evp.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDfs1evp.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       6: begin
                              QRLblCampo.Caption := aVLForm.lblDeseqFrenosSeroEje.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDfsoevp.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDfsoevp.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDfsoevp.Text;

                              { incrementamos iTab e inicializamos iCampo }
                              inc (iTab);
                              iCampo := 1;
                       end;
                   end;
            end;
            4: begin
                   case iCampo of
                       1: begin
                              HeightComponentes(self,[2],17);
                              MuevoComponentes(self,[1],16);
                              ActivarComponentes(true,self,[3]);
                              QRLblTipoVehiculo.Caption := 'Remolques';
                              QRLblCampo.Caption := aVLForm.lblDesliz1Eje.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDper.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDper.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDper.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       2: begin
                              HeightComponentes(self,[2],-17);
                              MuevoComponentes(self,[1],-16);
                              ActivarComponentes(false,self,[3]);
                              QRLblCampo.Caption := aVLForm.lblDeslizoEjes.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDoer.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDoer.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDoer.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       3: begin
                              QRLblCampo.Caption := aVLForm.lblEficFrEstac.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkEfer.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsEfer.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveEfer.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       4: begin
                              QRLblCampo.Caption := aVLForm.lblEficFrServ.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkEfsr.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsEfsr.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveEfsr.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       5: begin
                              QRLblCampo.Caption := aVLForm.lblDeseqFrSer1Eje.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDfs1er.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDfs1er.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDfs1er.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       6: begin
                              QRLblCampo.Caption := aVLForm.lblDeseqFrSeroEje.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtOkDfsoer.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDfsoer.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDfsoer.Text;

                              { incrementamos iTab e inicializamos iCampo }
                              inc (iTab);
                              iCampo := 1;
                       end;
                   end;
            end;
            5: begin
                   QRLblPeriodoFechas.Enabled := True;
                   case iCampo of
                       1: begin
                              HeightComponentes(self,[2],17);
                              MuevoComponentes(self,[1],16);
                              ActivarComponentes(true,self,[3]);
                              QRLblTipoVehiculo.Caption := 'Datos Comunes';
                              QRLblCampo.Caption := aVLForm.lblDeslizam1Eje.Caption;
                              QRLblPeriodoFechas.Caption := '';
                              QRLblCampoOK.Caption := aVLForm.edtOkDmae.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDmae.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDmae.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       2: begin
                              HeightComponentes(self,[2],-17);
                              MuevoComponentes(self,[1],-16);
                              ActivarComponentes(false,self,[3]);
                              QRLblCampo.Caption := aVLForm.lblEficMinAmort.Caption;
                              QRLblPeriodoFechas.Caption := '';
                              QRLblCampoOK.Caption := aVLForm.edtOkEma.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsEma.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveEma.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       3: begin
                              QRLblCampo.Caption := aVLForm.lblEficMaxAmort.Caption;
                              QRLblPeriodoFechas.Caption := '';
                              QRLblCampoOK.Caption := aVLForm.edtOkEmam.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsEmam.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveEmam.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       4: begin
//                              QRLblCampo.Caption := aVLForm.lblCOMaximo.Caption;
//                              QRLblPeriodoFechas.Caption := aVLForm.lblAntes1992.Caption;
//                              QRLblCampoOK.Caption := aVLForm.edtokco1.Text;
//                              QRLblCampoObservacion.Caption := aVLForm.edtobsco1.Text;
//                              QRLblCampoLeve.Caption := aVLForm.edtleveco1.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       5: begin
                              {QRLblCampo.Caption := aVLForm.lblCOMaximo.Caption;}
//                              QRLblPeriodoFechas.Caption := aVLForm.lbl19921994.Caption;
//                              QRLblCampoOK.Caption := aVLForm.edtokco2.Text;
//                              QRLblCampoObservacion.Caption := aVLForm.edtobsco2.Text;
//                              QRLblCampoLeve.Caption := aVLForm.edtleveco2.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       6: begin
                              {QRLblCampo.Caption := aVLForm.lblDeseqFrSeroEje.Caption;}
//                              QRLblPeriodoFechas.Caption := aVLForm.lblPos1994.Caption;
//                              QRLblCampoOK.Caption := aVLForm.edtokco3.Text;
//                              QRLblCampoObservacion.Caption := aVLForm.edtobsco3.Text;
//                              QRLblCampoLeve.Caption := aVLForm.edtleveco3.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       7: begin
//                              QRLblCampo.Caption := aVLForm.lblHCMaximos.Caption;
//                              QRLblPeriodoFechas.Caption := aVLForm.lblAnterior1992.Caption;
//                              QRLblCampoOK.Caption := aVLForm.edtOkhc1.Text;
//                              QRLblCampoObservacion.Caption := aVLForm.edtObshc1.Text;
//                              QRLblCampoLeve.Caption := aVLForm.edtLevehc1.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       8: begin
                              {QRLblCampo.Caption := aVLForm.lblEficMinAmort.Caption;}
//                              QRLblPeriodoFechas.Caption := aVLForm.lblhc19921994.Caption;
//                              QRLblCampoOK.Caption := aVLForm.edtOkhc2.Text;
//                              QRLblCampoObservacion.Caption := aVLForm.edtObshc2.Text;
//                              QRLblCampoLeve.Caption := aVLForm.edtLevehc2.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       9: begin
                              {QRLblCampo.Caption := aVLForm.lblEficMinAmort.Caption;}
//                              QRLblPeriodoFechas.Caption := aVLForm.lblhcPos1994.Caption;
//                              QRLblCampoOK.Caption := aVLForm.edtOkhc3.Text;
//                              QRLblCampoObservacion.Caption := aVLForm.edtObshc3.Text;
//                              QRLblCampoLeve.Caption := aVLForm.edtLevehc3.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                      10: begin
                              QRLblCampo.Caption := aVLForm.lblEmisionHumos.Caption;
                              QRLblPeriodoFechas.Caption := aVLForm.lblAntes1995.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtokem1.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtobsem1.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtleveem1.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                      11: begin
                              QRLblCampo.Caption := aVLForm.lblEmisionHumos.Caption;
                              QRLblPeriodoFechas.Caption := aVLForm.lblPos1995.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtokem2.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtobsem2.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtleveem2.Text;

                              { incrementamos iTab }
                              inc (iTab);
                       end;
                       end;
                   end;

               6:begin
                   QRLblPeriodoFechas.Enabled := True;
                   case iCampo of
                       1: begin
                              HeightComponentes(self,[2],17);
                              MuevoComponentes(self,[1],16);
                              ActivarComponentes(true,self,[3]);
                              QRLblTipoVehiculo.Caption := 'Datos CO MotorCicloOtto';
                              QRLblCampo.Caption := aVLForm.lblDeslizam1Eje.Caption;
                              QRLblPeriodoFechas.Caption := '';
                              QRLblCampoOK.Caption := aVLForm.edtOkDmae.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsDmae.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveDmae.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       2: begin
                              HeightComponentes(self,[2],-17);
                              MuevoComponentes(self,[1],-16);
                              ActivarComponentes(false,self,[3]);
                              QRLblCampo.Caption := aVLForm.lblEficMinAmort.Caption;
                              QRLblPeriodoFechas.Caption := '';
                              QRLblCampoOK.Caption := aVLForm.edtOkEma.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsEma.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveEma.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       3: begin
                              QRLblCampo.Caption := aVLForm.lblEficMaxAmort.Caption;
                              QRLblPeriodoFechas.Caption := '';
                              QRLblCampoOK.Caption := aVLForm.edtOkEmam.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtObsEmam.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtLeveEmam.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       4: begin
//                              QRLblCampo.Caption := aVLForm.lblCOMaximo.Caption;
//                              QRLblPeriodoFechas.Caption := aVLForm.lblAntes1992.Caption;
//                              QRLblCampoOK.Caption := aVLForm.edtokco1.Text;
//                              QRLblCampoObservacion.Caption := aVLForm.edtobsco1.Text;
//                              QRLblCampoLeve.Caption := aVLForm.edtleveco1.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       5: begin
                              {QRLblCampo.Caption := aVLForm.lblCOMaximo.Caption;}
//                              QRLblPeriodoFechas.Caption := aVLForm.lbl19921994.Caption;
//                              QRLblCampoOK.Caption := aVLForm.edtokco2.Text;
//                              QRLblCampoObservacion.Caption := aVLForm.edtobsco2.Text;
//                              QRLblCampoLeve.Caption := aVLForm.edtleveco2.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       6: begin
                              {QRLblCampo.Caption := aVLForm.lblDeseqFrSeroEje.Caption;}
//                              QRLblPeriodoFechas.Caption := aVLForm.lblPos1994.Caption;
//                              QRLblCampoOK.Caption := aVLForm.edtokco3.Text;
//                              QRLblCampoObservacion.Caption := aVLForm.edtobsco3.Text;
//                              QRLblCampoLeve.Caption := aVLForm.edtleveco3.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       7: begin
//                              QRLblCampo.Caption := aVLForm.lblHCMaximos.Caption;
//                              QRLblPeriodoFechas.Caption := aVLForm.lblAnterior1992.Caption;
//                              QRLblCampoOK.Caption := aVLForm.edtOkhc1.Text;
//                              QRLblCampoObservacion.Caption := aVLForm.edtObshc1.Text;
//                              QRLblCampoLeve.Caption := aVLForm.edtLevehc1.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       8: begin
                              {QRLblCampo.Caption := aVLForm.lblEficMinAmort.Caption;}
//                              QRLblPeriodoFechas.Caption := aVLForm.lblhc19921994.Caption;
//                              QRLblCampoOK.Caption := aVLForm.edtOkhc2.Text;
//                              QRLblCampoObservacion.Caption := aVLForm.edtObshc2.Text;
//                              QRLblCampoLeve.Caption := aVLForm.edtLevehc2.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                       9: begin
                              {QRLblCampo.Caption := aVLForm.lblEficMinAmort.Caption;}
//                              QRLblPeriodoFechas.Caption := aVLForm.lblhcPos1994.Caption;
//                              QRLblCampoOK.Caption := aVLForm.edtOkhc3.Text;
//                              QRLblCampoObservacion.Caption := aVLForm.edtObshc3.Text;
//                              QRLblCampoLeve.Caption := aVLForm.edtLevehc3.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                      10: begin
                              QRLblCampo.Caption := aVLForm.lblEmisionHumos.Caption;
                              QRLblPeriodoFechas.Caption := aVLForm.lblAntes1995.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtokem1.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtobsem1.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtleveem1.Text;

                              { Incrementamos el campo actual }
                              inc (iCampo);
                       end;
                      11: begin
                              QRLblCampo.Caption := aVLForm.lblEmisionHumos.Caption;
                              QRLblPeriodoFechas.Caption := aVLForm.lblPos1995.Caption;
                              QRLblCampoOK.Caption := aVLForm.edtokem2.Text;
                              QRLblCampoObservacion.Caption := aVLForm.edtobsem2.Text;
                              QRLblCampoLeve.Caption := aVLForm.edtleveem2.Text;

                              { incrementamos iTab }
                              inc (iTab);
                       end;
                   end;






            end;
       end;
    except
         on E:Exception do
         begin
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE, 1, FICHERO_ACTUAL, Format ('Error en RellenarCampos_TabSheet: %s  iTab: %d  iCampo: %d', [E.Message, iTab, iCampo]));
             raise;
         end;
    end;
end;

procedure TfrmImprimirValLim.Execute (const iCActual,iC_PorTabSheet,iT_Actual,iT_TabSheets: integer; aForm: TfrmValoresLimite; aTipo: smallint);
begin
    iCampoActual := iCActual;
    iCampos_PorTabSheet := iC_PorTabSheet;
    iTabSheet_Actual := iT_Actual;
    iTotal_TabSheets := iT_TabSheets;
    aVLForm := aForm;
    if aTipo = 0 then
        QRImpValLim.preview
    else
        QRImpValLim.Print;

end;


procedure TfrmImprimirValLim.QRImpValLimNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
    MoreData := (iTabSheet_Actual <= iTotal_TabSheets);
    RellenarCampos_TabSheet (iCampoActual, iTabSheet_Actual);
end;

end.
