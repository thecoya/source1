*&---------------------------------------------------------------------*
*& Include          YCL107_002_TOP
*&---------------------------------------------------------------------*

TABLES SCARR.
"화면의 INPUT필드에 값을 가져오기 위해 해당 테이블의 필드와 똑같은 이름의
" INPUT 필드 명이 일치하는 정보를 가져옴

DATA : OK_CODE TYPE SY-UCOMM,
       SAVE_OK TYPE SY-UCOMM.

DATA : GT_SCARR TYPE TABLE OF SCARR.
