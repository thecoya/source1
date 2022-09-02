*&---------------------------------------------------------------------*
*& Report ZRSA07_31
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa07_31_top                           .    " Global Data

* INCLUDE ZRSA07_31_O01                           .  " PBO-Modules
* INCLUDE ZRSA07_31_I01                           .  " PAI-Modules
INCLUDE zrsa07_31_f01                           .  " FORM-Routines



INITIALIZATION.
  pa_ent_b = sy-datum - 365.
  pa_ent_e = sy-datum.

  PERFORM set_default.

START-OF-SELECTION.
  SELECT *
    FROM ztsa0007
    INTO CORRESPONDING FIELDS OF TABLE gt_emp
    WHERE entdt BETWEEN pa_ent_b AND pa_ent_e.

  IF sy-subrc IS NOT INITIAL.

    RETURN.

  ENDIF.

  cl_demo_output=>display_data( gt_emp ).
