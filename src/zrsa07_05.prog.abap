*&---------------------------------------------------------------------*
*& Report ZRSA07_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA07_05.


*DATA gv_d1 TYPE d.
*DATA gv_d2 TYPE sy-datum.
*
*
*WRITE: gv_d1, gv_d2.


*DATA: gv_c1 TYPE c LENGTH 1,
*      gv_c2(1) TYPE c, "단어와 단어 사이에 space가 있어야 한다의 예외.
*      gv_c3 TYPE c,
*      gv_c4.    "뒤에 length를 줘야하니까 incomplete type임.


*DATA: gv_n1 TYPE n,
*      gv_n2 TYPE n LENGTH 2,
*      gv_i TYPE i.
*
*WRITE: gv_n1, gv_n2, gv_i.

*
*DATA gv_p TYPE p LENGTH 5 DECIMALS 5.
*gv_p = '133.45612451'.
*
*WRITE gv_p.


*TYPES t_name TYPE c LENGTH 10.    "변수가 아니라 타입을 선언                    " TYPE에는 value를 가질 수 없다. "local 타입(다른 프로그램에서는 쓸 수 없는 타입)을 쓰려면 선 정의 해줘야한다.
*DATA gv_name TYPE t_name.                             " 변수의 global/local 타입,  TYPE의 global/local의 의미는 다름.
*DATA gv_cname TYPE t_name.                            " local 타입 선언하는 게 많지는 않음


*DATA: gv_name TYPE c(기 선언된 타입)  LENGTH 20,
*      gv_cname LIKE gv_name(기 선언된 변수).

" 시스템 전체에서 쓸 변수 또는 타입 -> 글로벌 type



**DATA gv_ecode TYPE c LENGTH 4 VALUE 'SYNC'.
*CONSTANTS gc_ecode TYPE c LENGTH 4 VALUE 'SYNC'.     "CONSTANTS -> 지정된 value가 변경되지 않기 위해서 쓴다.
*
*gc_ecode = 'test'.
*
*WRITE gc_ecode.  " 단, 사용자는 sync로 확인.

*
*WRITE 'Last Name:'.
*WRITE 'Last Name:'.

*WRITE TEXT-t01. "Last Name"
*WRITE TEXT-t02. "First Name"        goto->text elements

WRITE 'New Name'(t02). "t02 = value 값이 항상 같아야한다.
WRITE 'First Name'(t02).
