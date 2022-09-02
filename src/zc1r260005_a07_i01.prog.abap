*&---------------------------------------------------------------------*
*& Include          ZC1R260005_A07_I01
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
*&      Module  EXIT_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit_0100 INPUT.
  CALL  METHOD : gcl_grid->free( ), gcl_container->free( ).
  FREE : gcl_grid, gcl_container.
  LEAVE TO SCREEN 0.
ENDMODULE.