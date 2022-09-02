*&---------------------------------------------------------------------*
*& Report ZRSA07_36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa07_36.


" 우리는 테이블/타입을 설정하면서 -> DB테이블을 만들고 프로그램에 코딩을하여 해당 값을 출력하는 작업을 하고 있음


TYPES: BEGIN OF ts_dep,
         budget TYPE ztsa07200701-budget,
         waers  TYPE ztsa07200701-waers,

       END OF ts_dep.





DATA: gs_dep TYPE ts_dep,
      gt_dep LIKE TABLE OF gs_dep.
DATA go_salv TYPE REF TO cl_salv_table.


START-OF-SELECTION.
  SELECT *
      FROM ztsa07200701
      INTO CORRESPONDING FIELDS OF TABLE gt_dep.

  cl_salv_table=>factory(
      IMPORTING r_salv_table = go_salv
        CHANGING t_table = gt_dep
  ).
  go_salv->display( ).
