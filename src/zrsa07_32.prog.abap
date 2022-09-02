*&---------------------------------------------------------------------*
*& Report ZRSA07_32
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA07_32.

"EMP INFO.


DATA gs_emp TYPE ZSSA0710.

PARAMETERS pa_pernr LIKE gs_emp-pernr.

INITIALIZATION.


pa_pernr = '20120018'.


START-OF-SELECTION.
  SELECT SINGLE *
    FROM ZTSA0007   "Employee Table
    INTO CORRESPONDING FIELDS OF gs_emp
    WHERE PERRNR = pa_PERNR.


IF sy-subrc <> 0.
  MESSAGE i001(zmcsa07).  "data is not found
  return.
ENDIF.

*WRITE gs_emp-depid.
*NEW-LINE.
*WRITE gs_emp-dep-depid.


SELECT SINGLE *
    FROM ztsa0002
    INTO gs_emp-dep
    WHERE depid = gs_emp-depid.


    cl_demo_output=>display_data( gs_emp-dep ).
