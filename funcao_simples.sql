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

SELECT nvl(to_char(percentual_comissao), 'TESTE')
FROM tb_empregado
WHERE percentual_comissao is null;

-- NVL2 caso tenha algo na coluna retorna primeira expressao se nao retorna a segunda

SELECT rpad(id_gerente,15,' ') as id_gerente, rpad(nvl2(id_gerente, 'Contem gerente', 'Nao ha gerencia '),30, '.') as NVL2
FROM tb_departamento;

--REPLACE (x,string_busca, string_substitutiva) procura por uma string caso ache substitui por outra

SELECT id_funcao, REPLACE(ds_funcao, 'Marketing', 'MARKETING')
FROM tb_funcao
WHERE ds_funcao like '%Marketing%'
order by 2 asc;

--SONDEX(x) busca pela fon'etica da coluna 

SELECT ds_funcao,nome
FROM tb_funcao 
inner join tb_empregado using(id_funcao)
WHERE soundex(ds_funcao) = soundex('President') or 
      soundex(nome) = soundex('KEvyn')


--SUBSTR(x,inicio,(comprimento)) corte de string com inicio e comprimento opcional

SELECT substr('Teste de corte da funçao SBSTR',26)
FROM dual; 

-- encotrou o endereço com o numero 9702 usando o corte 
SELECT endereco, substr(endereco, instr(endereco, '9702'),4), length(substr(endereco, instr(endereco, '9702'),4)) as length
FROM tb_localizacao
WHERE to_char(substr(endereco, instr(endereco, '9702'),4)) = to_char('9702');

-- encotrou o endereço com o numero 9702 usando o like 
SELECT endereco, '9702' as numero
FROM tb_localizacao
WHERE endereco like '%9702%'



--==================================================================================
--------------- FUNÇOES NUMERICAS

--ABS valor absoluto 

SELECT percentual_comissao, percentual_comissao - 30,  abs(percentual_comissao - 30) absoluto
FROM tb_empregado 
WHERE percentual_comissao  is not null

--CEIL(x) menor inteiro maior (arredonda para cima)

SELECT CEIL(5.8), CEIL(5.2), CEIL(-5.2)
FROM dual;

--FLOOR(x) maior inteiro menor (arredonda para baixo)

SELECT FLOOR(22.9), FLOOR(7.6), FLOOR(- 5.2)
FROM dual;

--MOD(x, y) resto da divisao 

SELECT MOD(8,3), MOD(27,3)
FROM dual;

--POWER(x, y) potenciaçao potencia

SELECT POWER(2,2), POWER(3,4)
FROM dual;

--round(x) arredonda o numero para o mais proximo, 
--round(x,1) arredonda 1 casa  decimal 5,75 - 5,8
--round(x, -1) 5,75 - 10 
--round(x,2) demias numeros casas a considerar apos a virgula
SELECT round(3.5666), round(3.5666, 1), round(3.5666, -1), round(7.5666, -1), round(3.6666, 2),round(3.444, 2)
FROM dual;

-- SING(x) retorna -1 se negativo 1 positivo e 0 se for zero

SELECT SIGN(33), SIGN(-33), SIGN(0)
FROM dual;

-- SQRT raiz quadrada 
SELECT SQRT(25), SQRT(5), ROUND(SQRT(5), 2), substr(to_char(SQRT(5)),1,4)
FROM dual;

-- TRUNC o truncamento é a limitação do número de dígitos à direita da vírgula decimal.

SELECT TRUNC(5,75), TRUNC(5.75,1), TRUNC(SQRT(5),2) truncamento, SQRT(5), ROUND(SQRT(5),2) arredondamento
FROM dual;



