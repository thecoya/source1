*&---------------------------------------------------------------------*
*& Include          MZSA0750_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form set_default
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_default CHANGING ps_default TYPE zssa0750cond.
  CLEAR ps_default.

  SELECT carrid mealno
  FROM ztsa07ven UP TO 1 ROWS
  INTO zssa0750cond
    WHERE carrid = 'AA'
    AND mealno = '00000007'.

  ENDSELECT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_domain
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_domain .




  CALL FUNCTION 'GET_DOMAIN_VALUES'
    EXPORTING
      domname = 'S_MEALTYPE'
*     TEXT    = 'X'
*     FILL_DD07L_TAB        = ' '
 TABLES
     VALUES_TAB            = gt_domain
*     VALUES_DD07L          =
 EXCEPTIONS
     NO_VALUES_FOUND       = 1
     OTHERS  = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


READ TABLE gt_domain with KEY domvalue_l = zssa0750tab1-MEALTYPE
INTO gs_domain.
zssa0750tab1-MEALTYPE_t = gs_domain-ddtext.


ENDFORM.
