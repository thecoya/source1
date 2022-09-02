*&---------------------------------------------------------------------*
*& Report ZBC401_07_MAIN_GLOBAL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_07_main_global.


DATA : go_airplane TYPE REF TO zcl_airplane_a07.
DATA : gt_airplanes TYPE TABLE OF REF TO zcl_airplane_a07.

START-OF-SELECTION.

  CALL METHOD zcl_airplane_a07=>display_n_o_airplanes.

  CREATE OBJECT go_airplane
    EXPORTING
      iv_name         = 'LH_BERLIN'
      iv_planetype    = 'A321'
    EXCEPTIONS
      wrong_planetype = 1
*     others          = 2
    .
  IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

  ELSE.
    CALL METHOD go_airplane->display_attributes.

  ENDIF.

  CREATE OBJECT go_airplane
    EXPORTING
      iv_name         = 'AA New York'
      iv_planetype    = '747-400'
    EXCEPTIONS
      wrong_planetype = 1
*     others          = 2
    .
  IF sy-subrc <> 0.
  ELSE.
    CALL METHOD go_airplane->display_attributes.
  ENDIF.


  CREATE OBJECT go_airplane
    EXPORTING
      iv_name         = 'US Hercules'
      iv_planetype    = '747-200F'
    EXCEPTIONS
      wrong_planetype = 1
*     others          = 2
    .
  IF sy-subrc <> 0.
  ELSE.
    CALL METHOD go_airplane->display_attributes.
  ENDIF.

    CALL METHOD zcl_airplane_a07=>display_n_o_airplanes.
