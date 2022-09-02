*&---------------------------------------------------------------------*
*& Report ZBC405_A07_TYPE_PRACTICE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_a07_type_practice.


DATA gv_type TYPE c LENGTH 20.
DATA gv_deci TYPE p LENGTH 5 DECIMALS 2.

DATA gv_no TYPE n LENGTH 8.

DATA gv_spl TYPE p LENGTH 10 DECIMALS 2.

gv_spl = 'ABCDEFGHIJ'.

WRITE : gv_spl.
