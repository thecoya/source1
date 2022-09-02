*&---------------------------------------------------------------------*
*& Include          MZSA0701_I01
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
    WHEN 'BACK' OR 'CANC'.
      "LEAVE TO SCREEN 0.
      SET SCREEN 0.
      LEAVE SCREEN.
    WHEN 'SEARCH'.
      "Get data

      PERFORM get_data USING gv_pno
                       CHANGING zssa0730.


      CLEAR zssa0730.
      SELECT SINGLE *
        FROM ztsa0001 AS a INNER JOIN ztsa0002 AS b " emp Table
        ON a~depid = b~depid
        INTO CORRESPONDING FIELDS OF zssa0730
        WHERE a~pernr = gv_pno.

*      MESSAGE s000(zmcsa00) WITH sy-ucomm.

   endcase.
ENDMODULE.
