*&---------------------------------------------------------------------*
*& Include          MZSA0712_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code. "sy-ucomm.
    WHEN 'BACK'.
      SET SCREEN 0.
      LEAVE SCREEN.
    WHEN 'SEARCH'.



      "get connection info
      PERFORM get_conn_info USING zssa0780-carrid
                                  zssa0780-connid
                            CHANGING zssa0782
                                     gv_subrc.
      IF gv_subrc <> 0.
        MESSAGE i016(pn) WITH 'Data is not found'.
        RETURN.
       ENDIF.

        " get airline info
        PERFORM get_airline_info.





      WHEN 'ENTER'.
    ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE sy-ucomm.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
