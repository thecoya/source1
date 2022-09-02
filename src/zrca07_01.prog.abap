


&---------------------------------------------------------------------*
& Report ZRCA07_01
&---------------------------------------------------------------------*
&
&---------------------------------------------------------------------*
REPORT ZRCA07_01.

*DATA gv_gender TYPE c LENGTH 1. "M, F
*gv_gender = 'M'.


*CASE gv_gender.
*  WHEN 'M'.
*
*  WHEN 'F'.
*
*  WHEN OTHERS.
*
*    ENDCASE.
*
*
*IF gv_gender = 'M'.
*
*  ELSEif gv_gender = 'F'.
*
*    ESLE.
*
*    ENDIF.
*
*
*
*gv_gender = 'F'.


DATA gv_num TYPE i.

DO 6 TIMES.
  gv_num = gv_num + 1.
  WRITE sy-index.
  IF gv_num > 3.
    EXIT.
    ENDIF.
    WRITE gv_num.
  NEW-LINE.

  ENDDO.
