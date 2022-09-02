*&---------------------------------------------------------------------*
*& Report ZRSA07_34
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA07_34.

"dep info
DATA gs_dep TYPE zssa0011.
DATA gt_dep LIKE TABLE OF gs_dep.


"emp info (structure variable)
DATA gs_emp LIKE LINE OF gs_dep-emp_list.



PARAMETERS pa_dep TYPE ztsa07200701-depid.

START-OF-SELECTION.
 SELECT SINGLE *
    FROM ztsa0007
    INTO  CORRESPONDING FIELDS OF gs_dep
   WHERE depid = pa_dep.

   IF sy-subrc <> 0 .
     return.

   ENDIF.


   "get employee list

   SELECT *
      FROM ztsa0007 "employ table
     INTO CORRESPONDING FIELDS OF TABLE gs_dep-emp_list
     WHERE depid = gs_dep-depid.


     LOOP AT gs_dep-emp_list INTO gs_emp.

MODIFY gs_dep-emp_list FROM gs_emp.


clear gs_emp.

     ENDLOOP.
