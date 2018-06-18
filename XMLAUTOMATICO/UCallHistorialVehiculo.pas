unit UCallHistorialVehiculo;

interface
   // Devuelve True si ha conseguido realizar correctamente el historial de un vehículo
   function Realizar_HistorialVehiculo: boolean;

implementation

   uses
      Controls,
      MBUSHIST,
      uHistorial,
      SysUtils,
      UCDIALGS,
      ULOGS,
      UFTMP,
      GLOBALS, Forms,
      UUTILS,
      UCTHISTORIALVEHICULO;

   // Devuelve True si ha conseguido realizar correctamente el historial de un vehículo
   function Realizar_HistorialVehiculo: boolean;
   var
      frmBusquedaHistorial_Auxi: TfrmBusquedaHistorial;
      frmImprimirHistorial_Auxi: TFrmHistorial;
      aFTmp: TFTmp;

   begin
       Result := False;
       frmBusquedaHistorial_Auxi := nil;
       frmImprimirHistorial_Auxi := nil;
       aFTmp := TFTmp.Create(Application);
       try
          frmBusquedaHistorial_Auxi := TfrmBusquedaHistorial.Create (Application);
          frmBusquedaHistorial_Auxi.InicializarHistorial;
          if (frmBusquedaHistorial_Auxi.ShowModal = mrOk) then
          begin
              aFTmp.MuestraClock ('Informe','generando el informe de historial de vehículo');
              frmImprimirHistorial_Auxi := TFrmHistorial.CreateFromInspeccion(frmBusquedaHistorial_Auxi.fInspeccion,true,false);
              Result := True;
          end;
       finally
            aFTmp.Free;
            frmBusquedaHistorial_Auxi.Free;
            frmImprimirHistorial_Auxi.Free;
       end;
   end;
end.
