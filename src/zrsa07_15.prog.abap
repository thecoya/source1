*&---------------------------------------------------------------------*
*& Report ZRSA07_15
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA07_15.


DATA: begin of gs_std,
        stdno TYPE n LENGTH 8,   "숫자로만 되어있는 n
        sname TYPE c LENGTH 40,
        gender TYPE c LENGTH 1,
        gender_t TYPE c LENGTH 10, " 사용자에게 보여주기 위해 gender_t TYPE c LENGTH 10,

    END OF gs_std.

DATA gt_std LIKE TABLE OF gs_std.    "structure 변수를 internal table 형태로 만든다. "internal table의 initial value는 테이블 자체가 없는 무의 상태
"형태는 있지만 값은 없는    창고같은 용도의 internal table.

gs_std-stdno = '20220001'.    "확인하는 단계가 디버깅
gs_std-sname = 'KWON'.
gs_std-gender = 'M'.
APPEND gs_std TO gt_std.
CLEAR gs_std.  "여기서부터 clear가 굉장히 중요해진다.

gs_std-stdno = '20220002'.
gs_std-sname = 'JAY'.
gs_std-gender = 'M'.
APPEND gs_std TO gt_std.
CLEAR gs_std.


"2번 LOOP 예시
LOOP AT gt_std INTO gs_std.
gs_std-gender_t = 'Male'(t01).  "structure 변수만 바뀌었다.
MODIFY gt_std FROM gs_std.    "loop문에서 잘쓴다. internal table을 structure 변수를 통해 수정해.
CLEAR gs_std.
ENDLOOP.


*cl_demo_output=>display_data(gt_std).  "INTERNAL TABLE 출력을 위해.

CLEAR gs_std.

* (READ TABLE 쓰는 방법1)READ TABLE gt_std INDEX 1 INTO gs_std.
READ TABLE gt_std WITH KEY stdno = '20220001'     "정확한 한개의 값을 가져옴
INTO gs_std.        " (READ TABLE 쓰는 방법2)

" 1번 LOOP 예시
*LOOP AT gt_std INTO gs_std.       "internal table에 있는 테이블을 gs_std 스트럭처변수에 담아라.
*   WRITE:/ sy-tabix, gs_std-stdno,  "출력하라
*          gs_std-sname, gs_std-gender.
*   NEW-LINE.
*   CLEAR gs_std.         "클리어
*ENDLOOP.







*DATA: gs_xxx TYPE <structure_type>,
*      gt_xxx LIKE TABLE OF gs_xxx.
*
*DATA: gt_xxx TYPE <table_type>,
*      gs_xxx LIKE LINE OF gt_xxx.
*
*DATA: gt_xxx TYPE TABLE OF <struture_type>,
*      gs-xxx LIKE LINE OF gt_xxx.
*
*DATA: gs_xxx TYPE LINE OF <table_type>,
*      gt_xxx LIKE TABLE OF gs_xxx.
*
*
*DATA: gs_xxx TYPE LINE OF <table_type>,
*      gt_xxx LIKE LINE OF gs_xxx.             "structure만 사용할건지, internal table위해 structure를 사용할 건지 생각.
