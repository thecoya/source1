*&---------------------------------------------------------------------*
*& Include ZBC405_A07_SOL_TOP                       - Report ZBC405_A07_SOL
*&---------------------------------------------------------------------*
REPORT zbc405_a07_sol.


" TOP include

CONSTANTS gc_mark VALUE 'X'.


DATA : gs_flight TYPE dv_flights.
SELECT-OPTIONS: so_car FOR gs_flight-carrid MEMORY ID car,
                so_con FOR gs_flight-connid.
SELECT-OPTIONS so_fdt FOR gs_flight-fldate NO-EXTENSION.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
  PARAMETERS: pa_all RADIOBUTTON GROUP rbg1,
              pa_nat RADIOBUTTON GROUP rbg1,
              pa_int RADIOBUTTON GROUP rbg1 DEFAULT 'X'.
SELECTION-SCREEN END OF BLOCK b1.
