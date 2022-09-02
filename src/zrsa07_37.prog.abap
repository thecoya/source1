*&---------------------------------------------------------------------*
*& Report ZRSA07_37
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa07_37.


DATA: gs_info TYPE zvsa0702, "database view
      gt_info LIKE TABLE OF gs_info.

PARAMETERS pa_dep LIKE gs_info-depid.

*START-OF-SELECTION.


"누구나 쓸 수 있는 db-view는 사람들이 잘 안씀
*  SELECT *
*    FROM zvsa0702 "database view "사원정보 조회할때 db view를 쓴것
*    INTO CORRESPONDING FIELDS OF TABLE gt_info
*    WHERE depid = pa_dep.

  "cl_demo_output=>display_data( gt_info ).

  "call by reference 개념 -> internal table 정보 많으니까,
  "type자리에 데이타view를 넣으면
  "form-endform에 기 선언된 테이블 변수도 사용 가능..
  "잘못된 출력 데이터 입력 시, 안나온다


" 나만의 inner join 방식
"OPEN SQL
*  SELECT *   111
*    FROM ztsa0007 INNER JOIN ztsa07200701
*      ON ztsa0007~depid = ztsa07200701~depid
*    INTO CORRESPONDING FIELDS OF TABLE gt_info
*    WHERE ztsa0007~depid = pa_dep.


*    SELECT a~perrnr a~ename a~depid b~phone  "222
*       FROM ztsa0007 AS a INNER JOIN ztsa07200701 as b
*        ON a~depid = b~depid
*      INTO CORRESPONDING FIELDS OF TABLE gt_info
*      WHERE a~depid = pa_dep.



SELECT *
  FROM ztsa0007 AS emp INNER JOIN ztsa07200701 as dep
  on emp~depid = dep~depid
  INTO CORRESPONDING FIELDS OF TABLE gt_info.


*SELECT *
*  FROM ztsa0007 AS emp LEFT OUTER ztsa07200701 as dep
*  on emp~depid = dep~depid
*  INTO CORRESPONDING FIELDS OF TABLE gt_info.




cl_demo_output=>display_data( gt_info ).





    "db view는 실제 db테이블에 만들어지기 때문에, open sql과 관련이 없고, db view에서 mandt를 빼는 경우 가 발생
    "db view와 inner join 중 inner join 많이 쓴다.
