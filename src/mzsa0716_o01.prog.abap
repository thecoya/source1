*&---------------------------------------------------------------------*
*& Include          MZSA0010_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module GET_DATA OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE get_data OUTPUT.
  PERFORM get_airline_info.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CLEAR_GV OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE clear_gv OUTPUT.
  CLEAR: gv_subrc, ok_code.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_TS_100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Module SET_TS_100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_ts_100 OUTPUT.
  CASE ts_info-activetab.
    WHEN 'TAB1'.
      gv_dynnr = '0101'.
    WHEN 'TAB2'.
      gv_dynnr = '0102'.
    WHEN OTHERS.
      gv_dynnr = '0102'.
      ts_info-activetab = 'TAB2'.
  ENDCASE.
ENDMODULE.
