*&---------------------------------------------------------------------*
*& Include MZSA0701_TOP                             - Module Pool      SAPMZSA0701
*&---------------------------------------------------------------------*
PROGRAM SAPMZSA0701.


* Condition "번수를 선언하자 " top을 수정하면 전체 acti하자
DATA gv_pno TYPE ztsa0001-pernr.

* Employee info
*DATA gs_info TYPE zssa0031.    0" 1)
TABLES zssa0730.   "2)       TABLE ??

*DATA zssa0730 type zssa0730 이름이 똑같은 변수 선언 이미 있다고 오류 발생함
