*&---------------------------------------------------------------------*
*& Include          MZSA0750_I01
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

      "Get Inflight Meal info
      CLEAR zssa0750tab1.

      SELECT SINGLE carrid mealnumber mealtype
        FROM smeal
        INTO zssa0750tab1
        WHERE carrid = zssa0750cond-carrid
        AND mealnumber = zssa0750cond-mealnumber.

      SELECT SINGLE *
        FROM scarr
        INTO CORRESPONDING FIELDS OF zssa0750tab1
        WHERE carrid = zssa0750tab1-carrid.

      SELECT SINGLE *
        FROM ztsa07ven
        INTO CORRESPONDING FIELDS OF zssa0750tab1
        WHERE carrid = zssa0750cond-carrid.
*        AND mealnumber = zssa0750cond-mealnumber.

      SELECT SINGLE *
        FROM ztsa07ven
        INTO CORRESPONDING FIELDS OF zssa0750tab2
        WHERE carrid = zssa0750cond-carrid.

       SELECT single text
         FROM SMEALT
         INTO CORRESPONDING FIELDS OF zssa0750tab1
         WHERE CARRID = zssa0750cond-carrid.

       SELECT SINGLE LANDX
         FROM t005t
         INTO CORRESPONDING FIELDS OF zssa0750tab2
         WHERE LAND1 = zssa0750tab2-LAND1
         AND SPRAS = sy-langu.


PERFORM get_domain.

  ENDCASE.
ENDMODULE.
