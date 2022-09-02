*&---------------------------------------------------------------------*
*& Report ZRSA07_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa07_07.

PARAMETERS pa_date TYPE sy-datum.
PARAMETERS pa_code TYPE c LENGTH 4 DEFAULT 'SYNC'.

*CONSTANTS gc_default TYPE c LENGTH 20 VALUE 'ABAP Workbench'.
"WRITE 'ABAP Workbench'(t01).


DATA gv_cond_d1 LIKE pa_date.
gv_cond_d1 = sy-datum + 7.

CASE pa_code.
  WHEN 'SYNC'.
      IF pa_date > gv_cond_d1. "날짜타입은 8자리 숫 자로. "날짜를 변수에 담아서 써도 댐.
        WRITE 'ABAP Dictionary'(t02).
        ELSE.
        WRITE 'ABAP Workbench'(t01).
      ENDIF.
 	WHEN OTHERS.
      WRITE '다음 기회에'(t03).
ENDCASE.








*IF + gv_result1 = pa_date + 7.
*  gv_result1 = 'ABAP Dictionary'.
*  WRITE gv_result1.
*
*ENDIF.
*
*IF + gv_result2 = pa_date - 7.
*  gv_date = 'ABAP Dictionary'.
*  WRITE pa_date.
*
*ENDIF.
