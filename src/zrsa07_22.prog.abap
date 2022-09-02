*&---------------------------------------------------------------------*
*& Report ZRSA07_22
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA07_22.


DATA: BEGIN OF gs_info,
     carrid TYPE zsinfo,
     carrname TYPE zsinfo,
     connid TYPE zsinfo,
     cityfrom TYPE zsinfo,
     cityto TYPE zsinfo,
END OF gs_info.
DATA gt_info LIKE TABLE OF gs_info.


APPEND gs_info TO gt_info.


SELECT carrid
  FROM spfli
  INTO CORRESPONDING FIELDS of  gs_info
  WHERE





cl_demo_output=>display_data( gs_info ).
