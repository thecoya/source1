*&---------------------------------------------------------------------*
*& Include          SAPMZSA0703_I01
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

    WHEN 'SEARCH'.
      CALL SCREEN 200.
      MESSAGE i000(zmsca00) WITH 'CALL'.

      PERFORM get_airline_name USING gv_carrid
                                CHANGING gv_carrname.


*      SET SCREEN 200.
      LEAVE SCREEN.


  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.

      CALL SCREEN 100.


*      SET SCREEN 100. " 목적지를 정한 것.
*
*      MESSAGE i000(zmcsa00) WITH 'BACK'.
      "LEAVE SCREEN.  어떤걸 처리하고, 떠나세요 보통, 밑에 코드 실행안하고 바로나가라.

*      LEAVE TO SCREEN 100. "목적지를 정하자마자 떠나라.

  ENDCASE.




ENDMODULE.
