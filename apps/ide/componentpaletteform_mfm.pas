unit componentpaletteform_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$INTERFACES CORBA}{$endif}

interface

implementation
uses
 mseclasses,componentpaletteform;

const
 objdata: record size: integer; data: array[0..2601] of byte end =
      (size: 2602; data: (
  84,80,70,48,19,116,99,111,109,112,111,110,101,110,116,112,97,108,101,116,
  116,101,102,111,18,99,111,109,112,111,110,101,110,116,112,97,108,101,116,116,
  101,102,111,13,111,112,116,105,111,110,115,119,105,100,103,101,116,11,13,111,
  119,95,97,114,114,111,119,102,111,99,117,115,11,111,119,95,115,117,98,102,
  111,99,117,115,17,111,119,95,100,101,115,116,114,111,121,119,105,100,103,101,
  116,115,9,111,119,95,104,105,110,116,111,110,12,111,119,95,97,117,116,111,
  115,99,97,108,101,0,8,98,111,117,110,100,115,95,120,3,131,0,8,98,
  111,117,110,100,115,95,121,3,33,1,9,98,111,117,110,100,115,95,99,120,
  3,226,2,9,98,111,117,110,100,115,95,99,121,2,69,15,102,114,97,109,
  101,46,103,114,105,112,95,115,105,122,101,2,10,18,102,114,97,109,101,46,
  103,114,105,112,95,111,112,116,105,111,110,115,11,14,103,111,95,99,108,111,
  115,101,98,117,116,116,111,110,16,103,111,95,102,105,120,115,105,122,101,98,
  117,116,116,111,110,12,103,111,95,116,111,112,98,117,116,116,111,110,0,11,
  102,114,97,109,101,46,100,117,109,109,121,2,0,8,116,97,98,111,114,100,
  101,114,2,1,7,118,105,115,105,98,108,101,8,23,99,111,110,116,97,105,
  110,101,114,46,111,112,116,105,111,110,115,119,105,100,103,101,116,11,13,111,
  119,95,109,111,117,115,101,102,111,99,117,115,11,111,119,95,116,97,98,102,
  111,99,117,115,13,111,119,95,97,114,114,111,119,102,111,99,117,115,11,111,
  119,95,115,117,98,102,111,99,117,115,19,111,119,95,109,111,117,115,101,116,
  114,97,110,115,112,97,114,101,110,116,17,111,119,95,100,101,115,116,114,111,
  121,119,105,100,103,101,116,115,12,111,119,95,97,117,116,111,115,99,97,108,
  101,0,18,99,111,110,116,97,105,110,101,114,46,98,111,117,110,100,115,95,
  120,2,0,18,99,111,110,116,97,105,110,101,114,46,98,111,117,110,100,115,
  95,121,2,0,19,99,111,110,116,97,105,110,101,114,46,98,111,117,110,100,
  115,95,99,120,3,216,2,19,99,111,110,116,97,105,110,101,114,46,98,111,
  117,110,100,115,95,99,121,2,69,21,99,111,110,116,97,105,110,101,114,46,
  102,114,97,109,101,46,100,117,109,109,121,2,0,23,99,111,110,116,97,105,
  110,101,114,46,111,110,99,104,105,108,100,115,99,97,108,101,100,7,27,99,
  111,109,112,111,110,101,110,116,103,114,111,117,112,111,110,99,104,105,108,100,
  115,99,97,108,101,100,16,100,114,97,103,100,111,99,107,46,99,97,112,116,
  105,111,110,6,17,67,111,109,112,111,110,101,110,116,32,80,97,108,101,116,
  116,101,20,100,114,97,103,100,111,99,107,46,111,112,116,105,111,110,115,100,
  111,99,107,11,10,111,100,95,115,97,118,101,112,111,115,10,111,100,95,99,
  97,110,109,111,118,101,11,111,100,95,99,97,110,102,108,111,97,116,10,111,
  100,95,99,97,110,100,111,99,107,15,111,100,95,112,114,111,112,111,114,116,
  105,111,110,97,108,11,111,100,95,112,114,111,112,115,105,122,101,0,7,111,
  112,116,105,111,110,115,11,10,102,111,95,115,97,118,101,112,111,115,12,102,
  111,95,115,97,118,101,115,116,97,116,101,0,8,115,116,97,116,102,105,108,
  101,7,22,109,97,105,110,102,111,46,112,114,111,106,101,99,116,115,116,97,
  116,102,105,108,101,21,105,99,111,110,46,116,114,97,110,115,112,97,114,101,
  110,116,99,111,108,111,114,4,6,0,0,128,12,105,99,111,110,46,111,112,
  116,105,111,110,115,11,10,98,109,111,95,109,97,115,107,101,100,0,10,105,
  99,111,110,46,105,109,97,103,101,10,8,3,0,0,0,0,0,0,2,0,
  0,0,24,0,0,0,24,0,0,0,116,2,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,128,76,240,33,248,252,248,9,128,128,128,1,248,252,
  248,5,128,76,240,1,248,252,248,7,128,128,128,1,248,252,248,1,224,224,
  224,8,128,128,128,1,248,252,248,1,224,224,224,4,128,76,240,1,248,252,
  248,1,224,224,224,6,128,128,128,1,248,252,248,1,224,224,224,8,128,128,
  128,1,248,252,248,1,224,224,224,4,128,76,240,1,248,252,248,1,224,224,
  224,6,128,128,128,1,248,252,248,1,224,224,224,8,128,128,128,1,248,252,
  248,1,224,224,224,4,128,76,240,1,248,252,248,1,224,224,224,6,128,128,
  128,1,248,252,248,1,224,224,224,1,0,0,0,2,224,224,224,2,0,0,
  0,1,224,224,224,2,128,128,128,1,248,252,248,1,224,224,224,1,0,0,
  0,1,224,224,224,2,128,76,240,1,248,252,248,1,224,224,224,1,0,0,
  0,3,224,224,224,2,128,128,128,1,248,252,248,1,224,224,224,8,128,128,
  128,1,248,252,248,1,224,224,224,4,128,76,240,1,248,252,248,1,224,224,
  224,6,128,128,128,1,248,252,248,1,224,224,224,8,128,128,128,1,248,252,
  248,1,224,224,224,4,128,76,240,1,248,252,248,1,224,224,224,6,128,128,
  128,1,248,252,248,15,128,76,240,1,248,252,248,1,224,224,224,2,0,252,
  248,1,224,224,224,10,0,252,248,1,224,224,224,8,128,76,240,1,248,252,
  248,1,224,224,224,1,0,252,248,3,224,224,224,8,0,252,248,3,224,224,
  224,7,128,76,240,1,248,252,248,1,0,252,248,5,224,224,224,6,0,252,
  248,5,224,224,224,6,128,76,240,1,248,252,248,1,224,224,224,1,0,252,
  248,3,224,224,224,8,0,252,248,3,224,224,224,7,128,76,240,1,248,252,
  248,1,224,224,224,2,0,252,248,1,224,224,224,4,96,232,72,1,224,224,
  224,5,0,252,248,1,224,224,224,4,96,232,72,1,224,224,224,3,128,76,
  240,1,248,252,248,1,224,224,224,6,96,232,72,3,224,224,224,8,96,232,
  72,3,224,224,224,2,128,76,240,1,248,252,248,1,224,224,224,6,96,232,
  72,3,224,224,224,8,96,232,72,3,224,224,224,2,128,76,240,1,248,252,
  248,1,0,0,248,4,224,224,224,1,96,232,72,5,224,224,224,1,0,0,
  248,4,224,224,224,1,96,232,72,5,224,224,224,1,128,76,240,1,248,252,
  248,1,0,0,248,4,224,224,224,7,0,0,248,4,224,224,224,7,128,76,
  240,1,248,252,248,1,0,0,248,4,224,224,224,7,0,0,248,4,224,224,
  224,7,128,76,240,1,248,252,248,1,0,0,248,4,224,224,224,7,0,0,
  248,4,224,224,224,7,128,76,240,1,248,252,248,1,224,224,224,22,128,76,
  240,1,248,252,248,1,128,128,128,22,128,76,240,48,0,0,0,9,0,254,
  255,9,254,255,255,191,254,255,255,8,254,255,255,191,254,255,255,0,254,255,
  255,191,254,255,255,183,254,255,255,0,254,255,255,191,254,255,255,0,254,255,
  255,2,254,255,255,0,254,255,255,0,254,255,255,191,254,255,255,8,254,255,
  255,0,254,255,255,2,254,255,255,64,254,255,255,0,254,255,255,183,254,255,
  255,183,0,0,0,191,0,0,0,8,10,111,110,115,116,97,116,114,101,97,
  100,7,12,102,111,111,110,114,101,97,100,115,116,97,116,13,111,110,99,104,
  105,108,100,115,99,97,108,101,100,7,27,99,111,109,112,111,110,101,110,116,
  103,114,111,117,112,111,110,99,104,105,108,100,115,99,97,108,101,100,15,109,
  111,100,117,108,101,99,108,97,115,115,110,97,109,101,6,9,116,100,111,99,
  107,102,111,114,109,0,8,116,116,111,111,108,98,97,114,16,99,111,109,112,
  111,110,101,110,116,112,97,108,101,116,116,101,13,111,112,116,105,111,110,115,
  119,105,100,103,101,116,11,13,111,119,95,109,111,117,115,101,102,111,99,117,
  115,11,111,119,95,116,97,98,102,111,99,117,115,13,111,119,95,97,114,114,
  111,119,102,111,99,117,115,17,111,119,95,100,101,115,116,114,111,121,119,105,
  100,103,101,116,115,9,111,119,95,104,105,110,116,111,110,0,8,98,111,117,
  110,100,115,95,120,2,0,8,98,111,117,110,100,115,95,121,2,26,9,98,
  111,117,110,100,115,95,99,120,3,216,2,9,98,111,117,110,100,115,95,99,
  121,2,30,11,102,114,97,109,101,46,100,117,109,109,121,2,0,13,102,97,
  99,101,46,116,101,109,112,108,97,116,101,7,29,103,117,105,116,101,109,112,
  108,97,116,101,115,109,111,46,102,97,100,101,104,111,114,122,99,111,110,118,
  101,120,10,102,97,99,101,46,100,117,109,109,121,2,0,7,97,110,99,104,
  111,114,115,11,6,97,110,95,116,111,112,9,97,110,95,98,111,116,116,111,
  109,0,8,116,97,98,111,114,100,101,114,2,1,13,98,117,116,116,111,110,
  115,46,119,105,100,116,104,2,26,14,98,117,116,116,111,110,115,46,104,101,
  105,103,104,116,2,26,7,111,112,116,105,111,110,115,11,14,116,98,111,95,
  100,114,97,103,115,111,117,114,99,101,12,116,98,111,95,100,114,97,103,100,
  101,115,116,0,15,111,110,98,117,116,116,111,110,99,104,97,110,103,101,100,
  7,29,99,111,109,112,111,110,101,110,116,112,97,108,101,116,116,101,98,117,
  116,116,111,110,99,104,97,110,103,101,100,20,100,114,97,103,46,111,110,97,
  102,116,101,114,100,114,97,103,100,114,111,112,7,24,99,111,109,112,111,110,
  101,110,116,112,97,108,101,116,116,101,100,114,97,103,100,114,111,112,4,108,
  101,102,116,3,128,0,3,116,111,112,2,8,0,0,7,116,116,97,98,98,
  97,114,14,99,111,109,112,111,110,101,110,116,112,97,103,101,115,13,111,112,
  116,105,111,110,115,119,105,100,103,101,116,11,15,111,119,95,97,114,114,111,
  119,102,111,99,117,115,105,110,16,111,119,95,97,114,114,111,119,102,111,99,
  117,115,111,117,116,17,111,119,95,100,101,115,116,114,111,121,119,105,100,103,
  101,116,115,18,111,119,95,102,111,110,116,103,108,121,112,104,104,101,105,103,
  104,116,12,111,119,95,97,117,116,111,115,99,97,108,101,0,8,98,111,117,
  110,100,115,95,120,2,0,8,98,111,117,110,100,115,95,121,2,0,9,98,
  111,117,110,100,115,95,99,120,3,216,2,9,98,111,117,110,100,115,95,99,
  121,2,18,12,98,111,117,110,100,115,95,99,121,109,105,110,2,15,11,102,
  114,97,109,101,46,100,117,109,109,121,2,0,13,102,97,99,101,46,116,101,
  109,112,108,97,116,101,7,29,103,117,105,116,101,109,112,108,97,116,101,115,
  109,111,46,102,97,100,101,118,101,114,116,107,111,110,118,101,120,10,102,97,
  99,101,46,100,117,109,109,121,2,0,7,97,110,99,104,111,114,115,11,6,
  97,110,95,116,111,112,0,8,115,116,97,116,102,105,108,101,7,22,109,97,
  105,110,102,111,46,112,114,111,106,101,99,116,115,116,97,116,102,105,108,101,
  17,111,110,97,99,116,105,118,101,116,97,98,99,104,97,110,103,101,7,29,
  99,111,109,112,111,110,101,110,116,112,97,103,101,115,97,99,116,105,118,101,
  116,97,98,99,104,97,110,103,101,7,111,112,116,105,111,110,115,11,15,116,
  97,98,111,95,100,114,97,103,115,111,117,114,99,101,13,116,97,98,111,95,
  100,114,97,103,100,101,115,116,0,4,108,101,102,116,3,128,0,3,116,111,
  112,2,72,13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,14,0,
  0,0)
 );

initialization
 registerobjectdata(@objdata,tcomponentpalettefo,'');
end.
