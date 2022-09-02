*&---------------------------------------------------------------------*
*& Report ZBC405_A07_M3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_a07_m3.

TABLES sbuspart.

SELECTION-SCREEN BEGIN OF BLOCK c1 WITH FRAME TITLE TEXT-001.
  PARAMETERS pa_sbus TYPE sbuspart-buspartnum OBLIGATORY.
  SELECT-OPTIONS : so_con FOR sbuspart-contact NO INTERVALS. "high값을 주지마라

  SELECTION-SCREEN ULINE.  "줄로 구분함.

  PARAMETERS : pa_ta RADIOBUTTON GROUP rd1 DEFAULT 'X',
               pa_fc RADIOBUTTON GROUP rd1.
SELECTION-SCREEN END OF BLOCK c1.

DATA : gt_sbus TYPE TABLE OF sbuspart,
       gv_type TYPE sbuspart-buspatyp.


REFRESH gt_sbus.




"IF 문 썼을 때
*IF pa_ta = 'X'.
*  SELECT mandant buspartnum contact contphono buspatyp
*    FROM sbuspart
*    INTO CORRESPONDING FIELDS OF TABLE gt_sbus
*    WHERE buspartnum = pa_sbus
*    AND contact IN so_con
*    AND buspatyp = 'TA'.
*ELSEIF pa_fc = 'X'.
*  SELECT mandant buspartnum contact contphono buspatyp
*    FROM sbuspart
*    INTO CORRESPONDING FIELDS OF TABLE gt_sbus
*    WHERE buspartnum = pa_sbus
*    AND contact IN so_con
*    AND buspatyp = 'FC'.
*ENDIF.



"" CASE문 1번 !
*CASE 'X'.  "값 / 안바뀌는 상수임
*  WHEN pa_ta.
*    SELECT mandant buspartnum contact contphono buspatyp
*  FROM sbuspart
*  INTO CORRESPONDING FIELDS OF TABLE gt_sbus
*  WHERE buspartnum = pa_sbus
*  AND contact IN so_con
*  AND buspatyp = 'TA'.   "--> pa_ta에 따라 변하는 값이 오게하려면 변수 선언
*  WHEN pa_fc.
*    SELECT mandant buspartnum contact contphono buspatyp
*      FROM sbuspart
*      INTO CORRESPONDING FIELDS OF TABLE gt_sbus
*      WHERE buspartnum = pa_sbus
*      AND contact IN so_con
*      AND buspatyp = 'FC'.
*ENDCASE.


"변수깔릴때 상수 상수깔릴때 변수 CASE문 변수가 오면 상수

"" CASE문 2번 !
CASE 'X'.
  WHEN pa_ta.
    gv_type = 'TA'.
  WHEN pa_fc.
    gv_type = 'FC'.
ENDCASE.

SELECT mandant buspartnum contact contphono buspatyp
  FROM sbuspart
  INTO CORRESPONDING FIELDS OF TABLE gt_sbus
  WHERE buspartnum = pa_sbus
  AND contact IN so_con
  AND buspatyp = gv_type.
