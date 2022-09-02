*&---------------------------------------------------------------------*
*& Report ZBC401_T03_CL_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_t03_cl_a07.

INTERFACE intf.                            "인터페이스 선언 데이터와 메소드 메소드의 종류는?
  DATA : ch1 TYPE i,
         ch2 TYPE i.

  METHODS : met1.      "선언만 interface안에.. 구현은 class implementaion안에.
ENDINTERFACE.

CLASS cl1 DEFINITION.                   "각각의 클래스 선언 CL1 / 사용공간간 PUBLIC이다. / 따르는 INTERFACE는 위에 선언한대로 써줌.
  PUBLIC SECTION.
    INTERFACES intf.     "항상 public 에 선언.
ENDCLASS.

CLASS cl1 IMPLEMENTATION.         "CL1 클래스의 IMPLEMENTATION
  METHOD intf~met1.               "CL1클래스에서 실행할 메소드를 호출 / 추가적인 DATA선언 / 로직 설정 / 출력 까지?


    DATA : rel TYPE i.
    rel = intf~ch1 + intf~ch2.

    WRITE : / 'reuslt + :', rel.
  ENDMETHOD.
ENDCLASS.

CLASS cl2 DEFINITION.            "cL2 클래스의 IMPLEMENTATION
  PUBLIC SECTION.
    INTERFACES intf.     "항상 public 에 선언.


    " ALIASES를 활용하는 방법

    ALIASES calc_intf FOR intf~met1.
    ALIASES z_cl1 FOR intf~ch1.      "애칭을 줄 수 있다.
    ALIASES x_cl2 FOR intf~ch2.      "애칭을 줄 수 있다.


ENDCLASS.


CLASS cl2 IMPLEMENTATION.          "CL2클래스의 IMPLEMENTATION
  METHOD intf~met1.                "메소드 호출 / DATA 선언 / 로직 설정 / 출력
    DATA : rel TYPE i.
    rel = intf~ch1 * intf~ch2.

    WRITE : / 'reuslt * :', rel.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.                     "PAI

  DATA : clobj TYPE REF TO cl1.         "클래스를 탈 객체 선언 /

  CREATE OBJECT clobj.


  clobj->intf~ch1 = 10.                "객체에 클래스 연산 값
  clobj->intf~ch2 = 20.

  CALL METHOD clobj->intf~met1.


  DATA : clobj1 TYPE REF TO cl2.

  CREATE OBJECT clobj1.


  clobj1->intf~ch1 = 10.   "Attribute에 값을 주고,,
  clobj1->intf~ch2 = 20.

  CALL METHOD clobj1->intf~met1.


  "중복을 최소화 / 필요한 것을 공유한다 .
