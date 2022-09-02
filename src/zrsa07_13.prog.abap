*&---------------------------------------------------------------------*
*& Report ZRSA07_13
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA07_13.



DATA: gv_a VALUE 'A',
      gv_b VALUE 'B',
      gv_c VALUE 'C',
      gv_d VALUE 'D'.


PERFORM test USING gv_a gv_b
             CHANGING gv_c gv_d.

NEW-LINE.
WRITE: 'PERFORM END: ', gv_a, gv_b, gv_c, gv_d.
*&---------------------------------------------------------------------*
*& Form test
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GV_A
*&      --> GV_B
*&      <-- GV_C
*&      <-- GV_D
*&---------------------------------------------------------------------*
FORM test  USING p_a
                 p_b
           CHANGING p_c
                 p_d.

p_a = 'W'. p_b = 'X'. p_c = 'Y'. p_d = 'Z'.

WRITE: 'FROM in: ', gv_a, gv_b, gv_c, gv_d.
ENDFORM.
