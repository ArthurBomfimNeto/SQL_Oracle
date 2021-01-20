
--====================== TO_DATE==================================

describe tb_historico_funcao; 

insert into tb_historico_funcao(id_empregado, data_inicio, data_termino, id_funcao, id_departamento)
values (203,  to_date('01/fev/2000'),  to_date('01/fev/2010'),'MK_MAN' , 50)


SELECT * 
FROM tb_historico_funcao;

ROLLBACK;

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


-- MONTH 

SELECT to_char(SYSDATE,'MM'),
       to_char(SYSDATE, 'MONTH'),
       to_char(SYSDATE, 'month'),
       to_char(SYSDATE, 'MON'),
       to_char(SYSDATE, 'Mon'),
       to_char(SYSDATE, 'RM') ROMANOS,
       to_char(to_date('01/fev/2020'), 'RM') ROMANOS
FROM dual;       

-- WEEK (SEMANA)

SELECT to_char(SYSDATE, 'WW'),
       to_char(SYSDATE, 'IW'),
       to_char(SYSDATE, 'W')
FROM dual;    

-- DAY 

SELECT to_char(SYSDATE,'DDD'),
       to_char(SYSDATE, 'DD'),
       to_char(SYSDATE, 'D'),
       to_char(SYSDATE, 'DAY'),
       to_char(SYSDATE, 'Day'),
       to_char(SYSDATE, 'DY') ,
       to_char(SYSDATE, 'Dy') ,
        to_char(SYSDATE, 'j')
FROM dual;        
      
-- HOUR  MINUTE  SECOND


SELECT to_char(SYSDATE,'HH24')hour,
       to_char(SYSDATE, 'HH') hour,
       to_char(SYSDATE, 'MI') minute,
       to_char(SYSDATE, 'SS') second,
       to_char(SYSDATE, 'SSSSS')second
FROM dual;       

-- FORMATOS 

SELECT to_char(SYSDATE,'MONTH DD, YYYY'),
       to_char(SYSDATE, 'MM/DD/YYYY'),
       to_char(SYSDATE, 'MM-DD-YYYY'),
       to_char(SYSDATE, 'DD/MM/YYYY'),
       to_char(SYSDATE, 'Day MON, YYY AD'),
       to_char(SYSDATE, 'DDSPTH "of" MONTH, YEAR A.D.') ,
       to_char(SYSDATE, 'CC') ,
        to_char(SYSDATE, 'Q')
FROM dual;    

-- TO_DATE

SELECT to_char(to_date('05-02-2012'), 'MONTH DD, YYYY')
FROM dual;

SELECT to_date('01-JUL-2013'), to_date('01-Jul-13')
FROM dual;

SELECT to_date('Jul 01, 2021', 'MONTH DD, YYYY')
FROM dual;


SELECT Parameter
FROM nls_session_parameters

describe nls_session_parameters;


ALTER SESSION SET nls_date_format= 'Mon/dd/yyyy';


-- DATA FINAL E EXIBIDA DE ACORDO COM NLS_DATE_FORMAT
SELECT TO_DATE('7.4.13', 'MM.DD.YY')
FROm dual;

describe tb_historico_funcao;



Alter session set NLS_DATE_FORMAT = 'Mon/dd/yyyy'; -- Alterado a forma de como as datas de exibem

insert into tb_historico_funcao 
values(300, to_date('Jan 04, 2021 19:32:22', 'MONTH DD, YYYY HH24:MI:SS'),
            to_date('Jul 04, 2021 19:32:22', 'MONTH DD, YYYY HH24:MI:SS'), 'AD_VP', 90);
     
     
--Formas de exibir datas             
select id_empregado, to_char(data_inicio, 'DD-MM-YYYY HH-MI-SSSS')
from tb_historico_funcao;

-- Mesclando to_char com to_date
SELECT to_char(to_date('Mai/05/2021 20:34:44', 'MONTH DD, YYYY HH24:MI:SS'), 'HH:MI:SSSS')
FROM dual;

select * 
from nls_session_parameters;

--altera para utilizar na sessao 
alter session set nls_date_format = 'Mon/dd/yyyy';

alter session set nls_date_format = 'DD/MM/YYYY';

--Se utilizar YY o mesmo considera o seculo atual 

SELECT to_char(to_date('Jun 03, 15', 'month dd, yy'), 'month dd, yyyy'),
      to_char(to_date('Jun 03, 75', 'month dd, yy'), 'month dd, yyyy')
FROM dual;

-- Utilizar RR para considerar o ano correto, pois de 50 a 99 ele considera o ano atual menos 1 


SELECT to_char(to_date('MAI 04, 21', 'Month dd, RR'), 'MM DD, YYYY'),
       to_char(to_date('MAI 04, 75', 'Month dd, RR'), 'MM DD, YYYY')
FROM dual;


--===== ADD_MONTHS(x,y) ======

--Adiciona ou subtrai meses da data 
alter session set nls_date_format = 'Mon/dd/yyyy';

SELECT ADD_MONTHS('Jul 01, 2020', 13)
FROM dual;

SELECT ADD_MONTHS('Jul 01, 2020', -13)
FROM dual;

----------------------

alter session set nls_date_format = 'DD/MM/YYYY';
--Adiciona 13 meses
SELECT ADD_MONTHS('01/07/2021', 13)
FROM dual;

-- Subtrai 13 meses
SELECT ADD_MONTHS('01/07/2021', -13)
FROM dual;

--======== LAST_DAY(x) Retorna o ultimo dia do mes 

SELECT LAST_DAY('Fev 01, 2013')
FROM dual;

--======= MONTHS_BETWEEN(x,y) encontra os meses que estao entre duas datas 

SELECT MONTHS_BETWEEN('Jan 19, 2021', 'Jan 19, 2022')
FROM dual;


--Utilizando o MONTHS_BETWEEN na tabela tb_historico_funcao
SELECT TRUNC(MONTHS_BETWEEN(data_termino, data_inicio),2) "Periodo entre datas ", 
       SUBSTR(TO_CHAR(TRUNC(MONTHS_BETWEEN(data_termino, data_inicio),2)),1,2)  as MESES,
       SUBSTR(TO_CHAR(TRUNC(MONTHS_BETWEEN(data_termino, data_inicio),2)),4)  as DIAS 
FROM tb_historico_funcao;

--Acha a data mais proxima do dia da semana sendo 
-- 1  Monday – Segunda-feira,
-- 2  Tuesday – Terça-feira,
-- 3  Wednesday – Quarta-feira,
-- 4  Thursday – Quinta-feira,
-- 5  Friday – Sexta-feira,
-- 6  Saturday – Sábado,
-- 7  Sunday – Domingo.

SELECT NEXT_DAY('Jan 19, 2021', 1)
FROM dual;

alter session set nls_date_format = 'mon/dd/yyyy';

--ROUND(x, unidade) arredonda dia mes ano hora

--Arredondamento para o dia do ano mais proximo
SELECT ROUND(to_date('jul 03,2021'), 'yyyy') ANO
FROM dual;

--Arredondamento para o dia do mes mais proximo 

SELECT ROUND(to_date('jan 22,2020'),'mm') MES
FROM dual;

-- Arredondamento da hora mais proxima

SELECT TO_CHAR(ROUND(to_date('Jul 02,2020 19:44:22', 'MONTH DD, YYYY HH24:MI:SS'), 'HH24'),'MONTH DD, YYYY HH24:MI:SS')
FROM dual;

-- Arredondamento do minuto mais proximo

SELECT TO_CHAR(ROUND(to_date('Jul 02,2020 19:44:22', 'MONTH DD, YYYY HH24:MI:SS'), 'MI'),'MONTH DD, YYYY HH24:MI:SS')
FROM dual;

--SYSDATE data atual

SELECT to_date(SYSDATE)
FROM dual;

--EXTRACT 

SELECT EXTRACT(YEAR FROM SYSDATE) ANO,
       EXTRACT(MONTH FROM TO_DATE('jan 09, 2020')) MES,
       EXTRACT(DAY FROM SYSDATE) DIA,
       EXTRACT(HOUR FROM TO_TIMESTAMP('jan 03, 2010 14:33:33', 'month dd, yyyy HH24:MI:SS')) HORA,
       EXTRACT(MINUTE FROM TO_TIMESTAMP('jan 03, 2010 14:33:33', 'month dd, yy HH24:MI:SS')) MINUTOS,
       EXTRACT(MINUTE FROm TO_TIMESTAMP('Jul 03, 2010 14:33:33', 'month dd, yy HH24:MI:SS')) SEGUNDOS
from dual;

