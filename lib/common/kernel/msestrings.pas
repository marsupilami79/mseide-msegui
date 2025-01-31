{ MSEgui Copyright (c) 1999-2017 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}
unit msestrings;
{$ifdef FPC}
 {$if defined(FPC) and (fpc_fullversion >= 020501)}
  {$define mse_fpc_2_6}
 {$ifend}
 {$if defined(FPC) and (fpc_fullversion >= 020300)}
  {$define mse_fpc_2_3}
 {$ifend}

 {$ifdef mse_fpc_2_6}
  {$define mse_hasvtunicodestring}
 {$endif}
 {$ifdef mse_fpc_2_3}
  {$define mse_unicodestring}
 {$endif}
 {$if fpc_fullversion >= 030000}
  {$define hascodepage}
 {$endif}
 {$if fpc_fullversion >= 030300}
  {$define mse_fpc_3_3}
 {$endif}
{$endif}

{$ifdef FPC}{$mode objfpc}{$h+}{$interfaces corba}{$goto on}{$endif}

interface
{$ifndef mse_allwarnings}
 {$if fpc_fullversion >= 030100}
  {$warn 5089 off}
  {$warn 5090 off}
  {$warn 5093 off}
  {$warn 6058 off}
 {$endif}
{$endif}

uses
 classes,mclasses,msetypes{$ifdef FPC},strings{$endif},typinfo,sysutils;
{$ifdef FPC}
 {$ifndef mse_nounicodestring}
  {$if defined(FPC) and (fpc_fullversion >= 020300)}
   {$define mse_unicodestring}
  {$ifend}
 {$endif}
 {$ifndef mse_unicodestring}
  {$ifdef FPC_WINLIKEWIDESTRING}
   {$define msestringsarenotrefcounted}
  {$endif}
 {$endif}
{$else}
 {$ifdef mswindows}
  {$define msestringsarenotrefcounted}
 {$endif}
{$endif}

type
 stringposty = (sp_left,sp_center,sp_right);
 utfoptionty = (uto_storeinvalid);  //store invalid utf8 chars in private area
 utfoptionsty = set of utfoptionty;

const
 utf16privatebase = $f800; //used to store invalid utf8 chars in filenamety
 utf16private = utf16privatebase + 0;
    //prefix for private area codepoint, following word is low byte
 utf16invalid = utf16privatebase + 1;
    //prefix for invalid utf8 byte, following word is data byte

 utferrorchar = char('?'); //single byte only

 {$ifdef mse_unicodestring}
 msestringtypekind = tkustring;
 {$else}
 msestringtypekind = tkwstring;
 {$endif}
 defaultdelimchars = ' '+c_tab+c_return+c_linefeed;
 defaultmsedelimchars = msestring(defaultdelimchars);

type
 doublestringty = record
  a,b: string;
 end;
 pdoublestringty = ^doublestringty;
 doublestringarty = array of doublestringty;

 doublemsestringty = record
  a,b: msestring;
 end;
 pdoublemsestringty = ^doublemsestringty;
 doublemsestringarty = array of doublemsestringty;
 doublemsestringaty = array[0..0] of doublemsestringty;
 pdoublemsestringaty = ^doublemsestringaty;

const
 upperchars: array[char] of char = (
  #$00,#$01,#$02,#$03,#$04,#$05,#$06,#$07,#$08,#$09,#$0a,#$0b,#$0c,#$0d,#$0e,#$0f,
  #$10,#$11,#$12,#$13,#$14,#$15,#$16,#$17,#$18,#$19,#$1a,#$1b,#$1c,#$1d,#$1e,#$1f,
  #$20,#$21,#$22,#$23,#$24,#$25,#$26,#$27,#$28,#$29,#$2a,#$2b,#$2c,#$2d,#$2e,#$2f,
  #$30,#$31,#$32,#$33,#$34,#$35,#$36,#$37,#$38,#$39,#$3a,#$3b,#$3c,#$3d,#$3e,#$3f,
  #$40,#$41,#$42,#$43,#$44,#$45,#$46,#$47,#$48,#$49,#$4a,#$4b,#$4c,#$4d,#$4e,#$4f,
  #$50,#$51,#$52,#$53,#$54,#$55,#$56,#$57,#$58,#$59,#$5a,#$5b,#$5c,#$5d,#$5e,#$5f,
  #$60,'A' ,'B' ,'C' ,'D' ,'E' ,'F' ,'G' ,'H' ,'I' ,'J' ,'K' ,'L' ,'M' ,'N' ,'O' ,
  'P' ,'Q' ,'R' ,'S' ,'T' ,'U' ,'V' ,'W' ,'X' ,'Y' ,'Z' ,#$7b,#$7c,#$7d,#$7e,#$7f,
  #$80,#$81,#$82,#$83,#$84,#$85,#$86,#$87,#$88,#$89,#$8a,#$8b,#$8c,#$8d,#$8e,#$8f,
  #$90,#$91,#$92,#$93,#$94,#$95,#$96,#$97,#$98,#$99,#$9a,#$9b,#$9c,#$9d,#$9e,#$9f,
  #$a0,#$a1,#$a2,#$a3,#$a4,#$a5,#$a6,#$a7,#$a8,#$a9,#$aa,#$ab,#$ac,#$ad,#$ae,#$af,
  #$b0,#$b1,#$b2,#$b3,#$b4,#$b5,#$b6,#$b7,#$b8,#$b9,#$ba,#$bb,#$bc,#$bd,#$be,#$bf,
  #$c0,#$c1,#$c2,#$c3,#$c4,#$c5,#$c6,#$c7,#$c8,#$c9,#$ca,#$cb,#$cc,#$cd,#$ce,#$cf,
  #$d0,#$d1,#$d2,#$d3,#$d4,#$d5,#$d6,#$d7,#$d8,#$d9,#$da,#$db,#$dc,#$dd,#$de,#$df,
  #$e0,#$e1,#$e2,#$e3,#$e4,#$e5,#$e6,#$e7,#$e8,#$e9,#$ea,#$eb,#$ec,#$ed,#$ee,#$ef,
  #$f0,#$f1,#$f2,#$f3,#$f4,#$f5,#$f6,#$f7,#$f8,#$f9,#$fa,#$fb,#$fc,#$fd,#$fe,#$ff);

 lowerchars: array[char] of char = (
  #$00,#$01,#$02,#$03,#$04,#$05,#$06,#$07,#$08,#$09,#$0a,#$0b,#$0c,#$0d,#$0e,#$0f,
  #$10,#$11,#$12,#$13,#$14,#$15,#$16,#$17,#$18,#$19,#$1a,#$1b,#$1c,#$1d,#$1e,#$1f,
  #$20,#$21,#$22,#$23,#$24,#$25,#$26,#$27,#$28,#$29,#$2a,#$2b,#$2c,#$2d,#$2e,#$2f,
  #$30,#$31,#$32,#$33,#$34,#$35,#$36,#$37,#$38,#$39,#$3a,#$3b,#$3c,#$3d,#$3e,#$3f,
  #$40,'a' ,'b' ,'c' ,'d' ,'e' ,'f' ,'g' ,'h' ,'i' ,'j' ,'k' ,'l' ,'m' ,'n' ,'o' ,
  'p' ,'q' ,'r' ,'s' ,'t' ,'u' ,'v' ,'w' ,'x' ,'y' ,'z' ,#$5b,#$5c,#$5d,#$5e,#$5f,
  #$60,#$61,#$62,#$63,#$64,#$65,#$66,#$67,#$68,#$69,#$6a,#$6b,#$6c,#$6d,#$6e,#$6f,
  #$70,#$71,#$72,#$73,#$74,#$75,#$76,#$77,#$78,#$79,#$7a,#$7b,#$7c,#$7d,#$7e,#$7f,
  #$80,#$81,#$82,#$83,#$84,#$85,#$86,#$87,#$88,#$89,#$8a,#$8b,#$8c,#$8d,#$8e,#$8f,
  #$90,#$91,#$92,#$93,#$94,#$95,#$96,#$97,#$98,#$99,#$9a,#$9b,#$9c,#$9d,#$9e,#$9f,
  #$a0,#$a1,#$a2,#$a3,#$a4,#$a5,#$a6,#$a7,#$a8,#$a9,#$aa,#$ab,#$ac,#$ad,#$ae,#$af,
  #$b0,#$b1,#$b2,#$b3,#$b4,#$b5,#$b6,#$b7,#$b8,#$b9,#$ba,#$bb,#$bc,#$bd,#$be,#$bf,
  #$c0,#$c1,#$c2,#$c3,#$c4,#$c5,#$c6,#$c7,#$c8,#$c9,#$ca,#$cb,#$cc,#$cd,#$ce,#$cf,
  #$d0,#$d1,#$d2,#$d3,#$d4,#$d5,#$d6,#$d7,#$d8,#$d9,#$da,#$db,#$dc,#$dd,#$de,#$df,
  #$e0,#$e1,#$e2,#$e3,#$e4,#$e5,#$e6,#$e7,#$e8,#$e9,#$ea,#$eb,#$ec,#$ed,#$ee,#$ef,
  #$f0,#$f1,#$f2,#$f3,#$f4,#$f5,#$f6,#$f7,#$f8,#$f9,#$fa,#$fb,#$fc,#$fd,#$fe,#$ff);

type
 lstringty = record
  po: pchar;
  len: integer;
 end;
 plstringty = ^lstringty;

 lmsestringty = record
  po: pmsechar;
  len: integer;
 end;
 plmsestringty = ^lmsestringty;

 lstringarty = array of lstringty;
 lmsestringarty = array of lmsestringty;

 stringheaderty = packed record
{$ifdef hascodepage}
  CodePage: TSystemCodePage;
  ElementSize: Word;
 {$if defined(mse_fpc_3_3)}
  {$ifdef CPU64}	
    Ref         : Longint;
  {$else}
    Ref         : SizeInt;
  {$endif}
{$else}
  {$ifdef CPU64}	
    { align fields  }
	Dummy       : DWord;
  {$endif CPU64}
    Ref         : SizeInt;
{$endif}
{$endif}
   len: sizeint;
 end;
 
  pstringheaderty = ^stringheaderty;

const
 emptylstring: lstringty = (po: nil; len: 0);
 emptywstring: lmsestringty = (po: nil; len: 0);

type
 tmemorystringstream = class(tmemorystream)
        //has room for stringheader
  protected
   procedure SetCapacity(NewCapacity: PtrInt) override;
   function getcapacity: ptrint override;
   function getmemory: pointer; override;
   Function GetSize : Int64; Override;
   function GetPosition: Int64; Override;
  public
   constructor create;
   procedure SetSize({$ifdef CPU64}const{$endif CPU64} NewSize: PtrInt); override;
   function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
   procedure destroyasstring(out data: string);
    //calls destroy, not possible to use as destructor in FPC
 end;

 searchoptionty = (so_caseinsensitive,so_wholeword,so_wordstart,so_backward);
 searchoptionsty = set of searchoptionty;

procedure trimright1(var s: string); overload;
procedure trimright1(var s: msestring); overload;

function removechar(const source: string; a: char): string; overload;
function removechar(const source: msestring; a: msechar): msestring; overload;
procedure removechar1(var dest: string; a: char); overload;
procedure removechar1(var dest: msestring; a: msechar); overload;
  //removes all a
function printableascii(const source: string): string; overload;
                //removes all nonprintablechars and ' '
function printableascii(const source: msestring): msestring; overload;
                //removes all nonprintablechars and ' '

function replacechar(const source: string; old,new: char): string; overload;
function replacechar(const source: msestring; old,new: msechar): msestring; overload;
procedure replacechar1(var dest: string; old,new: char); overload;
procedure replacechar1(var dest: msestring; old,new: msechar); overload;
  //replaces old by new
function stringfromchar(achar: char; count : integer): string; overload;
function stringfromchar(achar: msechar; count : integer): msestring; overload;

function replacetext(const source: string; index: integer;
                                      a: string): string; overload;
function replacetext(const source: msestring; index: integer;
                                      a: msestring): msestring; overload;
procedure replacetext1(var dest: string; index: integer;
                                      const a: string); overload;
procedure replacetext1(var dest: msestring; index: integer; const a: msestring); overload;

procedure addstringsegment(var dest: msestring; const a,b: pmsechar);
               //add text from a^ to (b-1)^ to dest
function stringsegment(a,b: pchar): string;
function stringsegment(a,b: pmsechar): msestring;

function lstringtostring(const value: lmsestringty): msestring; overload;
function lstringtostring(const value: pmsechar;
                                    const len: integer): msestring; overload;
function lstringtostring(const value: lstringty): string; overload;
function lstringtostring(const value: pchar;
                                    const len: integer): string; overload;
procedure stringtolstring(const value: string;
               var{out} res: lstringty); inline;  //todo!!!!! fpbug 3221
procedure stringtolstring(const value: msestring;
                             var{out} res: lmsestringty); inline;
function stringtolstring(const value: string): lstringty; inline;
function stringtolstring(const value: msestring): lmsestringty; inline;
function lstringartostringar(const value: lstringarty): stringarty;

procedure nextword(const value: msestring; out res: lmsestringty); overload;
procedure nextword(const value: string; out res: lstringty); overload;
procedure nextword(var value: lmsestringty; out res: lmsestringty); overload;
procedure nextword(var value: lstringty; out res: lstringty); overload;
procedure nextword(var value: lstringty; out res: string); overload;
function nextword(var start: pchar): string; overload;
function nextword(var start: pmsechar): msestring; overload;

function nextquotedstring(var value: lstringty; out res: string): boolean;
                   //false wenn kein quote vorhanden
procedure lstringgoback(var value: lstringty; const res: lstringty);
function issamelstring(const value: lmsestringty; const key: msestring;
             caseinsensitive: boolean = false): boolean; overload;
             //nur ascii caseinsens.
function issamelstring(const value: lstringty; const key: string;
             caseinsensitive: boolean = false): boolean; overload;
             //nur ascii caseinsens.
function lstringcomp(const a,b: lstringty): integer; overload;
function lstringcomp(const a: lstringty; const b: string): integer; overload;
function lstringicomp(const a,b: lstringty): integer; overload;
         //ascii case insensitive
function lstringicomp(const a: lstringty; const b: string): integer; overload;
         //ascii case insensitive
function lstringicompupper(const a,upper: lstringty): integer; overload;
         //ascii case insensitive, upper must be uppercase
function lstringicompupper(const a: lstringty; const upper: string): integer; overload;
         //ascii case insensitive, upper must be uppercase

function stringcomp(const a,b: string): integer;
function stringicomp(const a,b: string): integer;
         //ascii case insensitive
function stringicompupper(const a,upstr: string): integer;
         //ascii case insensitive, b must be uppercase

function msestringcomp(const a,b: msestring): integer;
function msestringicomp(const a,b: msestring): integer;
         //ascii case insensitive
function msestringicompupper(const a,upstr: msestring): integer;
         //ascii case insensitive, upstr must be uppercase

function comparestrlen(const S1,S2: string): integer;
                //case sensitiv, beruecksichtigt nur s1 laenge
function msecomparestrlen(const S1,S2: msestring): integer;
                //case sensitiv, beruecksichtigt nur s1 laenge

function msecomparestr(const S1, S2: msestring): Integer;
                                               {$ifdef FPC} inline; {$endif}
                //case sensitive
function msecomparetext(const S1, S2: msestring): Integer;
                                               {$ifdef FPC} inline; {$endif}
                //case insensitive
function msecomparestrnatural(const S1, S2: msestring): Integer;
                                               {$ifdef FPC} inline; {$endif}
                //case sensitive
function msecomparetextnatural(const S1, S2: msestring): Integer;
                                               {$ifdef FPC} inline; {$endif}
                //case insensitive
function mseCompareTextlen(const S1, S2: msestring): Integer;
                //case insensitiv, beruecksichtigt nur s1 laenge
function mseCompareTextlenupper(const S1, S2: msestring): Integer;
                //case insensitiv, checks length s1 only, s1 must be uppercase
function msepartialcomparetext(const s1,s2: msestring): integer;
                //case insensitive, checks s1 lenght only
function msepartialcomparestr(const s1,s2: msestring): integer;
                //case sensitive, checks s1 lenght only

function mseissamestrlen(const apartstring,astring: msestring): boolean;
function mseissametextlen(const apartstring,astring: msestring): boolean;
                //case insensitive

function encodesearchoptions(const caseinsensitive: boolean = false;
                        const wholeword: boolean = false;
                        const wordstart: boolean = false;
                        const backward: boolean = false): searchoptionsty;
function msestringsearch(const substring,s: msestring; start: integer;
                      const options: searchoptionsty;
                      const substringupcase: msestring = ''): integer; overload;
function stringsearch(const substring,s: string; start: integer;
                      const options: searchoptionsty;
                      const substringupcase: string = ''): integer; overload;
function replacestring(const s: msestring; oldsub: msestring;
                           const newsub: msestring;
               const options: searchoptionsty = []): msestring; overload;
function replacestring(const s: string; oldsub: string;
                           const newsub: string;
               const options: searchoptionsty = []): string; overload;

procedure addeditchars(const source: msestring; var buffer: msestring;
                         var cursorpos: integer);
                                  //cursorpos nullbased
function processeditchars(var value: msestring; stripcontrolchars: boolean): integer;
           //bringt offset durch backspace
function mseextractprintchars(const value: msestring): msestring;

function findchar(const str: string; achar: char): integer; overload;
  //bringt index des ersten vorkommens von zeichen in string, 0 wenn nicht gefunden
function findchar(const str: string; const astart: integer;
                                             achar: char): integer; overload;
function findchar(const str: msestring; achar: msechar): integer; overload;
  //bringt index des ersten vorkommens von zeichen in string, 0 wenn nicht gefunden
function findchar(const str: msestring; const astart: integer;
                                         achar: msechar): integer; overload;
function findchar(const str: pchar; achar: char): integer; overload;
  //bringt index des ersten vorkommens von zeichen in string, 0 wenn nicht gefunden
function findchar(const str: pmsechar; achar: msechar): integer; overload;
  //bringt index des ersten vorkommens von zeichen in string, 0 wenn nicht gefunden
function findchars(const str: string; const achars: string): integer; overload;
  //bringt index des ersten vorkommens von zeichen in string, 0 wenn nicht gefunden
function findchars(const str: msestring; const achars: msestring): integer; overload;
  //bringt index des ersten vorkommens von zeichen in string, 0 wenn nicht gefunden
function findlastchar(const str: string; achar: char): integer; overload;
  //bringt index des letzten vorkommens von zeichen in string, 0 wenn nicht gefunden
function findlastchar(const str: msestring; achar: msechar): integer; overload;
  //bringt index des letzten vorkommens von zeichen in string, 0 wenn nicht gefunden
function countchars(const str: string; achar: char): integer; overload;
function countchars(const str: msestring; achar: msechar): integer; overload;
function getcharpos(const str: msestring; achar: msechar): integerarty;

function strscan(const Str: PChar; Chr: Char): PChar; overload;
//function strscan(const str: string; chr: char): integer; overload;
           //use findchar()
function strscan(const str: lmsestringty; const chr: msechar): pmsechar; overload;
function msestrscan(const Str: PmseChar; Chr: mseChar): PmseChar; overload;
//function msestrscan(const str: msestring; chr: msechar): integer; overload;
           //use findchar()
procedure mseskipspace(var str: pmsechar); {$ifdef FPC} inline; {$endif}
procedure skipspace(var str: pchar); {$ifdef FPC} inline; {$endif}

function StrLScan(const Str: PChar; Chr: Char; len: integer): PChar;
function mseStrLScan(const Str: PmseChar; Chr: mseChar; len: integer): PmseChar;

function StrNScan(const Str: PChar; Chr: Char): PChar;
function StrLNScan(const Str: PChar; Chr: Char; len: integer): PChar;
function mseStrNScan(const Str: PmseChar; Chr: mseChar): PmseChar;
function mseStrLNScan(const Str: PmseChar; Chr: mseChar; len: integer): PmseChar;

function StrRScan(const Str: PChar; Chr: Char): PChar;
function StrLRScan(const Str: PChar; Chr: Char; len: integer): PChar;
function mseStrRScan(const Str: PmseChar; Chr: mseChar): PmseChar; overload;
function msestrrscan(const str: msestring; chr: msechar): integer; overload;
function mseStrLRScan(const Str: PmseChar; Chr: mseChar; len: integer): PmseChar;

function mseStrLNRScan(const Str: PmseChar; Chr: mseChar; len: integer): PmseChar;

function StrLComp(const Str1, Str2: PChar; len: integer): Integer;

function mseStrComp(const Str1, Str2: PmseChar): Integer;
function mseStrLComp(const Str1, Str2: PmseChar; len: integer): Integer;
function mseStrLIComp(const Str1, upstr: PmseChar; len: integer): Integer;
                //ascii caseinsensitive, upstr muss upcase sein
function StrLIComp(const Str1, upstr: PChar; len: integer): Integer;
                //ascii caseinsensitive, upstr muss upcase sein
function StrIComp(const Str1, upstr: PChar): Integer;
                //ascii caseinsensitive, upstr muss upcase sein

function startsstr(substring,s: pchar): boolean; overload;
function startsstr(const substring,s: string): boolean; overload;
function msestartsstr(substring,s: pmsechar): boolean; overload;
function msestartsstr(const substring,s: msestring): boolean; overload;

function msestartsstrcaseinsensitive(substring,s: pmsechar): boolean;
        //substring must be uppercase, ASCII caseinsensitve

function isnullstring(const s: ansistring): boolean;
function isemptystring(const s: pchar): boolean; overload;
function isemptystring(const s: pmsechar): boolean; overload;
function isnamechar(achar: char): boolean; overload;
function isnamechar(achar: msechar): boolean; overload;
            //true if achar in 'a'..'z','A'..'Z','0'..'9','_';
function isnumber(const s: string): boolean; overload;
function isnumber(const s: msestring): boolean; overload;
            //true if all characters in '0'..'9'

function strlcopy(const str: pchar; len: integer): ansistring;
                       //nicht nullterminiert
function msestrlcopy(const str: pmsechar; len: integer): msestring;
                       //nicht nullterminiert
function psubstr(const start,stop: pchar): string; overload;
function psubstr(const start,stop: pmsechar): msestring; overload;
function singleline(const start: pchar): string; overload;
function singleline(const start: pmsechar): msestring; overload;

function msePosEx(const SubStr, S: msestring; Offset: longword = 1): Integer;

function mselowercase(const s: msestring): msestring; overload;
function mselowercase(const s: msestringarty): msestringarty; overload;
function mseuppercase(const s: msestring): msestring; overload;
function mseuppercase(const s: msestringarty): msestringarty; overload;

//ascii only
function charuppercase(const c: char): char; overload;
                               {$ifdef FPC} inline; {$endif}
function charuppercase(const c: msechar): msechar; overload;
                               {$ifdef FPC} inline; {$endif}
function struppercase(const s: string): string; overload;
function struppercase(const s: msestring): msestring; overload;
function struppercase(const s: lmsestringty): msestring; overload;
function struppercase(const s: lstringty): string; overload;
procedure struppercase1(var s: msestring); overload;

function charlowercase(const c: char): char; overload;
function charlowercase(const c: msechar): msechar; overload;
function strlowercase(const s: string): string; overload;
function strlowercase(const s: msestring): msestring; overload;
function strlowercase(const s: lmsestringty): msestring; overload;
function strlowercase(const s: lstringty): string; overload;
procedure strlowercase1(var s: msestring); overload;

//ascii only

function mseremspace(const s: msestring): msestring;
    //entfernt alle space und steuerzeichen
function removelinebreaks(const s: msestring): msestring;
    //replaces linebreaks with space
function removelineterminator(const s: msestring): msestring;
procedure removetabterminator(var s: msestring);
function stripescapesequences(avalue: msestring): msestring;

procedure stringaddref(var str: ansistring); overload;
procedure stringaddref(var str: msestring); overload;
procedure stringsafefree(var str: string; const onlyifunique: boolean);
procedure stringsafefree(var str: msestring; const onlyifunique: boolean);

procedure reallocstring(var value: ansistring); overload;
                //macht datenkopie ohne free
procedure reallocstring(var value: msestring); overload;
                //macht datenkopie ohne free
procedure reallocarray(var value; elementsize: integer); overload;
                //macht datenkopie ohne free
procedure resizearray(var value; newlength, elementsize: integer);
                //ohne finalize

function lineatindex(const value: msestring; const index: int32): msestring;
procedure wordatindex(const value: msestring; const index: integer;
                          out first,pastlast: pmsechar;
                     const delimchars: msestring;
                     const nodelimstrings:  array of msestring); overload;
                          //index = 0..length(value)-1
function wordatindex(const value: msestring; const index: integer;
            const delimchars: msestring;
            const nodelimstrings:  array of msestring): msestring; overload;
function checkkeyword(const aname: string; const anames; //stringaty
                             const ahigh: integer): cardinal; overload;
          //scans from 1 to ahigh, 0 -> unknown
function checkkeyword(const aname: msestring; const anames; //msestringaty
                             const ahigh: integer): cardinal; overload;
function checkkeyword(const aname: pchar; const anames; //stringaty
                             const ahigh: integer): cardinal; overload;
          //scans from 1 to ahigh, 0 -> unknown
function checkkeyword(const aname: pmsechar; const anames; //msestringaty
                             const ahigh: integer): cardinal; overload;

function quotestring(value: string; quotechar: char;
                               const force: boolean = true;
                      const separator: char = ' '): string; overload;
function quotestring(value: msestring; quotechar: msechar;
                               const force: boolean = true;
                      const separator: msechar = ' '): msestring; overload;
function quoteescapedstring(value: string; quotechar: char;
                               const force: boolean = true;
                      const separator: char = ' '): string; overload;
function quoteescapedstring(value: msestring; quotechar: msechar;
                               const force: boolean = true;
                      const separator: msechar = ' '): msestring; overload;
function unquotestring(value: string; quotechar: char): string; overload;
function unquotestring(value: msestring; quotechar: msechar): msestring; overload;
function extractquotedstr(const value: msestring): msestring;
                //entfernt vorhandene paare ' und "

function checkfirstchar(const value: string; achar: char): pchar;
           //nil wenn erster char nicht space <> achar, ^achar sonst
function firstline(const atext: msestring): msestring;
function lastline(const atext: msestring): msestring;
procedure textdim(const atext: msestring; out firstx,lastx,y: integer);

function shrinkpathellipse(var value: msestring): boolean;
function shrinkstring(const value: msestring; maxcharcount: integer): msestring;
procedure extendstring(var value: string; const mincharcount: integer);
procedure extendstring(var value: msestring; const mincharcount: integer);

function nullstring(const count: integer): string;
function charstring(ch: char; count: integer): string; overload;
function charstring(ch: msechar; count: integer): msestring; overload;
function countleadingchars(const str: msestring;  char: msechar): integer; overload;
function countleadingchars(const str: string; char: char): integer; overload;
          //-1 = leer
function fitstring(const source: msestring; const len: integer;
                         const pos: stringposty = sp_left;
                         const cutchar: msechar = #0;
                         const padchar: msechar = ' '): msestring;
                  //cutchar = 0 -> no cutchar

function breaklines(const source: string): stringarty; overload;
function breaklines(const source: msestring): msestringarty; overload;
function breaklines(const source: msestring;
                       maxlength: integer): msestringarty; overload;

procedure splitstring(source: string;
                     var dest: stringarty; separator: char = c_tab;
                     trim: boolean = false); overload;
procedure splitstring(source: msestring;
                     var dest: msestringarty; separator: msechar = c_tab;
                     trim: boolean = false); overload;
          //length(dest) = 0 -> es werden die noetigen stellen erzeugt
          // sonst length(dest) <= length(dest uebergeben),
          // ganzer rest im letzten string, falls mehr vorhandene teile als
          // uebergebene strings
function splitstring(source: string; separator: char = c_tab;
                     trim: boolean = false): stringarty; overload;
function splitstring(source: msestring; separator: msechar = c_tab;
                     trim: boolean = false): msestringarty; overload;
function splitstringquoted(source: string; separator: char = c_tab;
                     quotechar: char = '"';
                     atrim: boolean = false): stringarty; overload;
function splitstringquoted(source: msestring; separator: msechar = c_tab;
                     quotechar: msechar = '"';
                     atrim: boolean = false): msestringarty; overload;

procedure splitstringquoted(const source: string; out dest: stringarty;
                       quotechar: char = '"'; separator: char = #0); overload;
procedure splitstringquoted(const source: msestring; out dest: msestringarty;
                       quotechar: msechar = '"'; separator: msechar = #0); overload;
           //separator = #0 -> ' ' and c_tab for separators

function concatstrings(const source: msestringarty;
                        const separator: msestring = ' ';
                   const quotechar: msechar = #0; //#0 -> no quote
                   const force: boolean = false): msestring; overload;

function concatstrings(const source: stringarty;
              const separator: string = ' ';
                           const quotechar: char = #0; //#0 -> no quote
                           const force: boolean = false): string; overload;

function parsecommandline(const s: pchar): stringarty; overload;
function parsecommandline(const s: pmsechar): msestringarty; overload;
function parsecommandline(const s: string): stringarty; overload;
function parsecommandline(const s: msestring): msestringarty; overload;

function rs(const resstring: ansistring): msestring;
                 //converts resourcestring,
                 // resourcesstring unit must be compiled with {$codepage utf8}
function stringtoutf8(const value: msestring;
                           const options: utfoptionsty = []): utf8string;
function stringtoutf8ansi(const value: msestring;
                           const options: utfoptionsty = []): ansistring;
function stringtoutf8(const value: pmsechar;
                            const count: integer;
                           const options: utfoptionsty = []): utf8string;
function stringtoutf8ansi(const value: pmsechar;
                            const count: integer;
                           const options: utfoptionsty = []): ansistring;
function utf8tostring(const value: pchar; const alength: integer;
                           const options: utfoptionsty = []): msestring;
function utf8tostring(const value: pchar;
                           const options: utfoptionsty = []): msestring;
function utf8tostring(const value: lstringty;
                           const options: utfoptionsty = []): msestring;
function utf8tostring(const value: utf8string;
                           const options: utfoptionsty = []): msestring;
function utf8tostringansi(const value: ansistring;
                           const options: utfoptionsty = []): msestring;
function checkutf8(const value: utf8string): boolean;
              //true if valid utf8
function checkutf8ansi(const value: ansistring): boolean;
              //true if valid utf8
function stringtolatin1(const value: msestring): string;
function latin1tostring(const value: string): msestring;
function ucs4tostring(achar: dword): msestring;
function getucs4char(const value: msestring; const aindex: int32): ucs4char;
            //returns surrogatevalue if index between high and low codeunit

function getasciichar(const source: msechar; out dest: char): boolean;
                                         {$ifdef FPC} inline; {$endif}
                    //true if valid;
function getansichar(const source: msechar; out dest: char): boolean;
                                         {$ifdef FPC} inline; {$endif}
                    //true if valid;

function ansistringof(const value: tbytes): ansistring;

type
// getkeystringfuncty = function (const index: integer;
//        var astring: msestring): boolean of object;
                           //false if no value
 getkeystringfuncty = function (const index: integer): msestring of object;

 locatestringoptionty = (lso_casesensitive,lso_posinsensitive,lso_exact,
                         lso_nodown,lso_noup,lso_noexact,
                         lso_filterisuppercase);
 locatestringoptionsty = set of locatestringoptionty;

function locatestring(const afilter: msestring;
                    const getkeystringfunc: getkeystringfuncty;
                    const options: locatestringoptionsty;
                    const count: integer; var aindex: integer): boolean;
                             //true if found

function getmsestringprop(const ainstance: tobject;
                                 const apropinfo: ppropinfo): msestring;
procedure setmsestringprop(const ainstance: tobject;
                           const apropinfo: ppropinfo; const avalue: msestring);
function treader_readmsestring(const areader: treader): msestring;
procedure twriter_writemsestring(awriter: twriter; const avalue: msestring);

implementation
uses
 msearrayutils{,msesysintf};
{$ifndef mse_allwarnings}
 {$if fpc_fullversion >= 030100}
  {$warn 5089 off}
  {$warn 5090 off}
  {$warn 5093 off}
  {$warn 6058 off}
 {$endif}
{$endif}
type
 tmemorystream1 = class(tmemorystream);

function getmsestringprop(const ainstance: tobject;
                                    const apropinfo: ppropinfo): msestring;
begin
{$ifdef mse_unicodestring}
 result:= GetunicodestrProp(ainstance,apropinfo);
{$else}
 result:= GetwidestrProp(ainstance,apropinfo);
{$endif}
end;

procedure twriter_writemsestring(awriter: twriter; const avalue: msestring);
begin
{$ifdef mse_unicodestring}
 awriter.writeunicodestring(avalue);
{$else}
 awriter.writewidestring(avalue); //msestringimplementation
{$endif}
end;

procedure setmsestringprop(const ainstance: tobject;
                           const apropinfo: ppropinfo; const avalue: msestring);
begin
{$ifdef mse_unicodestring}
 setunicodestrprop(ainstance,apropinfo,avalue);
{$else}
 setwidestrprop(ainstance,apropinfo,avalue);
{$endif}
end;

function treader_readmsestring(const areader: treader): msestring;
begin
{$ifdef mse_unicodestring}
 result:= areader.Readunicodestring; //msestringimplementation
{$else}
 result:= areader.Readwidestring; //msestringimplementation
{$endif}
end;

function locatestring(const afilter: msestring; const getkeystringfunc: getkeystringfuncty;
           const options: locatestringoptionsty;
           const count: integer; var aindex: integer): boolean;
               //true if found
type
 locateinfoty = record
  filter: msestring;
  casesensitive: boolean;
  posinsensitive: boolean;
  exact: boolean;
  result: boolean;
 end;

var
 locateinfo: locateinfoty;

// index1: integer;

 procedure check(index1: integer);
 var
  str1: msestring;
  int1: integer;

  procedure checkexactpos;
  var
   int2: integer;
  begin
   result:= (int1 > 0) and ((int1 = 1) or (str1[int1] = ' '));
   if result then begin
    int2:= int1 + length(locateinfo.filter);
    result:= (int2 = length(str1)) or (str1[int2] = ' ');
   end;
  end; //checkexactpos


 begin
  str1:= getkeystringfunc(index1);
  with locateinfo do begin
   if exact then begin
    if casesensitive then begin
     if posinsensitive then begin
      int1:= pos(filter,str1);
      checkexactpos;
     end
     else begin
      result:= msecomparestr(filter,str1) = 0;
     end;
    end
    else begin
     if posinsensitive then begin
      int1:= pos(filter,mseuppercase(str1));
      checkexactpos;
     end
     else begin
      result:= msecomparetext(filter,str1) = 0;
     end;
    end;
   end
   else begin
    if casesensitive then begin
     if posinsensitive then begin
      result:= pos(filter,str1) > 0;
     end
     else begin
      result:= msecomparestrlen(filter,str1) = 0;
     end;
    end
    else begin
     if posinsensitive then begin
      result:= pos(filter,mseuppercase(str1)) > 0;
     end
     else begin
      result:= msecomparetextlen(filter,str1) = 0;
     end;
    end;
   end;
   if result then begin
    aindex:= index1;
   end;
  end;
 end; //check

var
 int1,int2: integer;
begin
 if afilter = '' then begin
  result:= count > 0;
  if result then begin
   if not (lso_nodown in options) then begin
    aindex:= 0;
   end
   else begin
    if aindex >= count then begin
     aindex:= count-1;
    end;
   end;
  end;
 end
 else begin
  with locateinfo do begin
   posinsensitive:= lso_posinsensitive in options;
   casesensitive:= lso_casesensitive in options;
   filter:= afilter;
   if not casesensitive and not (lso_filterisuppercase in options) then begin
    filter:= mseuppercase(filter);
   end;
   result:= false;
   int1:= aindex;
   if not (lso_noup in options) then begin
    if int1 < 0 then begin
     int1:= 0;
    end;
   end;
   if not (lso_nodown in options) then begin
    if int1 >= count then begin
     int1:= count - 1;
    end;
   end;
   if int1 >= 0 then begin
    if not (lso_noexact in options) then begin //search whole filtertext
     exact:= true;
     for int2:= int1 to count - 1 do begin
      check(int2);
      if result or (lso_noup in options) then begin
       break;
      end;
     end;
     if not result then begin
      if not (lso_nodown in options) then begin
       for int2:= int1-1 downto 0 do begin
        check(int2);
        if result then begin
         break;
        end;
       end;
      end;
     end;
    end;
    if not result and not (lso_exact in options) then begin
                                               //search partial filter text
     exact:= false;
     for int2:= int1 to count - 1 do begin
      check(int2);
      if result  or (lso_noup in options) then begin
       break;
      end;
     end;
     if not result and not (lso_nodown in options) then begin
      for int2:= int1 - 1 downto 0 do begin
       check(int2);
       if result then begin
        break;
       end;
      end;
     end;
    end;
   end;
  end;
  result:= locateinfo.result;
 end;
end;

procedure dostringtoutf8(const value: pmsechar;
                                     var count: integer; const dest: pointer;
                                                   const options: utfoptionsty);
var
 ps,pe: pcard16;
 pd: pcard8;
 ca1: card16;

 procedure store3(); inline;
 begin
  pd^:= (ca1 shr 12) or $e0;
  inc(pd);
  pd^:= (ca1 shr 6) and $3f or $80;
  inc(pd);
  pd^:= ca1 and $3f or $80;
 end; //store3

begin
 pd:= dest;
 ps:= pointer(value);
 pe:= ps + count;
 while ps < pe do begin
 // writeln(inttostr(ps^));
  ca1:= ps^;
  inc(ps);
  if ca1 < $80 then begin //1 byte
   pd^:= ca1;
  end
  else begin
   if ca1 < $0800 then begin //2byte
    pd^:= (ca1 shr 6) or $c0;
    inc(pd);
    pd^:= (ca1 and $3f) or $80;
   end
   else begin
    if ca1 < $d800 then begin
     store3();
    end
    else begin
     if (ca1 > $dbff) then begin //3 byte
      if (uto_storeinvalid in options) then begin
       if ca1 = utf16private then begin
        ca1:= ca1 or ps^;
        store3();
        inc(ps);
       end
       else begin
        if ca1 = utf16invalid then begin
         pd^:= ps^;
         inc(ps);
        end
        else begin
         store3(); //should not happen
        end;
       end;
      end
      else begin
       store3();
      end;
     end
     else begin //surrogate pair
      if (ca1 >= $dc00) or (ps = pe) then begin
           //missing high or low surrogate
       pd^:= card8(utferrorchar);
      end;
      if ps^ and $fc00 <> $dc00 then begin //invalid low surrogate
       pd^:= card8(utferrorchar);
      end
      else begin
       ca1:= ca1 - card16($d800 - $0040);
       pd^:= (ca1 shr 8) or $f0;
       inc(pd);
       pd^:= (ca1 shr 2) and $3f or $80;
       inc(pd);
       pd^:= ((ca1 shl 4) and $30 or (ps^ shr 6) and $0f) or $80;
       inc(pd);
       pd^:= ps^ and $3f or $80;
       inc(ps);
      end;
     end;
    end;
   end;
  end;
  inc(pd);
 end;
 count:= pd - pcard8(dest);
end;

function stringtoutf8(const value: pmsechar;
                            const count: integer;
                           const options: utfoptionsty = []): utf8string;
var
 i1: int32;
begin
 i1:= count;
 setlength(result,i1*3); //max
 dostringtoutf8(value,i1,pointer(result),options);
 setlength(result,i1);
end;

function stringtoutf8ansi(const value: pmsechar;
                            const count: integer;
                           const options: utfoptionsty = []): ansistring;
var
 i1: int32;
begin
 i1:= count;
 setlength(result,i1*3); //max
 dostringtoutf8(value,i1,pointer(result),options);
 setlength(result,i1);
end;

function stringtoutf8(const value: msestring;
                           const options: utfoptionsty = []): utf8string;
var
 i1: int32;
begin
 i1:= length(value);
 setlength(result,i1*3); //max
 dostringtoutf8(pointer(value),i1,pointer(result),options);
 setlength(result,i1);
end;

function stringtoutf8ansi(const value: msestring;
                           const options: utfoptionsty = []): ansistring;
var
 i1: int32;
begin
 i1:= length(value);
 setlength(result,i1*3); //max
 dostringtoutf8(pointer(value),i1,pointer(result),options);
 setlength(result,i1);
end;

function utf8tostring(const value: pchar; const alength: integer;
                           const options: utfoptionsty = []): msestring;
var
 by1: card8;
 wo1: card16;
 pc,pe: pcard8;
 pd,pde: pcard16;
 storeinvalid: boolean;
 p1: pointer;

 procedure seterror(); inline;
 begin
  if storeinvalid then begin
   pd^:= utf16invalid;
   inc(pd);
   pd^:= by1;
  end
  else begin
   pd^:= card16(utferrorchar);
  end;
 end;

begin
 storeinvalid:= uto_storeinvalid in options;
 setlength(result,alength); //max
 pd:= pcard16(pointer(result));
 pde:= pd+alength;
 pc:= pointer(value);
 pe:= pc+alength;
 while pc < pe do begin
  by1:= pc^;
  inc(pc);
  if by1 < $80 then begin //1 byte
   pd^:= by1;
  end
  else begin
   if by1 < $e0 then begin //2 byte
    if (pc < pe) and (pc^ and $c0 = $80) then begin
     wo1:= ((by1 and $1f) shl word(6)) or (pc^ and $3f);
     if storeinvalid and (wo1 >= utf16privatebase) and
                           (wo1 < utf16privatebase + 256) then begin
      pd^:= utf16private;
      wo1:= wo1 and $00ff;
      inc(pd);
     end;
     pd^:= wo1;
     if pd^ < $80 then begin
      seterror();  //overlong
     end;
     inc(pc);
    end
    else begin
     seterror();
    end;
   end
   else begin
    if (by1 < $f0) then begin //3byte
     if (pe - pc >= 1) and (pc^ and $c0 = $80) and
                                         ((pc+1)^ and $c0 = $80) then begin
      pd^:= (by1 shl word(12)) or
            (pc^ and $3f) shl word(6) or ((pc+1)^ and $3f);
      if pd^ < $0800 then begin
       seterror(); //overlong
      end;
      inc(pc,2);
     end
     else begin
      seterror();
     end;
    end
    else begin
     if (by1 < $f8) then begin //4byte
      if (pe - pc >= 2) and (pc^ and $c0 = $80) and ((pc+1)^ and $c0 = $80) and
                              ((pc+2)^ and $c0 = $80) then begin
       if ((by1 <= $e0) and (pc^ < $90)) then begin //overlong
        seterror(); //overlong;
       end
       else begin
        pd^:= (((by1 and $07) shl word(8)) or
               ((pc^ and $3f) shl word(2)) or
               ((pc+1)^ and $30 shr word(4))) +
                         (word($d800) - word($10000 shr 10));
        inc(pd);
        pd^:= (((pc+1)^ and $0f) shl word(6)) or
                                         ((pc+2)^ and $3f) or word($dc00);
       end;
       inc(pc,3);
      end
      else begin
       seterror();
      end;
     end
     else begin
      seterror();
     end;
    end;
   end;
  end;
  if (pd >= pde) and (pc < pe) then begin //pd should never be bigger than pde,
                                          //there is at most one inc(pd) in loop
   p1:= pointer(result);
   setlength(result,length(result) + length(result) div 3 + 16);
   pointer(pd):= pointer(pd)+(pointer(result)-p1);
   pde:= pcard16(pointer(result))+length(result);
  end;
  inc(pd);
 end;
 setlength(result,pd-pcard16(pointer(result)));
end;

function utf8tostring(const value: utf8string;
                           const options: utfoptionsty = []): msestring;
begin
 result:= utf8tostring(pointer(value),length(value),options);
end;

function utf8tostringansi(const value: ansistring;
                           const options: utfoptionsty = []): msestring;
begin
 result:= utf8tostring(pointer(value),length(value),options);
end;

function rs(const resstring: ansistring): msestring;
                 //converts resourcestring,
                 // resourcesstring unit must be compiled with {$codepage utf8}
begin
 result:= utf8tostring(pointer(resstring),length(resstring),[]);
end;


function utf8tostring(const value: pchar;
                           const options: utfoptionsty = []): msestring;
begin
 result:= utf8tostring(value,strlen(value),options);
end;

function utf8tostring(const value: lstringty;
                           const options: utfoptionsty = []): msestring;
begin
 result:= utf8tostring(value.po,value.len,options);
end;

function docheckutf8(const value: pointer; const count: int32): boolean;
                     //null terminated
var
 po1: pbyte;
begin
 result:= true;
 if count > 0 then begin
  po1:= value;
  while po1^ <> $00 do begin
   if po1^ >= $80 then begin //2 bytes
    if po1^ < $e0 then begin
     if po1^ and $1e = 0 then begin
      result:= false; //overlong
      exit;
     end;
     inc(po1);
     if po1^ and $c0 <> $80 then begin
      result:= false;
      exit;
     end;
    end
    else begin
     if po1^ < $f0 then begin //3 bytes
      inc(po1);
      if (po1^ and $20 = 0) and ((po1-1)^ and $0f = 0) then begin
       result:= false; //overolong
       exit;
      end;
      if po1^ and $c0 <> $80 then begin
       result:= false;
       exit;
      end;
      inc(po1);
      if po1^ and $c0 <> $80 then begin
       result:= false;
       exit;
      end;
     end
     else begin
      if po1^ < $f8 then begin //4 bytes
       inc(po1);
       if po1^ and $c0 <> $80 then begin
        result:= false;
        exit;
       end;
       if (po1^ and $30 = 0) and ((po1-1)^ and $07 = 0) then begin
        result:= false; //overolong
        exit;
       end;
       inc(po1);
       if po1^ and $c0 <> $80 then begin
        result:= false;
        exit;
       end;
       inc(po1);
       if po1^ and $c0 <> $80 then begin
        result:= false;
        exit;
       end;
      end
      else begin
       result:= false;
       exit;
      end;
     end;
    end;
   end;
   inc(po1);
  end;
  if pointer(po1) <> value + count then begin
   result:= false;    //#0 in string
  end;
 end;
end;

function checkutf8(const value: utf8string): boolean;
              //true if valid utf8
begin
 result:= docheckutf8(pointer(value),length(value));
end;

function checkutf8ansi(const value: ansistring): boolean;
              //true if valid utf8
begin
 result:= docheckutf8(pointer(value),length(value));
end;

function stringtolatin1(const value: msestring): string;
var
 int1: integer;
begin
 setlength(result,length(value));
 for int1:= 0 to length(result)-1 do begin
  (pchar(pointer(result))+int1)^:=
                  char(word((pmsechar(pointer(value))+int1)^));
 end;
end;

function latin1tostring(const value: string): msestring;
var
 int1: integer;
begin
 setlength(result,length(value));
 for int1:= 0 to length(result)-1 do begin
  (pmsechar(pointer(result))+int1)^:=
          msechar(byte((pchar(pointer(value))+int1)^));
 end;
end;

function ucs4tostring(achar: dword): msestring;
begin
 if achar < $10000 then begin
  setlength(result,1);
  pmsechar(pointer(result))^:= msechar(achar);
 end
 else begin
  setlength(result,2);
  achar:= achar - $10000;
  pmsechar(pointer(result))^:=
                        msechar(word((achar shr 10) and $3ff or $d800));
  (pmsechar(pointer(result))+1)^:= msechar(word(achar) and $3ff or $dc00);
 end;
end;

function getucs4char(const value: msestring; const aindex: int32): ucs4char;
            //returns surrogatevalue if index between high and low codeunit
begin
 result:= 0;
 if (aindex > 0) and (aindex <= length(value)) then begin
  result:= ord(value[aindex]);
  if result and $fc00 = $d800 then begin
   result:= ((result - $d800) shl 10) + ord(value[aindex+1]) - $dc00 + $10000;
  end
  else begin
   if (result and $fc00 = $dc00) and (aindex > 1) then begin
    result:= result - $dc00 + ((ord(value[aindex-1]) - $d800) shl 10) + $10000;
   end;
  end;
 end;
end;

function getasciichar(const source: msechar; out dest: char): boolean;
                    //true if valid;
begin
 result:= source < #128;
 dest:= char(byte(source));
end;

function getansichar(const source: msechar; out dest: char): boolean;
                    //true if valid;
begin
 result:= source < #256;
 dest:= char(byte(source));
end;

function psubstr(const start,stop: pchar): string;
var
 int1: integer;
begin
 int1:= stop-start;
 if (int1 < 0) or (start = nil) or (stop = nil) then begin
  result:= '';
 end
 else begin
  setlength(result,int1);
  move(start^,result[1],int1);
 end;
end;

function ansistringof(const value: tbytes): ansistring;
begin
 setlength(result,length(value));
 move(pointer(value)^,pointer(result)^,length(result));
end;

function psubstr(const start,stop: pmsechar): msestring;
var
 int1: integer;
begin
 int1:= stop-start;
 if (int1 < 0) or (start = nil) or (stop = nil) then begin
  result:= '';
 end
 else begin
  setlength(result,int1);
  move(start^,result[1],int1*sizeof(msechar));
 end;
end;

function singleline(const start: pchar): string;
var
 po1: pchar;
begin
 if start = nil then begin
  result:= '';
 end
 else begin
  po1:= start;
  while po1^ <> #0 do begin
   if (po1^ = c_linefeed) or (po1^ = c_return) then begin
    break;
   end;
   inc(po1);
  end;
  result:= psubstr(start,po1);
 end;
end;

function singleline(const start: pmsechar): msestring;
var
 po1: pmsechar;
begin
 if start = nil then begin
  result:= '';
 end
 else begin
  po1:= start;
  while po1^ <> msechar(#0) do begin
   if (po1^ = msechar(c_linefeed)) or (po1^ = msechar(c_return)) then begin
    break;
   end;
   inc(po1);
  end;
  result:= psubstr(start,po1);
 end;
end;

function concatstrings(const source: msestringarty;
        const separator: msestring = ' '; const quotechar: msechar = #0;
                                    const force: boolean = false): msestring;
var
 int1: integer;
 sepchar: msechar;
begin
 if source = nil then begin
  result:= '';
 end
 else begin
  if quotechar = #0 then begin
   result:= source[0];
   for int1:= 1 to high(source) do begin
    result:= result + separator + source[int1];
   end;
  end
  else begin
   sepchar:= pmsechar(separator)^;
   result:= quotestring(source[0],quotechar,force);
   for int1:= 1 to high(source) do begin
    result:= result + separator +
                      quotestring(source[int1],quotechar,force,sepchar);
   end;
  end;
 end;
end;

function concatstrings(const source: stringarty;
        const separator: string = ' '; const quotechar: char = #0;
                                    const force: boolean = false): string;
var
 int1: integer;
 sepchar: char;
begin
 if source = nil then begin
  result:= '';
 end
 else begin
  if quotechar = #0 then begin
   result:= source[0];
   for int1:= 1 to high(source) do begin
    result:= result + separator + source[int1];
   end;
  end
  else begin
   sepchar:= pchar(separator)^;
   result:= quotestring(source[0],quotechar,force);
   for int1:= 1 to high(source) do begin
    result:= result + separator +
             quotestring(source[int1],quotechar,force,sepchar);
   end;
  end;
 end;
end;
{
procedure stringaddref(var str: ansistring);
var
 po1: psizeint;
begin
 if pointer(str) <> nil then begin
  po1:= pointer(str)-2*sizeof(sizeint);
  if po1^ >= 0 then begin
   inc(po1^);
  end;
 end;
end;
}

 procedure stringaddref(var str: ansistring);
    var
     temp: ansistring;
    begin
     { increase refcount if it was > 0}
     temp:=str;
     { prevent the compiler from finalising temp, so it won't decrease the refcount again }
     pointer(temp):=nil;
    end;

{
procedure stringaddref(var str: msestring);
{$ifndef msestringsarenotrefcounted}
var
 po1: psizeint;
{$endif}
begin
 if pointer(str) <> nil then begin
{$ifndef msestringsarenotrefcounted}
  po1:= pointer(str)-2*sizeof(sizeint);
  if po1^ >= 0 then begin
   inc(po1^);
  end;
{$else}
  reallocstring(str); //delphi and FPC 2.2
                      //widestrings are not refcounted on win32
{$endif}
 end;
end;
}

procedure stringaddref(var str: msestring);
var
{$ifndef msestringsarenotrefcounted}
 po1: psizeint;
{$endif}
 temp: msestring;
begin
 if pointer(str) <> nil then begin
{$ifndef msestringsarenotrefcounted}
  { increase refcount if it was > 0}
     temp:=str;
     { prevent the compiler from finalising temp, so it won't decrease the refcount again }
     pointer(temp):=nil;
  end;
{$else}
  reallocstring(str); //delphi and FPC 2.2
                      //widestrings are not refcounted on win32
{$endif}
 end;

procedure stringsafefree(var str: string; const onlyifunique: boolean);
var
 {$if fpc_fullversion < 030000}
 po1: psizeint;
 {$else}
  po1: longint;
 {$endif}
begin
 if pointer(str) <> nil then begin
 {$if fpc_fullversion < 030000}
  po1:= pointer(str)-2*sizeof(sizeint);
  if (po1^ >= 0) and (not onlyifunique or (po1^ = 1)) then begin
  {$else}
  po1:= StringRefCount(str);
  if (po1 >= 0) and (not onlyifunique or (po1 = 1)) then begin
 {$endif}

  fillchar(pointer(str)^,length(str)*sizeof(str[1]),0);
   str:= '';
  end;
 end;
end;

procedure stringsafefree(var str: msestring; const onlyifunique: boolean);
var
{$if fpc_fullversion < 030000}
 po1: psizeint;
 {$else}
  po1: longint;
 {$endif}
begin
 if pointer(str) <> nil then begin
{$if fpc_fullversion < 030000}
  po1:= pointer(str)-2*sizeof(sizeint);
  if (po1^ >= 0) and (not onlyifunique or (po1^ = 1)) then begin
  {$else}
  po1:= StringRefCount(str);
  if (po1 >= 0) and (not onlyifunique or (po1 = 1)) then begin
 {$endif}

   fillchar(pointer(str)^,length(str)*sizeof(str[1]),0);
   str:= '';
  end;
 end;
end;

procedure splitstringquoted(const source: string; out dest: stringarty;
                       quotechar: char = '"'; separator: char = #0);
var
 po1,po2: pchar;
 count: integer;
 str1: string;

 procedure addsubstring;
 var
  int1: integer;
 begin
  if po1 <> po2 then begin
   int1:= length(str1);
   setlength(str1,int1+(po1-po2));
   move(po2^,str1[int1+1],(po1-po2)*sizeof(char));
  end;
 end;

begin
 dest:= nil;
 po1:= pointer(source);
 if po1 <> nil then begin
  count:= 0;
  while po1^ <> #0 do begin
   if separator = #0 then begin
    while (po1^ = ' ') or (po1^ = c_tab) do begin
     inc(po1);
    end;
   end
   else begin
    while true do begin
     if po1^ = quotechar then begin
      break;
     end;
     po2:= po1;
     while (po1^ <> separator) and (po1^ <> #0) do begin
      inc(po1);
     end;
     setstring(str1,po2,po1-po2);
     additem(dest,str1,count);
     if po1^ <> #0 then begin
      inc(po1);
     end
     else begin
      setlength(dest,count);
      exit;
     end;
    end;
   end;
   str1:= '';
   if po1^ <> quotechar then begin
    po2:= po1;
    while (po1^ <> quotechar) and (po1^ <> ' ') and (po1^ <> c_tab) and (po1^ <> #0) do begin
     inc(po1);
    end;
    addsubstring;
   end
   else begin
    while po1^ <> #0 do begin
     inc(po1);    //po1^ = quotechar
     po2:= po1;
     while (po1^ <> quotechar) and (po1^ <> #0) do begin
      inc(po1);
     end;
     if po1^ <> #0 then begin           //       ?
      if (po1+1)^ = quotechar then begin//  "....""...
       inc(po1);                        //        ?
       addsubstring;                    //  "....""...
      end
      else begin                        //       ?
       addsubstring;                    //  "...."....
       inc(po1);                        //        ?
                                        //  "...."....
                                        //  "...."..,..
       if (separator <> #0) then begin
        while (po1^ <> #0) and (po1^ <> separator) do begin
         inc(po1);
        end;
                                        //          ?
                                        //  "...."..,..
        if po1^ = separator then begin
         inc(po1);
        end;
                                        //           ?
                                        //  "...."..,..
       end;
       break;
      end;
     end;
    end;
   end;
   additem(dest,str1,count);
  end;
  setlength(dest,count);
 end;
end;

procedure splitstringquoted(const source: msestring; out dest: msestringarty;
                       quotechar: msechar = '"'; separator: msechar = #0);
var
 po1,po2: pmsechar;
 count: integer;
 str1: msestring;

 procedure addsubstring;
 var
  int1: integer;
 begin
  if po1 <> po2 then begin
   int1:= length(str1);
   setlength(str1,int1+(po1-po2));
   move(po2^,str1[int1+1],(po1-po2)*sizeof(msechar));
  end;
 end;

begin
 dest:= nil;
 po1:= pointer(source);
 if po1 <> nil then begin
  count:= 0;
  while po1^ <> #0 do begin
   if separator = #0 then begin
    while (po1^ = ' ') or (po1^ = c_tab) do begin
     inc(po1);
    end;
   end
   else begin
    while true do begin
     if po1^ = quotechar then begin
      break;
     end;
     po2:= po1;
     while (po1^ <> separator) and (po1^ <> #0) do begin
      inc(po1);
     end;
     setstring(str1,po2,po1-po2);
     additem(dest,str1,count);
     if po1^ <> #0 then begin
      inc(po1);
     end
     else begin
      setlength(dest,count);
      exit;
     end;
    end;
   end;
   str1:= '';
   if po1^ <> quotechar then begin
    po2:= po1;
    while (po1^ <> quotechar) and (po1^ <> ' ') and (po1^ <> c_tab) and (po1^ <> #0) do begin
     inc(po1);
    end;
    addsubstring;
   end
   else begin
    while po1^ <> #0 do begin
     inc(po1);    //po1^ = quotechar
     po2:= po1;
     while (po1^ <> quotechar) and (po1^ <> #0) do begin
      inc(po1);
     end;
     if po1^ <> #0 then begin           //       ?
      if (po1+1)^ = quotechar then begin//  "....""...
       inc(po1);                        //        ?
       addsubstring;                    //  "....""...
      end
      else begin                        //       ?
       addsubstring;                    //  "...."....
       inc(po1);                        //        ?
                                        //  "...."....
                                        //  "...."..,..
       if (separator <> #0) then begin
        while (po1^ <> #0) and (po1^ <> separator) do begin
         inc(po1);
        end;
                                        //          ?
                                        //  "...."..,..
        if po1^ = separator then begin
         inc(po1);
        end;
                                        //           ?
                                        //  "...."..,..
       end;
       break;
      end;
     end;
    end;
   end;
   additem(dest,str1,count);
  end;
  setlength(dest,count);
 end;
end;

function breaklines(const source: string): stringarty;
var
 int1,int2: integer;
begin
 result:= nil;
 splitstring(source,result,c_linefeed);
 for int1:= 0 to high(result) do begin
  int2:= length(result[int1]);
  if (int2 > 0) and (result[int1][int2] = c_return) then begin
   setlength(result[int1],int2-1);
  end;
 end;
end;

function breaklines(const source: msestring): msestringarty;
var
 int1,int2: integer;
begin
 result:= nil;
 splitstring(source,result,c_linefeed);
 for int1:= 0 to high(result) - 1 do begin
  while true do begin
   int2:= length(result[int1]);
   if (int2 > 0) and (result[int1][int2] = c_return) then begin
    setlength(result[int1],int2-1);
   end
   else begin
    break;
   end;
  end;
 end;
end;

function breaklines(const source: msestring; maxlength: integer): msestringarty;
var
 charindex,charindexbefore,rowindex,lineend,lastbreak: integer;
 int1,int2,len: integer;
 po1: pmsechar;
 mch1: msechar;
 bo1: boolean;
begin
 len:= length(source);
 setlength(result,len div 10 + 1);
 if source <> '' then begin
  if maxlength <= 0 then begin
   maxlength:= 1;
  end;
  rowindex:= 0;
  charindex:= 1;
  while charindex <= length(source) do begin
   if rowindex > high(result) then begin
    setlength(result,length(result)*2);
   end;
   charindexbefore:= charindex;
   charindex:= length(source);
   lineend:= 0;
   lastbreak:= 0;
   int2:= 1;
   bo1:= false;
   for int1:= charindexbefore to len do begin
    mch1:= source[int1];
    if bo1 and ((mch1 = ' ') or (mch1 = c_tab)) then begin
     lineend:= int1;
     charindex:= int1;
    end;
    if mch1 = c_return then begin
     lineend:= int1;
     charindex:= int1;
     if source[charindex+1] = c_linefeed then begin
      inc(charindex);
     end;
     break;
    end;
    if mch1 = c_linefeed then begin
     lineend:= int1;
     charindex:= int1;
     break;
    end;
    if (int2 <= maxlength) and ((mch1 = c_softhyphen) or (mch1 = '-') or
       (mch1 = ' ') or  (mch1 = c_tab)) then begin
     lastbreak:= int1;
    end;
    if bo1 then begin
     break;
    end;
    if mch1 <> c_softhyphen then begin
     inc(int2);
    end;
    if int2 > maxlength then begin
     charindex:= int1;
     if int1 = len then begin
      lineend:= int1 + 1;
     end;
     bo1:= true;
    end;
   end;
   inc(charindex);
   if lineend = 0 then begin
    if int2 <= maxlength then begin
     lineend:= charindex;
    end
    else begin
     lineend:= lastbreak;
     if lineend = 0 then begin
      lineend:= charindex;
     end
     else begin
      charindex:= lineend + 1;
      mch1:= source[lineend];
      if (mch1 = c_softhyphen) or (mch1 = '-') then begin
       inc(lineend);
      end;
     end;
    end;
   end;
   setlength(result[rowindex],lineend-charindexbefore); //max
   po1:= pointer(result[rowindex]);
   if po1 <> nil then begin
    for int1:= charindexbefore to lineend - 1 do begin
     po1^:= source[int1];
     if po1^ <> c_softhyphen then begin
      inc(po1);
     end;
    end;
    if source[lineend-1] = c_softhyphen then begin
     inc(po1);
    end;
    setlength(result[rowindex],po1-pmsechar(result[rowindex]));
   end;
   inc(rowindex);
  end;
  setlength(result,rowindex);
 end;
end;

function fitstring(const source: msestring; const len: integer;
           const pos: stringposty = sp_left;
           const cutchar: msechar = #0;
           const padchar: msechar = ' '): msestring;
                  //cutchar = 0 -> no cutchar
 procedure pad(const dest: pmsechar; const count: integer);
 var
  int1: integer;
  ch1: msechar;
 begin
  ch1:= padchar;
  for int1:= 0 to count-1 do begin
   {$ifdef FPC}
   dest[int1]:= ch1;
   {$else}
   pmsecharaty(dest)^[int1]:= ch1;
   {$endif}
  end;
 end;

var
 copylen,padlen: integer;
 int1: integer;
begin //fitstring
 if (length(source) > len) and (cutchar <> #0) then begin
  result:= charstring(cutchar,len);
 end
 else begin
  setlength(result,len);
  if len > 0 then begin
   copylen:= length(source);
   padlen:= len - copylen;
   if padlen < 0 then begin
    copylen:= len;
    padlen:= 0;
   end;
   case pos of
    sp_center: begin
     int1:= padlen div 2;
     move((pmsechar(pointer(source))+(length(source)-copylen) div 2)^,
             (pmsechar(pointer(result))+int1)^,copylen*sizeof(msechar));
     pad(pointer(result),int1);
     pad(pmsechar(pointer(result))+int1+copylen,len-copylen-int1);
    end;
    sp_right: begin
     move((pmsechar(pointer(source))+length(source)-copylen)^,
             (pmsechar(pointer(result))+padlen)^,copylen*sizeof(msechar));
     pad(pmsechar(pointer(result)),padlen);
    end;
    else begin //sp_left
     move(pointer(source)^,pointer(result)^,copylen*sizeof(msechar));
     pad(pmsechar(pointer(result))+copylen,padlen);
    end;
   end;
  end;
 end;
end;

procedure splitstring(source: string;
                     var dest: stringarty; separator: char = c_tab;
                     trim: boolean = false);
          // dest = [] -> length(dest) = anzahl vorhandene teile
          // sonst length(dest) <= length(dest uebergeben),
          // ganzer rest im letzten string, fallse mehr vorhandene teile als
          // uebergebene strings
var
 int2,int3: integer;
 po,po1,po2: pchar;
 all: boolean;
 bo1: boolean;

begin
 all:= length(dest) = 0;
 if all then begin
  int2:= countchars(source,separator);
  setlength(dest,int2+1); //maximale zahl
 end
 else begin
  for int2:= 0 to length(dest)-1 do begin
   dest[int2]:= '';
  end;
 end;
 po:= pchar(source);
 int3:= length(source);
 bo1:= false;
 for int2:= 0 to length(dest) - 1 do begin
  if int3 <= 0 then begin
   if bo1 and (int2 < length(dest)) then begin
    setlength(dest,int2+1); //leerer schluss
   end
   else begin
    setlength(dest,int2);
   end;
   break;
  end;
  po2:= po;
  po1:= strlscan(po,separator,int3);
  if (po1 = nil) or (int2 = high(dest)) then begin
   po1:= po + int3;           //rest
   bo1:= false;
  end
  else begin
   bo1:= true;
  end;
  if trim then begin
   po:= strnscan(po,' ');
  end;
  if po <> nil then begin
   if trim then begin
    dest[int2]:= trimright(strlcopy(po,po1-po));
   end
   else begin
    dest[int2]:= strlcopy(po,po1-po);
   end;
  end;
  if trim and (separator = ' ') then begin
   po1:= strlnscan(po1,separator,int3);
   if po1 = nil then begin
    int3:= 0;
   end;
  end
  else begin
   inc(po1);
  end;
  int3:= int3 - (po1 - po2);
             //verbrauchte stringlaenge
  po:= po1;
 end;
end;

procedure splitstring(source: msestring;
                     var dest: msestringarty; separator: msechar = c_tab;
                     trim: boolean = false);
          // dest = [] -> length(dest) = anzahl vorhandene teile
          // sonst length(dest) <= length(dest uebergeben),
          // ganzer rest im letzten string, fallse mehr vorhandene teile als
          // uebergebene strings
var
 int2,int3: integer;
 po,po1,po2: pmsechar;
 all: boolean;
 bo1: boolean;

begin
 all:= length(dest) = 0;
 if all then begin
  int2:= countchars(source,separator);
  setlength(dest,int2+1); //maximale zahl
 end
 else begin
  for int2:= 0 to length(dest)-1 do begin
   dest[int2]:= '';
  end;
 end;
 po:= pmsechar(source);
 int3:= length(source);
 bo1:= false;
 for int2:= 0 to length(dest) - 1 do begin
  if int3 <= 0 then begin
   if bo1 and (int2 < length(dest)) then begin
    setlength(dest,int2+1); //leerer schluss
   end
   else begin
    setlength(dest,int2);
   end;
   break;
  end;
  po2:= po;
  po1:= msestrlscan(po,separator,int3);
  if (po1 = nil) or (int2 = high(dest)) then begin
   po1:= po + int3;           //rest
   bo1:= false;
  end
  else begin
   bo1:= true;
  end;
  if trim then begin
   po:= msestrnscan(po,' ');
  end;
  if po <> nil then begin
   if trim then begin
    dest[int2]:= trimright(msestrlcopy(po,po1-po));
   end
   else begin
    dest[int2]:= msestrlcopy(po,po1-po);
   end;
  end;
  if trim and (separator = ' ') then begin
   po1:= msestrlnscan(po1,separator,int3);
   if po1 = nil then begin
    int3:= 0;
   end;
  end
  else begin
   inc(po1);
  end;
  int3:= int3 - (po1 - po2);
             //verbrauchte stringlaenge
  po:= po1;
 end;
end;

function splitstring(source: string; separator: char = c_tab;
                     trim: boolean = false): stringarty;
begin
 result:= nil;
 splitstring(source,result,separator,trim);
end;

function splitstring(source: msestring; separator: msechar = c_tab;
                     trim: boolean = false): msestringarty;
begin
 result:= nil;
 splitstring(source,result,separator,trim);
end;

function splitstringquoted(source: string; separator: char = c_tab;
                     quotechar: char = '"';
                     atrim: boolean = false): stringarty;
var
 int1: integer;
begin
 splitstringquoted(source,result,quotechar,separator);
 if atrim then begin
  for int1:= 0 to high(result) do begin
   result[int1]:= trim(result[int1]);
  end;
 end;
end;

function splitstringquoted(source: msestring; separator: msechar = c_tab;
                     quotechar: msechar = '"';
                     atrim: boolean = false): msestringarty; overload;
var
 int1: integer;
begin
 splitstringquoted(source,result,quotechar,separator);
 if atrim then begin
  for int1:= 0 to high(result) do begin
   result[int1]:= trim(result[int1]);
  end;
 end;
end;

function stringfromchar(achar: char; count : integer): string;
var
 int1: integer;
begin
 setlength(result,count);
 for int1:= 1 to count do begin
  result[int1]:= achar;
 end;
end;

function stringfromchar(achar: msechar; count : integer): msestring;
var
 int1: integer;
begin
 setlength(result,count);
 for int1:= 1 to count do begin
  result[int1]:= achar;
 end;
end;

function parsecommandline(const s: pchar): stringarty;
var
 po1,po2: pchar;
 count: integer;
 str1: string;

 procedure addsubstring;
 var
  int1,int2: integer;
 begin
 {$ifdef FPC}{$checkpointer off}{$endif}
  int1:= po1-po2;
  int2:= length(str1);
  setlength(str1,int2+int1);
  move(po2^,str1[int2+1],int1);
  po2:= po1;
 {$ifdef FPC}{$checkpointer default}{$endif}
 end;

begin
 result:= nil;
 count:= 0;
 if s <> nil then begin
 {$ifdef FPC}{$checkpointer off}{$endif}
  po1:= s;
  while (po1^ <> #0) and (po1^ = ' ') do begin
   inc(po1);
  end;
  if po1^ <> #0 then begin
   po2:= po1;
   str1:= '';
   while true do begin
    case po1^ of
     ' ',#0: begin
      addsubstring;
      additem(result,str1,count);
      str1:= '';
      while (po1^ <> #0) and (po1^ = ' ') do begin
       inc(po1);
      end;
      if po1^ = #0 then begin
       break;
      end;
      po2:= po1;
     end;
     '"': begin
      addsubstring;
      po2:= po1 + 1;
      repeat
       inc(po1);
       case po1^ of
        '"': begin
         addsubstring;
         inc(po1);
         inc(po2);
         break;
        end;
        {
        '\': begin
         if (po1+1)^ = '"' then begin
          addsubstring;
          inc(po1);
          inc(po2);
         end;
        end;
        }
       end;
      until po1^ = #0;
     end;
     {
     '\': begin
      if ((po1+1)^ < ' ') or ((po1+1)^ in ['"','\']) then begin
       addsubstring;
       inc(po1);
       if po1^ = #0 then begin
        break;
       end;
       inc(po1);
       inc(po2);
      end
      else begin
       inc(po1);
      end;
     end;
     }
     else begin
      inc(po1);
     end;
    end;
   end;
  end;
 {$ifdef FPC}{$checkpointer default}{$endif}
  setlength(result,count);
 end;
end;

function parsecommandline(const s: pmsechar): msestringarty;
var
 po1,po2: pmsechar;
 count: integer;
 str1: msestring;

 procedure addsubstring;
 var
  int1,int2: integer;
 begin
 {$ifdef FPC}{$checkpointer off}{$endif}
  int1:= po1-po2;
  int2:= length(str1);
  setlength(str1,int2+int1);
  move(po2^,str1[int2+1],int1*sizeof(msechar));
  po2:= po1;
 {$ifdef FPC}{$checkpointer default}{$endif}
 end;

begin
 result:= nil;
 count:= 0;
 if s <> nil then begin
 {$ifdef FPC}{$checkpointer off}{$endif}
  po1:= s;
  while (po1^ <> #0) and (po1^ = ' ') do begin
   inc(po1);
  end;
  if po1^ <> #0 then begin
   po2:= po1;
   str1:= '';
   while true do begin
    case po1^ of
     ' ',#0: begin
      addsubstring;
      additem(result,str1,count);
      str1:= '';
      while (po1^ <> #0) and (po1^ = ' ') do begin
       inc(po1);
      end;
      if po1^ = #0 then begin
       break;
      end;
      po2:= po1;
     end;
     '"': begin
      addsubstring;
      po2:= po1 + 1;
      repeat
       inc(po1);
       case po1^ of
        '"': begin
         addsubstring;
         inc(po1);
         inc(po2);
         break;
        end;
        {
        '\': begin
         if (po1+1)^ = '"' then begin
          addsubstring;
          inc(po1);
          inc(po2);
         end;
        end;
        }
       end;
      until po1^ = #0;
     end;
     {
     '\': begin
      if ((po1+1)^ < ' ') or ((po1+1)^ in ['"','\']) then begin
       addsubstring;
       inc(po1);
       if po1^ = #0 then begin
        break;
       end;
       inc(po1);
       inc(po2);
      end
      else begin
       inc(po1);
      end;
     end;
     }
     else begin
      inc(po1);
     end;
    end;
   end;
  end;
 {$ifdef FPC}{$checkpointer default}{$endif}
  setlength(result,count);
 end;
end;

function parsecommandline(const s: string): stringarty;
begin
 result:= parsecommandline(pchar(s));
end;

function parsecommandline(const s: msestring): msestringarty;
begin
 result:= parsecommandline(pmsechar(s));
end;

procedure trimright1(var s: string); overload;
var
 po1,po2: pchar;
begin
 if s <> '' then begin
  po1:= pointer(s);
  po2:= po1+length(s)-1;
  while (po2^ <= ' ') do begin
   dec(po2);
   if po2 < po1 then begin
    break;
   end;
  end;
  setlength(s,po2-po1+1);
 end;
end;

procedure trimright1(var s: msestring); overload;
var
 po1,po2: pmsechar;
begin
 if s <> '' then begin
  po1:= pointer(s);
  po2:= po1+length(s)-1;
  while (po2^ <= ' ') do begin
   dec(po2);
   if po2 < po1 then begin
    break;
   end;
  end;
  setlength(s,po2-po1+1);
 end;
end;

function printableascii(const source: string): string;
                //removes all nonprintablechars and ' '
var
 int1,int2: integer;
 ca1: char;
begin
 setlength(result,length(source));
 int2:= 0;
 for int1:= 0 to length(source)-1 do begin
  ca1:= pcharaty(source)^[int1];
  if (ca1 > ' ') and (ca1 < #127) then begin
   pcharaty(result)^[int2]:= ca1;
   inc(int2);
  end;
 end;
 setlength(result,int2);
end;

function printableascii(const source: msestring): msestring;
                //removes all nonprintablechars and ' '
var
 int1,int2: integer;
 ca1: msechar;
begin
 setlength(result,length(source));
 int2:= 0;
 for int1:= 0 to length(source)-1 do begin
  ca1:= pmsecharaty(source)^[int1];
  if (ca1 > ' ') and (ca1 < #127) then begin
   pmsecharaty(result)^[int2]:= ca1;
   inc(int2);
  end;
 end;
 setlength(result,int2);
end;

function removechar(const source: string; a: char): string;
  //removes all a
var
 int1,int2: integer;
begin
 setlength(result,length(source));
 int2:= 0;
 for int1:= 1 to length(source) do begin
  if source[int1] <> a then begin
   pcharaty(result)^[int2]:= source[int1];
   inc(int2);
  end;
 end;
 setlength(result,int2);
end;

procedure removechar1(var dest: string; a: char);
  //removes all a
begin
 dest:= removechar(dest,a);
end;

function removechar(const source: msestring; a: msechar): msestring;
  //removes all a
var
 int1,int2: integer;
begin
 setlength(result,length(source));
 int2:= 0;
 for int1:= 1 to length(source) do begin
  if source[int1] <> a then begin
   pmsecharaty(result)^[int2]:= source[int1];
   inc(int2);
  end;
 end;
 setlength(result,int2);
end;

procedure removechar1(var dest: msestring; a: msechar);
  //removes all a
begin
 dest:= removechar(dest,a);
end;

function replacechar(const source: string; old,new: char): string;
  //replaces a by b
begin
 result:= source;
 replacechar1(result,old,new);
end;
{
procedure replacechar1(var dest: string; a,b: char);
  //replaces a by b
var
 int1: integer;
begin
 uniquestring(dest);
 for int1:= 0 to length(dest)-1 do begin
  if pcharaty(dest)^[int1] = a then begin
   pcharaty(dest)^[int1]:= b;
  end;
 end;
end;
}
procedure replacechar1(var dest: string; old,new: char);
  //replaces a by b
var
 pd,pe: pchar;
begin
 uniquestring(dest);
 pd:= pointer(dest);
 pe:= pd + length(dest);
 while pd < pe do begin
  if pd^ = old then begin
   pd^:= new;
  end;
  inc(pd);
 end;
end;

function replacechar(const source: msestring; old,new: msechar): msestring;
  //replaces a by b
begin
 result:= source;
 replacechar1(result,old,new);
end;
{
procedure replacechar1(var dest: msestring; a,b: msechar);
  //replaces a by b
var
 int1: integer;
begin
 uniquestring(dest);
 for int1:= 0 to length(dest)-1 do begin
  if pmsecharaty(dest)^[int1] = a then begin
   pmsecharaty(dest)^[int1]:= b;
  end;
 end;
end;
}

procedure replacechar1(var dest: msestring; old,new: msechar);
  //replaces a by b
var
 pd,pe: pmsechar;
begin
 uniquestring(dest);
 pd:= pointer(dest);
 pe:= pd + length(dest);
 while pd < pe do begin
  if pd^ = old then begin
   pd^:= new;
  end;
  inc(pd);
 end;
end;

procedure replacetext1(var dest: string; index: integer; const a: string);
 //dest will be extended with spaces if necessary
var
 int1,int2: integer;
begin
 uniquestring(dest);
 if length(dest) < index + length(a) then begin
  int1:= length(dest);
  setlength(dest,index+length(a)-1);
  for int2:= int1 to index - 2 do begin
   pcharaty(dest)^[int2]:= ' ';
  end;
 end;
 dec(index);
 int1:= length(a);
 if index < 0 then begin
  int1:= int1 + index;
  index:= 0;
 end;
 for int2:= 0 to int1-1 do begin
  pcharaty(dest)^[int2+index]:= pcharaty(a)^[int2];
 end;
end;

function replacetext(const source: string; index: integer; a: string): string;
begin
 result:= source;
 replacetext1(result,index,a);
end;

procedure replacetext1(var dest: msestring; index: integer; const a: msestring);
 //dest will be extended with spaces if necessary
var
 int1,int2: integer;
begin
 uniquestring(dest);
 if length(dest) < index + length(a) then begin
  int1:= length(dest);
  setlength(dest,index+length(a)-1);
  for int2:= int1 to index - 2 do begin
   pmsecharaty(dest)^[int2]:= ' ';
  end;
 end;
 dec(index);
 int1:= length(a);
 if index < 0 then begin
  int1:= int1 + index;
  index:= 0;
 end;
 for int2:= 0 to int1-1 do begin
  pmsecharaty(dest)^[int2+index]:= pmsecharaty(a)^[int2];
 end;
end;

function replacetext(const source: msestring; index: integer; a: msestring): msestring;
begin
 result:= source;
 replacetext1(result,index,a);
end;

procedure addstringsegment(var dest: msestring; const a,b: pmsechar);
var
 int1,int2: integer;
begin
 int1:= length(dest);
 int2:= b-a;
 setlength(dest,int1 + int2);
 move(a^,dest[int1+1],int2*sizeof(msechar));
end;

function stringsegment(a,b: pchar): string;
var
 int1: integer;
begin
 int1:= b - a;
 setlength(result,int1);
 move(a^,result[1],int1*sizeof(char));
end;

function stringsegment(a,b: pmsechar): msestring;
var
 int1: integer;
begin
 int1:= b - a;
 setlength(result,int1);
 move(a^,result[1],int1*sizeof(msechar));
end;

function countleadingchars(const str: msestring;  char: msechar): integer;
var
 int1: integer;
 po1,po2: pmsechar;
begin
 int1:= length(str);
 if int1 > 0 then begin
  po1:= pointer(str);
  po2:= msestrlnscan(po1,' ',int1);
  if po2 = nil then begin
   result:= int1;
  end
  else begin
   result:= po2-po1;
  end;
 end
 else begin
  result:= -1; //leer
 end;
end;

function countleadingchars(const str: string; char: char): integer;
var
 int1: integer;
 po1,po2: pchar;
begin
 int1:= length(str);
 if int1 > 0 then begin
  po1:= pointer(str);
  po2:= strlnscan(po1,' ',int1);
  if po2 = nil then begin
   result:= int1;
  end
  else begin
   result:= po2-po1;
  end;
 end
 else begin
  result:= -1; //leer
 end;
end;

function nullstring(const count: integer): string;
begin
 if count > 0 then begin
  setlength(result,count);
  fillchar(pointer(result)^,count,#0 );
 end
 else begin
  result:= '';
 end;
end;

function charstring(ch: char; count: integer): string; overload;
begin
 if count > 0 then begin
  setlength(result,count);
  for count:= count - 1 downto 0 do begin
   (pchar(pointer(result)) + count)^:= ch;
 //  result[count]:= ch;
  end;
 end
 else begin
  result:= '';
 end;
end;

function charstring(ch: msechar; count: integer): msestring; overload;
begin
 if count > 0 then begin
  setlength(result,count);
  for count:= count - 1 downto 0 do begin
   (pmsechar(pointer(result)) + count)^:= ch;
 //  result[count]:= ch;
  end;
 end
 else begin
  result:= '';
 end;
end;
{
function posmse(substring: pmsechar; const s: lmsestringty): pmsechar;
var
 po1: pmsechar;
 int1: integer;
begin
 if (substring <> nil) and (substring^ <> #0) and
               (s.po <> nil) and (s.len > 0) then begin
  result:= msestrlscan(s.po,substring^,s.len);
  int1:= s.len - (s.po-result) - 1;
  if result <> nil then begin
   po1:= result;
   while (substring^ <> #0) and (int1 > 0) do begin
    dec(int1);
    inc(substring);
    inc(po1);
    if po1^ <> substring^ then begin
     break;
    end;
   end;
   if po1^ <> #0 then begin
    result:= nil;
   end;
  end;
 end
 else begin
  result:= nil;
 end;
end;
}
{
function msestrpos(const substr: msestring; const s: msestring): integer;
var
 po1,po2,po3,po4: pmsechar;
begin
 po3:= pmsechar(substr);
 if po3^ <> #0 then begin
  po4:= pmsechar(s);
  repeat
   while (po4^ <> #0) and (po4^ <> po3^) do begin
    inc(po4);
   end;
   po1:= po3;
   po2:= po4;
   while (po1^ <> #0) and (po1^ = po2^) do begin
    inc(po1);
    inc(po2);
   end;
   if po1^ = #0 then begin
    result:= po4 - pmsechar(s) + 1;
    exit;
   end;
   inc(po4);
  until po2^ = #0;
 end;
 result:= 0;
end;

function msetextpos1(const substrlower,substrupper: msestring; const s: msestring): integer;
var
 po1l,po1u,po2,po3l,po3u,po4: pmsechar;
begin
 po3l:= pmsechar(substrlower);
 po3u:= pmsechar(substrupper);
 if po3l^ <> #0 then begin
  po4:= pmsechar(s);
  repeat
   while (po4^ <> #0) and (po4^ <> po3l^) and (po4^ <> po3u^) do begin
    inc(po4);
   end;
   po1l:= po3l;
   po1u:= po3u;
   po2:= po4;
   while (po1l^ <> #0) and ((po1l^ = po2^) or (po1u^ = po2^)) do begin
    inc(po1l);
    inc(po1u);
    inc(po2);
   end;
   if po1l^ = #0 then begin
    result:= po4 - pmsechar(s) + 1;
    exit;
   end;
   inc(po4);
  until po2^ = #0;
 end;
 result:= 0;
end;


function msetextpos(const substr: msestring; const s: msestring): integer;
                     //substr has to be uppercase
begin
 result:= msetextpos1(mseuppercase(substr),mseuppercase(substr),s);
end;
}

function charuppercase(const c: char): char;
begin
 result:= upperchars[c];
end;

function charuppercase(const c: msechar): msechar;
begin
 if c < #$100 then begin
  result:= msechar(byte(upperchars[char(byte(c))]));
 end
 else begin
  result:= c;
 end;
end;

function struppercase(const s: string): string; overload;
var
 int1,int2: integer;
begin
 int1:= length(s);
 setlength(result,int1);
 for int2:= int1 - 1 downto 0 do begin
  pcharaty(result)^[int2]:= upperchars[pcharaty(s)^[int2]];
 end;
end;

function struppercase(const s: msestring): msestring; overload;
var
 ch1: msechar;
 int1: integer;
 po1,po2: pmsecharaty;
begin
 setlength(result,length(s));
 po1:= pointer(s);
 po2:= pointer(result);
 for int1:= length(s) - 1 downto 0 do begin
  ch1:= po1^[int1];
  if (ch1 >= 'a') and (ch1 <= 'z') then begin
   inc(ch1,ord('A') - ord('a'));
  end;
  po2^[int1]:= ch1;
 end;
end;

procedure struppercase1(var s: msestring); overload;
var
 ch1: msechar;
 int1: integer;
 po1: pmsecharaty;
begin
 po1:= pointer(s);
 for int1:= 0 to length(s) - 1 do begin
  ch1:= po1^[int1];
  if (ch1 >= 'a') and (ch1 <= 'z') then begin
   inc(ch1,ord('A') - ord('a'));
  end;
  po1^[int1]:= ch1;
 end;
end;

function struppercase(const s: lmsestringty): msestring; overload;
var
 Ch1: msechar;
 int1: Integer;
 Source, Dest: Pmsechar;
begin
 int1:= s.len;
 setlength(result,int1);
 Source := s.po;
 Dest := Pointer(Result);
 while int1 > 0 do begin
  Ch1 := Source^;
  if (Ch1 >= 'a') and (Ch1 <= 'z') then Dec(Ch1, 32);
  Dest^ := Ch1;
  Inc(Source);
  Inc(Dest);
  Dec(int1);
 end;
end;

function struppercase(const s: lstringty): string; overload;
var
 int1: integer;
begin
 setlength(result,s.len);
 for int1:= 0 to s.len - 1 do begin
  pcharaty(result)^[int1]:= upperchars[pcharaty(s.po)^[int1]];
 end;
end;

function charlowercase(const c: char): char;
begin
 result:= lowerchars[c];
end;

function charlowercase(const c: msechar): msechar;
begin
 if ord(c) < $100 then begin
  result:= msechar(lowerchars[char(c)]);
 end
 else begin
  result:= c;
 end;
end;

function strlowercase(const s: string): string; overload;
var
 int1,int2: integer;
begin
 int1:= length(s);
 setlength(result,int1);
 for int2:= int1 - 1 downto 0 do begin
  pcharaty(result)^[int2]:= lowerchars[pcharaty(s)^[int2]];
 end;
end;

function strlowercase(const s: msestring): msestring; overload;
var
 ch1: msechar;
 int1: integer;
 po1,po2: pmsecharaty;
begin
 setlength(result,length(s));
 po1:= pointer(s);
 po2:= pointer(result);
 for int1:= length(s) - 1 downto 0 do begin
  ch1:= po1^[int1];
  if (ch1 >= 'A') and (ch1 <= 'Z') then begin
   inc(ch1,ord('a') - ord('A'));
  end;
  po2^[int1]:= ch1;
 end;
end;

procedure strlowercase1(var s: msestring); overload;
var
 ch1: msechar;
 int1: integer;
 po1: pmsecharaty;
begin
 po1:= pointer(s);
 for int1:= 0 to length(s) - 1 do begin
  ch1:= po1^[int1];
  if (ch1 >= 'A') and (ch1 <= 'Z') then begin
   inc(ch1,ord('a') - ord('A'));
  end;
  po1^[int1]:= ch1;
 end;
end;

function strlowercase(const s: lmsestringty): msestring; overload;
var
 Ch1: msechar;
 int1: Integer;
 Source, Dest: Pmsechar;
begin
 int1:= s.len;
 setlength(result,int1);
 Source := s.po;
 Dest := Pointer(Result);
 while int1 > 0 do begin
  Ch1 := Source^;
  if (Ch1 >= 'A') and (Ch1 <= 'Z') then Dec(Ch1, 32);
  Dest^ := Ch1;
  Inc(Source);
  Inc(Dest);
  Dec(int1);
 end;
end;

function strlowercase(const s: lstringty): string; overload;
var
 int1: integer;
begin
 setlength(result,s.len);
 for int1:= 0 to s.len - 1 do begin
  pcharaty(result)^[int1]:= lowerchars[pcharaty(s.po)^[int1]];
 end;
end;

function lstringtostring(const value: lmsestringty): msestring; overload;
begin
 setlength(result,value.len);
 move(value.po^,result[1],value.len*sizeof(msechar));
end;

function lstringtostring(const value: pmsechar;
                                    const len: integer): msestring; overload;
begin
 setlength(result,len);
 move(value^,result[1],len*sizeof(msechar));
end;

function lstringtostring(const value: lstringty): string; overload;
begin
 setlength(result,value.len);
 move(value.po^,result[1],value.len*sizeof(char));
end;

function lstringtostring(const value: pchar;
                                    const len: integer): string; overload;
begin
 setlength(result,len);
 move(value^,result[1],len*sizeof(char));
end;

procedure stringtolstring(const value: string; var{out} res: lstringty);
begin
 res.po:= pointer(value);
 res.len:= length(value);
end;

procedure stringtolstring(const value: msestring; var{out} res: lmsestringty);
                                                              inline;
begin
 res.po:= pointer(value);
 res.len:= length(value);
end;

function stringtolstring(const value: string): lstringty; inline;
begin
 result.po:= pointer(value);
 result.len:= length(value);
end;

function stringtolstring(const value: msestring): lmsestringty; inline;
begin
 result.po:= pointer(value);
 result.len:= length(value);
end;

function lstringartostringar(const value: lstringarty): stringarty;
var
 int1: integer;
begin
 setlength(result,length(value));
 for int1:= 0 to high(value) do begin
  with value[int1] do begin
   setstring(result[int1],po,len);
  end;
 end;
end;

procedure nextword(const value: msestring; out res: lmsestringty); overload;
var
 po1: pmsechar;
begin
 res.po:= msestrlscan(pointer(value),' ',length(value));
 res.len:= length(value)-(res.po-pointer(value));
 po1:= msestrlnscan(res.po,' ',res.len);
 if po1 <> nil then begin
  res.len:= po1-res.po;
 end;
end;

procedure nextword(const value: string; out res: lstringty); overload;
var
 po1: pchar;
begin
 res.po:= strlnscan(pointer(value),' ',length(value));
 res.len:= length(value)-(res.po-pointer(value));
 po1:= strlscan(res.po,' ',res.len);
 if po1 <> nil then begin
  res.len:= po1-res.po;
 end;
end;

procedure nextword(var value: lmsestringty; out res: lmsestringty); overload;
var
 po1: pmsechar;
 int1: integer;
begin
 res.po:= msestrlnscan(value.po,' ',value.len);
 if res.po = nil then begin
  int1:= value.len;
 end
 else begin
  int1:= res.po-value.po;
 end;
 res.len:= value.len-int1;
 po1:= msestrlscan(res.po,' ',res.len);
 if po1 <> nil then begin
  res.len:= po1-res.po;
 end;
 int1:= int1 + res.len;
 inc(value.po,int1);
 dec(value.len,int1);
end;

procedure nextword(var value: lstringty; out res: lstringty); overload;
var
 po1: pchar;
 int1: integer;
begin
 res.po:= strlnscan(value.po,' ',value.len);
 if res.po = nil then begin
  int1:= value.len;
 end
 else begin
  int1:= res.po-value.po;
 end;
 res.len:= value.len-int1;
 po1:= strlscan(res.po,' ',res.len);
 if po1 <> nil then begin
  res.len:= po1-res.po;
 end;
 int1:= int1 + res.len;
 inc(value.po,int1);
 dec(value.len,int1);
end;

procedure nextword(var value: lstringty; out res: string); overload;
var
 lstr1: lstringty;
begin
 nextword(value,lstr1);
 setstring(res,lstr1.po,lstr1.len);
end;

function nextword(var start: pchar): string;
var
 po1,po2: pchar;
begin
 po1:= start;
 while (po1^ = ' ') and (po1^ <> #0) do begin
  inc(po1);
 end;
 po2:= po1;
 while (po2^ <> ' ') and (po2^ <> #0) do begin
  inc(po2);
 end;
 setlength(result,po2-po1);
 move(po1^,pchar(pointer(result))^,pchar(pointer(po2))-pchar(pointer(po1)));
 start:= po2;
end;

function nextword(var start: pmsechar): msestring;
var
 po1,po2: pmsechar;
begin
 po1:= start;
 while (po1^ = ' ') and (po1^ <> #0) do begin
  inc(po1);
 end;
 po2:= po1;
 while (po2^ <> ' ') and (po2^ <> #0) do begin
  inc(po2);
 end;
 setlength(result,po2-po1);
 move(po1^,pmsechar(pointer(result))^,pchar(pointer(po2))-pchar(pointer(po1)));
 start:= po2;
end;

procedure lstringgoback(var value: lstringty; const res: lstringty);
begin
 dec(value.po,res.len);
 inc(value.len,res.len);
end;

function nextquotedstring(var value: lstringty; out res: string): boolean;
var
 po1: pchar;
 int1,int2,int3: integer;
begin
 result:= false;
 res:= '';
 po1:= strlnscan(value.po,' ',value.len);
 if po1 = nil then begin
  int1:= value.len;
 end
 else begin
  int1:= po1-value.po;
 end;
 if (po1 <> nil) and (po1^ = '''') then begin
  result:= true;
  inc(po1);
  int2:= 0;
  int3:= value.len-int1;
  setlength(res,int3); //maximum
  while po1^ <> #0 do begin
   if po1^ <> '''' then begin
    inc(int2);
    res[int2]:= po1^;
   end
   else begin
    inc(po1);
    if po1^ = '''' then begin
     inc(int2);
     res[int2]:= po1^;
    end
    else begin
     break;
    end;
   end;
   inc(po1);
  end;
  setlength(res,int2);
  int1:= po1-value.po;
 end;
 inc(value.po,int1);
 dec(value.len,int1);
end;

function shrinkpathellipse(var value: msestring): boolean;
const
 ellipsis = '...' + pathdelim;
var
 po1,po2: pmsechar;
 int1,int2: integer;
begin
 result:= false;
 int1:= pos(ellipsis,value);
 if int1 = 0 then begin
  int1:= pos(pathdelim,value);
  if int1 > 0 then begin
   inc(int1);                //ellipsenstart
   int2:= int1;              //ellipsenend;
  end
  else exit;         //shrink unmoeglich
 end
 else begin
  int2:= int1 + length(ellipsis);
 end;
 po1:= @value[int2]; //ende ellipse
 po2:= msestrlscan(po1,pathdelim,length(value)-int2);
 if po2 <> nil then begin
  inc(po2);
  value:= copy(value,1,int1-1) + ellipsis + copy(value,int2 + (po2-po1),bigint);
  result:= true;
 end;
end;

function shrinkstring(const value: msestring; maxcharcount: integer): msestring;
begin
 result:= value;
 repeat
 until (length(result) <= maxcharcount) or not shrinkpathellipse(result);
end;

procedure extendstring(var value: string; const mincharcount: integer);
var
 int1: integer;
begin
 int1:= length(value);
 if int1 < mincharcount then begin
  setlength(value,mincharcount);
  for int1:= int1 to mincharcount do begin
   pchar(pointer(value))[int1]:= ' ';
  end;
 end;
end;

procedure extendstring(var value: msestring; const mincharcount: integer);
var
 int1: integer;
begin
 int1:= length(value);
 if int1 < mincharcount then begin
  setlength(value,mincharcount);
  for int1:= int1 to mincharcount do begin
   pmsechar(pointer(value))[int1]:= ' ';
  end;
 end;
end;

function checkfirstchar(const value: string; achar: char): pchar;
           //nil wenn erster char nicht space <> achar, ^achar sonst
begin
 result:= strlnscan(pointer(value),' ',length(value));
 if result <> nil then begin
  if result^ <> achar then begin
   result:= nil;
  end;
 end;
end;

function lastline(const atext: msestring): msestring;
var
 po1: pmsechar;
 int1: integer;
begin
 po1:= msestrlrscan(pmsechar(atext),c_linefeed,length(atext));
 if po1 = nil then begin
  result:= atext;
 end
 else begin
  inc(po1);
  int1:= length(atext)-(po1-pmsechar(pointer(atext)));
  setlength(result,int1);
  move(po1^,pointer(result)^,int1*sizeof(msechar));
//  result:= po1;
 end;
end;

function firstline(const atext: msestring): msestring;
var
 po1: pmsechar;
begin
 if atext <> '' then begin
  po1:= pointer(atext);
  while (po1^ <> c_linefeed) and (po1^ <> #0) do begin
   inc(po1);
  end;
  if (po1 > pointer(atext)) and ((po1-1)^ = c_return) then begin
   dec(po1);
  end;
  result:= psubstr(pmsechar(pointer(atext)),po1);
 end
 else begin
  result:= '';
 end;
end;
{
function firstline(atext: msestring): msestring;
var
 po1: pmsechar;
begin
 po1:= msestrlscan(pmsechar(atext),c_linefeed,length(atext));
 if po1 = nil then begin
  result:= atext;
 end
 else begin
  dec(po1);
  if po1 >= @atext[1] then begin
   if po1^ <> c_return then begin
    inc(po1);
   end;
  end
  else begin
   inc(po1);
  end;
  setlength(result,po1-pmsechar(@atext[1]));
  move(po1^,result[1],length(result)*sizeof(result[1]));
 end;
end;
}
procedure textdim(const atext: msestring; out firstx,lastx,y: integer);
begin
 Y:= countchars(atext,c_linefeed);
 if Y = 0 then begin
  firstx:= length(atext);
  lastx:= firstx;
 end
 else begin
  lastx:= length(lastline(atext));
  firstx:= length(firstline(atext));
 end;
end;

function encodesearchoptions(const caseinsensitive: boolean = false;
                        const wholeword: boolean = false;
                        const wordstart: boolean = false;
                        const backward: boolean = false): searchoptionsty;
begin
 result:= [];
 if caseinsensitive then include(result,so_caseinsensitive);
 if wholeword then include(result,so_wholeword);
 if wordstart then include(result,so_wordstart);
 if backward then include(result,so_backward);
end;

function quotestring(value: string; quotechar: char;
                         const force: boolean = true;
                         const separator: char = ' '): string; overload;
var
 ps,pd,pe: pchar;
begin
 if force or (findchar(value,quotechar) > 0) or
               (separator <> #0) and (findchar(value,separator) > 0)then begin
  setlength(result,length(value)*2+2); //max
  pd:= pchar(pointer(result));
  pd^:= quotechar;
  inc(pd);
  if value <> '' then begin
   ps:= pchar(pointer(value));
   pe:= ps+length(value);
   while ps < pe do begin
    pd^:= ps^;
    inc(pd);
    if ps^ = quotechar then begin
     pd^:= quotechar;
     inc(pd);
    end;
    inc(ps);
   end;
  end;
  pd^:= quotechar;
  inc(pd);
  setlength(result,pd-pchar(pointer(result)));
 end
 else begin
  result:= value;
 end;
end;

function quotestring(value: msestring; quotechar: msechar;
                      const force: boolean = true;
                      const separator: msechar = ' '): msestring; overload;
var
 ps,pd,pe: pmsechar;
begin
 if force or (findchar(value,quotechar) > 0) or
              (separator <> #0) and (findchar(value,separator) > 0) then begin
  setlength(result,length(value)*2+2); //max
  pd:= pmsechar(pointer(result));
  pd^:= quotechar;
  inc(pd);
  if value <> '' then begin
   ps:= pmsechar(pointer(value));
   pe:= ps+length(value);
   while ps < pe do begin
    pd^:= ps^;
    inc(pd);
    if ps^ = quotechar then begin
     pd^:= quotechar;
     inc(pd);
    end;
    inc(ps);
   end;
  end;
  pd^:= quotechar;
  inc(pd);
  setlength(result,pd-pmsechar(pointer(result)));
 end
 else begin
  result:= value;
 end;
end;

function unquotestring(value: string; quotechar: char): string; overload;
var
 ps,pd,pe: pchar;
begin
 result:= value;
 if (value <> '') and (value[1] = quotechar) then begin
  ps:= pchar(pointer(value));
  pe:= ps + length(value);
  setlength(result,length(value)); //unique, max
  pd:= pchar(pointer(result));
  while ps < pe do begin
   if ps^ = quotechar then begin
    inc(ps);
   end;
   pd^:= ps^;
   inc(ps);
   inc(pd);
  end;
  if ps > pe then begin
   dec(pd); //remove trailing quote
  end;
  setlength(result,pd-pchar(pointer(result)));
 end;
end;

function unquotestring(value: msestring;
                                       quotechar: msechar): msestring;
var
 ps,pd,pe: pmsechar;
begin
 result:= value;
 if (value <> '') and (value[1] = quotechar) then begin
  ps:= pmsechar(pointer(value));
  pe:= ps + length(value);
  setlength(result,length(value)); //unique, max
  pd:= pmsechar(pointer(result));
  while ps < pe do begin
   if ps^ = quotechar then begin
    inc(ps);
   end;
   pd^:= ps^;
   inc(ps);
   inc(pd);
  end;
  if ps > pe then begin
   dec(pd); //remove trailing quote
  end;
  setlength(result,pd-pmsechar(pointer(result)));
 end;
end;


const
 escapechar = '\';

function quoteescapedstring(value: string; quotechar: char;
                                      const force: boolean = true;
                                      const separator: char = ' '): string;
var
 ps,pd,pe: pchar;
begin
 if force or (findchar(value,quotechar) > 0) or
          (separator <> #0) and (findchar(value,separator) > 0) then begin
  setlength(result,length(value)*2+2); //max
  pd:= pchar(pointer(result));
  pd^:= quotechar;
  inc(pd);
  if value <> '' then begin
   ps:= pchar(pointer(value));
   pe:= ps+length(value);
   while ps < pe do begin
    pd^:= ps^;
    if ps^ = quotechar then begin
     pd^:= escapechar;
     inc(pd);
     pd^:= quotechar;
    end;
    if ps^ = escapechar then begin
     inc(pd);
     pd^:= escapechar;
    end;
    inc(pd);
    inc(ps);
   end;
  end;
  pd^:= quotechar;
  inc(pd);
  setlength(result,pd-pchar(pointer(result)));
 end
 else begin
  result:= value;
 end;
end;

function quoteescapedstring(value: msestring; quotechar: msechar;
                                  const force: boolean = true;
                                  const separator: msechar = ' '): msestring;
var
 ps,pd,pe: pmsechar;
begin
 if force or (findchar(value,quotechar) > 0) or
           (separator <> #0) and (findchar(value,separator) > 0) then begin
  setlength(result,length(value)*2+2); //max
  pd:= pmsechar(pointer(result));
  pd^:= quotechar;
  inc(pd);
  if value <> '' then begin
   ps:= pmsechar(pointer(value));
   pe:= ps+length(value);
   while ps < pe do begin
    pd^:= ps^;
    if ps^ = quotechar then begin
     pd^:= escapechar;
     inc(pd);
     pd^:= quotechar;
    end;
    if ps^ = escapechar then begin
     inc(pd);
     pd^:= escapechar;
    end;
    inc(pd);
    inc(ps);
   end;
  end;
  pd^:= quotechar;
  inc(pd);
  setlength(result,pd-pmsechar(pointer(result)));
 end
 else begin
  result:= value;
 end;
end;

function extractquotedstr(const value: msestring): msestring;
                //entfernt vorhandene paare ' und "
begin
 if (value <> '') and ((value[1] = '"') or (value[1] = '''')) then begin
  result:= unquotestring(value,value[1]);
 end
 else begin
  result:= value;
 end;
end;

function lineatindex(const value: msestring; const index: int32): msestring;
var
 po1,po2,ps,pe: pmsechar;
begin
 if value <> '' then begin
  ps:= pointer(value);
  pe:= ps + length(value);
  po1:= ps + index;
  po2:= po1;
  if (po1^ = c_linefeed) and (po1 > ps) then begin
   dec(po1);
  end;
  if (po1^ = c_return) and (po1 > ps) then begin
   dec(po1);
  end;
  while (po1^ <> c_linefeed) and (po1 > ps) do begin
   dec(po1);
  end;
  if po1^ = c_linefeed then begin
   inc(po1);
  end;
  while not ((po2^ = c_return) or (po2^ = c_linefeed)) and (po2 < pe) do begin
   inc(po2);
  end;
  result:= psubstr(po1,po2);
 end
 else begin
  result:= '';
 end;
end;

procedure wordatindex(const value: msestring; const index: integer;
                          out first,pastlast: pmsechar;
                     const delimchars: msestring;
                     const nodelimstrings:  array of msestring);

 function checkdelimchars(achar: msechar): boolean;
 var
  po1: pmsechar;
 begin
  po1:= pmsechar(delimchars);
  result:= false;
  while po1^ <> #0 do begin
   if po1^ = achar then begin
    result:= true;
    break;
   end;
   inc(po1);
  end;
 end;

 function checknodelimstringsdown(var po1: pmsechar; var int1: integer): boolean;
 var
  {bo1,}bo2: boolean;
  int2,int3,int4: integer;
  po2: pmsechar;
 begin
  result:= true;
  for int2:= high(nodelimstrings) downto 0 do begin
   po2:= po1;
   int4:= length(nodelimstrings[int2])-1;
   int3:= int1 - int4;
   if int3 >= 0 then begin
    bo2:= true;
    for int3:= int4 downto 0 do begin
     if (pmsechar(pointer(nodelimstrings[int2]))+int3)^ <> po2^ then begin
      bo2:= false;
      break;
     end;
     dec(po2);
    end;
    if bo2 then begin
     inc(po2);
     result:= false;
     int1:= int1 - (po1 - po2);
     po1:= po2;
     break;
    end;
   end;
  end;
 end;

 function checknodelimstringsup(var po1: pmsechar; var int3: integer): boolean;
 var
  int1,int2: integer;
  bo1: boolean;
  po2: pmsechar;
 begin
  result:= true;
  for int2:= high(nodelimstrings) downto 0 do begin
   bo1:= true;
   po2:= po1;
   for int1:= 0 to length(nodelimstrings[int2]) - 1 do begin
    if po2^ <> (pmsechar(pointer(nodelimstrings[int2]))+int1)^ then begin
     bo1:= false;
     break;
    end;
    inc(po2);
   end;
   if bo1 then begin
    dec(po2);
    int3:= int3 - (po1 - po2);
    po1:= po2;
    result:= false;
    break;
   end;
  end;
 end;

var
 int1: integer;
 po1: pmsechar;
// bo1{,bo2}: boolean;
begin
 first:= nil;
 pastlast:= nil;
 if (index >= 0) and (index < length(value)) then begin
  first:= pmsechar(pointer(value)) + index;
  po1:= first;
  int1:= index;
  while int1 >= 0 do begin
   if checkdelimchars(po1^) and checknodelimstringsdown(po1,int1) then begin
    if po1 = first then begin
     first:= nil;
     exit;
    end;
    break;
   end;
   dec(po1);
   dec(int1);
  end;
  pastlast:= first + 1;
  first:= po1 + 1;
  int1:= length(value) - index - 2;
  while int1 >= 0 do begin
   if checkdelimchars(pastlast^) and checknodelimstringsup(pastlast,int1) then begin
    break;
   end;
   inc(pastlast);
   dec(int1);
  end;
 end;
end;

function wordatindex(const value: msestring; const index: integer;
            const delimchars: msestring;
            const nodelimstrings:  array of msestring): msestring;
var
 po1,po2: pmsechar;
begin
 wordatindex(value,index,po1,po2,delimchars,nodelimstrings);
 result:= copy(msestring(po1),1,po2-po1);
end;

function checkkeyword(const aname: string; const anames;
                                        const ahigh: integer): cardinal;
var
 int1: integer;
 po1: pchar;
begin
 result:= 0;
 po1:= pchar(pointer(aname));
 if po1 <> nil then begin
  for int1:= 1 to ahigh do begin
   if strcomp(po1,pchar(pointer(stringaty(anames)[int1]))) = 0 then begin
    result:= int1;
    break;
   end;
  end;
 end;
end;

function checkkeyword(const aname: msestring; const anames;
                                        const ahigh: integer): cardinal;
var
 int1: integer;
 po1: pmsechar;
begin
 result:= 0;
 po1:= pmsechar(pointer(aname));
 if po1 <> nil then begin
  for int1:= 1 to ahigh do begin
   if msestrcomp(po1,pmsechar(pointer(stringaty(anames)[int1]))) = 0 then begin
    result:= int1;
    break;
   end;
  end;
 end;
end;

function checkkeyword(const aname: pchar; const anames;
                                        const ahigh: integer): cardinal;
var
 int1: integer;
 po1: pchar;
begin
 result:= 0;
 po1:= aname;
 if po1 <> nil then begin
  for int1:= 1 to ahigh do begin
   if strcomp(po1,pchar(pointer(stringaty(anames)[int1]))) = 0 then begin
    result:= int1;
    break;
   end;
  end;
 end;
end;

function checkkeyword(const aname: pmsechar; const anames;
                                        const ahigh: integer): cardinal;
var
 int1: integer;
 po1: pmsechar;
begin
 result:= 0;
 po1:= aname;
 if po1 <> nil then begin
  for int1:= 1 to ahigh do begin
   if msestrcomp(po1,pmsechar(pointer(stringaty(anames)[int1]))) = 0 then begin
    result:= int1;
    break;
   end;
  end;
 end;
end;

//todo: optimise
function msestringsearch(const substring,s: msestring; start: integer;
                              const options: searchoptionsty;
                              const substringupcase: msestring = ''): integer;
var
 int1,int2: integer;
 ch1,ch2: msechar;
 str1,str2: msestring;
 opt1: searchoptionsty;
 slen,sublen: int32;

begin
 result:= 0;
 if (length(substring) = 0) or (length(s) = 0) then begin
  exit;
 end;
 sublen:= length(substring);
 slen:= length(s);
 if so_backward in options then begin //backward search
  if start <= 0 then begin
   exit;
  end;
  if start > slen then begin
   start:= slen;
  end;
  if options * [so_wholeword,so_wordstart] <> [] then begin
   opt1:= options - [so_wholeword,so_wordstart];
   result:= start;
   repeat
    result:= msestringsearch(substring,s,result,opt1,substringupcase);
    if result <> 0 then begin
     if (result = slen) or not isnamechar(s[result+1]) then begin
      if not (so_wholeword in options) then begin
       break; //so_wordstart
      end;
      if (result - length(substring) > 0) then begin
       break;
      end
      else begin
       if not isnamechar(s[result - length(substring)]) then begin
        break; //io
       end
       else begin
        dec(result); //kein ganzes wort
       end;
      end;
     end
     else begin
      dec(result);
     end;
    end
    else begin
     break;
    end;
   until result < 1;
   if result < 1 then begin
    result:= 0;
   end;
  end
  else begin
   if so_caseinsensitive in options then begin
    if substringupcase = '' then begin
     str1:= mseuppercase(substring);
     str2:= mselowercase(substring);
    end
    else begin
     str1:= substringupcase;
     str2:= substring;
    end;
    ch2:= str1[sublen];
    ch1:= str2[sublen];
    for int1:= start downto sublen do begin
     if (s[int1] = ch1) or (s[int1] = ch2) then begin
      result:= int1-sublen;
      for int2:= sublen downto 1 do begin
       if (s[result+int2] <> str1[int2]) and
              (s[result+int2] <> str2[int2]) then begin
        result:= -1;
        break;
       end;
      end;
      inc(result);
     end;
     if result <> 0 then begin
      result:= result+sublen-1;
      break;
     end;
    end
   end
   else begin
    ch1:= substring[sublen];      //casesensitive
    for int1:= start downto sublen do begin
     if s[int1] = ch1 then begin
      result:= int1-sublen;
      for int2:= sublen downto 1 do begin
       if s[result+int2] <> substring[int2] then begin
        result:= -1;
        break;
       end;
      end;
      inc(result);
     end;
     if result <> 0 then begin
      result:= result+sublen-1;
      break;
     end;
    end
   end;
  end;
 end
 else begin //not backward
  if options * [so_wholeword,so_wordstart] <> [] then begin
   opt1:= options - [so_wholeword,so_wordstart];
   result:= start;
   repeat
    result:= msestringsearch(substring,s,result,opt1,substringupcase);
    if result <> 0 then begin
     if (result = 1) or not isnamechar(s[result-1]) then begin
      if not (so_wholeword in options) then begin
       break; //so_wordstart
      end;
      if result + sublen > slen then begin
       break;
      end
      else begin
       if not isnamechar(s[result + sublen]) then begin
        break; //io
       end
       else begin
        inc(result); //kein ganzes wort
       end;
      end;
     end
     else begin
      inc(result);
     end;
    end
    else begin
     break;
    end;
   until result > slen;
   if result > slen then begin
    result:= 0;
   end;
  end
  else begin
   if so_caseinsensitive in options then begin
    if substringupcase = '' then begin
     str1:= mseuppercase(substring);
     str2:= mselowercase(substring);
    end
    else begin
     str1:= substringupcase;
     str2:= substring;
    end;
    ch2:= str1[1];
    ch1:= str2[1];
    for int1:= start to slen do begin
     if (s[int1] = ch1) or (s[int1] = ch2) then begin
      result:= int1-1;
      for int2:= 1 to sublen do begin
       if (s[result+int2] <> str1[int2]) and
              (s[result+int2] <> str2[int2]) then begin
        result:= -1;
        break;
       end;
      end;
      inc(result);
     end;
     if result <> 0 then begin
      break;
     end;
    end
   end
   else begin
    ch1:= substring[1];
    for int1:= start to slen do begin
     if s[int1] = ch1 then begin
      result:= int1-1;
      for int2:= 1 to sublen do begin
       if s[result+int2] <> substring[int2] then begin
        result:= -1;
        break;
       end;
      end;
      inc(result);
     end;
     if result <> 0 then begin
      break;
     end;
    end
   end;
  end;
 end; //not backward
end;

//todo: optimise
function stringsearch(const substring,s: ansistring; start: integer;
                              const options: searchoptionsty;
                              const substringupcase: ansistring = ''): integer;
var
 int1,int2: integer;
 ch1,ch2: char;
 str1,str2: ansistring;
 opt1: searchoptionsty;
 slen,sublen: int32;

begin
 result:= 0;
 if (length(substring) = 0) or (length(s) = 0) then begin
  exit;
 end;
 sublen:= length(substring);
 slen:= length(s);
 if so_backward in options then begin //backward search
  if start <= 0 then begin
   exit;
  end;
  if start > slen then begin
   start:= slen;
  end;
  if options * [so_wholeword,so_wordstart] <> [] then begin
   opt1:= options - [so_wholeword,so_wordstart];
   result:= start;
   repeat
    result:= stringsearch(substring,s,result,opt1,substringupcase);
    if result <> 0 then begin
     if (result = slen) or not isnamechar(s[result+1]) then begin
      if not (so_wholeword in options) then begin
       break; //so_wordstart
      end;
      if (result - length(substring) > 0) then begin
       break;
      end
      else begin
       if not isnamechar(s[result - length(substring)]) then begin
        break; //io
       end
       else begin
        dec(result); //kein ganzes wort
       end;
      end;
     end
     else begin
      dec(result);
     end;
    end
    else begin
     break;
    end;
   until result < 1;
   if result < 1 then begin
    result:= 0;
   end;
  end
  else begin
   if so_caseinsensitive in options then begin
    if substringupcase = '' then begin
     str1:= uppercase(substring);
     str2:= lowercase(substring);
    end
    else begin
     str1:= substringupcase;
     str2:= substring;
    end;
    ch2:= str1[sublen];
    ch1:= str2[sublen];
    for int1:= start downto sublen do begin
     if (s[int1] = ch1) or (s[int1] = ch2) then begin
      result:= int1-sublen;
      for int2:= sublen downto 1 do begin
       if (s[result+int2] <> str1[int2]) and
              (s[result+int2] <> str2[int2]) then begin
        result:= -1;
        break;
       end;
      end;
      inc(result);
     end;
     if result <> 0 then begin
      result:= result+sublen-1;
      break;
     end;
    end
   end
   else begin
    ch1:= substring[sublen];      //casesensitive
    for int1:= start downto sublen do begin
     if s[int1] = ch1 then begin
      result:= int1-sublen;
      for int2:= sublen downto 1 do begin
       if s[result+int2] <> substring[int2] then begin
        result:= -1;
        break;
       end;
      end;
      inc(result);
     end;
     if result <> 0 then begin
      result:= result+sublen-1;
      break;
     end;
    end
   end;
  end;
 end
 else begin //not backward
  if options * [so_wholeword,so_wordstart] <> [] then begin
   opt1:= options - [so_wholeword,so_wordstart];
   result:= start;
   repeat
    result:= stringsearch(substring,s,result,opt1,substringupcase);
    if result <> 0 then begin
     if (result = 1) or not isnamechar(s[result-1]) then begin
      if not (so_wholeword in options) then begin
       break; //so_wordstart
      end;
      if result + sublen > slen then begin
       break;
      end
      else begin
       if not isnamechar(s[result + sublen]) then begin
        break; //io
       end
       else begin
        inc(result); //kein ganzes wort
       end;
      end;
     end
     else begin
      inc(result);
     end;
    end
    else begin
     break;
    end;
   until result > slen;
   if result > slen then begin
    result:= 0;
   end;
  end
  else begin
   if so_caseinsensitive in options then begin
    if substringupcase = '' then begin
     str1:= uppercase(substring);
     str2:= lowercase(substring);
    end
    else begin
     str1:= substringupcase;
     str2:= substring;
    end;
    ch2:= str1[1];
    ch1:= str2[1];
    for int1:= start to slen do begin
     if (s[int1] = ch1) or (s[int1] = ch2) then begin
      result:= int1-1;
      for int2:= 1 to sublen do begin
       if (s[result+int2] <> str1[int2]) and
              (s[result+int2] <> str2[int2]) then begin
        result:= -1;
        break;
       end;
      end;
      inc(result);
     end;
     if result <> 0 then begin
      break;
     end;
    end
   end
   else begin
    ch1:= substring[1];
    for int1:= start to slen do begin
     if s[int1] = ch1 then begin
      result:= int1-1;
      for int2:= 1 to sublen do begin
       if s[result+int2] <> substring[int2] then begin
        result:= -1;
        break;
       end;
      end;
      inc(result);
     end;
     if result <> 0 then begin
      break;
     end;
    end
   end;
  end;
 end; //not backward
end;

function replacestring(const s: msestring; oldsub: msestring;
                           const newsub: msestring;
                           const options: searchoptionsty = []): msestring;
var
 po1,po2,po3,poend: pmsechar;
// pold: pmsechar;
 oldhigh,newhigh: integer;
 int1,int2: integer;
 ch1: msechar;
 bo1,bo2,bo3: boolean;
 s1: msestring;
begin
 int1:= length(s);
 if (int1 = 0) or (length(oldsub) = 0) then begin
  result:= s;
  exit;
 end;
 oldhigh:= length(oldsub)-1;
 newhigh:= length(newsub)-1;
 po1:= pointer(s);
 poend:= po1;
 if so_caseinsensitive in options then begin
  s1:= mseuppercase(s);
  po3:= pointer(s1);
  oldsub:= mseuppercase(oldsub);
 end
 else begin
  po3:= po1;
 end;
 inc(poend,int1-oldhigh);
 if length(newsub) > length(oldsub) then begin
  int1:= (int1 div length(oldsub) + 1) * length(newsub);
 end;
 setlength(result,int1); //max
 po2:= pointer(result);
 ch1:= oldsub[1];
 bo2:= options*[so_wholeword,so_wordstart] = [];
 bo3:= not (so_wholeword in options);
 while po1 < poend do begin
  bo1:= po3^ = ch1;
  if bo1 then begin
   for int2:= 0 to oldhigh do begin
    if (po3+int2)^ <> (pmsechar(pointer(oldsub))+int2)^ then begin
     bo1:= false;
     break;
    end;
   end;
   bo1:= bo1 and (bo2 or
             (bo3 or not isnamechar((po1+length(oldsub))^)) and
              ((po1=pointer(s)) or not isnamechar((po1-1)^)));
   if bo1 then begin
    for int2:= 0 to newhigh do begin
     po2^:= (pmsechar(pointer(newsub))+int2)^;
     inc(po2);
    end;
    inc(po1,oldhigh);
    inc(po3,oldhigh);
    dec(po2);
   end
   else begin
    po2^:= po1^;
   end;
  end
  else begin
   po2^:= po1^;
  end;
  inc(po1);
  inc(po2);
  inc(po3);
 end;
 inc(poend,oldhigh);
 while po1 < poend do begin
  po2^:= po1^;
  inc(po1);
  inc(po2);
 end;
 setlength(result,po2 - pmsechar(pointer(result)));
end;

function replacestring(const s: string; oldsub: string;
                           const newsub: string;
                           const options: searchoptionsty = []): string;
var
 po1,po2,po3,poend: pchar;
// pold: pchar;
 oldhigh,newhigh: integer;
 int1,int2: integer;
 ch1: char;
 bo1,bo2,bo3: boolean;
 s1: string;
begin
 int1:= length(s);
 if (int1 = 0) or (length(oldsub) = 0) then begin
  result:= s;
  exit;
 end;
 oldhigh:= length(oldsub)-1;
 newhigh:= length(newsub)-1;
 po1:= pointer(s);
 poend:= po1;
 if so_caseinsensitive in options then begin
  s1:= uppercase(s);
  po3:= pointer(s1);
  oldsub:= uppercase(oldsub);
 end
 else begin
  po3:= po1;
 end;
 inc(poend,int1-oldhigh);
 if length(newsub) > length(oldsub) then begin
  int1:= (int1 div length(oldsub) + 1) * length(newsub);
 end;
 setlength(result,int1); //max
 po2:= pointer(result);
 ch1:= oldsub[1];
 bo2:= options*[so_wholeword,so_wordstart] = [];
 bo3:= not (so_wholeword in options);
 while po1 < poend do begin
  bo1:= po3^ = ch1;
  if bo1 then begin
   for int2:= 0 to oldhigh do begin
    if (po3+int2)^ <> (pchar(pointer(oldsub))+int2)^ then begin
     bo1:= false;
     break;
    end;
   end;
   bo1:= bo1 and (bo2 or
             (bo3 or not isnamechar((po1+length(oldsub))^)) and
              ((po1=pointer(s)) or not isnamechar((po1-1)^)));
   if bo1 then begin
    for int2:= 0 to newhigh do begin
     po2^:= (pchar(pointer(newsub))+int2)^;
     inc(po2);
    end;
    inc(po1,oldhigh);
    inc(po3,oldhigh);
    dec(po2);
   end
   else begin
    po2^:= po1^;
   end;
  end
  else begin
   po2^:= po1^;
  end;
  inc(po1);
  inc(po2);
  inc(po3);
 end;
 inc(poend,oldhigh);
 while po1 < poend do begin
  po2^:= po1^;
  inc(po1);
  inc(po2);
 end;
 setlength(result,po2 - pchar(pointer(result)));
end;

function msePosEx(const SubStr, S: msestring; Offset: longword = 1): Integer;
//todo: optimize
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;

procedure reallocstring(var value: ansistring);
                //macht datenkopie ohne free
var
 po1: pointer;
 int1: sizeint;
begin
 po1:= pointer(value);
 if po1 <> nil then begin
  int1:= length(value);
  pointer(value):= nil;
  if int1 > 0 then begin
   setlength(value,int1);
   move(po1^,pointer(value)^,int1);
  end;
 end;
end;

procedure reallocstring(var value: msestring);
                //macht datenkopie ohne free
var
 po1: pointer;
 int1: sizeint;
begin
 po1:= pointer(value);
 if po1 <> nil then begin
  int1:= length(value);
  pointer(value):= nil;
  if int1 > 0 then begin
   setlength(value,int1);
   move(po1^,pointer(value)^,int1*sizeof(msechar));
  end;
 end;
end;

procedure reallocarray(var value; elementsize: integer); overload;
                //macht datenkopie ohne free
var
 po1,po2: ^sizeint;
 lwo1: longword;
begin
 if pointer(value) <> nil then begin
  lwo1:= length(bytearty(value))*elementsize + 2*sizeof(sizeint);
  getmem(po1,lwo1);
  po1^:= 1; //refcount
  inc(po1);
  po2:= pointer(value);
  dec(po2);
  move(po2^,po1^,lwo1-sizeof(sizeint)); //size+data
  inc(po1);
  pointer(value):= po1;
 end;
end;

procedure resizearray(var value; newlength, elementsize: integer);
var
 po1: ^sizeint;
 lwo1,lwo2: longword;
begin
 if pointer(value) <> nil then begin
  po1:= pointer(value);
  lwo1:= newlength*elementsize;
  if po1 <> nil then begin
   dec(po1);
   {$ifdef FPC}
   lwo2:= (po1^+1)*longword(elementsize);
   {$else}
   lwo2:= po1^*longword(elementsize);
   {$endif}
   dec(po1);
  end
  else begin
   lwo2:= 0;
  end;
  if lwo1 = 0 then begin
   dispose(po1);
   pointer(value):= nil;
  end
  else begin
   reallocmem(po1,lwo1 + 2*sizeof(sizeint));
   inc(po1);
   {$ifdef FPC}
   po1^:= newlength-1;
   {$else}
   po1^:= newlength;
   {$endif}
   inc(po1);
   pointer(value):= po1;
   if lwo1 > lwo2 then begin
    fillchar((pchar(po1)+lwo2)^,lwo1-lwo2,0);
   end;
  end;
 end;
end;

procedure removereturn(var avalue: msestring; var aindex: integer);
var
 s,d: pmsechar;
begin
 if avalue <> '' then begin
  s:= pmsechar(avalue);
  d:= s;
  while s^ <> #0 do begin
   if s^ <> msechar(c_return) then begin
    d^:= s^;
    inc(d);
   end
   else begin
    if d - pmsechar(pointer(avalue)) < aindex then begin
     dec(aindex);
    end;
   end;
   inc(s);
  end;
  setlength(avalue,d-pmsechar(pointer(avalue)));
  if aindex < 0 then begin
   aindex:= 0;
  end;
 end;
end;

procedure addeditchars(const source: msestring; var buffer: msestring;
                                  var cursorpos: integer);
                                  //cursorpos nullbased
var
 s,d: pmsechar;
 len1: integer;
 ch1: msechar;
 int1,int2: integer;
 i: integer;
 hasreturn: boolean;
begin
 hasreturn:= false;
 len1:= length(buffer);
 i:= cursorpos;
 if i > len1 then begin
  i:= len1;
 end;
 int1:= len1;
 int2:= cursorpos + length(source);
 if int1 < int2 then begin
  int1:= int2;
 end;
 setlength(buffer,int1); //refcount one
 s:= pmsechar(source);
 d:= pmsechar(buffer);
 while true do begin
  ch1:= s^;
  if ch1 = #0 then begin
   if s - pmsechar(pointer(source)) >= length(source) then begin
    break;
   end
   else begin
    ch1:= #$2400; //unicode null glyph
   end;
  end;
  case ch1 of
   c_backspace: begin
    if i > 0 then begin
     dec(i);
     dec(len1,2);
    end;
   end;
   c_return: begin
    i:= 0;
    hasreturn:= true;
   end;
   else begin
    (d+i)^:= ch1;
    inc(i);
    if i > len1 then begin
     len1:= i;
    end;
   end;
  end;
  inc(s);
 end;
 setlength(buffer,len1);
 if hasreturn then begin
  removereturn(buffer,i);
 end;
 cursorpos:= i;
end;

function processeditchars(var value: msestring; stripcontrolchars: boolean): integer;
               //bringt -anzahl rueckwaerts gefressene zeichen,
               // -grosse zahl bei c_return
var
 int1,int2,int3: integer;
 str1: msestring;
 ch1: msechar;
 hasreturn: boolean;
begin
 hasreturn:= false;
 setlength(str1,length(value));
 int2:= 0;
 int3:= 1;
 for int1:= 1 to length(value) do begin
  ch1:= value[int1];
  if ch1 = c_return then begin
   int2:= -bigint div 2;
   int3:= 1;
   hasreturn:= true;
  end
  else begin
   if ch1 = c_backspace then begin
    dec(int3);
    if int3 <= 0 then begin
     dec(int2);
     inc(int3);
    end;
   end
   else begin
    if ch1 = #0 then begin
     ch1:= #$2400; //unicode null glyph
    end;
    if not stripcontrolchars or (ord(ch1) >= ord(' ')) or (ch1 = c_tab) then begin
     (pmsechar(pointer(str1))+int3)^:= ch1;
     inc(int3);
    end;
   end;
  end;
 end;
 setlength(str1,int3-1);
 if hasreturn then begin
  int1:= -1;
  removereturn(str1,int1);
 end;
 result:= int2;
 value:= str1;
end;

function mseextractprintchars(const value: msestring): msestring;
var
 int1,int2: integer;
 ch1: msechar;
begin
 setlength(result,length(value));
 int2:= 0;
 for int1:= 1 to length(value) do begin
  ch1:= value[int1];
  if (ch1 >= ' ') and (ch1 <> c_delete) then begin
   pmsecharaty(pointer(result))^[int2]:= ch1;
   inc(int2);
  end;
 end;
 setlength(result,int2);
end;

function countchars(const str: string; achar: char): integer;
var
 int1: integer;
begin
 result:= 0;
 for int1:= 1 to length(str) do begin
  if str[int1] = achar then begin
   inc(result);
  end;
 end;
end;

function countchars(const str: msestring; achar: msechar): integer;
var
 int1: integer;
begin
 result:= 0;
 for int1:= 1 to length(str) do begin
  if str[int1] = achar then begin
   inc(result);
  end;
 end;
end;

function getcharpos(const str: msestring; achar: msechar): integerarty;
var
 count: integer;
 int1: integer;
begin
 result:= nil;
 count:= 0;
 for int1:= 1 to length(str) do begin
  if str[int1] = achar then begin
   additem(result,int1,count);
  end;
 end;
 setlength(result,count);
end;

function findchar(const str: string; achar: char): integer;
  //bringt index des ersten vorkommens von zeichen in string, 0 wenn nicht gefunden
var
 int1: integer;
begin
 result:= 0;
 for int1:= 1 to length(str) do begin
  if str[int1] = achar then begin
   result:= int1;
   exit;
  end;
 end;
end;

function findchar(const str: string; const astart: integer; achar: char): integer; overload;
var
 int1: integer;
begin
 result:= 0;
 for int1:= astart to length(str) do begin
  if str[int1] = achar then begin
   result:= int1;
   exit;
  end;
 end;
end;

function findchar(const str: msestring; achar: msechar): integer;
  //bringt index des ersten vorkommens von zeichen in string, 0 wenn nicht gefunden
var
 int1: integer;
begin
 result:= 0;
 for int1:= 1 to length(str) do begin
  if str[int1] = achar then begin
   result:= int1;
   exit;
  end;
 end;
end;

function findchar(const str: msestring; const astart: integer;
                                         achar: msechar): integer; overload;
var
 int1: integer;
begin
 result:= 0;
 for int1:= astart to length(str) do begin
  if str[int1] = achar then begin
   result:= int1;
   exit;
  end;
 end;
end;

function findchar(const str: pchar; achar: char): integer;
  //bringt erstes vorkommens von zeichen in string, 0 wenn nicht gefunden
var
 po1: pchar;
begin
 result:= 0;
 if str <> nil then begin
  po1:= str;
  while po1^ <> #0 do begin
   if po1^ = achar then begin
    result:= (po1-pchar(pointer(str)))+1;
    break;
   end;
   inc(po1);
  end;
 end;
end;

function findchar(const str: pmsechar; achar: msechar): integer;
  //bringt erstes vorkommens von zeichen in string, 0 wenn nicht gefunden
var
 po1: pmsechar;
begin
 result:= 0;
 if str <> nil then begin
  po1:= str;
  while po1^ <> #0 do begin
   if po1^ = achar then begin
    result:= (po1-pmsechar(pointer(str)))+1;
    break;
   end;
   inc(po1);
  end;
 end;
end;

function findchars(const str: string; const achars: string): integer;
  //bringt index des ersten vorkommens von zeichen in string, 0 wenn nicht gefunden
var
 int1: integer;
 po1: pchar;
begin
 result:= 0;
 po1:= pchar(str);
 while po1^ <> #0 do begin
  for int1:= 1 to length(achars) do begin
   if achars[int1] = po1^ then begin
    result:= po1-pchar(str)+1;
    exit;
   end;
  end;
  inc(po1);
 end;
end;

function findchars(const str: msestring; const achars: msestring): integer;
  //bringt index des ersten vorkommens von zeichen in string, 0 wenn nicht gefunden
var
 int1: integer;
 po1: pmsechar;
begin
 result:= 0;
 po1:= pmsechar(str);
 while po1^ <> #0 do begin
  for int1:= 1 to length(achars) do begin
   if achars[int1] = po1^ then begin
    result:= po1-pmsechar(str)+1;
    exit;
   end;
  end;
  inc(po1);
 end;
end;

function findlastchar(const str: string; achar: char): integer;
  //bringt index des letzten vorkommens von zeichen in string, 0 wenn nicht gefunden
var
 int1: integer;
begin
 result:= 0;
 for int1:= length(str) downto 1 do begin
  if str[int1] = achar then begin
   result:= int1;
   exit;
  end;
 end;
end;

function findlastchar(const str: msestring; achar: msechar): integer;
  //bringt index des letzten vorkommens von zeichen in string, 0 wenn nicht gefunden
var
 int1: integer;
begin
 result:= 0;
 for int1:= length(str) downto 1 do begin
  if str[int1] = achar then begin
   result:= int1;
   exit;
  end;
 end;
end;

procedure mseskipspace(var str: pmsechar); {$ifdef FPC}inline;{$endif}
begin
 while str^ = ' ' do begin
  inc(str);
 end;
end;

procedure skipspace(var str: pchar); {$ifdef FPC}inline;{$endif}
begin
 while str^ = ' ' do begin
  inc(str);
 end;
end;

function StrLScan(const Str: PChar; Chr: Char; len: integer): PChar;
var
 int1: integer;
 po1: pcharaty;
begin
 result:= nil;
 if str <> nil then begin
  po1:= pointer(str);
  for int1:= 0 to len - 1 do begin
   if po1^[int1] = chr then begin
    result:= @(po1^[int1]);
    break;
   end;
  end;
 end;
end;

function mseStrLScan(const Str: PmseChar; Chr: mseChar; len: integer): PmseChar;
var
 int1: integer;
 po1: pmsecharaty;
begin
 result:= nil;
 if str <> nil then begin
  po1:= pointer(str);
  for int1:= 0 to len - 1 do begin
   if po1^[int1] = chr then begin
    result:= @(po1^[int1]);
    break;
   end;
  end;
 end;
end;

function StrLNScan(const Str: PChar; Chr: Char; len: integer): PChar;
var
 int1: integer;
 po1: pcharaty;
begin
 result:= nil;
 if str <> nil then begin
  po1:= pointer(str);
  for int1:= 0 to len - 1 do begin
   if po1^[int1] <> chr then begin
    result:= @(po1^[int1]);
    break;
   end;
  end;
 end;
end;

function mseStrLNScan(const Str: PmseChar; Chr: mseChar; len: integer): PmseChar;
var
 int1: integer;
 po1: pmsecharaty;
begin
 result:= nil;
 if str <> nil then begin
  po1:= pointer(str);
  for int1:= 0 to len - 1 do begin
   if po1^[int1] <> chr then begin
    result:= @(po1^[int1]);
    break;
   end;
  end;
 end;
end;
{
function strscan(const str: string; chr: char): integer; overload;
var
 int1: integer;
begin
 result:= 0;
 for int1:= 1 to length(str) do begin
  if str[int1] = chr then begin
   result:= int1;
   break;
  end;
 end;
end;

function msestrscan(const str: msestring; chr: msechar): integer; overload;
var
 int1: integer;
begin
 result:= 0;
 for int1:= 1 to length(str) do begin
  if str[int1] = chr then begin
   result:= int1;
   break;
  end;
 end;
end;
}
function StrScan(const Str: PChar; Chr: Char): PChar;
var
 po1: pchar;
begin
 po1:= str;
 result:= nil;
 if po1 <> nil then begin
  while po1^ <> #0 do begin
   if po1^ = chr then begin
    result:= po1;
    break;
   end;
   inc(po1);
  end;
 end;
end;

function strscan(const str: lmsestringty; const chr: msechar): pmsechar; overload;
var
 int1: integer;
 po1: pmsechar;
begin
 po1:= str.po;
 for int1:= 0 to str.len-1 do begin
  if (po1+int1)^ = chr then begin
   result:= po1+int1;
   exit;
  end;
 end;
 result:= nil;
end;

function mseStrScan(const Str: PmseChar; Chr: mseChar): Pmsechar;
var
 po1: pmsechar;
begin
 po1:= str;
 result:= nil;
 if po1 <> nil then begin
  while po1^ <> #0 do begin
   if po1^ = chr then begin
    result:= po1;
    break;
   end;
   inc(po1);
  end;
 end;
end;

function StrNScan(const Str: PChar; Chr: Char): PChar;
var
 po1: pchar;
begin
 po1:= str;
 result:= nil;
 if po1 <> nil then begin
  while po1^ <> #0 do begin
   if po1^ <> chr then begin
    result:= po1;
    break;
   end;
   inc(po1);
  end;
 end;
end;

function mseStrNScan(const Str: PmseChar; Chr: mseChar): Pmsechar;
var
 po1: pmsechar;
begin
 po1:= str;
 result:= nil;
 if po1 <> nil then begin
  while po1^ <> #0 do begin
   if po1^ <> chr then begin
    result:= po1;
    break;
   end;
   inc(po1);
  end;
 end;
end;

function StrRScan(const Str: PChar; Chr: Char): PChar;
var
 po1: pchar;
begin
 po1:= str;
 result:= nil;
 if po1 <> nil then begin
  while po1^ <> #0 do begin
   inc(po1);
  end;
  while po1 > str do begin
   dec(po1);
   if po1^ = chr then begin
    result:= po1;
    break;
   end;
  end;
 end;
end;

function mseStrRScan(const Str: PmseChar; Chr: mseChar): PmseChar;
var
 po1: pmsechar;
begin
 po1:= str;
 result:= nil;
 if po1 <> nil then begin
  while po1^ <> #0 do begin
   inc(po1);
  end;
  while po1 > str do begin
   dec(po1);
   if po1^ = chr then begin
    result:= po1;
    break;
   end;
  end;
 end;
end;

function msestrrscan(const str: msestring; chr: msechar): integer;
var
 int1: integer;
begin
 result:= 0;
 for int1:= length(str) downto 1 do begin
  if str[int1] = chr then begin
   result:= int1;
   break;
  end;
 end;
end;

function StrLRScan(const Str: PChar; Chr: Char; len: integer): PChar;
var
 po1: pchar;
begin
 result:= nil;
 if str <> nil then begin
  po1:= str+len;
  while po1 > str do begin
   dec(po1);
   if po1^ = chr then begin
    result:= po1;
    break;
   end;
  end;
 end;
end;

function mseStrLRScan(const Str: PmseChar; Chr: mseChar; len: integer): PmseChar;
var
 po1: pmsechar;
begin
 result:= nil;
 if str <> nil then begin
  po1:= str+len;
  while po1 > str do begin
   dec(po1);
   if po1^ = chr then begin
    result:= po1;
    break;
   end;
  end;
 end;
end;

function mseStrLNRScan(const Str: PmseChar; Chr: mseChar; len: integer): PmseChar;
var
 po1: pmsechar;
begin
 result:= nil;
 if str <> nil then begin
  po1:= str+len;
  while po1 > str do begin
   dec(po1);
   if po1^ <> chr then begin
    result:= po1;
    break;
   end;
  end;
 end;
end;

function mseStrComp(const Str1, Str2: PmseChar): Integer;
var
 po1,po2: pmsechar;
 wo1: word;
begin
 po1:= str1;
 po2:= str2;
 if po1 <> po2 then begin
  repeat
   wo1:= word(po1^) - word(po2^);
   if po2^ = #0 then begin
    break;
   end;
   inc(po1);
   inc(po2);
  until (wo1 <> 0);
  result:= smallint(wo1);
 end
 else begin
  result:= 0;
 end;
end;

function StrLComp(const Str1, Str2: PChar; len: integer): Integer;
var
 po1,po2: pchar;
 by1: byte;
begin
 by1:= 0;
 if len > 0 then begin
  po1:= str1;
  po2:= str2;
  repeat
   by1:= byte(po1^) - byte(po2^);
   if po2^ = #0 then begin
    break;
   end;
   inc(po1);
   inc(po2);
   dec(len);
  until (len <= 0) or (by1 <> 0);
 end;
 result:= shortint(by1);
end;

function mseStrLComp(const Str1, Str2: PmseChar; len: integer): Integer;
var
 po1,po2: pmsechar;
 wo1: word;
begin
 wo1:= 0;
 if len > 0 then begin
  po1:= str1;
  po2:= str2;
  repeat
   wo1:= word(po1^) - word(po2^);
   if po2^ = #0 then begin
    break;
   end;
   inc(po1);
   inc(po2);
   dec(len);
  until (len <= 0) or (wo1 <> 0);
 end;
 result:= smallint(wo1);
end;

function StrLIComp(const Str1, upstr: PChar; len: integer): Integer;
                //ascii caseinsensitive, str2 muss upcase sein
var
 po1,po2: pcharaty;
 int1: integer;
 by1: byte;
begin
 by1:= 0;
 if not((len = 0) or (str1 = upstr)) then begin
  po1:= pointer(str1);
  po2:= pointer(upstr);
  for int1:= 0 to len - 1 do begin
   by1:= ord(upperchars[po1^[int1]])-ord(po2^[int1]);
   if (by1 <> 0) then begin
    break;
   end;
  end;
 end;
 result:= shortint(by1);
end;

function StrIComp(const Str1, upstr: PChar): Integer;
                //ascii caseinsensitive, upstr muss upcase sein
var
 po1,po2: pchar;
 by1: byte;
begin
 by1:= 0;
 if str1 <> upstr then begin
  po1:= pointer(str1);
  po2:= pointer(upstr);
  repeat
   by1:= ord(upperchars[po1^])-ord(po2^);
   inc(po1);
   inc(po2);
  until (by1 <> 0) or (po1^ = #0);
 end;
 result:= shortint(by1);
end;

function mseStrLIComp(const Str1, upstr: PmseChar; len: integer): Integer;
                //ascii caseinsensitive, str2 muss upcase sein
var
 po1,po2: pmsecharaty;
 int1: integer;
 ch1: msechar;
 wo1: word;
begin
 wo1:= 0;
 if not((len = 0) or (str1 = upstr)) then begin
  po1:= pointer(str1);
  po2:= pointer(upstr);
  for int1:= 0 to len - 1 do begin
   ch1:= po1^[int1];
   if (ch1 >= 'a') and (ch1 <= 'z') then begin
    inc(ch1,ord('A')-ord('a'));
   end;
   wo1:= ord(ch1)-ord(po2^[int1]);
   if (wo1 <> 0) then begin
    break;
   end;
  end;
 end;
 result:= smallint(wo1);
end;

function issamelstring(const value: lmsestringty; const key: msestring;
             caseinsensitive: boolean = false): boolean;
              //nur ascii caseinsens., key muss upcase sein
begin
 if caseinsensitive then begin
  result:= msestrlicomp(value.po,pointer(key),value.len) = 0;
 end
 else begin
  result:= msestrlcomp(value.po,pointer(key),value.len) = 0;
 end;
end;

function issamelstring(const value: lstringty; const key: string;
             caseinsensitive: boolean = false): boolean;
              //nur ascii caseinsens., key muss upcase sein
begin
 if caseinsensitive then begin
  result:= strlicomp(value.po,pointer(key),value.len) = 0;
 end
 else begin
  result:= strlcomp(value.po,pointer(key),value.len) = 0;
 end;
end;

function minhigh(const a,b: lstringty): integer; overload;
begin
 if a.len < b.len then begin
  result:= a.len;
 end
 else begin
  result:= b.len;
 end;
 dec(result);
end;

function minhigh(const a: lstringty; const b: string): integer; overload;
begin
 if a.len < length(b) then begin
  result:= a.len;
 end
 else begin
  result:= length(b);
 end;
 dec(result);
end;

function minhigh(const a,b: string): integer; overload;
begin
 if length(a) < length(b) then begin
  result:= length(a);
 end
 else begin
  result:= length(b);
 end;
 dec(result);
end;

function minhigh(const a,b: msestring): integer; overload;
begin
 if length(a) < length(b) then begin
  result:= length(a);
 end
 else begin
  result:= length(b);
 end;
 dec(result);
end;

function lstringcomp(const a,b: lstringty): integer;
var
 int1: integer;
 by1: byte;
 po1,po2: pcharaty;
begin
 po1:= pointer(a.po);
 po2:= pointer(b.po);
 by1:= 0;
 for int1:= 0 to minhigh(a,b) do begin
  by1:= byte(po1^[int1]) - byte(po2^[int1]);
  if by1 <> 0 then begin
   break;
  end;
 end;
 if by1 = 0 then begin
  result:= a.len - b.len;
 end
 else begin
  result:= shortint(by1);
 end;
end;

function lstringcomp(const a: lstringty; const b: string): integer;
var
 int1: integer;
 by1: byte;
 po1,po2: pcharaty;
begin
 po1:= pointer(a.po);
 po2:= pointer(b);
 by1:= 0;
 for int1:= 0 to minhigh(a,b) do begin
  by1:= byte(po1^[int1]) - byte(po2^[int1]);
  if by1 <> 0 then begin
   break;
  end;
 end;
 if by1 = 0 then begin
  result:= a.len - length(b);
 end
 else begin
  result:= shortint(by1);
 end;
end;

function lstringicompupper(const a,upper: lstringty): integer;
         //case insensitive, upper must be uppercase
var
 int1: integer;
 by1: byte;
 po1,po2: pcharaty;
begin
 po1:= pointer(a.po);
 po2:= pointer(upper.po);
 by1:= 0;
 for int1:= 0 to minhigh(a,upper) do begin
  by1:= byte(upperchars[po1^[int1]]) - byte(po2^[int1]);
  if by1 <> 0 then begin
   break;
  end;
 end;
 if by1 = 0 then begin
  result:= a.len - upper.len;
 end
 else begin
  result:= shortint(by1);
 end;
end;

function lstringicompupper(const a: lstringty; const upper: string): integer; overload;
         //ansi case insensitive, upper must be uppercase
var
 int1: integer;
 by1: byte;
 po1,po2: pcharaty;
begin
 po1:= pointer(a.po);
 po2:= pointer(upper);
 by1:= 0;
 for int1:= 0 to minhigh(a,upper) do begin
  by1:= byte(upperchars[po1^[int1]]) - byte(po2^[int1]);
  if by1 <> 0 then begin
   break;
  end;
 end;
 if by1 = 0 then begin
  result:= a.len - length(upper);
 end
 else begin
  result:= shortint(by1);
 end;
end;

function lstringicomp(const a,b: lstringty): integer;
         //case insensitive
var
 int1: integer;
 by1: byte;
 po1,po2: pcharaty;
begin
 po1:= pointer(a.po);
 po2:= pointer(b.po);
 by1:= 0;
 for int1:= 0 to minhigh(a,b) do begin
  by1:= byte(upperchars[po1^[int1]]) - byte(upperchars[po2^[int1]]);
  if by1 <> 0 then begin
   break;
  end;
 end;
 if by1 = 0 then begin
  result:= a.len - b.len;
 end
 else begin
  result:= shortint(by1);
 end;
end;

function lstringicomp(const a: lstringty; const b: string): integer;
         //case insensitive,
var
 int1: integer;
 by1: byte;
 po1,po2: pcharaty;
begin
 po1:= pointer(a.po);
 po2:= pointer(b);
 by1:= 0;
 for int1:= 0 to minhigh(a,b) do begin
  by1:= byte(upperchars[po1^[int1]]) - byte(upperchars[po2^[int1]]);
  if by1 <> 0 then begin
   break;
  end;
 end;
 if by1 = 0 then begin
  result:= a.len - length(b);
 end
 else begin
  result:= shortint(by1);
 end;
end;

{
function stringcomp(const a,b: string): integer;
var
 int1: integer;
 by1: byte;
 po1,po2: pcharaty;
begin
 po1:= pointer(a);
 po2:= pointer(b);
 by1:= 0;
 for int1:= 0 to minhigh(a,b) do begin
  by1:= byte(po1^[int1]) - byte(po2^[int1]);
  if by1 <> 0 then begin
   break;
  end;
 end;
 if by1 = 0 then begin
  result:= length(a) - length(b);
 end
 else begin
  result:= shortint(by1);
 end;
end;

function stringicomp(const a,b: string): integer;
         //case insensitive
var
 int1: integer;
 by1: byte;
 po1,po2: pcharaty;
begin
 po1:= pointer(a);
 po2:= pointer(b);
 by1:= 0;
 for int1:= 0 to minhigh(a,b) do begin
  by1:= byte(upperchars[po1^[int1]]) - byte(upperchars[po2^[int1]]);
  if by1 <> 0 then begin
   break;
  end;
 end;
 if by1 = 0 then begin
  result:= length(a) - length(b);
 end
 else begin
  result:= shortint(by1);
 end;
end;
}

function stringcomp(const a,b: string): integer;
var
 by1: byte;
 po1,po2: pchar;
begin
 po1:= pointer(a);
 po2:= pointer(b);
 if po1 = nil then begin
  if po2 = nil then begin
   result:= 0;
   exit;
  end;
  result:= -1;
  exit;
 end;
 if po2 = nil then begin
  result:= 1;
  exit;
 end;
 while true do begin
  by1:= byte(po1^)-byte(po2^);
  if (by1 <> 0) or (po1^ = #0) or (po2^=#0) then begin
   break;
  end;
  inc(po1);
  inc(po2);
 end;
 result:= shortint(by1);
end;

function stringicomp(const a,b: string): integer;
var
 by1: byte;
 po1,po2: pchar;
begin
 po1:= pointer(a);
 po2:= pointer(b);
 if po1 = nil then begin
  if po2 = nil then begin
   result:= 0;
   exit;
  end;
  result:= -1;
  exit;
 end;
 if po2 = nil then begin
  result:= 1;
  exit;
 end;
 while true do begin
  by1:= byte(upperchars[po1^])-byte(upperchars[po2^]);
  if (by1 <> 0) or (po1^ = #0) or (po2^=#0) then begin
   break;
  end;
  inc(po1);
  inc(po2);
 end;
 result:= shortint(by1);
end;

function stringicompupper(const a,upstr: string): integer;
         //case insensitive, b must be uppercase
var
 int1: integer;
 by1: byte;
 po1,po2: pcharaty;
begin
 po1:= pointer(a);
 po2:= pointer(upstr);
 by1:= 0;
 for int1:= 0 to minhigh(a,upstr) do begin
  by1:= byte(upperchars[po1^[int1]]) - byte(po2^[int1]);
  if by1 <> 0 then begin
   break;
  end;
 end;
 if by1 = 0 then begin
  result:= length(a) - length(upstr);
 end
 else begin
  result:= shortint(by1);
 end;
end;

function msestringcomp(const a,b: msestring): integer;
var
 int1: integer;
 wo1: word;
 po1,po2: pmsecharaty;
begin
 po1:= pointer(a);
 po2:= pointer(b);
 wo1:= 0;
 for int1:= 0 to minhigh(a,b) do begin
  wo1:= word(po1^[int1]) - word(po2^[int1]);
  if wo1 <> 0 then begin
   break;
  end;
 end;
 if wo1 = 0 then begin
  result:= length(a) - length(b);
 end
 else begin
  result:= smallint(wo1);
 end;
end;

function msestringicomp(const a,b: msestring): integer;
         //ascii case insensitive
var
 int1: integer;
 wo1: word;
 ch1,ch2: msechar;
 po1,po2: pmsecharaty;
begin
 po1:= pointer(a);
 po2:= pointer(b);
 wo1:= 0;
 for int1:= 0 to minhigh(a,b) do begin
  ch1:= po1^[int1];
  if (ch1 >= 'a') and (ch1 <= 'z') then begin
   inc(ch1,ord('A')-ord('a'));
  end;
  ch2:= po2^[int1];
  if (ch2 >= 'a') and (ch2 <= 'z') then begin
   inc(ch2,ord('A')-ord('a'));
  end;
  wo1:= word(ch1) - word(ch2);
  if wo1 <> 0 then begin
   break;
  end;
 end;
 if wo1 = 0 then begin
  result:= length(a) - length(b);
 end
 else begin
  result:= smallint(wo1);
 end;
end;

function msestringicompupper(const a,upstr: msestring): integer;
         //case insensitive, b must be uppercase
var
 int1: integer;
 wo1: word;
 ch1: msechar;
 po1,po2: pmsecharaty;
begin
 po1:= pointer(a);
 po2:= pointer(upstr);
 wo1:= 0;
 for int1:= 0 to minhigh(a,upstr) do begin
  ch1:= po1^[int1];
  if (ch1 >= 'a') and (ch1 <= 'z') then begin
   inc(ch1,ord('A')-ord('a'));
  end;
  wo1:= word(ch1) - word(po2^[int1]);
  if wo1 <> 0 then begin
   break;
  end;
 end;
 if wo1 = 0 then begin
  result:= length(a) - length(upstr);
 end
 else begin
  result:= smallint(wo1);
 end;
end;

function isnullstring(const s: ansistring): boolean;
var
 int1: integer;
begin
 result:= true;
 for int1:= 1 to length(s) do begin
  if s[int1] <> #0 then begin
   result:= false;
   break;
  end;
 end;
end;

function isemptystring(const s: pchar): boolean;
begin
 result:= (s = nil) or (s^ = char(0));
end;

function isemptystring(const s: pmsechar): boolean;
begin
 result:= (s = nil) or (s^ = msechar(0));
end;

function isnamechar(achar: char): boolean;
            //true if achar in 'a'..'z','A'..'Z','0'..'9','_';
begin
 result:= (achar >= 'a') and (achar <= 'z') or (achar >= 'A') and (achar <= 'Z') or
                (achar >= '0') and (achar <= '9') or (achar = '_');
end;

function isnamechar(achar: msechar): boolean;
            //true if achar in 'a'..'z','A'..'Z','0'..'9','_';
begin
 result:= (achar >= 'a') and (achar <= 'z') or (achar >= 'A') and (achar <= 'Z') or
                (achar >= '0') and (achar <= '9') or (achar = '_');
end;

function isnumber(const s: string): boolean;
var
 int1: integer;
 ch1: char;
begin
 if s = '' then begin
  result:= false;
 end
 else begin
  result:= true;
  for int1:= length(s)-1 downto 0 do begin
   ch1:= (pchar(pointer(s))+int1)^;
   if (ch1 < '0') or (ch1 > '9') then begin
    result:= false;
    break;
   end;
  end;
 end;
end;

function isnumber(const s: msestring): boolean;
var
 int1: integer;
 ch1: msechar;
begin
 if s = '' then begin
  result:= false;
 end
 else begin
  result:= true;
  for int1:= length(s)-1 downto 0 do begin
   ch1:= (pmsechar(pointer(s))+int1)^;
   if (ch1 < '0') or (ch1 > '9') then begin
    result:= false;
    break;
   end;
  end;
 end;
end;

function startsstr(substring: pchar; s: pchar): boolean;
begin
 result:= substring = s;
 if not result then begin
  if (substring <> nil) and (s <> nil) then begin
   while (substring^ = s^) and (substring^ <> #0) do begin
    inc(substring);
    inc(s);
   end;
   result:= substring^= #0;
  end
  else begin
   result:= isemptystring(substring) and isemptystring(s);
  end;
 end;
end;

function StartsStr(const substring,s: string): boolean;
begin
 result:= startsstr(pchar(substring),pchar(s));
end;

function msestartsstr(substring: pmsechar; s: pmsechar): boolean;
begin
 result:= substring = s;
 if not result then begin
  if (substring <> nil) and (s <> nil) then begin
   while (substring^ = s^) and (substring^ <> #0) do begin
    inc(substring);
    inc(s);
   end;
   result:= substring^= #0;
  end
  else begin
   result:= isemptystring(substring) and isemptystring(s);
  end;
 end;
end;

function msestartsstrcaseinsensitive(substring: pmsechar; s: pmsechar): boolean;
begin
 result:= substring = s;
 if not result then begin
  if (substring <> nil) and (s <> nil) then begin
   while (substring^ = charuppercase(s^)) and (substring^ <> #0) do begin
    inc(substring);
    inc(s);
   end;
   result:= substring^= #0;
  end
  else begin
   result:= isemptystring(substring) and isemptystring(s);
  end;
 end;
end;

function mseStartsStr(const substring,s: msestring): boolean;
begin
 result:= msestartsstr(pmsechar(substring),pmsechar(s));
end;

function strlcopy(const str: pchar; len: integer): ansistring;
                       //nicht nullterminiert
begin
 setlength(result,len);
 move(str^,result[1],len*sizeof(char));
end;

function msestrlcopy(const str: pmsechar; len: integer): msestring;
                       //nicht nullterminiert
begin
 setlength(result,len);
 move(str^,result[1],len*sizeof(msechar));
end;

function comparestrlen(const S1,S2: string): integer;
                //case sensitiv, beruecksichtigt nur s1 laenge
begin
 if (length(s1) = 0) or (pointer(s1) = pointer(s2)) then begin
  result:= 0;
  exit;
 end;
 if length(s2) = 0 then begin
  result:= 1;
  exit;
 end
 else begin
  result:= strlcomp(pointer(s1),pointer(s2),length(s1));
 end;
end;

function msecomparestrlen(const S1,S2: msestring): integer;
                //case sensitiv, beruecksichtigt nur s1 laenge
begin
 if (length(s1) = 0) or (pointer(s1) = pointer(s2)) then begin
  result:= 0;
  exit;
 end;
 if length(s2) = 0 then begin
  result:= 1;
  exit;
 end
 else begin
  result:= msestrlcomp(pointer(s1),pointer(s2),length(s1));
 end;
end;

function msecomparestr(const S1, S2: msestring): Integer;
begin
{$ifdef FPC}
  result:= unicodecomparestr(s1,s2);
// {$ifdef mswindows}
// if iswin95 then begin
//  result:= comparestr(s1,s2);
// end
// else begin
//  result:= unicodecomparestr(s1,s2);
// end;
// {$else}
//  result:= unicodecomparestr(s1,s2);
// {$endif}
{$else}
 result:= widecomparestr(s1,s2);
{$endif}
end;

function msecomparetext(const S1, S2: msestring): Integer;
begin
{$ifdef FPC}
// {$ifdef mswindows}
// if iswin95 then begin
//  result:= comparetext(s1,s2);
// end
// else begin
//  result:= unicodecomparetext(s1,s2);
// end;
// {$else}
  result:= unicodecomparetext(s1,s2);
// {$endif}
{$else}
 result:= widecomparetext(s1,s2);
{$endif}
end;

function comparenatural(const s1,s2: msestring;
                                   const caseinsensitive: boolean): int32;
var
 p1,p2: pmsechar;
 pa,pb: pmsechar;
 i1,ia,ib: int32;
 si0,si1,si2: sizeint;
 c1,c2: msechar;
 b1: boolean;
begin
 b1:= false;
 if (s1 <> '') and (s2 <> '') and (pointer(s1) <> pointer(s2)) then begin
  p1:= pmsechar(pointer(s1)) + (length(s1) - 1);
  pa:= p1;
  while pa >= pointer(s1) do begin
   if (pa^ > '9') or (pa^ < '0') then begin
    break;
   end;
   dec(pa);
  end;
  if pa <> p1 then begin
   p2:= pmsechar(pointer(s2)) + (length(s2) - 1);
   pb:= p2;
   while pb >= pointer(s2) do begin
    if (pb^ > '9') or (pb^ < '0') then begin
     break;
    end;
    dec(pb);
   end;
   if pb <> p2 then begin
    si0:= pa - pmsechar(pointer(s1));
    if si0 = pb - pmsechar(pointer(s2)) then begin
     inc(si0);
     i1:= 1;
     ia:= 0;
     while p1 > pa do begin
      ia:= ia + i1 * (card16(p1^)-card16('0'));
      i1:= i1 * 10;
      dec(p1);
     end;
     i1:= 1;
     ib:= 0;
     while p2 > pb do begin
      ib:= ib + i1 * (card16(p2^)-card16('0'));
      i1:= i1 * 10;
      dec(p2);
     end;
     si1:= length(s1);
     si2:= length(s2);
     (psizeint(pointer(s1))-1)^:= si0;
     (psizeint(pointer(s2))-1)^:= si0;
     inc(pa);
     c1:= pa^;
     pa^:= #0;
     inc(pb);
     c2:= pb^;
     pb^:= #0;
     if caseinsensitive then begin
      result:= msecomparetext(s1,s2);
     end
     else begin
      result:= msecomparestr(s1,s2);
     end;
     if result = 0 then begin
      result:= ia - ib;
     end;
     (psizeint(pointer(s1))-1)^:= si1;
     (psizeint(pointer(s2))-1)^:= si2;
     pa^:= c1;
     pb^:= c2;
     b1:= true;
    end;
   end;
  end;
 end;
 if not b1 then begin
  if caseinsensitive then begin
   result:= msecomparetext(s1,s2);
  end
  else begin
   result:= msecomparestr(s1,s2);
  end;
 end;
end;

function msecomparestrnatural(const S1, S2: msestring): Integer;
                //case sensitive
begin
 result:= comparenatural(s1,s2,false);
end;

function msecomparetextnatural(const S1, S2: msestring): Integer;
                //case insensitive
begin
 result:= comparenatural(s1,s2,true);
end;

function mseCompareTextlen(const S1, S2: msestring): Integer;
                //case insensitiv, beruecksichtigt nur s1 laenge
var
 str1: msestring;
begin
 str1:= copy(s2,1,length(s1));  //todo: optimize
 result:= msecomparetext(s1,str1);
end;

function msepartialcomparestr(const s1,s2: msestring): integer;
var
 mstr1: msestring;
begin
 mstr1:= copy(s2,1,length(s1));
 result:= msecomparestr(s1,mstr1);
 if (result <> 0) and (length(s2) > length(s1)) then begin
  if msecomparestr(s1+'A',mstr1+'Z') <
                     msecomparestr(s1+'Z',mstr1+'A') then begin
   result:= 0;
  end;
 end;
end;

function msepartialcomparetext(const s1,s2: msestring): integer;
var
 mstr1: msestring;
begin
 mstr1:= copy(s2,1,length(s1));
 result:= msecomparetext(s1,mstr1);
 if (result <> 0) and (length(s2) > length(s1)) then begin
  if msecomparetext(s1+'A',mstr1+'Z') <
                     msecomparetext(s1+'Z',mstr1+'A') then begin
   result:= 0;
  end;
 end;
end;

function mseCompareTextlenupper(const S1, S2: msestring): Integer;
                //case insensitiv, checks length s1 only, s1 must be uppercase
var
 str1: msestring;
begin
 str1:= mseuppercase(copy(s2,1,length(s1)));  //todo: optimize
 result:= msecomparestr(s1,str1);
end;

function mseissamestrlen(const apartstring,astring: msestring): boolean;
var
 po1,po2: pmsechar;
begin
 result:= pointer(apartstring) = pointer(astring);
 if not result then begin
  po1:= pmsechar(apartstring);
  po2:= pmsechar(astring);
  while po1^ <> #0 do begin
   if po1^ <> po2^ then begin
    exit;
   end;
   inc(po1);
   inc(po2);
  end;
 end;
 result:= true;
end;

function mseissametextlen(const apartstring,astring: msestring): boolean;
                //case insensitive
begin
 result:= mseissamestrlen(mseuppercase(apartstring),mseuppercase(astring));
end;

function mselowercase(const s: msestring): msestring;
begin
{$ifdef FPC}
// {$ifdef mswindows}
// if iswin95 then begin
//  result:= lowercase(s);
// end
// else begin
//  result:= unicodelowercase(s);
// end;
// {$else}
 result:= unicodelowercase(s);
// {$endif}
{$else}
 result:= widelowercase(s);
{$endif}
end;

function mseuppercase(const s: msestring): msestring;
begin
{$ifdef FPC}
// {$ifdef mswindows}
// if iswin95 then begin
//  result:= ansiuppercase(s);
// end
// else begin
//  result:= unicodeuppercase(s);
// end;
// {$else}
 result:= unicodeuppercase(s);
// {$endif}
{$else}
 result:= wideuppercase(s);
{$endif}
end;

function mselowercase(const s: msestringarty): msestringarty;
var
 int1: integer;
begin
 setlength(result,length(s));
 for int1:= high(s) downto 0 do begin
  result[int1]:= mselowercase(s[int1]);
 end;
end;

function mseuppercase(const s: msestringarty): msestringarty;
var
 int1: integer;
begin
 setlength(result,length(s));
 for int1:= high(s) downto 0 do begin
  result[int1]:= mseuppercase(s[int1]);
 end;
end;

function msestartstr(const atext: msestring; trenner: msechar): msestring;
var
 po1: pmsechar;
begin
 po1:= msestrlscan(pmsechar(atext),trenner,length(atext));
 if po1 = nil then begin
  result:= atext;
 end
 else begin
  result:= copy(atext,1,po1-pmsechar(atext));
 end;
end;

function mseremspace(const s: msestring): msestring;
var
 int1,int2: integer;
 ch: msechar;
begin
 int2:= 0;
 setlength(result,length(s));
 for int1:= 1 to length(s) do begin
  ch:= s[int1];
  if ch > ' ' then begin
   inc(int2);
   pmsecharaty(result)^[int2]:= ch;
  end;
 end;
 setlength(result,int2);
end;

function removelinebreaks(const s: msestring): msestring;
    //replaces linebreaks with space
begin
 result:= concatstrings(breaklines(s),' ');
end;

function removelineterminator(const s: msestring): msestring;
var
 int1: integer;
begin
 int1:= length(s);
 if int1 > 0 then begin
  if s[int1] = c_linefeed then begin
   dec(int1);
  end;
  if (int1 > 0) and (s[int1] = c_return) then begin
   dec(int1);
  end;
 end;
 result:= copy(s,1,int1);
end;

procedure removetabterminator(var s: msestring);
var
 int1: integer;
begin
 int1:= length(s);
 if (int1 > 0) and (s[int1] = c_tab) then begin
  setlength(s,int1-1);
 end;
end;

function stripescapesequences(avalue: msestring): msestring;
label
 lab1;
var
 s,d,e: pmsechar;
begin
 if avalue <> '' then begin
  setlength(result,length(avalue));
  s:= pointer(avalue);
  d:= pointer(result);
  e:= s+length(avalue);
  while s < e do begin
   if s^ = c_esc then begin
    inc(s);
    case s^ of
     '[': begin
      inc(s);
      if (s^ >= '0') and (s^ <= '9') then begin
       inc(s);
lab1:
       while (s^ >= '0') and (s^ <= '9') do begin
        inc(s);
       end;
       if s^ = ';' then begin
        inc(s);
        goto lab1; //multiple attributes
       end;
       if not (char(word(s^)) in ['n','h','l','H','A','B','C','D',
                 'f','r','g','K','J','i','m']) then begin
        dec(s);
       end;
      end
      else begin
       if not (char(word(s^)) in ['c','s','u','r','g','K','J','i','m']) then begin
        dec(s);
       end;
      end;
     end;
     else begin
      if not (char(word(s^)) in ['c','(',')','7','8','D','M','H']) then begin
       dec(s);
      end;
     end;
    end;
   end
   else begin
    d^:= s^;
    inc(d);
   end;
   inc(s);
  end;
  setlength(result,d-pmsechar(pointer(result)));
 end
 else begin
  result:= '';
 end;
end;


{ tmemorystringstream }
const
 stringheadersize = sizeof(stringheaderty);

constructor tmemorystringstream.create;
//var
// header: stringheaderty;
begin
 inherited;
 setcapacity(0);
 fposition:= stringheadersize;
// fillchar(header,sizeof(header),0);
// writebuffer(header,sizeof(header));
end;

procedure tmemorystringstream.SetCapacity(NewCapacity: PtrInt);
begin
 inherited setcapacity(newcapacity + stringheadersize);
end;

function tmemorystringstream.getcapacity: ptrint;
begin
 result:= inherited getcapacity - stringheadersize;
end;

function tmemorystringstream.Seek(const Offset: Int64;
               Origin: TSeekOrigin): Int64;
begin
  Case Word(Origin) of
    soFromBeginning : FPosition:=Offset+stringheadersize;
    soFromEnd       : FPosition:=FSize+Offset;
    soFromCurrent   : FPosition:=FPosition+Offset;
  end;
  Result:=FPosition;
  {$IFDEF DEBUG}
  if Result < stringheadersize then
    raise Exception.Create('TCustomMemoryStream');
  {$ENDIF}
end;

function tmemorystringstream.getmemory: pointer;
begin
 result:= fmemory + stringheadersize;
end;

function tmemorystringstream.GetSize: Int64;
begin
 result:= fsize - stringheadersize;
end;

function tmemorystringstream.GetPosition: Int64;
begin
 result:= fposition - stringheadersize;
end;

procedure tmemorystringstream.SetSize(
                     {$ifdef CPU64}const{$endif CPU64} NewSize: PtrInt);
begin
 inherited setsize(newsize + stringheadersize);
end;

procedure tmemorystringstream.destroyasstring(out data: string);
var
 ch1: char;
begin
 data:= ''; //decref
 if size > 0 then begin
  with pstringheaderty(fmemory)^ do begin
 {$ifdef hascodepage}
   codepage:= cp_acp;
   elementsize:= 1;
  {$if not defined(mse_fpc_3_3)}
  {$ifdef cpu64}
   dummy:= 0;
  {$endif}
  {$endif}
 {$endif}
 
 {$if fpc_fullversion >= 030000}
   ref:= 1;
 {$endif} 
   len:= size;
  end;
  ch1:= #0;
  position:= size;
  writebuffer(ch1,sizeof(ch1));
  pointer(data):= memory; //pointer(ptruint(memory) + sizeof(stringheaderty));
  setpointer(nil,0);
 end;
 // destroy;            //destroy does not free memory???
 free();
end;

end.


