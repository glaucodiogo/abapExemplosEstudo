*&---------------------------------------------------------------------*
*& Report  Z998904_GDA_EXER1
*&
*&---------------------------------------------------------------------*

REPORT  z998904_gda_exer2.

*--------------------------------------------------------------------*
* Tipos
*--------------------------------------------------------------------*
TYPES: BEGIN OF ty_tab_estados,
          uf    TYPE c LENGTH 2,
          desc  TYPE c LENGTH 30,
       END OF ty_tab_estados.

*--------------------------------------------------------------------*
* Tabelas internas
*--------------------------------------------------------------------*

DATA it_estado TYPE STANDARD TABLE OF ty_tab_estados.

*--------------------------------------------------------------------*
* Estruturas
*--------------------------------------------------------------------*


  DATA st_estado TYPE ty_tab_estados.

*--------------------------------------------------------------------*
* Parâmetros de entrada
*--------------------------------------------------------------------*
  PARAMETERS p_matric TYPE n LENGTH 10.

*--------------------------------------------------------------------*
* Processamento
*--------------------------------------------------------------------*
START-OF-SELECTION.
  PERFORM preencher_tabela.
  PERFORM exibir_alv.


*&---------------------------------------------------------------------*
*&      Form  PREENCHER_TABELA
*&---------------------------------------------------------------------*
FORM preencher_tabela .
  "Inserir 5 linhas na tabela interna
  CLEAR st_estado.
  st_estado-uf = 'MG'.
  st_estado-desc      = 'Minas Gerais'.
  APPEND  st_estado TO it_estado.

  CLEAR st_estado.
  st_estado-uf    = 'RJ'.
  st_estado-desc  = 'Rio de Janeiro'.
  APPEND  st_estado TO it_estado.

  CLEAR st_estado.
  st_estado-uf = 'SP'.
  st_estado-desc      = 'São Paulo'.
  APPEND  st_estado TO it_estado.

ENDFORM.                    " PREENCHER_TABELA
*&---------------------------------------------------------------------*
*&      Form  EXIBIR_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM exibir_alv .
  DATA: lo_alv TYPE REF TO cl_salv_table, "Classe mais atual no momento para se criar ALV
        lo_functions TYPE REF TO cl_salv_functions_list.

  TRY.

    CALL METHOD cl_salv_table=>factory(
      IMPORTING
        r_salv_table   = lo_alv
      CHANGING
        t_table        = it_estado ).

    lo_functions = lo_alv->get_functions( ).
    lo_functions->set_all( abap_true ).

    lo_alv->display( ).
  CATCH cx_salv_msg.
  ENDTRY.

ENDFORM.                    " EXIBIR_ALV
