class ZCLC107_0002 definition
  public
  final
  create public .

public section.

  methods SET_BOM_INFO
    importing
      !PI_MATNR type MAKT-MATNR
    exporting
      !PE_CODE type CHAR1
      !PE_MSG type CHAR100
    changing
      !ET_BOMIF type ZC1SA070001 .
protected section.
private section.
ENDCLASS.



CLASS ZCLC107_0002 IMPLEMENTATION.


  METHOD set_bom_info.

    IF pi_matnr IS INITIAL.
      pe_code = 'E'.
      pe_msg = TEXT-t01.
      EXIT.
    ENDIF.

    SELECT matnr spras
      INTO CORRESPONDING FIELDS OF TABLE et_bomif
      FROM makt
      WHERE matnr = pi_matnr
      AND spras = sy-langu.

    IF sy-subrc NE 0.
      pe_code = 'E'.
      pe_msg = TEXT-t01.
      EXIT.
    ELSE.
      pe_code = 'S'.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
