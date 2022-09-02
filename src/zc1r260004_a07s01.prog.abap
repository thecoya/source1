*&---------------------------------------------------------------------*
*& Include          ZC1R260004_A07S01
*&---------------------------------------------------------------------*


SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-t01.
  PARAMETERS pa_werks TYPE mast-werks OBLIGATORY.
  SELECT-OPTIONS so_matnr FOR mast-matnr DEFAULT '1010'.
SELECTION-SCREEN END OF BLOCK a1.


SELECT a~matnr a~stlan a~stlnr a~stlal
       b~maktx
  FROM mast AS a INNER JOIN makt AS b
  ON a~matnr = b~matnr
  INTO CORRESPONDING FIELDS OF gt_data
  WHERE a~matnr = pa_werks.

  SELECT a~matnr a~stlan a~stlnr a~stlal
         b~mtart b~matkl
    FROM mast AS a INNER JOIN mara AS b
    ON a~matnr = pa_werks.


    SELECT matnr maktx stlan stlnr stlal mtart matkl
      INTO CORRESPONDING FIELDS OF TABLE gt_data
      FROM mast
      WHERE matnr = pa_werks.
