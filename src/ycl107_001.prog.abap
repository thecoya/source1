*&---------------------------------------------------------------------*
*& Report YCL107_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE YCL107_001_TOP                          .    " Global Data, 전연변수 선언

INCLUDE YCL107_001_CLS.                             "ALV 관련 선언
INCLUDE YCL107_001_SCR.                             "검색화면

INCLUDE YCL107_001_PBO                          .  " PBO-Modules
INCLUDE YCL107_001_PAI                          .  " PAI-Modules
INCLUDE YCL107_001_F01                          .  " FORM-Routines/SUBROUTIN


INITIALIZATION.
  "report프로그램은 이벤트 구간이 다름
  " 프로그램 실행 시, 가장 처음에 1회만 수행된믄 이벤트 구간
TEXTT01 = '검색조건'.   "변수로 만들 수 있게 하는 이유는  ?
                          "변수는 값이 변하므로 상황에 따라 메시지를 바꿀 수 있으므로

AT SELECTION-SCREEN OUTPUT.
  " 검색화면에서 화면이 출력되기 직전에 수행되는 구간
  " 주용도는 검색화면에 대한 제어( 특정 필드 숨김 또는 읽기 전용 )
AT SELECTION-SCREEN.
  " 검색화면에서 사용자가 특정 이벤트를 발생시켰을 때 수행되는 구간
  " 상단의 function key 이벤트, 특정필드의 클릭, 엔터 등의 이벤트에서
  " 입력값에 대한 점검, 실행 권한 점검
START-OF-SELECTION.
  "검색화면에서 실행버튼 눌렀을 때 수행되는 구간
  "데이터 조회 +(출력까지 가능)

  PERFORM SELECT_DATA.

END-OF-SELECTION.

IF gt_scarr[] is INITIAL.
MESSAGE '데이터가 없습니다.' TYPE 'S' DISPLAY LIKE 'W'. "메시지는 2가지 타입
" 프로그램을 계속 이어서 진행되도록 만드는 타입
" S, I
" S ( 하단에 메시지 출력하면서 계속 ),
" I ( 팝업창을 출력하면서 일시정지 )
"프로그램을 중단시키는 타입
" W, E, X
ELSE.
  CALL SCREEN 0100.
ENDIF.
  "START-OF-SELECTION.이 끝나고 실행되는 구간
  "데이터 출력
