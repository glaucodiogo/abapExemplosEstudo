*&---------------------------------------------------------------------*
*& Report  Z998904_GDA_EXER1
*&
*&---------------------------------------------------------------------*

REPORT  z998904_gda_exer1.

*--------------------------------------------------------------------*
* Tipos
*--------------------------------------------------------------------*
TYPES: BEGIN OF ty_tab_func,
          matricula TYPE n LENGTH 10,
          nome      TYPE c LENGTH 30,
          salario   TYPE p DECIMALS 2,
       END OF ty_tab_func.

*--------------------------------------------------------------------*
* Tabelas internas
*--------------------------------------------------------------------*

DATA it_func TYPE STANDARD TABLE OF ty_tab_func.

*--------------------------------------------------------------------*
* Estruturas
*--------------------------------------------------------------------*


TOP-OF-PAGE.
  PERFORM imprimir_cabecalho.

  DATA st_func TYPE ty_tab_func.

*--------------------------------------------------------------------*
* Parâmetros de entrada
*--------------------------------------------------------------------*
  PARAMETERS p_matric TYPE n LENGTH 10.

*--------------------------------------------------------------------*
* Processamento
*--------------------------------------------------------------------*
START-OF-SELECTION.
  PERFORM preencher_tabela.
  PERFORM pesquisar_matricula.

*&---------------------------------------------------------------------*
*&      Form  PREENCHER_TABELA
*&---------------------------------------------------------------------*
FORM preencher_tabela .
  "Inserir 5 linhas na tabela interna
  CLEAR st_func.
  st_func-matricula = '0001'.
  st_func-nome      = 'Glauco'.
  st_func-salario   = '1.50'.
  APPEND  st_func TO it_func.

  CLEAR st_func.
  st_func-matricula = '0002'.
  st_func-nome      = 'Joy'.
  st_func-salario   = '3.50'.
  APPEND  st_func TO it_func.

  CLEAR st_func.
  st_func-matricula = '0003'.
  st_func-nome      = 'Nicolas'.
  st_func-salario   = '100'.
  APPEND  st_func TO it_func.

  CLEAR st_func.
  st_func-matricula = '0004'.
  st_func-nome      = 'Nadir'.
  st_func-salario   = '1.50'.
  APPEND  st_func TO it_func.

  CLEAR st_func.
  st_func-matricula = '0005'.
  st_func-nome      = 'Wander'.
  st_func-salario   = '1.50'.
  APPEND  st_func TO it_func.
ENDFORM.                    " PREENCHER_TABELA
*&---------------------------------------------------------------------*
*&      Form  PESQUISAR_MATRICULA
*&---------------------------------------------------------------------*
FORM pesquisar_matricula .
  "Ler a tab. interna com a matricula, se encontrar imprimir
  READ TABLE  it_func INTO st_func WITH KEY matricula = p_matric.

  IF sy-subrc = 0.
    st_func-salario = st_func-salario + ( st_func-salario * '0.10' ) .
    WRITE:/ st_func-matricula,
            st_func-nome,
            st_func-salario.
  ELSE.
    WRITE: 'Matrícula não existe'.
  ENDIF.
ENDFORM.                    " PESQUISAR_MATRICULA
*&---------------------------------------------------------------------*
*&      Form  IMPRIMIR_CABECALHO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM imprimir_cabecalho .
  FORMAT COLOR COL_KEY.
  WRITE:/ 'Matricula',
          AT 12 'Nome',
          AT 50 'Salário'.

ENDFORM.                    " IMPRIMIR_CABECALHO
