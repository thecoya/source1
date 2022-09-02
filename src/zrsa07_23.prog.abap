*&---------------------------------------------------------------------*
*& Report ZRSA07_23
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa07_23_top                           .    " Global Data  탑에 글로벌 변수만 선언한다.

* INCLUDE ZRSA07_23_O01                           .  " PBO-Modules
* INCLUDE ZRSA07_23_I01                           .  " PAI-Modules
INCLUDE zrsa07_23_f01                           .  " FORM-Routines


*EVENT BLOCK

INITIALIZATION. "RUNTIME(프로그램 시작하면)에 최초에 딱 한번 실행.

**** IF sy-uname =
****    from
****
**** ENDIF.


AT SELECTION-SCREEN OUTPUT. "PBO 역할을 한다. 1000번 화면에 찍히기 전에

AT SELECTION-SCREEN. "PAI

START-OF-SELECTION. "EVENTS


******"get info List
****** PERFORM get info.
****** IF gt_info IS INITIAL.
******"s, I, E, X, A, W
******
******    cl_demo_output=>display_data( gt_info ).
****** ENDIF.


CLEAR gt_info.
  SELECT *
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_info
    WHERE carrid = pa_car
      AND connid = pa_con.

CLEAR gs_info.
    LOOP AT gt_info INTO gs_info.
"get Airline Name
      SELECT SINGLE carrname
        FROM scarr
        INTO gs_info-carrname
        WHERE carrid = gs_info-carrid.

"get Connection info
      SELECT SINGLE cityfrom  cityto
        FROM spfli
         INTO CORRESPONDING FIELDS OF gs_info     " corresponding 대신 ( gs_info-cityfrom, gs_info-cityto ) 쓸 수 있다 /다만 순서 중요
          WHERE carrid = gs_info-carrid
          AND   connid = gs_info-connid.

    MODIFY gt_info FROM gs_info. "INDEX sy-tabix. 생략 매우자주함
    CLEAR gs_info.


    ENDLOOP.


    cl_demo_output=>display_data( gt_info ).









"LOOP 안에서 SELECT / READ 가능
"READ TABLE은 효율적 사용을 위해..
"많이 쓰이는 부분은 SUB-ROUTINE으로 -> select문에서 into는 changing으로 받고,, USING은..
