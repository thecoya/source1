*&---------------------------------------------------------------------*
*& Include YCL107_001_TOP                           - Report YCL107_001
*&---------------------------------------------------------------------*
REPORT ycl107_001.

TABLES scarr. "scarr로 선언된 구조체를 쓰겠다. 변수임 참고하는 table을 쓰겠다.
" data scarr type scarr.

DATA gt_scarr TYPE TABLE OF scarr.
DATA gs_scarr TYPE scarr.


DATA ok_code TYPE sy-ucomm. "사용자가 action할때
DATA save_ok TYPE sy-ucomm.
