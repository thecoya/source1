*&---------------------------------------------------------------------*
*&  REPORT BC405_SELECT_S2
*&---------------------------------------------------------------------*
REPORT zbc405_07_group_by.

TYPES: BEGIN OF gty_flight,
         carrid      TYPE sflight-carrid,
         connid      TYPE sflight-connid,
         seatsmax    TYPE sflight-seatsmax,
         seatsocc    TYPE sflight-seatsocc,
         num_flights TYPE i,
       END OF gty_flight.

DATA: gt_flights TYPE TABLE OF gty_flight,
      gs_flight  TYPE          gty_flight.

DATA: go_alv_grid TYPE REF TO cl_salv_table.

SELECT-OPTIONS: so_car FOR gs_flight-carrid.


*----------------------------------------------------------------------*
START-OF-SELECTION.

  SELECT
      carrid connid  "SELECT문에 있어야 한다.
      SUM( seatsmax )
      SUM( seatsocc )
      COUNT( * )
    INTO TABLE gt_flights
    FROM sflight
    WHERE carrid IN so_car
    GROUP BY carrid connid.   "그룹바이 필드들은

  cl_salv_table=>factory(
    IMPORTING
      r_salv_table   = go_alv_grid
    CHANGING
      t_table        = gt_flights ).

  go_alv_grid->display( ).
