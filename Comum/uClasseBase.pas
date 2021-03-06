unit uClasseBase;

interface

uses uFormBase, FireDac.Comp.Client, uDmdPrincipal, SysUtils;

type TClasseBase = Class(TObject)
  private
  RegistroEncontrado :Boolean;

  function CriaQuery(lSQL :String):TFDQUery;
  public
  class function GeraCodigo(lCampo, lTabela , lCondicao :String):Integer;
End;

implementation

{ TClasseBase }


function TClasseBase.CriaQuery(lSQL: String): TFDQUery;
begin
  result := dmdPrincipal.CriaQuery(lSQL);
end;

class function TClasseBase.GeraCodigo(lCampo, lTabela,
  lCondicao: String): Integer;
  var lQuery:TFDQuery;
      lSQL  :TStringBuilder;
begin
 try
   lSQL := TStringBuilder.Create;
   lSQL.Append('SELECT coalesce(MAX('+lCampo+'),0)+1  FROM '+lTabela+' ');

   if Trim(lCondicao) <> EmptyStr then
   lSQL.Append(' WHERE '+lCondicao);

   lQuery := dmdPrincipal.CriaQuery(lSQL.ToString);
   lQuery.Open;

   result :=  lQuery.Fields[0].AsInteger;

 finally
   lQuery.Free;
   lSQL.Free;
 end;
end;

end.
