*&---------------------------------------------------------------------*
*& Report ZRSA07_24
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa07_24_top                           .    " Global Data

* INCLUDE ZRSA07_24_O01                           .  " PBO-Modules
* INCLUDE ZRSA07_24_I01                           .  " PAI-Modules
INCLUDE zrsa07_24_f01                           .  " FORM-Routines


"이벤트 블록

INITIALIZATION.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN.

START-OF-SELECTION.

  CLEAR gt_list.

  SELECT *
    FROM sflight
  INTO CORRESPONDING FIELDS OF TABLE gt_list
  WHERE carrid = pa_car
  AND connid BETWEEN pa_con1 AND pa_con2.

  CLEAR gs_list.


  LOOP AT gt_list INTO gs_list.

    SELECT SINGLE carrname
    FROM scarr
    INTO CORRESPONDING FIELDS OF gs_list
*      INTO gs_list-carrname
    WHERE carrid = gs_list-carrid.

    MODIFY gt_list FROM gs_list.

    CLEAR gs_list.


  ENDLOOP.


  cl_demo_output=>display_data( gt_list ).
