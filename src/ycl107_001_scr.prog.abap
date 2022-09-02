*&---------------------------------------------------------------------*
*& Include          YCL107_001_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK B01 WITH FRAME
                                   TITLE TEXTT01. "변수로 만들면 init에서 직접 타이틀 줘도 된다

SELECT-OPTIONS s_carrid FOR gs_scarr-carrid.         "for 다음 변수를 참조해서 selscr를만들어라
SELECT-OPTIONS s_carrnm for scarr-carrname.

SELECTION-SCREEN END OF BLOCK B01.
