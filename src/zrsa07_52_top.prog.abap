*&---------------------------------------------------------------------*
*& Include ZRSA07_52_TOP                            - Module Pool      ZRSA07_52
*&---------------------------------------------------------------------*
PROGRAM ZRSA07_52.

TABLES: scarr, spfli, sflight.

PARAMETERS: pa_car TYPE scarr-carrid,
            pa_con TYPE spfli-connid.

SELECT-OPTIONS so_dat FOR sflight-fldate.   "테이블 선언하면 변수가 생기는 것으로 봄, type이 들어가면 안된다.
