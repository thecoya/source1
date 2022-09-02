*&---------------------------------------------------------------------*
*&  Include BC405_INTRO_S_E01                                          *
*&---------------------------------------------------------------------*

INITIALIZATION.

  push_but = 'PBBUTTON'. ""hide
  gv_change = 1.

  MOVE: 'AA' TO so_car-low,
        'QF' TO so_car-high,
        'BT' TO so_car-option,
        'I' TO so_car-sign.
  APPEND so_car.

  CLEAR so_car.

  MOVE: 'AZ' TO so_car-low,
        'EQ' TO so_car-option,
        'E' TO so_car-sign.
  APPEND so_car.

  tab1 = 'Connections'(t11).
  tab2 = 'Date'(t12).
  tab3 = 'Type of flight'(t13).
  tab4 = 'Country From'.

  airlines-activetab = 'FRTO'.
  airlines-dynnr = '1400'.      " 이거 안하면, 첫 번째 스크린이 뜬다(1100).


AT SELECTION-SCREEN.  "PAI

  CASE sscrfields-ucomm.    "ok code - ucomm
    WHEN 'PBBUTTON'.
      CHECK sy-dynnr = '1400'.
      IF gv_change = '1'.
        gv_change = '0'.
      ELSE.
        gv_change = '1'.
      ENDIF.

*      MESSAGE i000(zt03_msg) WITH 'This is pushbutton test !'.
  ENDCASE.

AT SELECTION-SCREEN OUTPUT.   "PBO
  IF sy-dynnr = '1400'.
    LOOP AT SCREEN.
      IF screen-group1 = 'DET'.
        screen-active = gv_change.

*screen-invisible = gv_change.

        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.

    IF gv_change = '1'.
      push_but = 'hide'.
    ELSE.
      push_but = 'show'.
    ENDIF.


  ENDIF.



START-OF-SELECTION.

  CASE gc_mark.

    WHEN bt_all.

      SELECT * FROM dv_flights INTO gs_flight
        WHERE carrid IN so_car
        AND connid IN so_con
        AND fldate IN so_fdt
        AND cityfrom IN s_cifr
        AND countryfr IN s_cofr.

        WRITE: / gs_flight-carrid,
             gs_flight-connid,
             gs_flight-fldate,
             gs_flight-countryfr,
             gs_flight-cityfrom,
             gs_flight-airpfrom,
             gs_flight-countryto,
             gs_flight-cityto,
             gs_flight-airpto,
             gs_flight-seatsmax,
             gs_flight-seatsocc.

      ENDSELECT.

    WHEN bt_dome.

      SELECT * FROM dv_flights INTO gs_flight
      WHERE carrid IN so_car
      AND connid IN so_con
      AND fldate IN so_fdt
      AND cityfrom IN s_cifr
      AND countryfr IN s_cofr
      AND countryto = dv_flights~countryfr.

        WRITE: / gs_flight-carrid,
             gs_flight-connid,
             gs_flight-fldate,
             gs_flight-countryfr,
             gs_flight-cityfrom,
             gs_flight-airpfrom,
             gs_flight-countryto,
             gs_flight-cityto,
             gs_flight-airpto,
             gs_flight-seatsmax,
             gs_flight-seatsocc.

      ENDSELECT.

    WHEN bt_int.

      SELECT * FROM dv_flights INTO gs_flight
      WHERE carrid IN so_car
      AND connid IN so_con
      AND fldate IN so_fdt
      AND cityfrom IN s_cifr
      AND countryfr IN s_cofr
      AND countryto <> dv_flights~countryfr.
        WRITE: / gs_flight-carrid,
             gs_flight-connid,
             gs_flight-fldate,
             gs_flight-countryfr,
             gs_flight-cityfrom,
             gs_flight-airpfrom,
             gs_flight-countryto,
             gs_flight-cityto,
             gs_flight-airpto,
             gs_flight-seatsmax,
             gs_flight-seatsocc.

      ENDSELECT.

  ENDCASE.
