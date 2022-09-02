*&---------------------------------------------------------------------*
*& Report ZRCA07_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrca07_02.

*
*DATA gv_step TYPE i.
*DATA gv_cal LIKE gv_step.
*DATA gv_lev LIKE gv_cal.
*PARAMETERS pa_req LIKE gv_lev.
*PARAMETERS pa_syear(1) TYPE c.
*DATA gv_new_lev LIKE gv_lev.
*
*
*CASE pa_syear.
*  WHEN '1'.
*    IF pa_req > 3.
*       gv_new_lev = 3.
*        ENDIF.
*  WHEN '2'.
*      IF pa_req > 5.
*        gv_new_lev = 5.
*        ELSE.
*        gv_new_lev = pa_req.
*        ENDIF.
*        WHEN '3'.
*        IF pa_req >= 7.
*          gv_new_lev = 7.
*          ELSE.
*           gv_new_lev = pa_req.
*           ENDIF.
*           WHEN '4'.
*             IF pa_req > 9.
*               gv_new_lev = 9.
*               ELSE.
*                gv_new_lev = pa_req.
*                ENDIF.
*               WHEN '6'.
*                 IF pa_req > 9.
*                   gv_new_lev = 9.
*                    ENDIF.
*
*      ENDCASE.
*
*
*
*DO pa_req TIMES.
*  gv_lev = gv_lev + 1.
*
*  CLEAR gv_step.
*
*DO 9 TIMES.
*  gv_step = gv_step + 1.
*  CLEAR gv_cal.
*  gv_cal = gv_lev * gv_step.
*WRITE: gv_lev, ' * ', gv_step, ' = ', gv_cal.
*NEW-LINE.
*ENDDO.
*
*CLEAR gv_step.
*
*WRITE '-------------------'.
*ENDDO.



*DATA gv_i TYPE I.
*gv_i = 'KANG'.
*
*WRITE gv_i. "메시지 처리.
*
*
*MESSAGE 'Message Test' TYPE 'i'.
















*PARAMETERS pa_num TYPE i.
*
*DO 5 TIMES.
*write : pa_num.
*pa_num = pa_num + 1.
*ENDDO.
*
*write pa_num.
*
*" continue, exit 등 들어 갈 수 있다.


*data gs_car TYPE scarr.
*parameters pa_car TYPE scarr-carrid.
*
*select SINGLE carrid carrname
*  FROM scarr
*  into CORRESPONDING FIELDS OF gs_car
*  WHERE carrid = pa_car.
*
*
*WRITE gs_car.
*
**  WRITE: gs_car-mandt, gs_car-carrid, gs_car-carrname.


PARAMETERS: pa_int1 TYPE i,
            pa_char TYPE c,
            pa_int2 TYPE i.

DATA gs_sum TYPE p DECIMALS 2.


CASE pa_char.
  WHEN '+'.
    gs_sum =  pa_int1 + pa_int2.
  WHEN '-'.
    gs_sum = pa_int1 - pa_int2.
  WHEN '*'.
    gs_sum =  pa_int1 * pa_int2.
  WHEN '/'.
    gs_sum = pa_int1 / pa_int2.

ENDCASE.

WRITE gs_sum.
