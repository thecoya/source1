*&---------------------------------------------------------------------*
*& Report ZBC405_A07_PR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a07_pr_top                       .    " Global Data

* INCLUDE ZBC405_A07_PR_O01                       .  " PBO-Modules
* INCLUDE ZBC405_A07_PR_I01                       .  " PAI-Modules
* INCLUDE ZBC405_A07_PR_F01                       .  " FORM-Routines



INITIALIZATION. "초기값 설정
  gv_text = '버튼'.
gv_chg = 1.

tab1 = 'CAR_INFO'.
tab2 = 'Check'.

AT SELECTION-SCREEN OUTPUT. "pbo
  LOOP AT SCREEN.
    CASE screen-group1.
      WHEN 'GR1'.
        screen-active = gv_chg.    "o 또는 1이 들어가므로 변수로 준다. 변수 선언 필요  0을 주면 라디오버튼 안보인다, 1은 보인다. --> 다이나믹
        MODIFY SCREEN.
    ENDCASE.
  ENDLOOP.


  "PAI

AT SELECTION-SCREEN.     "버튼에 넣어서 활성화 유무를
  CHECK sy-dynnr = '1000'. "check 구문의 경우 1000번 스크린을 한번 돌아줘, 서브 스크린이 있을 경우, pai를 2번 돌기 때문에 어느 pai를 도는지 모르기 때문에 그대로 반복되므로
  CASE sscrfields-ucomm.     "안보이면 계속 안보임
    WHEN 'ON'.
      "gv_chg = 0.
      CASE gv_chg.
        WHEN '1'.
          gv_chg = 0.
        WHEN '0'.
          gv_chg = 1.
      ENDCASE.
  ENDCASE.
