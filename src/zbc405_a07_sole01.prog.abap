*&---------------------------------------------------------------------*
*& Include          ZBC405_A07_SOLE01
*&---------------------------------------------------------------------*


START-OF-SELECTION.


  SELECT *
    FROM dv_flights
    INTO gs_flt.
    where carrid = p_car
    and connid = p_con
    and fldate in s_fldate
    into gs_flt.

    WRITE : /10(5) gs_flt-carrid, 16(5) gs_flt-connid, 22(10) gs_flt-fldate, gs_flt-price,   " '/' 새로운 라인이 시작된다. new line
              gs_flt-price CURRENCY gs_flt-currency, gs_flt-currency.

  ENDSELECT.
