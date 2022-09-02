*&---------------------------------------------------------------------*
*& Include SAPMZSA0705_TOP                          - Module Pool      SAPMZSA0705
*&---------------------------------------------------------------------*
PROGRAM sapmzsa0705.

"화면을 구성하려면 top에 선언해야한다.
"Condition 이란 변수를 선언할거야 근데 tables를 하자
"tables를 하려면 str 변수를 만들어야  한다.


" Condition
TABLES zssa0073.
DATA gs_cond TYPE zssa0073.

"Employee info

TABLES zssa0070.
DATA gs_emp TYPE zssa0070.


" Dep info
TABLES zssa0071.
DATA gs_dep TYPE zssa0071.


"Radio button

DATA: gv_r1 TYPE c LENGTH 1,
      gv_r2(1),
      gv_r3.
