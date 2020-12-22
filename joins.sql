------------------- JOINS --------------------
--Padrao SQL/86
-- JOIN WHERE

select tb_departamento.nm_departamento, tb_empregado.nome
from tb_departamento, tb_empregado 
where tb_departamento.id_departamento = tb_empregado.id_empregado 
order by 1;

select d.nm_departamento, d.id_departamento, e.nome, d.id_gerente
from tb_departamento d, tb_empregado e 
where d.id_departamento = e.id_departamento and e.id_empregado > 150
order by e.nome;

-- JOIN DE VARIAS TABELAS
select e.id_empregado, d.id_departamento, l.id_localizacao, p.id_pais
from tb_empregado e, tb_departamento d, tb_localizacao l, tb_pais p
where e.id_departamento = d.id_departamento and
      d.id_localizacao = l.id_localizacao and
      l.id_pais        = p.id_pais;

-- NAO EQUIJOIN nao usa o sinal de = 

-- junta as tabelas onde salario esta entre a base e o teto 
select e.nome, e.salario, f.base_salario, f.teto_salario
from tb_funcao f, tb_empregado e
where e.salario between f.base_salario and f.teto_salario
order by 2;

-- JOINS EXTERNAS 
-- Recupera o Arthur mesmo ele tendo o id_departamento null(nao esta vinculado a nenhum departamento )
select e.nome, nvl(to_char(e.id_departamento), 'Nao vinculado'), d.nm_departamento, d.id_departamento
from tb_empregado e, tb_departamento d
where e.id_departamento = d.id_departamento(+)
order by 1;

-- Auto join recupera os funcionarios com que nao possuem gerentes e substitui por acionistas
select e.nome || ' trabalha para ' || nvl(g.nome, 'os acionistas'), g.id_empregado
from tb_empregado e, tb_empregado g
where e.id_gerente = g.id_empregado(+)
order by g.id_empregado asc;


-- Padrao SQL/92 ANSI
select e.nome funcionario, g.nome gerente
from tb_empregado e 
inner join tb_empregado g on (e.id_gerente = g.id_empregado)
order by 2;

--Nao equijoin 

select e.nome funcionario, d.nm_departamento departamento 
from tb_empregado e 
inner join tb_departamento d on (e.id_departamento  between 90 and 120);

-- Recupera data_admissao funcionario e inicio e fim da funcao 
select e.data_admissao , f.data_inicio, f.data_termino
from tb_empregado e 
inner join tb_funcao  using (id_funcao)


select f.data_inicio, e.data_admissao, f.data_termino
from tb_empregado e
inner join tb_historico_funcao f on (e.data_admissao between f.data_inicio and f.data_termino);

-- Using 

-- com uso de using para exibir o id_departamento o mesmo deve estar distinto do apelido da tabela 
select e.nome, d.nm_departamento , id_departamento 
from tb_empregado e 
inner join tb_departamento d using (id_departamento); -- na clausula o id deve estar sozinho 

-- Varios joins com using
select e.nome, f.base_salario, e.salario, f.teto_salario, d.nm_departamento,f.ds_funcao ,id_funcao
from tb_empregado e 
inner join tb_departamento d using (id_departamento)
inner join tb_funcao f using (id_funcao)
where to_number(length(e.nome) + length(e.sobrenome)) > 15
order by 1;


--Left Outer join recupera os empregados mesmo eles nao estando vinculado a um departamento 
select e.nome, id_departamento, d.nm_departamento
from tb_empregado e 
left outer join tb_departamento d using (id_departamento)
where id_departamento is null;

--right outer join recupera os departaentos mesmo n~ao estando vinculados a nenhum empregado. 
select e.nome, id_departamento, d.nm_departamento 
from tb_empregado e
right outer join tb_departamento d using (id_departamento);

-- full outer join recupera todos empregados e departamentos mesmo n~ao estando vinculados um com o outro. 
select e.nome, id_departamento, d.nm_departamento 
from tb_empregado e
full outer join tb_departamento d using (id_departamento);

--CROSS JOIN 
-- força um produto cartesiano. 
select * 
from tb_empregado 
cross join tb_departamento;
