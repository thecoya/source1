*&---------------------------------------------------------------------*
*& Include          MZSA0790_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_airline_name
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA0790_CARRID
*&      <-- ZSSA0790_CARRNAME
*&---------------------------------------------------------------------*
FORM get_airline_name  USING    VALUE(p_carrid)
                       CHANGING VALUE(p_carrname).

  CLEAR p_carrname.
  SELECT SINGLE carrname
    FROM scarr
    INTO p_carrname   "p_carrname or ( p_carrname )
    WHERE carrid = p_carrid.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_meal_text
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA0790_CARRID
*&      --> ZSSA0790_MEALNUMBER
*&      --> SY_LANGU
*&      <-- ZSSA0790_MEALNUMBER_T
*&---------------------------------------------------------------------*
FORM get_meal_text  USING   VALUE(p_carrid)
                            VALUE(p_mealno)
                             VALUE(p_langu)
                    CHANGING VALUE(p_meal_t).
  CLEAR p_meal_t.
  SELECT SINGLE text
    FROM smealt
    INTO p_meal_t
    WHERE carrid = p_carrid
    AND mealnumber = p_mealno
    AND sprache = p_langu. "sy-langu

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_meal_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_meal_info USING VALUE(p_carrid)
                          VALUE(p_mealno)
                          CHANGING ps_meal_info TYPE zssa0791.
  "Meal info
  CLEAR ps_meal_info.

  SELECT SINGLE *
    FROM smeal
    INTO CORRESPONDING FIELDS OF zssa0791
    WHERE carrid = p_carrid
    AND mealnumber = p_mealno.
  "파라미터 없는 상태에서 파라미터 있는 상태로 바꿔줬음
  "전체 activation 필요 오류날때 user커맨드에 선언해줬다면.

  "Airline text
  PERFORM get_airline_name USING ps_meal_info-carrid
                           CHANGING ps_meal_info-carrname.



  " Meal text   ""PERFORM만 쓴다.
  PERFORM get_meal_text USING ps_meal_info-carrid
                          ps_meal_info-mealnumber
                          sy-langu
                          CHANGING ps_meal_info-meal_t.


  "Get price
  "Flag(V,M) , Vendor ID, Airline Code, Meal Number
  DATA ls_vendor_info TYPE zssa0793.
  PERFORM get_vendor_info USING 'M' "meal number'
                                ps_meal_info-carrid
                                ps_meal_info-mealnumber
                         CHANGING ls_vendor_info.
  ps_meal_info-price = ls_vendor_info-price.
  ps_meal_info-waers = ls_vendor_info-waers.



  "Meal type text



ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_vendor_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> ZSSA0790_CARRID
*&      --> ZSSA0790_MEALNUMBER
*&      <-- ZSSA0791
*&---------------------------------------------------------------------*
FORM get_vendor_info  USING    VALUE(p_flag)
                               VALUE(p_code1)
                               VALUE(p_code2)
                      CHANGING ps_info TYPE zssa0793.
  DATA: BEGIN OF ls_cond,
          lifnr  TYPE ztsa0799-lifnr,
          carrid TYPE ztsa0799-carrid,
          mealno TYPE ztsa0799-mealnumber,
        END OF ls_cond.
  CASE p_flag.
    WHEN 'V'. "Vendor
      ls_cond-carrid = p_code1.

    WHEN 'M'. "Meal Number
      ls_cond-carrid = p_code1.
      ls_cond-mealno = p_code2.

      SELECT SINGLE *
        FROM ztsa0799
        INTO CORRESPONDING FIELDS OF ps_info
        WHERE carrid = ls_cond-carrid
        AND mealnumber = ls_cond-mealno.
    WHEN OTHERS.
      RETURN.
  ENDCASE.


ENDFORM.
