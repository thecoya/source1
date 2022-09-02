*&---------------------------------------------------------------------*
*& Include          ZBC405_A07_SOLE01
*&---------------------------------------------------------------------*

INITIALIZATION.


  MOVE : 'AA' TO so_car-low,
         'QF' TO so_car-high,
         'BF' TO so_car-option,
         'I' TO so_car-sign.

  APPEND so_car.
  CLEAR so_car.

  MOVE: 'AZ' TO so_car-low,
        'EQ' TO so_car-option,
        'E' TO so_car-sign.

START-OF-SELECTION.
*
*  CASE gc_mark.
*    WHEN pa_all.
*      SELECT *
*        FROM dv_flights
*        INTO gs_flight
*        WHERE carrid IN so_car
*        AND connid IN so_con
*        AND fldate IN so_fdt.
*
*
*        WRITE: / gs_flight-carrid,
*                 gs_flight-connid,
*                 gs_flight-fldate.
*
*
**      WHEN pa_nat.
**
**
**      WHEN pa_int.
*
*
**      WHEN OTHERS.
*    ENDCASE.
