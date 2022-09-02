*&---------------------------------------------------------------------*
*& Include          YCL107_001_PAI
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE EXIT_0100 INPUT.
SAVE_OK = OK_CODE. CLEAR OK_CODE.

CASE SAVE_OK.
  WHEN 'EXIT'.   LEAVE PROGRAM. "프로그램 나가기
  WHEN 'CANC'.   LEAVE TO SCREEN 0. "상징적 의미 이전 화면으로
  WHEN OTHERS.
    OK_CODE = SAVE_OK.
ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.
SAVE_OK = OK_CODE. CLEAR OK_CODE.

CASE SAVE_OK.
  WHEN 'BACK'.
    LEAVE TO SCREEN 0.
  WHEN OTHERS.
    OK_CODE = SAVE_OK.
ENDCASE.
ENDMODULE.
