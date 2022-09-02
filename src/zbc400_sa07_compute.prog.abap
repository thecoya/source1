*&---------------------------------------------------------------------*
*& Report ZBC400_SA07_COMPUTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_sa07_compute.


PARAMETERS pa_int1 TYPE i.
PARAMETERS pa_int2 TYPE i.
PARAMETERS pa_op TYPE c.
DATA gv_result TYPE p LENGTH 16 DECIMALS 2.



CASE pa_op.
  WHEN '+'.
    gv_result = pa_int1 + pa_int2.
    WRITE gv_result.

  WHEN '-'.
    gv_result = pa_int1 - pa_int2.
    WRITE gv_result.

  WHEN '*'.
    gv_result = pa_int1 * pa_int2.
    WRITE gv_result.

  WHEN '/'.
    gv_result = pa_int1 / pa_int2.
    WRITE gv_result.

  ENDCASE.
