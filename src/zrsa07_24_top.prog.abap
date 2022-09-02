*&---------------------------------------------------------------------*
*& Include ZRSA07_24_TOP                            - Report ZRSA07_24
*&---------------------------------------------------------------------*
REPORT zrsa07_24.

"Data 선언 - 무슨정보에 대한 ? -> 항공권 정보네.


DATA: BEGIN OF gs_list,
        carrid     TYPE sflight-carrid,
        carrname   TYPE scarr-carrname,
        connid     TYPE sflight-connid,
        fldate     TYPE sflight-fldate,
        price      TYPE sflight-price,
        currency   TYPE sflight-currency,
        seatsocc   TYPE sflight-seatsocc,
        seatsmax   TYPE sflight-seatsmax,
        seatsocc_b TYPE sflight-seatsocc_b,
        seatsmax_b TYPE sflight-seatsmax_b,
        seatsocc_f TYPE sflight-seatsocc_f,
        seatsmax_f TYPE sflight-seatsmax_f,
        cityfrom   TYPE spfli-cityfrom,
        cityto     TYPE spfli-cityto,
      END OF gs_list.

DATA gt_list LIKE TABLE OF gs_list.

PARAMETERS: pa_car  TYPE sflight-carrid,
            pa_con1 TYPE sflight-connid,
            pa_con2 LIKE pa_con1.
