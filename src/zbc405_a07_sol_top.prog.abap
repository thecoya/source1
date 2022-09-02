*&---------------------------------------------------------------------*
*& Include ZBC405_A07_SOL_TOP                       - Report ZBC405_A07_SOL
*&---------------------------------------------------------------------*
REPORT zbc405_a07_sol.

*DATA gs_flt TYPE dv_flights.   "라인 타입이 아님  "select from 다음에 table도 되지만 DB view(두테이블의 조인)도 된다.
*
*
*PARAMETERS p_car TYPE s_carr_id MEMORY ID CAR.   "숫자일 경우 decimal 쓰기.
*
*
*"MEMORY ID -> DATA ELEMENT에 있고, 만들어서 쓸 수 있고, 다른프로그램에서도 동일한 입력값을 기억하고 있다.(ex. AA)
*"호출할 때, 그냥 별도로 SET할때
*
**SET PARAMETER ID car FIELD p_car.   "p_car 에 para id car에 있는거 set해라.
*
*set PARAMETER ID 'z01' FIELD p_car.
*get PARAMETER ID 'z01' FIELD p_car.  " 'z01'에 있는 데이터를 p_car로 불러와.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.

DATA : gs_flt TYPE dv_flights.

PARAMETERS : p_car TYPE dv_flights-carrid       "s_carr_id
                   MEMORY ID car
                   OBLIGATORY
                   DEFAULT 'LH' VALUE CHECK,  "scarr에 없는 데이터 입력하면 에러나는ㄴ것
             p_con TYPE s_conn_id  MEMORY ID con OBLIGATORY.


SELECT-OPTIONS : s_fldate for dv_flights-fldate.
SELECTION-SCREEN end of BLOCK b1.     "또 다른 block 만들 때 다른 이름 필수 !!

SELECTION-SCREEN SKIP 2.



*PARAMETERS : p_str TYPE string LOWER CASE.

PARAMETERS : p_chk AS CHECKBOX DEFAULT 'X' MODIF ID mod. "체크박스 만드는 것.

*INITIALIZATION.

LOOP AT SCREEN.
  IF screen-group1 = 'MOD'.

    screen-input = 0. "입력 못하게
    screen-output = 1. "output만가능
    MODIFY SCREEN.
  ENDIF.
ENDLOOP.



PARAMETERS : p_rad1 RADIOBUTTON GROUP rd1,    "그룹 이름
             p_rad2 RADIOBUTTON GROUP rd1,
             p_rad3 RADIOBUTTON GROUP rd1.


INITIALIZATION.

s_fldate-low = sy-datum.
s_fldat-hight = sy-datum + 30.

s_fldate_sign = 'I'.
s_fldate_option = 'BT'.

APPEND s_fldate.



"memory id
"obligatory : obligatory 필수 입력
"default
"lower case : 대문자 입력해도 소문자로 인식/출력.
"value check : value 입력하는 데, value table/check table/ fkey 에 연결되지 않은 값 입력하면 에러난다. 벨류체크 시 type은 스터럭쳐로
"check box :
"radio button : case문을 쓰면 좋다.
"modify id : id를 주고 스크린을 modify한다. 입력불가하게/보이게 안보이게/
""modif <id>는   abap에서 제공하는 스크린이라는 internal table이 있는데 str타입의 컴포가 modif id다. 여러개 컴포를
""묵어서 modif id를 할 수 있다.

*CASE 'X'.
*  WHEN p_rad1.
*
*  WHEN p_rad2.
*
*  WHEN p_rad3.
*
*ENDCASE.

"no extenstion : 추가입력 x
"no interval : to를 없앤것

"goto-> text element -> selection text -> text를 줄 수 있다.
"goto-> translate

"loop 써서 그냥 연산될 수 있는게 헤더라인 internal table.
"select option는 internal table이고 parameter와 다르고, workarea를 가진 테이블이고
"사인 옵션이 정해진 타입이 있고, select option의 변수 값을 참조한다.
"자기 자신이 workarea가 되는 특별한 internal table.



"range 타입의  table은 select option의 테이블처럼 만드는 것???
