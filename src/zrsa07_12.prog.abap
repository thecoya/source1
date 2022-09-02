*&---------------------------------------------------------------------*
*& Report ZRSA07_12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA07_12.




DATA gv_carrname TYPE scarr-carrname.

PARAMETERS pa_carr  TYPE scarr-carrid.

PERFORM cal_carrname USING pa_carr
                     CHANGING gv_carrname.


" Get Airline Name
*SELECT SINGLE carrname
*    FROM scarr
*    INTO gv_carrname
*    WHERE carrid = pa_carr.

*&---------------------------------------------------------------------*
*& Form carrname
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM cal_carrname USING p_cid
                    CHANGING VALUE(p_cname).

SELECT SINGLE carrname
    FROM scarr
    INTO p_cname
    WHERE carrid = p_cid.


WRITE 'Test GV_CARRNAME:'.
WRITE pa_carr.

ENDFORM.



" USING에서 VALUE를 뺐다, call by 레퍼런스 !  value 공간이 사라지고 reference 된다. "레퍼런스 값된 값을 그대로 가져온다/출력한다.
