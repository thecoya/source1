class ZCL_IM_BADI07 definition
  public
  final
  create public .

public section.

  interfaces IF_EX_BADI_BOOK07 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_BADI07 IMPLEMENTATION.


  METHOD if_ex_badi_book07~change_vline.
    c_pos = c_pos + 25.
  ENDMETHOD.


  METHOD if_ex_badi_book07~output.
    DATA: name TYPE s_custname.

    SELECT SINGLE name FROM scustom INTO name
      WHERE id = i_booking-customid.


    WRITE: name.

  ENDMETHOD.
ENDCLASS.
