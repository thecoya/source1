*&---------------------------------------------------------------------*
*& Report ZRCA07_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRCA07_04.


PARAMETERS pa_car TYPE scarr-carrid.
PARAMETERS pa_car1  TYPE c LENGTH 3.

DATA gs_info TYPE scarr. "밑의 SCARR와 다르다

CLEAR gs_info.
SELECT SINGLE carrid carrname
  FROM SCARR "데이터베이스 테이블
*  INTO CORRESPONDING FIELDS OF gs_info
  INTO gs_info
  WHERE carrid = pa_car.

  WRITE: gs_info-mandt, gs_info-carrid, gs_info-carrname.
