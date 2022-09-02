*&---------------------------------------------------------------------*
*& Include          YCL107_001_CLS
*&---------------------------------------------------------------------*


" ALV
" 1. LIST
"     ㄴ WRITE
" 2. Functional ALV
"     ㄴ reuse
" 3. Class ALV
"     ㄴ Simple ALV  (편집불가)
"     ㄴ Grid ALV    (대다수)
"     ㄴ ALV with IDA(최신)


" CONTAINER
" 1. Custom Container (100번화면에서 layout 그려서 만든것)
" 2. Docking Container ( 프로그램의 화면이 지속적으로 추가, 언제든지 이벤트에 화면을 추가하여 만들 수 있음)
" 3. Splitter Container ( 하나의 컨테이너를 n개로 쪼개주는 것 )
DATA: GR_CON TYPE REF TO CL_GUI_DOCKING_CONTAINER,  "공간을 하나 만들면
      GR_SPLIT TYPE REF TO CL_GUI_SPLITTER_CONTAINER,
      GR_CON_TOP TYPE REF TO CL_GUI_CONTAINER,
      GR_CON_ALV TYPE REF TO CL_GUI_CONTAINER.

"네모난 영역을 만들고 top이랑 sub를 누가 나눠가져야할지 정함

DATA: GR_ALV TYPE REF TO CL_GUI_ALV_GRID,
      GS_LAYOUT TYPE LVC_S_LAYO,   "어떤 형태로 출력?
      GT_FIELDCAT TYPE LVC_T_FCAT,  " 어떤 필드를 출력?
      GS_FIELDCAT TYPE LVC_S_FCAT,
      gs_variant TYPE disvariant,
      gs_save TYPE c.
