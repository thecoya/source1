*&---------------------------------------------------------------------*
*& Report ZRS07_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRS07_04.



*PARAMETERS pa_num TYPE i.
*DATA gv_result TYPE i.
*MOVE pa_num TO gv_result.
*ADD 1 TO gv_result.
*
*WRITE: 'UR Input:', pa_num.
*
*
*WRITE: 'Result:', gv_result.
