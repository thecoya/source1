class ZCL_AIRPLANE_A07 definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IV_NAME type STRING
      !IV_PLANETYPE type SAPLANE-PLANETYPE
    exceptions
      WRONG_PLANETYPE .
  methods DISPLAY_ATTRIBUTES .
  class-methods CLASS_CONSTRUCTOR .
  class-methods DISPLAY_N_O_AIRPLANES .
protected section.
private section.

  constants I_POS_1 type I value 30 ##NO_TEXT.
  data MV_NAME type STRING .
  data MV_PLANETYPE type SAPLANE-PLANETYPE .
  data MV_WEIGHT type SAPLANE-WEIGHT .
  data MV_TANKCAP type SAPLANE-TANKCAP .
  class-data GV_N_O_AIRPLANES type I .
  class-data MT_PLANETYPES type TY_PLANETYPES .
ENDCLASS.



CLASS ZCL_AIRPLANE_A07 IMPLEMENTATION.


  METHOD class_constructor.

    SELECT * INTO TABLE mt_planetypes FROM saplane.

  ENDMETHOD.


  METHOD constructor.
    mv_name = iv_name.
    mv_planetype = iv_planetype.

    DATA : ls_planetype TYPE saplane.

    READ TABLE mt_planetypes INTO ls_planetype
    WITH KEY planetype = iv_planetype.


    IF sy-subrc EQ 0.
      gv_n_o_airplanes = gv_n_o_airplanes + 1.
      mv_weight = ls_planetype-weight.
      mv_tankcap = ls_planetype-tankcap.
    ELSE.
      RAISE wrong_planetype.
    ENDIF.







  ENDMETHOD.


  METHOD display_attributes.

    WRITE: / icon_ws_plane AS ICON,
                / 'Name of airplane', AT  i_pos_1 mv_name,
                 / 'Type of airplane', AT i_pos_1 mv_planetype,
                 / 'Weight', AT i_pos_1 mv_planetype,
                / 'tankcap', AT i_pos_1 mv_planetype.


  ENDMETHOD.


  METHOD display_n_o_airplanes.

    WRITE : / 'Number of Airplanes', gv_n_o_airplanes.

  ENDMETHOD.
ENDCLASS.
