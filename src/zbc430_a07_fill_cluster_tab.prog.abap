*&---------------------------------------------------------------------*
*& Report  SAPBC430S_FILL_CLUSTER_TAB                                  *
*&                                                                     *
*&---------------------------------------------------------------------*
*&                                                                     *
*&                                                                     *
*&---------------------------------------------------------------------*

REPORT  zbc430_a07_fill_cluster_tab                                  .

DATA wa_scarr  TYPE zscarr_a07.
DATA wa_spfli  TYPE zspfli_a07.
DATA wa_flight TYPE zsflight_a07.

DATA my_error TYPE i VALUE 0.


START-OF-SELECTION.

* Replace # by Your user-number and remove all * from here

  DELETE FROM zscarr_a07.
  DELETE FROM zspfli_a07.
  DELETE FROM zsflight_a07.


  SELECT * FROM scarr INTO wa_scarr.
    INSERT INTO zscarr_a07 VALUES wa_scarr.
  ENDSELECT.

  IF sy-subrc = 0.
    SELECT * FROM spfli INTO wa_spfli.
      INSERT INTO zspfli_a07 VALUES wa_spfli.
    ENDSELECT.

    IF sy-subrc = 0.

      SELECT * FROM sflight INTO wa_flight.
        INSERT INTO zsflight_a07 VALUES wa_flight.
      ENDSELECT.
      IF sy-subrc <> 0.
        my_error = 1.
      ENDIF.
    ELSE.
      my_error = 2.
    ENDIF.
  ELSE.
    my_error = 3.
  ENDIF.

  IF my_error = 0.
    WRITE / 'Data transport successfully finished'.
  ELSE.
    WRITE: / 'ERROR:', my_error.
  ENDIF.
