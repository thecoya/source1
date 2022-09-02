*&---------------------------------------------------------------------*
*& Report ZRSA07_20
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA07_20.


DATA: gs_list TYPE scarr,
      gt_list LIKE TABLE OF gs_list.

CLEAR: gs_list,
      gt_list.

*SELECT *
*    FROM scarr
*    INTO CORRESPONDING FIELDS OF gs_list
*    WHERE carrid BETWEEN 'AA' AND 'UA'.
*  APPEND gs_list TO gt_list.
*  CLEAR gs_list.
*  ENDSELECT.     "돌아가면서 담아라, "하나의 문장


SELECT carrid carrname
  FROM  scarr
    INTO TABLE gt_list
      WHERE carrid BETWEEN 'AA' AND 'UA'.     "select single into gs_  ??? / select * -> into table


  WRITE sy-subrc.    " select 문 반복 횟수를 알 수 있다. "certi 시험에서 잘나옴
  WRITE sy-dbcnt.



  cl_demo_output=>display_data( gt_list ).
