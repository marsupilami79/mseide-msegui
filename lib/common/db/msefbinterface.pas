{ MSEgui Copyright (c) 2016 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}
//
// specialised api interfaces
//
unit msefbinterface;
{$ifdef FPC}{$mode delphi}{$h+}{$endif}
interface
uses
 firebird,msetypes,msefbconnection,mdb,msedb;
type

 paraminfoty = record
  _type: card32;
  subtype: int32;
  scale: int32;
  _length: card32;
  offset: card32;
  nulloffset: card32;
  _isnull: boolean;
 end;
 paraminfoarty = array of paraminfoty;
 
 tparamdata = class(imessagemetadataimpl)
  private
   frefcount: int32;
   fparambuffer: pointer;
   fitems: paraminfoarty;
   fcount: int32;
   fmessagelength: int32;
  public
   constructor create(const cursor: tfbcursor; const params: tmseparams);
   destructor destroy(); override;
   procedure addRef() override;
   function release(): Integer override;
   function getCount(status: IStatus): Cardinal override;
   function getField(status: IStatus; index: Cardinal): PAnsiChar override;
   function getRelation(status: IStatus; index: Cardinal): PAnsiChar override;
   function getOwner(status: IStatus; index: Cardinal): PAnsiChar override;
   function getAlias(status: IStatus; index: Cardinal): PAnsiChar override;
   function getType(status: IStatus; index: Cardinal): Cardinal override;
   function isNullable(status: IStatus; index: Cardinal): Boolean override;
   function getSubType(status: IStatus; index: Cardinal): Integer override;
   function getLength(status: IStatus; index: Cardinal): Cardinal override;
   function getScale(status: IStatus; index: Cardinal): Integer override;
   function getCharSet(status: IStatus; index: Cardinal): Cardinal override;
   function getOffset(status: IStatus; index: Cardinal): Cardinal override;
   function getNullOffset(status: IStatus; index: Cardinal): Cardinal override;
   function getBuilder(status: IStatus): IMetadataBuilder override;
   function getMessageLength(status: IStatus): Cardinal override;
   property parambuffer: pointer read fparambuffer;
 end;

implementation
uses
 msefirebird,dbconst,sysutils;
 
type
 tfbcursor1 = class(tfbcursor);
 
{ tparamdata }

constructor tparamdata.create(const cursor: tfbcursor;
                                                  const params: tmseparams);
var
 i1: int32;
 data: stringarty;
 sqltype,sqllen: card32;
 data1: stringarty;
 po1: pointer;
 bo1: boolean;
 totsize1: int32;
// len1: int32;
 align1: int32;
begin
 inherited create();
 addref();
 with tfbcursor1(cursor) do begin
  fcount:= length(fparambinding);
  totsize1:= 0;
//  len1:= 0;
  if fcount > 0 then begin
   setlength(fitems,fcount);
   setlength(data,fcount); //buffer for null pointers
   for i1:= 0 to fcount-1 do begin
    sqltype:= 0;
    sqllen:= 0;
    align1:= 0;
    with params[fparambinding[i1]],fitems[i1] do begin
     _isnull:= isnull;
     case datatype of
      ftunknown: begin
       if isnull then begin
        sqltype:= SQL_NULL;
       end;
      end;
      ftboolean: begin
       sqltype:= SQL_BOOLEAN+1;
       sqllen:= 1;
      end;
      ftinteger,ftsmallint,ftword: begin
       sqltype:= SQL_LONG+1;
       sqllen:= 4;
       align1:= 3;
      end;
      ftlargeint: begin
       sqltype:= SQL_INT64+1;
       sqllen:= 8;
       align1:= 3;
      end;
      ftstring,ftwidestring: begin
       sqltype:= SQL_TEXT+1;
       if not isnull then begin
        data[i1]:= params.asdbstring(fparambinding[i1]);
        sqllen:= length(data[i1]);
       end;
      end;
     end;
     if sqltype = 0 then begin
      databaseerrorfmt(sunsupportedparameter,[fieldtypenames[datatype]],
                                                                 fconnection);
     end;
//     len1:= len1 + sqllen;
//     if _isnull then begin
//      sqllen:= 0;
//     end;
     _type:= sqltype;
     _length:= sqllen;
     totsize1:= (totsize1 + align1) and not align1;
     offset:= totsize1;
     totsize1:= totsize1 + sqllen;
     totsize1:= (totsize1 + 1) and not 1;
     nulloffset:= totsize1;
     totsize1:= totsize1 + 2;
    end;
   end;
   getmem(fparambuffer,totsize1);
   fmessagelength:= totsize1;
   for i1:= 0 to fcount-1 do begin
    with fitems[i1] do begin
     if _type <> SQL_NULL then begin
      po1:= fparambuffer + offset;
      with params[i1] do begin
       pisc_short(fparambuffer+nulloffset)^:= card8(_isnull);
       if not _isnull then begin
        case _type of
         SQL_BOOLEAN+1: begin
          pcard8(po1)^:= card8(asboolean);
         end;
         SQL_LONG+1: begin
          pint32(po1)^:= asinteger;
         end;
         SQL_INT64+1: begin
          pint32(po1)^:= aslargeint;
         end;
         SQL_TEXT+1: begin
          move(pointer(data[i1])^,po1^,length(data[i1]));
         end;
         else begin
          raise exception.create('Internal error 20160908A');
         end;
        end;
       end;
      end;
     end;
    end;
   end;
  end;
 end;
end;

destructor tparamdata.destroy();
begin
 inherited;
 if fparambuffer <> nil then begin
  freemem(fparambuffer);
 end;
end;

procedure tparamdata.addRef();
begin
 inc(frefcount);
end;

function tparamdata.release(): Integer;
begin
 dec(frefcount);
 result:= frefcount;
 if frefcount = 0 then begin
  destroy();
 end;
end;

function tparamdata.getCount(status: IStatus): Cardinal;
begin
 result:= fcount;
end;

function tparamdata.getField(status: IStatus;
               index: Cardinal): PAnsiChar;
begin
 result:= nil;
end;

function tparamdata.getRelation(status: IStatus;
               index: Cardinal): PAnsiChar;
begin
 result:= nil;
end;

function tparamdata.getOwner(status: IStatus;
               index: Cardinal): PAnsiChar;
begin
 result:= nil;
end;

function tparamdata.getAlias(status: IStatus;
               index: Cardinal): PAnsiChar;
begin
 result:= nil;
end;

function tparamdata.getType(status: IStatus;
               index: Cardinal): Cardinal;
begin
 result:= fitems[index]._type;
end;

function tparamdata.isNullable(status: IStatus;
               index: Cardinal): Boolean;
begin
 result:= fitems[index]._type and 1 <> 0;
end;

function tparamdata.getSubType(status: IStatus;
               index: Cardinal): Integer;
begin
 result:= fitems[index].subtype;
end;

function tparamdata.getLength(status: IStatus;
               index: Cardinal): Cardinal;
begin
 result:= fitems[index]._length;
end;

function tparamdata.getScale(status: IStatus;
               index: Cardinal): Integer;
begin
 result:= fitems[index].scale;
end;

function tparamdata.getCharSet(status: IStatus;
               index: Cardinal): Cardinal;
begin
 result:= 0;
end;

function tparamdata.getOffset(status: IStatus;
               index: Cardinal): Cardinal;
begin
 result:= fitems[index].offset;
end;

function tparamdata.getNullOffset(status: IStatus;
               index: Cardinal): Cardinal;
begin
 result:= fitems[index].nulloffset;
end;

function tparamdata.getBuilder(status: IStatus): IMetadataBuilder;
begin
 result:= nil;
end;

function tparamdata.getMessageLength(status: IStatus): Cardinal;
begin
 result:= fmessagelength;
end;

end.