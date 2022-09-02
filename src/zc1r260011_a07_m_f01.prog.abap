*&---------------------------------------------------------------------*
*& Include          ZC1R260011_A07_M_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_flight_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_flight_data .

  CLEAR gt_list.

  SELECT a~carrid a~carrname a~url
    b~connid b~fldate b~planetype b~price b~currency  "as ptype
    FROM scarr AS a INNER JOIN sflight AS b
    ON a~carrid = b~carrid
    INTO CORRESPONDING FIELDS OF TABLE gt_list
    WHERE a~carrid IN so_car
    AND b~connid IN so_con
    AND b~planetype IN so_pla.

  IF sy-subrc NE 0.
    MESSAGE s001.
    LEAVE LIST-PROCESSING.
  ENDIF.

*  cl_demo_output=>display_data( gt_list ).

ENDFORM.

FORM set_fcat_lt.

  ENDFORM.
