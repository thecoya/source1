*&---------------------------------------------------------------------*
*& Report ZRSA07_33
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA07_33.


DATA gs_dep TYPE zssa0706. "dep info.

DATA: gt_emp TYPE TABLE OF zssa0705,
      gs_emp LIKE LINE OF gt_emp.



PARAMETERS pa_dep TYPE ztsa0007-depid.

START-OF-SELECTION.

SELECT SINGLE *
  FROM ZTSA07200701
  INTO  CORRESPONDING FIELDS OF gs_dep

    WHERE depid = pa_dep.

  cl_demo_output=>display_data( gs_dep ).



SELECT *
  FROM ztsa0007
  INTO CORRESPONDING FIELDS OF TABLE gt_emp
  WHERE depid = gs_dep-depid.

cl_demo_output=>display_data( gt_emp ).
