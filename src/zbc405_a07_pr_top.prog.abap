*&---------------------------------------------------------------------*
*& Include ZBC405_A07_PR_TOP                        - Report ZBC405_A07_PR
*&---------------------------------------------------------------------*
REPORT zbc405_a07_pr.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME. "title text-t03
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 3(8) TEXT-t01 FOR FIELD pa_rad1.    "라디오버튼 글자는 딸려오고 위치가 먼저 구성되는거
    SELECTION-SCREEN POSITION 1.                                         "position은 동그라미 위치
    PARAMETERS pa_rad1 RADIOBUTTON GROUP rg1 MODIF ID gr1.
    SELECTION-SCREEN COMMENT pos_low(7) TEXT-t01.     "select options의 위치
    PARAMETERS pa_rad2 RADIOBUTTON GROUP rg1 MODIF ID gr1..
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK bl1.

TABLES: sflight, sscrfields. "버튼에 대한 정보를 담고 있음

*SELECT-OPTIONS so_fld FOR sflight-fldate.

* selection-screen skip 1
SELECTION-SCREEN PUSHBUTTON /1(10) gv_text USER-COMMAND on.

DATA gv_chg type c LENGTH 1.



**subscreen
SELECTION-SCREEN BEGIN OF SCREEN 1100 as SUBSCREEN.
  PARAMETERS pa_car TYPE sflight-carrid.
  SELECTION-SCREEN end of SCREEN 1100.

SELECTION-SCREEN BEGIN OF SCREEN 1200 as SUBSCREEN.
  SELECT-OPTIONS so_fld FOR sflight-fldate.
  SELECTION-SCREEN END OF SCREEN 1200.


** tap strip
SELECTION-SCREEN BEGIN OF TABBED BLOCK ts_info FOR 5 LINES.
"tab들 선언
  SELECTION-SCREEN tab (10) tab1 USER-COMMAND car DEFAULT SCREEN 1100.
  SELECTION-SCREEN tab (10) tab2 USER-COMMAND fld DEFAULT SCREEN 1200.
SELECTION-SCREEN END OF block ts_info.


"초기값 설정 /  select options low / high
"날짜 조건이 있는 tab을 초기탭으로 설정
