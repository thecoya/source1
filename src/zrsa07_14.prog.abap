*&---------------------------------------------------------------------*
*& Report ZRSA07_14
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA07_14.


*DATA: gv_cat_name TYPE c  LENGTH 10,
*      gv_cat_age TYPE i.
*
*DATA: BEGIN OF gs_cat,
*        name TYPE c LENGTH 10,     "component. // field와 차이.
*        age TYPE i,
*      END OF gs_cat.


*TYPES:BEGIN OF ts_cat,
*        home TYPE c LENGTH 10,
*        name TYPE c LENGTH 10,
*        age TYPE i,
*      END OF ts_cat.
*
*DATA gs_cat TYPE ts_cat.


"스트럭쳐의 필드의 타입은 각각의 컴포넌트 타입에 따라 달라짐


"Transparent Table = structure type 중 하나이다.

DATA gs_scarr TYPE scarr.

PARAMETERS pa_carr LIKE gs_scarr-carrid.

SELECT SINGLE carrid carrname url   "특정 필드를 가져오는게 더 낫다 but  * -> 테이블 정보를 다가져올 수 있다.
    FROM scarr
    INTO CORRESPONDING FIELDS OF
*    INTO gs_scarr
    WHERE carrid = pa_carr.

WRITE: gs_scarr-carrid, gs_scarr-carrname, gs_scarr-currcode.
