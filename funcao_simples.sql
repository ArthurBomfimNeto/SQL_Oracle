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

-- --==================================================================================
--------------- FUNÇOES CONVERSÂO

--TO_CHAR(x,FORMAT) converte x em uma string com um formato opcional 

SELECT TO_CHAR(1234.56)
FROM dual;


--FORMAT
SELECT TO_CHAR(12345.67,'99,999.99') as virgula,
       TO_CHAR(12345.67,'999,999.9') as ponto
FROM dual;

SELECT TO_CHAR(12345.67, '99999.99') as ponto
FROM dual;

-- PARAMETRO 0 retorna Zero a direita e esquerda AMBOS

SELECT TO_CHAR(12345.67,'099999.99') as esquerda, 
       TO_CHAR(12345.67,'99999.990') direita,
       TO_CHAR(12345.67,'099999.990') AMBOS
FROM dual;

-- USO SO $ 

SELECT TO_CHAR(12345.67, '$99,999.99') virgula,
       TO_CHAR(12345.67, '$99999.99') ponto, 
       TO_CHAR(12345.67, '$99,999.9')
FROM dual;

-- USO DO B se a parte inteira do numero for zero ele substitui por espaço  

SELECT TO_CHAR(00.67, 'B9.99')
FROM dual;

-- Uso do C simbolo da moeda extraido do parametro NLS_ISO_CURRENCY

SELECT TO_CHAR(12345.67, 'C99,999.99')
FROM dual;

-- Uso da letra D retorna o valor de uma virgula em ponto especifico 

SELECT TO_CHAR(123456.78,'999999D99')
FROM dual;


-- Parametro retorna utilizando notaç~ao cientifica 
SELECT TO_CHAR(123456.78,'999999.99EEEE')
FROM dual;

-- Parametro FM remove os espaços em brancos 

SELECT TO_CHAR(00123456.7800,'FM999999.99')
FROM dual;

-- Parametro L retorna o simbolo da moeda local 

SELECT TO_CHAR(123456.78,'l999999.99')
FROM dual;

-- Parametro MI retorna o sinal de negativo a direita
SELECT TO_CHAR(-123456.78,'999999.99MI'),TO_CHAR(-123456.78,'999999.99')
FROM dual;



--Parametro PR retorna para numeros negativos o mesmo entre <>

SELECT TO_CHAR(-123456.78,'999999.99PR'),TO_CHAR(123456.78,'999999.99PR')
FROM dual;


-- PARAMETRO RN fica sosinho e retorna em romanos o numero
SELECT TO_CHAR(2020, 'RN')
FROM dual;

-- PARAMETRO TM retorna o numero utilizando a quantidade minima de caracteres

SELECT TO_CHAR(12345.67,'TM'), TO_CHAR(12345.67)
FROM dual;

--PARAMETRO S retorna o negativo a esquerda com sinal de negativo e positivo tambem 

SELECT TO_CHAR(12345.67, 'S99,999.99') positivo ,
       TO_CHAR(-12345.67, 'S99,999.99') negativo,
       TO_CHAR(12345.67, '99,999.99S') positivo -- Com esse do outro lado inverte o lado do sinal
FROM dual;

-- retorna simbolo do euro U
SELECT TO_CHAR(12345.67, 'U99,999.99') 
FROM dual;

--OBS retornara ##.. caso for formatado um numero contendo digitos a mais para o formato\

SELECT TO_CHAR(1234589.67, 'S99,999.99') 
FROM dual;

-- Exemplo com concatenaçao 

SELECT ROWNUM,id_empregado,
       'O empregado recebe por mes:'|| TO_CHAR(salario,'L99,999.99') as salarios,
      length('O empregado recebe por mes:'|| TO_CHAR(salario,'L99,999.99')) tamanho
FROM tb_empregado;

----========================= TO_NUMBER(x) ==================================

SELECT TO_NUMBER('970,66')
FROM dual; 


-- SOMA COM NUMERO
SELECT TO_NUMBER('888,55') + 33.33
FROM dual;

-- Format number usando $

SELECT TO_NUMBER('-$12,345.67', '$99,999.99')
FROM dual;

----------------------CAST(x AS tipo)
-- converte o dado em um tipo de dado especifico 

SELECT 
    CAST(12345.67 as varchar2(10)),
    CAST('9A4F' as RAW(2)),
    CAST('01-DEZ-2007' as DATE),
    CAST(12345.678 as NUMBER(10,2))
FROM dual;   

SELECT 
      CAST(salario as varchar(10)),
      CAST(salario + 245.755 as number(8,2))
FROM tb_empregado
WHERE id_empregado = 100;

-==============FUNÇOES de EXPRESSAO REGULAR===============

^196[5-8]$

-- ^ correspondea posiçao que a string inicializa
--[5-8] corresponde caracteres que estejam entre 5 e 8
-- $ corresponde a posiç~ao final da string 

--==============REGEXP_LIKE(x,padrao,[opçao_correspondencia])

SELECT sobrenome
from tb_empregado
where REGEXP_LIKE(sobrenome, '[Bb]om', 'i') or REGEXP_LIKE(sobrenome, '[gih]$', 'i');

--Opçao de corresponcencia 

-- c : determina correspondencia com diferenciaç~ao de maisculo e minusculo 

-- i : determina a correspondencia sem diferenciaçao de maisculo e munusculo 

-- n : permite usar o operador de correspondencia com qualuqer caracter


-- Resgatou os empregados que nao foram admitidos entre 1993 a 1998
SELECT id_empregado, nome, data_admissao
FROM tb_empregado
WHERE NOT REGEXP_LIKE(TO_CHAR(data_admissao, 'YYYY'),'^199[3-8]$')

--NUmeros de admitidos e restantes
SELECT count(*) "ADMITIDOS 1993/8",108- count(*) RESTANTES
FROM tb_empregado
WHERE REGEXP_LIKE(TO_CHAR(data_admissao, 'YYYY'),'^199[3-8]$')

-- Utilizando A OPACAO  "i" procura os empregado cujo nome inicia com K ou k

SELECT id_empregado, nome 
FROM tb_empregado
WHERE REGEXP_LIKE(nome,'^K','i');

-- Procura por nomes começados da letra A ou M sem distinçao
SELECT id_empregado, nome 
FROM tb_empregado
WHERE REGEXP_LIKE(nome,'^[AM]','i')
ORDER BY 2 desc



-- Procura por empregados chamados Arthur ou Kevin, OR pessoas com salarios de 24000 ou 6000
SELECT id_empregado, nome , salario
FROM tb_empregado
WHERE REGEXP_LIKE(nome,'(Arthur|Kevin)','i') or REGEXP_LIKE(TO_CHAR(salario), '(24000|6000)')
ORDER BY 3 desc;




--=============REGEXP_INSTR(x, padrao, [inicio], [ocorrencia], [opcao de retorno],[opcao_de_correspondencia])

--Procura posiçao da segunda vez em que o "e" aprece apartir da 6º casa, sem diferença de maisculo e minusculo

SELECT 
    REGEXP_INSTR('TESTE DE EXPRESSAO REGULAR', 'e',6,2,0,'i')
FROM dual;  


--============= REGEXP_REPLACE(x,padrao,[string_substituiçao],[inicio], [ocorrencia], [opçao_de_correspondencia])

--Procura onde começa com a letra d considerando mais dois caracter alpha(letras do alfabeto) a sua frente

SELECT endereco,REGEXP_REPLACE(TO_CHAR(endereco), 'd[[:alpha:]]{2}','TESTE')
FROM tb_localizacao
WHERE REGEXP_REPLACE(TO_CHAR(endereco), 'd[[:alpha:]]{2}','TESTE') like '%TESTE%';

--============REGEXP_SUBSTR(x, padrao, inicio, ocorrencia, opcao_correspondencia)


-- Corte começando pela letra e apos 8 casas que sejam alpha(letras)
SELECT 
      REGEXP_SUBSTR('TESTE DE EXPRESSAO REGULAR', 'e[[:alpha:]]{8}',1,1,'i')
FROM dual;


-- CORTE dos enderecos com numeros começados em 1 com tamanho de 4 digitos
SELECT 
      endereco,
      REGEXP_SUBSTR(endereco, '1[[:digit:]]{3}') as "NUMERO"
FROM tb_localizacao
WHERE REGEXP_SUBSTR(endereco, '1[[:digit:]]{3}') > 0

--=========== REGEXP_COUNT(x, padrao, inicio, opcao_correspondencia)


--conta a quantidade de palavra que começa com "t" e possui mias 4 caracteres a frente 
SELECT 
      REGEXP_COUNT('teste teste teste totle expressao regular', 't[[:alpha:]]{4}')
FROM dual;   


--Conta as palavra que começa com a e tem 5 caractere 
SELECT 
     REGEXP_COUNT(nome, 'a[[:alpha:]]{5}',1,'i') as "5 caractere", nome
FROM tb_empregado;     
