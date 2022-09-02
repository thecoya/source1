*&---------------------------------------------------------------------*
*& Include          MZSA0712_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_airline_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_airline_info .
  CLEAR zssa0781.
  SELECT SINGLE *
    FROM scarr
    INTO CORRESPONDING FIELDS OF zssa0781
    WHERE carrid = zssa0780-carrid.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_conn_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA0780_CARRID
*&      --> ZSSA0780_CONNID
*&      <-- ZSSA0782
*&---------------------------------------------------------------------*
FORM get_conn_info  USING    VALUE(p_carrid)
                             VALUE(p_connid)
                    CHANGING ps_info TYPE zssa0782
                              p_subrc.
  CLEAR: p_subrc, zssa0781, ps_info.

  SELECT SINGLE *
    FROM spfli
    INTO CORRESPONDING FIELDS OF ps_info
    WHERE carrid = p_carrid
    AND connid = p_connid.

  IF sy-subrc <> 0.       "0이 아니니까 메시지를 뿌려라
    p_subrc = 4. "sy-subrc.

*    MESSAGE i016(pn) WITH 'Data is not found'.
  ENDIF.

ENDFORM.
