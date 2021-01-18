
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

alter system set nls_date_format = 'DD/MM/YYYY';

--Se utilizar YY o mesmo considera o seculo atual 

SELECT to_char(to_date('Jun 03, 15', 'month dd, yy'), 'month dd, yyyy')
FROM dual;