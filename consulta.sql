--------------- Caulculo aritimetico ------------

select to_date('02/fev/2020') + 3, 5* 4 as multiplicacao
from dual ;

select ROUND((4*4) * (12/ 88), 2)
from tb_departamento
where id_departamento = 10;

select to_date('22-fev-2020') - to_date('24-mar-2020')
from dual;

select nome, salario, salario*1.2 as "20%"
from tb_empregado;

---------- DUAL ----------

-- composta por uma unica coluna com um valor x 


------------------- ELIMINAR TABELA ------------ 
DROP TABLE tb_departamento_teste CASCADE CONSTRAINTS; -- 

--------------- NULOS ----------------

select *
from tb_departamento 
where id_gerente is null ; -- conta todos os ids nuls dos id_gerente 

-- NVL 

select nvl(percentual_comissao, '0')
from tb_empregado; -- retora uma string quando o campo for null 

------------ NULLIF --------
--Compara a primeira expressao com a segunda caso igual retrna null se nao a primeira
select nome, length(nome) "expressao 1", 
       sobrenome, length(sobrenome) "expressao 2",
       nvl(to_char(nullif(length(nome), length(sobrenome))), 'TEM') as "resultado"
from tb_empregado
where nvl(to_char(nullif(length(nome), length(sobrenome))), 'TEM') = 'TEM';




select nullif( length(sobrenome),  length(nome)) as comparacao
from tb_empregado;

select * from tb_empregado 


select coalesce(to_char(percentual_comissao), to_char(id_gerente), 'Nenhum deles')
from tb_empregado;


select * from tb_empregado;


------- DISTINCT --------
select id_departamento, count(id_departamento)
from tb_empregado
group by id_departamento;

-- Elimina os dados suplicados 
select  distinct id_departamento
from tb_empregado;

--------------------- Comparando Valores ----------------

select * 
from tb_empregado 
where id_empregado <> 100 and id_empregado <> 101; -- diferente que com <> 

select * 
from tb_empregado 
where id_empregado != 100 and id_empregado != 101; -- diferente que com =!

select * 
from tb_departamento 
where id_departamento > all(10,20,30); -- Maior que todos os tres 


select * 
from tb_departamento 
where id_departamento = any(10,20,30); -- Igual que qualquer um dos tres 

select * 
from tb_empregado 
where id_empregado = some(100, 101, 102); -- igual o operador any 

                                                                                                                          
--------------------- OPERADOR SQL ---------------

----LIKE
select * 
from tb_empregado
where sobrenome like '%l_';

--ESCAPE 
select * 
from tb_promocao
where nome like '%|%%' escape '|'; -- ESCAPE diferenia os caracteres que tem que se pesquisados dos coringas 

-- IN 

select e.nome, f.base_salario
from tb_funcao f 
inner join tb_empregado e using(id_funcao)
where base_salario in (4000, 9000, 2000, 2500) -- Base salrios que sejam uma das que estao na lista 

-- NOT IN 

select *
from tb_localizacao
where id_localizacao not in (1000, 1100, 2000) -- id que nao seja os que estao na lista 

-- BETWEEN

select id_departamento, nome, sobrenome
from tb_departamento 
inner join tb_empregado using(id_departamento)
where id_departamento between 30 and 70
order by 1;

-- NOT BETWEEN 

select base_salario  
from tb_funcao
where base_salario not between 4000 and 11000;


-- AND OR NOT 

select id_departamento, sum(salario) "SOMA SALARIO", round(avg(salario), 2 ) "MEDIA SALARIO", id_gerente, count(id_gerente)
from tb_empregado
where data_admissao > '01/jan/98' and salario > 6000
group by id_departamento, id_gerente;

select * 
from tb_historico_funcao
where data_inicio > '13/jan/1997' or data_termino < '01/jan/1999';

select * 
from tb_departamento 
where id_departamento = any(10,20,40,50,60) and to_char(id_localizacao) like '17%' or to_char(id_localizacao) like '18%';

--ORDER BY 

select id_empregado, nome,sobrenome, salario
from tb_empregado
order by 1 desc;

select id_empregado, nome,sobrenome, salario
from tb_empregado
order by nome asc, sobrenome desc