*&---------------------------------------------------------------------*
*& Include ZRSA07_23_TOP                            - Report ZRSA07_23
*&---------------------------------------------------------------------*
REPORT ZRSA07_23.




"스케쥴 정보(DATE INFO)



DATA: gt_info TYPE TABLE OF zsinfo00,
     gs_info LIKE LINE OF gt_info.



" SELECTION-SCREEN도 글로벌 변수다.

PARAMETERS: pa_car TYPE sbook-carrid,     " -> sbook-xxxx 이면 이유를 몰라서 동작하는 방법을 모르면 못쓴다.
            pa_con TYPE sbook-connid.

*1번 방식 sbook
*2번 방식

" 프로그램의 메인 테이블을 찾아서 분석
