*&---------------------------------------------------------------------*
*& Include          MZSA0790_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
    WHEN 'BACK'.
      SET SCREEN 0.
      LEAVE SCREEN.

    WHEN 'ENTER'.
      "get airline name
      PERFORM get_airline_name USING zssa0790-carrid
                              CHANGING zssa0790-carrname.

      """CLEAR zssa0790-carrname. "성공이든 실패든 지우는 습관


      "get Meal Text
      PERFORM get_meal_text USING zssa0790-carrid   "재사용, 서브루틴
                                  zssa0790-mealnumber
                                  sy-langu
                            CHANGING zssa0790-meal_t.

    WHEN 'SEARCH'.
      PERFORM get_meal_info USING zssa0790-carrid
                                  zssa0790-mealnumber
                            CHANGING zssa0791.


      PERFORM get_vendor_info USING 'M' "meal number'
                              zssa0790-carrid
                              zssa0790-mealnumber
                       CHANGING zssa0793.
  ENDCASE.

ENDMODULE.
