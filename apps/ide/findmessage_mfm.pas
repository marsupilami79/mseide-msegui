unit findmessage_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,findmessage;

const
 objdata: record size: integer; data: array[0..2281] of byte end =
      (size: 2282; data: (
  84,80,70,48,14,116,102,105,110,100,109,101,115,115,97,103,101,102,111,13,
  102,105,110,100,109,101,115,115,97,103,101,102,111,7,118,105,115,105,98,108,
  101,8,8,98,111,117,110,100,115,95,120,3,203,1,8,98,111,117,110,100,
  115,95,121,3,42,1,9,98,111,117,110,100,115,95,99,120,3,96,1,9,
  98,111,117,110,100,115,95,99,121,2,111,26,99,111,110,116,97,105,110,101,
  114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,
  27,99,111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,49,11,0,16,99,111,110,116,97,105,110,101,114,
  46,98,111,117,110,100,115,1,2,0,2,0,3,96,1,2,111,0,7,99,
  97,112,116,105,111,110,6,16,70,105,110,100,32,105,110,32,109,101,115,115,
  97,103,101,115,12,105,99,111,110,46,111,112,116,105,111,110,115,11,10,98,
  109,111,95,109,97,115,107,101,100,0,15,105,99,111,110,46,111,114,105,103,
  102,111,114,109,97,116,6,3,112,110,103,13,119,105,110,100,111,119,111,112,
  97,99,105,116,121,5,0,0,0,0,0,0,0,128,255,255,7,111,110,99,
  108,111,115,101,7,7,111,110,99,108,111,115,101,15,109,111,100,117,108,101,
  99,108,97,115,115,110,97,109,101,6,8,116,109,115,101,102,111,114,109,0,
  7,116,98,117,116,116,111,110,8,116,98,117,116,116,111,110,51,3,84,97,
  103,2,1,15,102,97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,
  0,8,98,111,117,110,100,115,95,120,3,25,1,8,98,111,117,110,100,115,
  95,121,2,2,9,98,111,117,110,100,115,95,99,120,2,66,9,98,111,117,
  110,100,115,95,99,121,2,30,5,115,116,97,116,101,11,10,97,115,95,100,
  101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,100,101,102,97,117,
  108,116,15,97,115,95,108,111,99,97,108,99,97,112,116,105,111,110,17,97,
  115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,101,0,7,99,97,
  112,116,105,111,110,6,5,69,38,120,105,116,9,111,110,101,120,101,99,117,
  116,101,7,6,111,110,101,120,105,116,0,0,7,116,98,117,116,116,111,110,
  8,116,98,117,116,116,111,110,50,15,102,97,99,101,46,108,111,99,97,108,
  112,114,111,112,115,11,0,8,116,97,98,111,114,100,101,114,2,1,8,98,
  111,117,110,100,115,95,120,2,6,8,98,111,117,110,100,115,95,121,2,2,
  9,98,111,117,110,100,115,95,99,120,2,94,9,98,111,117,110,100,115,95,
  99,121,2,30,5,115,116,97,116,101,11,10,97,115,95,100,101,102,97,117,
  108,116,15,97,115,95,108,111,99,97,108,100,101,102,97,117,108,116,15,97,
  115,95,108,111,99,97,108,99,97,112,116,105,111,110,17,97,115,95,108,111,
  99,97,108,111,110,101,120,101,99,117,116,101,0,7,99,97,112,116,105,111,
  110,6,10,70,105,110,100,32,38,78,101,120,116,9,111,110,101,120,101,99,
  117,116,101,7,10,111,110,102,105,110,100,110,101,120,116,0,0,12,116,104,
  105,115,116,111,114,121,101,100,105,116,8,102,105,110,100,116,101,120,116,13,
  102,114,97,109,101,46,99,97,112,116,105,111,110,6,13,84,101,120,116,32,
  116,111,32,38,102,105,110,100,22,102,114,97,109,101,46,99,97,112,116,105,
  111,110,116,101,120,116,102,108,97,103,115,11,9,116,102,95,98,111,116,116,
  111,109,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,
  11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,
  11,0,29,102,114,97,109,101,46,98,117,116,116,111,110,46,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,11,0,30,102,114,97,109,101,
  46,98,117,116,116,111,110,46,102,114,97,109,101,46,108,111,99,97,108,112,
  114,111,112,115,49,11,0,19,102,114,97,109,101,46,98,117,116,116,111,110,
  115,46,99,111,117,110,116,2,1,19,102,114,97,109,101,46,98,117,116,116,
  111,110,115,46,105,116,101,109,115,14,1,16,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,49,11,0,0,0,16,102,114,97,109,101,46,111,
  117,116,101,114,102,114,97,109,101,1,2,0,2,18,2,0,2,0,0,8,
  116,97,98,111,114,100,101,114,2,2,8,98,111,117,110,100,115,95,120,2,
  11,8,98,111,117,110,100,115,95,121,2,60,9,98,111,117,110,100,115,95,
  99,120,3,76,1,9,98,111,117,110,100,115,95,99,121,2,40,7,97,110,
  99,104,111,114,115,11,7,97,110,95,108,101,102,116,6,97,110,95,116,111,
  112,8,97,110,95,114,105,103,104,116,0,8,115,116,97,116,102,105,108,101,
  7,22,109,97,105,110,102,111,46,112,114,111,106,101,99,116,115,116,97,116,
  102,105,108,101,12,111,112,116,105,111,110,115,101,100,105,116,49,11,17,111,
  101,49,95,97,117,116,111,112,111,112,117,112,109,101,110,117,13,111,101,49,
  95,115,97,118,101,118,97,108,117,101,13,111,101,49,95,115,97,118,101,115,
  116,97,116,101,0,11,111,112,116,105,111,110,115,101,100,105,116,11,12,111,
  101,95,117,110,100,111,111,110,101,115,99,13,111,101,95,99,108,111,115,101,
  113,117,101,114,121,16,111,101,95,99,104,101,99,107,109,114,99,97,110,99,
  101,108,20,111,101,95,114,101,115,101,116,115,101,108,101,99,116,111,110,101,
  120,105,116,15,111,101,95,101,120,105,116,111,110,99,117,114,115,111,114,13,
  111,101,95,97,117,116,111,115,101,108,101,99,116,25,111,101,95,97,117,116,
  111,115,101,108,101,99,116,111,110,102,105,114,115,116,99,108,105,99,107,0,
  19,100,114,111,112,100,111,119,110,46,99,111,108,115,46,99,111,117,110,116,
  2,1,19,100,114,111,112,100,111,119,110,46,99,111,108,115,46,105,116,101,
  109,115,14,1,0,0,13,114,101,102,102,111,110,116,104,101,105,103,104,116,
  2,15,0,0,7,116,98,117,116,116,111,110,8,116,98,117,116,116,111,110,
  52,15,102,97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,8,
  116,97,98,111,114,100,101,114,2,4,4,104,105,110,116,6,16,82,101,115,
  101,116,32,105,110,100,101,120,32,116,111,32,48,8,98,111,117,110,100,115,
  95,120,3,206,0,8,98,111,117,110,100,115,95,121,2,2,9,98,111,117,
  110,100,115,95,99,120,2,68,9,98,111,117,110,100,115,95,99,121,2,30,
  5,115,116,97,116,101,11,10,97,115,95,100,101,102,97,117,108,116,15,97,
  115,95,108,111,99,97,108,100,101,102,97,117,108,116,15,97,115,95,108,111,
  99,97,108,99,97,112,116,105,111,110,12,97,115,95,108,111,99,97,108,104,
  105,110,116,17,97,115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,
  101,0,7,99,97,112,116,105,111,110,6,6,38,82,101,115,101,116,9,111,
  110,101,120,101,99,117,116,101,7,7,111,110,114,101,115,101,116,0,0,7,
  116,98,117,116,116,111,110,8,116,98,117,116,116,111,110,53,3,84,97,103,
  2,1,15,102,97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,
  8,116,97,98,111,114,100,101,114,2,5,8,98,111,117,110,100,115,95,120,
  2,106,8,98,111,117,110,100,115,95,121,2,2,9,98,111,117,110,100,115,
  95,99,120,2,94,9,98,111,117,110,100,115,95,99,121,2,30,5,115,116,
  97,116,101,11,10,97,115,95,100,101,102,97,117,108,116,15,97,115,95,108,
  111,99,97,108,100,101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,
  99,97,112,116,105,111,110,17,97,115,95,108,111,99,97,108,111,110,101,120,
  101,99,117,116,101,0,7,99,97,112,116,105,111,110,6,9,70,105,110,100,
  32,65,38,108,108,9,111,110,101,120,101,99,117,116,101,7,9,111,110,102,
  105,110,100,97,108,108,0,0,12,116,98,111,111,108,101,97,110,101,100,105,
  116,13,99,97,115,101,115,101,110,115,105,116,105,118,101,13,102,114,97,109,
  101,46,99,97,112,116,105,111,110,6,15,67,97,115,101,32,38,83,101,110,
  115,105,116,105,118,101,16,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,49,11,0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,
  109,101,1,2,0,2,2,2,89,2,2,0,8,116,97,98,111,114,100,101,
  114,2,3,8,98,111,117,110,100,115,95,120,2,44,8,98,111,117,110,100,
  115,95,121,2,40,9,98,111,117,110,100,115,95,99,120,2,102,9,98,111,
  117,110,100,115,95,99,121,2,17,8,115,116,97,116,102,105,108,101,7,22,
  109,97,105,110,102,111,46,112,114,111,106,101,99,116,115,116,97,116,102,105,
  108,101,0,0,12,116,98,111,111,108,101,97,110,101,100,105,116,10,99,111,
  112,121,116,111,99,108,105,112,13,102,114,97,109,101,46,99,97,112,116,105,
  111,110,6,18,38,67,111,112,121,32,116,111,32,99,108,105,112,98,111,97,
  114,100,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,
  0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,
  0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,
  0,2,2,2,109,2,2,0,8,116,97,98,111,114,100,101,114,2,6,8,
  98,111,117,110,100,115,95,120,3,188,0,8,98,111,117,110,100,115,95,121,
  2,40,9,98,111,117,110,100,115,95,99,120,2,122,9,98,111,117,110,100,
  115,95,99,121,2,17,8,115,116,97,116,102,105,108,101,7,22,109,97,105,
  110,102,111,46,112,114,111,106,101,99,116,115,116,97,116,102,105,108,101,0,
  0,0)
 );

initialization
 registerobjectdata(@objdata,tfindmessagefo,'');
end.