*&---------------------------------------------------------------------*
*& Report ZRSA07_06
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA07_06.

PARAMETERS pa_i TYPE i.
" A, B, C, D만 입력 가능
PARAMETERS pa_class TYPE c LENGTH 1.
DATA gv_result LIKE pa_i.



* 10보다 크면 출력하고,
* 20보다 크면 10을 더하세요.
" A반이라면, 입력한 값에 모두 100을 더하세요.

*IF pa_i > 10.      "1번째방법
*WRITE pa_i.
*ENDIF.
*
*
*
*IF pa_i > 20.
*" CLEAR gv_result.
*
*
*gv_result = pa_i + 10.
*WRITE gv_result.
*
*
*" CLEAR gv_result. "gv_result 변수의 값을 더이상 안쓴다. 쓰면 CLEAR
*
*  ENDIF.


IF pa_i > 20.     "2번째 방법


ELSE.
 IF pa_i > 10.


   ENDIF .

ENDIF.


*IF pa_i > 20.             "3번째 방법
*
*
*  ELSEIF pa_i > 10.
*
*  ELSE.
*
*  ENDIF.



*  CASE 변수.
*    WHEN 값.
*      WHEN OTHERS.
*
*  ENDCASE.


" 뭔가 추가되면 우선순위를 파악해야함!!! 스스로 생각 !

*  CASE pa_class.                " OTHERS=ELSE.
*    WHEN 'A'.
*      gv_result = pa_i + 100.
*    WHEN OTHERS.
*      IF pa_i > 20.
*
*        ELSE.
*          IF pa_i > 10.
*
*      ENDIF.
*ENDCASE.
