*&---------------------------------------------------------------------*
*& Include MZSA0712_TOP                             - Module Pool      SAPMZSA0712
*&---------------------------------------------------------------------*
PROGRAM sapmzsa0712.


DATA ok_code TYPE sy-ucomm.
DATA gv_subrc TYPE sy-subrc.

"Condition
TABLES zssa0780. "Use Screen

"Use ABAP
"DATA gs_cond TYPE zssa0780.

"Airline info
TABLES zssa0781.
"DATA gs_airline type zssa0781


"Connection Info
TABLES zssa0782.
*DATA gs_conn type zssa0082.


" Tab Strip
CONTROLS ts_info TYPE TABSTRIP. "TABSTRIP은 글로벌변수 약간 특별함, 로컬타입인데 글로벑타입으로 씀
