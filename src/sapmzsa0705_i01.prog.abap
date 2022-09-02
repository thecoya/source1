*&---------------------------------------------------------------------*
*& Include          SAPMZSA0705_I01
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
    WHEN  'CANC'.
      LEAVE TO SCREEN 0.
    WHEN 'BACK'.
      SET SCREEN 0.
      LEAVE SCREEN.
    WHEN 'ENTER'.
      "get emp name
      PERFORM get_emp_name USING zssa0073-pernr    "스트럭쳐변수 중 사번을 던지면 이름이 튀어나오는 서브루틴을 쓸거야. zssa0073전체다 말고
                          CHANGING zssa0073-ename.

    WHEN  'SEARCH'.
      "get emp name
      PERFORM get_emp_name USING zssa0073-pernr    "스트럭쳐변수 중 사번을 던지면 이름이 튀어나오는 서브루틴을 쓸거야. zssa0073전체다 말고
                          CHANGING zssa0073-ename.

      "get Employee info
      PERFORM get_emp_info USING zssa0073-pernr
                            CHANGING zssa0070.

    WHEN 'DEP'.  "Popup
      CALL SCREEN 0101 STARTING AT 10 10.


  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0101  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0101 INPUT.
  CASE sy-ucomm.
    WHEN 'CLOSE'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
