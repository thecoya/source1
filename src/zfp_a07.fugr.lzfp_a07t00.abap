*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZSAPLANE_A07....................................*
DATA:  BEGIN OF STATUS_ZSAPLANE_A07                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSAPLANE_A07                  .
CONTROLS: TCTRL_ZSAPLANE_A07
            TYPE TABLEVIEW USING SCREEN '0080'.
*...processing: ZSCARR_A07......................................*
DATA:  BEGIN OF STATUS_ZSCARR_A07                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSCARR_A07                    .
CONTROLS: TCTRL_ZSCARR_A07
            TYPE TABLEVIEW USING SCREEN '0050'.
*...processing: ZSFLIGHT_A07....................................*
DATA:  BEGIN OF STATUS_ZSFLIGHT_A07                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSFLIGHT_A07                  .
CONTROLS: TCTRL_ZSFLIGHT_A07
            TYPE TABLEVIEW USING SCREEN '0060'.
*...processing: ZSPFLI_A07......................................*
DATA:  BEGIN OF STATUS_ZSPFLI_A07                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSPFLI_A07                    .
CONTROLS: TCTRL_ZSPFLI_A07
            TYPE TABLEVIEW USING SCREEN '0030'.
*.........table declarations:.................................*
TABLES: *ZSAPLANE_A07                  .
TABLES: *ZSCARR_A07                    .
TABLES: *ZSFLIGHT_A07                  .
TABLES: *ZSPFLI_A07                    .
TABLES: ZSAPLANE_A07                   .
TABLES: ZSCARR_A07                     .
TABLES: ZSFLIGHT_A07                   .
TABLES: ZSPFLI_A07                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
