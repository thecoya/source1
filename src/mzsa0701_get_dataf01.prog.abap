*----------------------------------------------------------------------*
***INCLUDE MZSA0701_GET_DATAF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GV_PNO
*&      <-- ZSSA0730
*&---------------------------------------------------------------------*



FORM get_data  USING VALUE(p_pernr)
               CHANGING ps_info TYPE zssa0730.

  CLEAR ps_info.

  "EMP / Dep Table

  SELECT SINGLE *                     "서브루틴 가능
    FROM ztsa0001 AS a INNER JOIN ztsa0002 AS b " emp Table
    ON a~depid = b~depid
    INTO CORRESPONDING FIELDS OF ps_info
    WHERE a~pernr = p_pernr.

  IF sy-subrc IS NOT INITIAL.   "일치하는 데이터가 없다면, 밑으로 가지말고 빠져나가라.
    RETURN.     "한단계 전으로 빠져나감
  ENDIF.

  " Dep Text Table           "서브루틴 가능 "서브루틴안에 서브루틴 가능
  SELECT SINGLE dtext
    FROM ztsa0002_t
    INTO ps_info-dtext
    WHERE depid = ps_info-depid
    AND spras = sy-langu.


  "Gender Text
*  CASE ps_info-gender.
*    WHEN '1'.
*      ps_info-gender_t = 'Man'(t01).
*    WHEN '2'.
*      ps_info-gender_t = 'Woman'(t02).
*    WHEN OTHERS.
*      ps_info-gender_t = 'None'(t03).
*  ENDCASE.

  DATA: lt_domain TYPE TABLE OF dd07v,
        ls_domain LIKE LINE OF lt_domain.

  CALL FUNCTION 'GET_DOMAIN_VALUES'
    EXPORTING
      domname         = 'ZDGENDER_A00'
*     TEXT            = 'X'
*     FILL_DD07L_TAB  = ' '
    TABLES
      values_tab      = lt_domain
*     VALUES_DD07L    =
    exceptions
      no_values_found = 1
      OTHERS          = 2.



  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


*  READ TABLE lt_domain WITH TABLE KEY domvalue_l = ps_info-gender
*  INTO ls_domain.
*  ps_info-gender_t - ls_domain-ddtext.

ENDFORM.
