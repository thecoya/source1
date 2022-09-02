*&---------------------------------------------------------------------*
*& Report ZBC405_A07_M2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_a07_m2.


TYPES : BEGIN OF ty_data,
          ktopl TYPE  ska1-ktopl,
          ktplt TYPE t004t-ktopl,
          saknr TYPE ska1-saknr,
          txt20 TYPE skat-txt20,
          ktoks TYPE ska1-ktoks,
          txt30 TYPE t077z-txt30.
TYPES :  END OF ty_data.


DATA : gs_data  TYPE ty_data,
       gt_data  LIKE TABLE OF gs_data,
       lv_tabix TYPE sy-tabix.

DATA : gs_aa TYPE ty_data,
       gt_aa LIKE TABLE OF gs_aa.

DATA : gs_bb TYPE ty_data,
       gt_bb LIKE TABLE OF gs_bb.

DATA : gs_cc TYPE ty_data,
       gt_cc LIKE TABLE OF gs_cc.

SELECT ktopl saknr ktoks
  FROM ska1
  INTO CORRESPONDING FIELDS OF TABLE gt_data
  WHERE ktopl = 'WEG'.


SELECT ktopl ktplt
  FROM t004t
  INTO CORRESPONDING FIELDS OF TABLE gt_aa
    WHERE spras = sy-langu.

SELECT saknr txt20
  FROM skat
  INTO CORRESPONDING FIELDS OF TABLE gt_bb
    WHERE spras = sy-langu.

SELECT ktoks txt30
FROM t077z
INTO CORRESPONDING FIELDS OF TABLE gt_cc
    WHERE spras = sy-langu.


LOOP AT gt_data INTO gs_data.
  lv_tabix = sy-tabix.

  READ TABLE gt_aa INTO gs_aa WITH KEY ktopl = gs_data-ktopl.
  IF sy-subrc EQ 0.
    gs_data-ktplt = gs_aa-ktplt.
    MODIFY gt_data FROM gs_data INDEX lv_tabix TRANSPORTING ktplt.
  ENDIF.

  READ TABLE gt_bb INTO gs_bb WITH KEY saknr = gs_data-saknr.
  IF sy-subrc EQ 0.
    gs_data-txt20 = gs_bb-txt20.
    MODIFY gt_data FROM gs_data INDEX lv_tabix TRANSPORTING txt20.
  ENDIF.

  READ TABLE gt_cc INTO gs_cc WITH KEY ktoks = gs_data-ktoks.
  IF sy-subrc EQ 0.
    gs_data-txt30 = gs_cc-txt30.
    MODIFY gt_data FROM gs_data INDEX lv_tabix TRANSPORTING txt30.
  ENDIF.

ENDLOOP.

cl_demo_output=>display_data( gt_data ).
