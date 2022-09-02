*&---------------------------------------------------------------------*
*& Report ZRSA07_09
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa07_09.
*
*DATA gv_cnt TYPE i.
*
*DO 10 TIMES.   "무한 돌리기 하지마~
**WRITE sy-index.
*
*DO 5 TIMES.
*  gv_cnt = gv_cnt + 1.
*
**WRITE sy-index.                 "write의 위치(어느 DO문에 있는지)에 따라..
*ENDDO.
*
*
*ENDDO.
*
*clear gv_cnt.
*
*DO 5 TIMES.
*gv_cnt = gv_cnt + 1.
*
*ENDDO.



" sy-subrc -> 인티저 0 또는 0이 아닌 것을 표현 / IS INITIAL OR IS NOT INITIAL
