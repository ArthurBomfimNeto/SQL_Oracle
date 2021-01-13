-- -------TO_CHAR para converter data/hora ---------
-- script nao interfere se minusculo ou maiusculo 
SELECT id_empregado, to_char(data_inicio, 'month dd,yyyy') manipulado_mini, data_inicio, to_char(data_inicio, 'MONTH DD,YYYY') manipulado_maiscula
FROM tb_historico_funcao;

-- Obtendo data e hora atual 
SELECT to_char(SYSDATE, 'MONTH DD, YYYY, HH24:MI:SS'), SYSDATE
FROM dual;

--Parametros de formataçao

--Century(seculo)
SELECT to_char(SYSDATE, 'CC') Century, to_char(SYSDATE, 'SCC') Century
FROM dual;

--Quarter(trimestre)

SELECT to_char(SYSDATE, 'Q')
FROM dual;

--YEAR(ano)

SELECT to_char(SYSDATE, 'yyyy' ) yyyy,
       to_char(SYSDATE, 'IYYY') IYYY, 
       to_char(SYSDATE, 'RRRR') RRRR , 
       to_char(SYSDATE, 'SYYYY' ) SYYYY
FROM dual;

SELECT to_char(SYSDATE, 'Y,YYY' ), 
       to_char(SYSDATE, 'YYY') YYY, 
       to_char(SYSDATE, 'IYY') IYY, 
       to_char(SYSDATE, 'YY')  YY, 
       to_char(SYSDATE, 'IY')  IY,
       to_char(SYSDATE, 'RR')  RR,
       to_char(SYSDATE, 'Y')  Y,
       to_char(SYSDATE, 'I')  I,
       to_char(SYSDATE, 'YEAR')  as "YEAR",
       to_char(SYSDATE, 'Year')  "Year"
FROM dual;