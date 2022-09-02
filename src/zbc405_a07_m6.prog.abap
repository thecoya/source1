*&---------------------------------------------------------------------*
*& Report ZBC405_A07_M6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_a07_m6.

DATA: BEGIN OF ls_scarr,
        carrid   TYPE scarr-carrid,
        carrname TYPE scarr-carrname,
        url      TYPE scarr-url,
      END OF ls_scarr,
      lt_scarr LIKE TABLE OF ls_scarr.

SELECT carrid  carrname url
  INTO CORRESPONDING FIELDS OF TABLE lt_scarr
  FROM scarr.


* new syntax
SELECT carrid, carrname, url
  INTO TABLE @DATA(lt_scarr2)
  FROM scarr.


READ TABLE lt_scarr2 INTO DATA(ls_scarr2)
WITH KEY carrid = 'AA'.

cl_demo_output=>display( ls_scarr2 ).
