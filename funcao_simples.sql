------------------FUNÇAO SIMPLES --------------------

-------------- UNICA LINHA
-- que opera linha por vez, retorna uma linha de saida para cada linha de entrada.

---------1) Funçao de Caracter 

-- ASCII retorna valor ascii dos caracter 
SELECT ASCII('a'), ASCII('A'), ASCII('z'), ASCII('Z'), ASCII('0'), ASCII('9')
FROM dual;


-- CHR(x) o caracter do valor ASCII
SELECT CHR(97), CHR(65), CHR(122), CHR(90), CHR(48), CHR(57)
FROM dual;

--CONCAT(x,y) anexa colunas 

SELECT concat(nome,salario), concat(id_empregado,sobrenome)
FROM tb_empregado
order by 2;

--INITCAP(x) transforma a primeira letra da coluna em maiusculo

SELECT INITCAP('turbinho')
FROM dual;

SELECT 
FROM tb_localizacao
WHERE endereco like 'C%';

--INSTR(x) procura uma string e retorna a posiçao em que ela começa

SELECT ds_funcao, instr(ds_funcao,'Marketing') POSICAO
FROM tb_funcao
WHERE instr(ds_funcao,'Marketing') > 0;

-- Procura a posiçao da segunda ocorrencia da paalavra 'a' começando do inicio 

SELECT nome, instr(nome,'a',1,2)
FROM tb_empregado
WHERE instr(nome,'a',1,2) != 0;

-- LENGTH(x) tamanho sa string

SELECT d.id_departamento, d.nm_departamento, e.nome, e.sobrenome
FROM tb_departamento d 
INNER JOIN tb_empregado e ON(d.id_departamento = e.id_departamento)
WHERE length(nome) = length(sobrenome); 

--LOWER(x) --Transforma letras em minusculos

SELECT LOWER('MINUSCULO')
FROM dual;

-- UPPER(x) - transforma letras em maisculo

SELECT UPPER('maiusculo')
FROM dual;

SELECT UPPER(nome), INITCAP(LOWER(sobrenome))
FROM tb_empregado;

--LPAD e RPAD prenche com string o restante dos espaços desejados 

SELECT RPAD(nome,25, '.'), LPAD(salario, 8,'$')
FROM tb_empregado;

--LTRIM , RTRIM TRIM cortes a esquerda e direita permite string de corte se nao e elinidado os espaços

SELECT LTRIM('  Esse e um corte a esquerda dos espaços'),
       RTRIM('Esse corte e de string! abcabc','abc'),
       TRIM ('$' FROM '$$$Corte a direita e esqueda$$$')
FROM dual;    

--NVL substitui valores nulos por string

SELECT nvl(percentual_comissao, 'TESTE')
FROM tb_empregado
WHERE percentual_comissao is null;








