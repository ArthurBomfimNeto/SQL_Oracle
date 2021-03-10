-- PL/SQL
-- PROCEDURE

create or replace
PROCEDURE manipula_dados(
  p_id_empregado   in tb_empregado_teste.id_empregado%TYPE,
  p_descricao      in tb_empregado_teste.ds_empregado%TYPE,
  p_nome           in tb_empregado_teste.nm_empregado%TYPE,
  p_valor          in tb_empregado_teste.valor%TYPE,
  p_fg_ativo       in tb_empregado_teste.fg_ativo%TYPE,
  p_opcao          in CHAR)
  
AS 

v_controle   integer;

begin 

--verifica a exixtencia de tuplas na tb de acordo com id passado por parametro 
select count(*) into v_controle 
from tb_empregado_teste
where id_empregado = p_id_empregado 
and fg_ativo =1;

IF(p_opcao = 'I') THEN
  IF(v_controle != 1)THEN
    insert into tb_empregado_teste(id_empregado,ds_empregado,nm_empregado,valor,fg_ativo)
    values(p_id_empregado,p_descricao,p_nome,p_valor,p_fg_ativo);
    
    dbms_output.put_line('Cliente inserido com sucesso');

  ELSE
    dbms_output.put_line('ID do cliente ja existe');
  END IF;
END IF;

--OPCAO UPDATE

IF(p_opcao = 'U') THEN
  IF(v_controle = 1)THEN
    update tb_empregado_teste
        SET   ds_empregado = p_descricao,
              nm_empregado = p_nome,
              valor        = p_valor,
              fg_ativo     = p_fg_ativo
        WHERE id_empregado = p_id_empregado 
        and fg_ativo = p_fg_ativo;
        
        commit;
        dbms_output.put_line('Atualizado com sucesso');
        
   ELSE
      dbms_output.put_line('ID do cliente nao existe');
   END IF;
 END IF;
     
--OPCAO = D (DELETE)
IF(p_opcao = 'D')THEN
  IF(v_controle =1)THEN
    DELETE
    FROM tb_empregado_teste
    WHERE id_empregado = p_id_empregado;
    COMMIT;
    
    dbms_output.put_line('Cliente excluido com sucesso');
    
   ELSE 
          dbms_output.put_line('ID do cliente nao existe');

  END IF;
END IF;

EXCEPTION
  WHEN OTHERS THEN
      ROLLBACK;
END manipula_dados ;
      

--Chamando procedure apartir do bloco anonimo

--inserindo empregado
SET serveroutput ON
BEGIN
  manipula_dados(1, 'Empregado 1', 'Empregado_1',22.33, 1, 'I');
END;

SET serveroutput ON
BEGIN
  manipula_dados(2,'Empregado 2', 'Empregado_2', 33.33, 1, 'I');
END;  


--atualizando com CALL

CALL manipula_dados(2,'EMPRAGDO_2','empregado 2', 44.44, 1, 'U');

SET serveroutput ON
BEGIN
 manipula_dados(2,'Empregado 2', 'Empregado_2', 33.33, 1,'U');
END; 

--Deletando com CALL
CALL manipula_dados(2,null,null,null,1, 'D');


@ \home\oracle\Script_3.sql

@ \home\oracle\cenario_plsql.sql

SELECT *
FROM tb_empregado;

SET serveroutput ON

DECLARE
 v_texto VARCHAR(30) := 'Treinamento Oracle Essecial';
 BEGIN
   dbms_output.put_line(v_texto);
END;   


-- BOLOCO ANONIMO

SET serveroutput ON 

DECLARE -- secao de declaracao
  v_contador NUMBER; --declaracao de variavel
BEGIN --secao executavél 
   SELECT COUNT(1) INTO v_contador
   FROM tb_departamento; --insrucoes SQL
   
   IF v_contador = 0 THEN --indtrucao procedural
   DBMS_OUTPUT.PUT_LINE('Nenhum funcionario cadastrado no esquema de RH');
   
   ELSE 
   DBMS_OUTPUT.PUT_LINE('Existem' || to_char(v_contador) || 'funcionarios cadastrados no esquema RH');
   
   END IF;
   
EXCEPTION --seccao de tratamento de exceçao
   WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;     
   

-- ANINHADO
SET serveroutput ON 

--inicio do bloco EXTERNO

DECLARE
  v_contador NUMBER;
BEGIN
  BEGIN
    SELECT 1 INTO v_contador
    FROM tb_empregado
    WHERE ROWNUM = 1;
    
    EXCEPTION 
      WHEN OTHERS THEN
      v_contador := 0; 
  END; 
  
  IF (v_contador = 0) THEN
     DBMS_OUTPUT.PUT_LINE('Nenhum funcionário cadastrado no esquema de RH');
  ELSE
     DBMS_OUTPUT.PUT_LINE('Existe ' || TO_CHAR(v_contador) || ' funcionário cadastrado no esquema RH');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;




SET serveroutput ON 

DECLARE
  v_contador NUMBER;
  BEGIN
    SELECT 1 INTO v_contador
    FROM tb_empregado
    WHERE ROWNUM = 2;
  
  IF (v_contador = 0) THEN
     DBMS_OUTPUT.PUT_LINE('Nenhum funcionário cadastrado no esquema de RH');
  ELSE
     DBMS_OUTPUT.PUT_LINE('Existe ' || TO_CHAR(v_contador) || ' funcionário cadastrado no esquema RH');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;


-- VARIAVEIS 

VARIABLE v_minha_string VARCHAR2(30);

BEGIN 
   :v_minha_string:='UM string literal';
END;

SET serveroutput ON

BEGIN
  dbms_output.put_line(:v_minha_string);
END;  


---PARAMETRO &

SET serveroutput ON

DECLARE
  v_string VARCHAR2(30);
BEGIN
  v_string := '&input';
  dbms_output.put_line('Testando: ' || v_string);
END;  


-- UTILIZANDO indicado atributo %

SET serveroutput ON
DECLARE 

v_id_emp     tb_empregado.id_empregado%TYPE; --NUMBER(6)
v_sobrenome  tb_empregado.sobrenome%TYPE; --VARCHAR2(25)

BEGIN
  v_id_emp := 100301; -- OK porque cabe em um NUMBER(6)
  v_sobrenome := 'Silva'; -- OK porque cabe no VARCHAR(25)
  
  dbms_output.put_line('ID: ' || v_id_emp || ' Sobrenome ' || 'v_sobrenome');
  
END;

--%ROWTYPE permite a variavel receber todas as colunas podendo utilizar como objeto 

SET serveroutput ON
DECLARE

  v_emp_reg  tb_empregado%ROWTYPE;
  
BEGIN 
  SELECT * INTO v_emp_reg 
  FROM tb_empregado
  WHERE id_empregado = 125;
  
  dbms_output.put_line('Nome: ' || v_emp_reg.nome || ' Sobrenome: ' || v_emp_reg.sobrenome);
  
END;  



---- ============== COTADO -=============
--para permanecer com letras intercaladas 

CREATE TABLE "tb_Demo"(
"id_Demo"   number,
valor_demo VARCHAR2(20)
);

INSERT INTO "tb_Demo"
VALUES (1,'Linha um apenas');

SET serveroutput ON 
BEGIN 
 FOR i IN (SELECT "id_Demo",valor_demo
           FROM "tb_Demo") LOOP
       dbms_output.put_line(i."id_Demo");
       dbms_output.put_line(i.valor_demo);
 END LOOP;
END; 

--Não é sensitivecase apenas se estiver entre aspas 

SET serveroutput ON
DECLARE --secção declarativa

   v_nome VARCHAR2(50); -- declaração da variavel 
BEGIN --seção executavel 

  V_NOME := 'Treinamento PL/SQL Essencial'; --atribuição
  dbms_output.put_line('O conteudo eh: ' || v_nome);
  
END;  

--Atribuindo valores a variveis com o operador de atribuição PL/SQL

DECLARE 

v_salario           NUMBER(6,2);
v_horas_trabalhada  NUMBER := 40;
v_valor_hora        NUMBER := 22.50;
v_bonus             NUMBER := 150;
v_pais              VARCHAR2(128);
v_contador          NUMBER := 0;
v_controle          BOOLEAN := FALSE;
v_id_validade       BOOLEAN;

BEGIN
 v_salario := (v_horas_trabalhada * v_valor_hora) + v_bonus;
 v_pais := 'Brasil';
 v_pais := UPPER('Canada');
 v_controle := (v_contador > 100);-- FALSE
 v_id_validade := TRUE;
END; 

--USANDO LITEARIS BOOLEANOS EM PL/SQL

DECLARE 

v_finalizado BOOLEAN := TRUE;
v_completo BOOLEAN;
v_true_or_false BOOLEAN;

BEGIN

v_finalizado := FALSE; --set para FALSE
v_completo := NULL; --valor desconhecido
v_true_or_false := (3=4); -- set para FALSE
v_true_or_false := (3<4); --set para TRUE
END;
-- DECLARANDO VARIAVEIS COM palavra chave DEFAULT 

DECLARE 

  v_id_empregado         NUMBER(6);
  v_emp_ativo            BOOLEAN NOT NULL :=TRUE;
  v_salario_mensal       NUMBER(6) NOT NULL := 2000;
  v_valor_diaria         NUMBER(6,2);
  v_media_dias_trab_mes  NUMBER(2) DEFAULT 21;
BEGIN 
    NULL; --a instrução NULL nada faz
END;    
  

--======== CRIANDO UMA NOVA FORMA DE DADO  DATYPE(OBJETO)
  
SET serveroutput ON 
DECLARE 
  TYPE registro_demo IS RECORD(
    id_aluno   NUMBER DEFAULT 1,
    nome       VARCHAR2(10) := 'Mário');
  reg_demo REGISTRO_DEMO;
  
BEGIN 
  dbms_output.put_line('[' || reg_demo.id_aluno || ']['|| reg_demo.nome || ']');
END;  


-- CRIANDO OUTROS REGISTOR DE DATATYPE 

SET serveroutput ON
DECLARE 
 
 TYPE tp_full_name IS RECORD(
  nome        VARCHAR2(10) := 'Ricardo',
  sobrenome   VARCHAR2(10) := 'Vargas');
  
 TYPE tp_reg_aluno IS RECORD(
  id_aluno        NUMBER DEFAULT 1,
  nm_aluno       TP_FULL_NAME);
  
  reg_demo    TP_REG_ALUNO;
  
BEGIN 

dbms_output.put_line('[' || reg_demo.id_aluno || ']');
dbms_output.put_line('[' || reg_demo.nm_aluno.nome || ']');
dbms_output.put_line('[' || reg_demo.nm_aluno.sobrenome || ']');
END;


-- CRIANDO UMA LISTA COMO DATATYPE
SET serveroutput ON 
DECLARE
  TYPE varray_numerico IS VARRAY(5) OF NUMBER;
  
  v_lista VARRAY_NUMERICO := varray_numerico(1,2,3,null,null);
BEGIN

 FOR i IN 1 .. v_lista.LIMIT LOOP
    dbms_output.put('[' || v_lista(i) || ']');
 END LOOP;
  dbms_output.new_line;
END;  


---===================================== 26/02/2021 ========================
--BLOCOS ANONIMOS ANINHADOS 

SET serveroutput ON 

<<outer>> -- inicio do bloco pa

DECLARE 

v_contador    NUMBER;

BEGIN 
   <<inner>> -- inicio do cloco filho 
  DECLARE 
  
  v_contador NUMBER;
  
  BEGIN 
  
    SELECT 1 INTO inner.v_contador
    FROM tb_empregado
    WHERE ROWNUM =1;
  
    outer.v_contador :=inner.v_contador;
    
  EXCEPTION 
  
    WHEN OTHERS THEN
      
      outer.v_contador := 0;
  END; -- Fim do bloco filho 
  
  IF (v_contador = 0) THEN
    dbms_output.put_line('Nenhum registro do esquema RH');
  ELSE  
    dbms_output.put_line('Existe ' || to_char(outer.v_contador) || ' registros no esquema RH');
  END IF;
  
  EXCEPTION 
    WHEN OTHERS THEN 
      
      dbms_output.put_line(SQLERRM);
  END;    

--VARIAVEIS GLOBAIS com mesmo nome. 

SET serveroutput ON 

DECLARE 

--VARIAVEIS LOcais
 v_num1 NUMBER := 95;
 v_num2 NUMBER := 85;

BEGIN 
  dbms_output.put_line('Variavel global v_num1 ' || v_num1 );
  dbms_output.put_line('Variavel global v_num2 ' || v_num2 );
  
 DECLARE
  
  v_num1 NUMBER := 195;
  v_num2 NUMBER := 185;
 
 BEGIN
    dbms_output.put_line('Variavel global v_num1 ' || v_num1 );
    dbms_output.put_line('Variavel global v_num2 ' || v_num2 );
 END;
END; 
  
  


SET serveroutput ON 

DECLARE --seção declarativa

  c_identificador CONSTANT VARCHAR2(30) := 'PL/SQL Essencial';
  
 BEGIN
   dbms_output.put_line('Conteudo da constante: ' || c_identificador);
END;   



SET serveroutput ON 

DECLARE 
c_pi CONSTANT NUMBER := 3.141592654;

v_raio              NUMBER(5,2);
v_diametro          NUMBER(5,2);
v_circunferencia    NUMBER(7,2);
v_area              NUMBER(10,2);


BEGIN 
  v_raio  := 9.5;
  v_diametro := v_raio * 2;
  v_circunferencia := 2.0 * c_pi*v_raio;
  v_area := c_pi*v_raio*v_raio;
  
-- SAIDA

dbms_output.put_line('Raio: ' || v_raio);
dbms_output.put_line('Diametro: ' || v_diametro);
dbms_output.put_line('Circunferencia  : ' || v_circunferencia);
dbms_output.put_line('Area: ' || v_area);

END;



--SELECT INTO para inserir colunas em variaveis 


SET serveroutput ON

DECLARE 
  v_soma_salario   NUMBER(10,2);
  v_nome           tb_empregado.nome%TYPE;
  v_sobrenome      tb_empregado.sobrenome%TYPE;
  
BEGIN
   SELECT SUM(NVL(salario,0)) INTO v_soma_salario
   FROM tb_empregado
   WHERE id_departamento = 10;
   
   dbms_output.put_line('A soma dos sálarios é: ' || v_soma_salario);
   
   SELECT nome, sobrenome INTO v_nome, v_sobrenome
   FROM tb_empregado
   WHERE id_empregado = 100;
   
   dbms_output.put_line('O nome completo do empregado é: ' || v_nome || ' ' || v_sobrenome);
END;   
  
  
--INSERINDO DADOS ATRAVES DE BLOCOS ANONIMOS 

BEGIN 
  INSERT INTO tb_empregado(id_empregado,nome, sobrenome, email, data_admissao, id_funcao,salario)
  
  VALUES( sq_empregado.NEXTVAL, 
          'Geraldo','Henrrique Neto','geraldohenrique@usp.br',
           SYSDATE, 'IT_PROG', 5000);
  COMMIT;
END;  


SELECT * 
FROM tb_empregado
WHERE nome = 'Geraldo' AND sobrenome = 'Henrrique Neto';


-- UPDATE BLOCO ANONIMO 

BEGIN 
   UPDATE tb_empregado
   SET  salario = 15000
   WHERE   nome= 'Geraldo'
   AND  sobrenome = 'Henrique Neto';
   
   COMMIT;
END;   
  
  
SELECT * 
FROM tb_empregado
WHERE nome = 'Geraldo' AND sobrenome = 'Henrrique Neto';
  

-- DELETE UTULIZANDO O BLOCO ANONIMO 

DECLARE 
  v_id_empregado NUMBER;
  
BEGIN 
  SELECT sq_empregado.CURRVAL INTO v_id_empregado
  FROM dual;
  
  DELETE FROM tb_empregado
  WHERE id_empregado = v_id_empregado;
  COMMIT;
END;  


SELECT * 
FROM tb_empregado
WHERE nome = 'Geraldo' AND sobrenome = 'Henrrique Neto';

@ \home\oracle\script_exemplo_01.sql;


-- VARIAVEIS 

SET serveroutput ON 
DECLARE
 v_emp_count NUMBER;
BEGIN
  SELECT COUNT(1) INTO v_emp_count
  FROM tb_empregado 
  WHERE id_departamento = &&id_departamento;
  
  DBMS_OUTPUT.PUT_LINE('A contagem de empregados eh; ' || v_emp_count || ' para o depto com o ID de: ' ||
  &id_departamento);
END;  

UNDEFINE id_departamento; -- para inibir o erro de guardar as variaveis ´


--=========CONDIÇÂO IF ===============

SET serveroutput ON
DECLARE
  v_a NUMBER(2) := 10;
BEGIN
 v_a := 10;
 --verifica a condição boolean usando a instrução IF
 
 IF (v_a <20) THEN  -- se a condição for verdadeira
   dbms_output.put_line('v_a eh menor que 20');
   
 END IF;
 DBMS_OUTPUT.PUT_LINE('O valor de v_a eh: ' || v_a);
END;


-- UTILIZANDO TABELA DO ESQUEMA DO BD

SET serveroutput ON
DECLARE 
  v_contador  NUMBER;
BEGIN 
  SELECT COUNT(1) INTO v_contador
  FROM tb_empregado;
  
  IF v_contador = 0 THEN
    dbms_output.put_line('Não existem empregados cadastrados');
  END IF;
END;  

CREATE TABLE tb_clientes(
id_cliente    INT NOT NULL, 
nm_cliente    VARCHAR2(20) NOT NULL, 
idade         INT NOT NULL, 
endereco      VARCHAR2(25), 
salario       DECIMAL (18,2), 
PRIMARY KEY (id_cliente)
);

INSERT INTO tb_clientes (id_cliente, nm_cliente, idade, endereco, salario) 
VALUES (1, 'Ramesh', 32, 'Ahmedabad', 2000.00 ); 

INSERT INTO tb_clientes (id_cliente, nm_cliente, idade, endereco, salario) 
VALUES (2, 'Khilan', 25, 'Delhi', 1500.00 ); 

INSERT INTO tb_clientes (id_cliente, nm_cliente, idade, endereco, salario)  
VALUES (3, 'kaushik', 23, 'Kota', 2000.00 ); 

INSERT INTO tb_clientes (id_cliente, nm_cliente, idade, endereco, salario) 
VALUES (4, 'Chaitali', 25, 'Mumbai', 6500.00 ); 

INSERT INTO tb_clientes (id_cliente, nm_cliente, idade, endereco, salario)  
VALUES (5, 'Hardik', 27, 'Bhopal', 8500.00 ); 

INSERT INTO tb_clientes (id_cliente, nm_cliente, idade, endereco, salario) 
VALUES (6, 'Komal', 22, 'MP', 4500.00 );

COMMIT;


--- UPDATE USANDO IF
SET severoutput ON

DECLARE
  c_id_cliente           tb_clientes.id_cliente%TYPE := 1;
  c_salario              tb_clientes.salario%TYPE; 
  
BEGIN 
  SELECT salario into c_salario
  FROM tb_clientes
  WHERE id_cliente = c_id_cliente;
  
  IF (c_salario <= 2000) THEN
     UPDATE tb_clientes SET salario = salario + 1000
     WHERE id_cliente = c_id_cliente;
     dbms_output.put_line('Slario alterado com êxito');
     COMMIT;
  END IF;
END;  

---- ==IF THEN ELSE

SET serveroutput ON
DECLARE
   v_a    NUMBER(3) := 100;
BEGIN
  IF(v_a<20) THEN
     dbms_output.put_line('v_a eh menor que 20');
  ELSE
     dbms_output.put_line('v_a não eh menor que 20');
  END IF;
     dbms_output.put_line('O valor de v_a eh: ' || v_a);
END;


---OUTRO EXEMPLO 

SET serveroutput ON
DECLARE
   v_contador   NUMBER;
BEGIN 
   SELECT COUNT(1) INTO v_contador
   FROM tb_empregado;
   
 IF v_contador = 0 THEN
   dbms_output.put_line('Não existem empregados cadastrados');
 ELSE
   dbms_output.put_line('Existem' || TO_CHAR(v_contador) || ' empregados cadastrados');
   
 END IF;
END; 


----- IF THEN ELSIF ----------

SET serveroutput ON

DECLARE 
  v_a   NUMBER(3) := 100;
BEGIN 
  IF(v_a =10) THEN 
    dbms_output.put_line('Valores de v_a eh 10');
  ELSIF (v_a = 20) THEN
    dbms_output.put_line('Valor de v_a eh 20');
  ELSIF (v_a = 30)  THEN
    dbms_output.put_line('Valor de v_a eh 30');
  ELSE
    dbms_output.put_line('Nenhuma correspondencia com os valores acima');
  END IF;
  dbms_output.put_line('O valor exato de v_a eh:' || v_a);
END;  

SET serveroutput ON
DECLARE
  v_contador NUMBER;
BEGIN
  SELECT COUNT(1) INTO v_contador
  FROM tb_empregado;
  
  IF v_contador = 0 THEN
    dbms_output.put_line('Não existe empregado cadastrado');
  ELSIF v_contador > 100 THEN
    dbms_output.put_line('Existem mais de 100 empregados cdastrados');
  ELSE
    dbms_output.put_line('Exitem ' || TO_CHAR(v_contador) || ' empregados cadastrados');
  END IF;
END;  
  
  
-- ======CASE============

SET serveroutput ON 
DECLARE 
  v_grade   CHAR(1) := 'A';
BEGIN

 CASE v_grade
       WHEN 'A' THEN dbms_output.put_line('Excelente');
       WHEN 'B' THEN dbms_output.put_line('Muito bom');
       WHEN 'C' THEN dbms_output.put_line('Bom');
       WHEN 'D' THEN dbms_output.put_line('Reprovado');
       WHEN 'F' THEN dbms_output.put_line('Tente novamente');
  ELSE dbms_output.put_line('Nenhuma classificação');
  END CASE;
END;  


--===== SEGUNDo EXEMPLO ======

SET serveroutput ON
DECLARE
  v_contador          NUMBER;
  v_msg               VARCHAR2(100);
BEGIN 
   SELECT COUNT(1) INTO v_contador
   FROM tb_empregado;
   
   CASE v_contador
      WHEN 0 THEN dbms_output.put_line('Nenhum empregado cadastrado');
   ELSE dbms_output.put_line('Existem ' || TO_CHAR(v_contador) || ' empregados cadastrados');
   END CASE;
END;   
  

--=============== CASE com seletor no WHEN ===========

SET serveroutput ON 
DECLARE 
  v_grade   CHAR(1) := 'B';
BEGIN
 CASE 
       WHEN v_grade = 'A' THEN dbms_output.put_line('Excelente');
       WHEN v_grade = 'B' THEN dbms_output.put_line('Muito bom');
       WHEN v_grade = 'C' THEN dbms_output.put_line('Bom');
       WHEN v_grade = 'D' THEN dbms_output.put_line('Reprovado');
       WHEN v_grade = 'F' THEN dbms_output.put_line('Tente novamente');
  ELSE dbms_output.put_line('Nenhuma classificação');
  END CASE;
END;  

--USO DA VARIVEL COM RETORNO DO CASE 

SET serveroutput ON
DECLARE
  v_contador    NUMBER;
  v_msg         VARCHAR2(100);
BEGIN 
  SELECT COUNT(1) INTO v_contador
  FROM tb_empregado;
  
  v_msg := CASE
           WHEN v_contador = 0 THEN 'Nenhum empregado cadastrado' 
           WHEN v_contador > 100 THEN 'Existem mais de 100 empregado cadastrado'
           ELSE 'Existem ' || TO_CHAR(v_contador) || ' empregados cadastrados'
           END;
     dbms_output.put_line(v_msg);
END;     

--EXIBE DE FORMA HORIZONTAL 

SELECT COUNT(CASE WHEN salario < 2000 THEN 1 ELSE NULL END) contador_1,
       COUNT(CASE WHEN salario BETWEEN 2001 AND 4000 THEN 1 ELSE NULL END) contador_2,
       COUNT(CASE WHEN salario > 4000 THEN 1 ELSE NULL END) contador_3
FROM tb_empregado;  

--EXIBE DE FORMA VERTICAL 

SELECT COUNT(1)
FROM tb_empregado
WHERE salario < 2000
UNION ALL
SELECT COUNT(1)
FROM tb_empregado
WHERE salario BETWEEN 2001 AND 4000
UNION ALL
SELECT COUNT(1)
FROM tb_empregado
WHERE salario> 4000;


-- IF ANINHADOS 

SET serveroutput ON

DECLARE 
 v_a    NUMBER(3) := 100;
 v_b    NUMBER(3) := 200;
BEGIN 
  IF(v_a = 100) THEN 
    IF(v_b = 200) THEN
      dbms_output.put_line('Valor de v_a eh 100 e v_b eh 200');
    END IF;
  END IF;
  dbms_output.put_line('Valor exato de v_a eh : ' || v_a);
  dbms_output.put_line('Valor exato de v_b eh: ' || v_b);
END;  

--==================== LOOPS ==============================================

--LOOP BASICO

SET serveroutput ON
DECLARE
  v_x     NUMBER := 10;
BEGIN 
  LOOP
   dbms_output.put_line(v_x);
   
   v_x := v_x + 10;
   IF v_x > 50 THEN
     EXIT;
   END IF;
  END LOOP;
  dbms_output.put_line('Depois do Exit v_x eh: ' ||v_x);
END;

-- LOOP BASICO COM EXIT WHEN; (Parar Quando)

SET serveroutput ON
DECLARE 
  v_x  number := 10;
BEGIN 
  LOOP 
  dbms_output.put_line(v_x);
  v_x := v_x + 10;
  EXIT WHEN v_x > 50;
 END LOOP;
dbms_output.put_line('Depois do Exit v_x eh: ' ||v_x);
END;

--========== WHILE ============

SET serveroutput ON 
DECLARE
  v_a   NUMBER(2) := 10;
BEGIN
  WHILE v_a < 20 LOOP
   dbms_output.put_line('Valor de v_a: ' || v_a);
   v_a := v_a + 1;
  END LOOP;
END; 

--============= FOR x IN 100..20 LOOP=========

SET serveroutput ON
DECLARE 
  v_a NUMBER(2);
BEGIN
  FOR v_a IN 10..20 LOOP
   dbms_output.put_line( 'Valor de v_a: ' || v_a);
 END LOOP;
END; 

SET serveroutput ON

DECLARE
  v_contador   NUMBER :=0;
BEGIN
  FOR i IN 1..100 LOOP
    v_contador := v_contador + 1;
    dbms_output.put_line(i);
  END LOOP;
  
  dbms_output.put_line('O valor final do v_contador eh: ' || v_contador);
END;


--=========== FOR LOOP REVERSE faz de forma contraria ======================
SET serveroutput ON 
DECLARE 
  v_a  NUMBER(2);
BEGIN 
  FOR v_a IN REVERSE 10..20 LOOP
    dbms_output.put_line('Valor de v_a: ' || v_a);
  END LOOP;
END;  


--======== LOOP ANINHADO ========

SEt serveroutput ON
DECLARE 
  v_contador        NUMBER := 1;
BEGIN
  <<loop_filho>>
 
 
SET serveroutput ON

DECLARE
  v_a   NUMBER(2) := 10;
BEGIN
   WHILE  v_a < 20 LOOP
     dbms_output.put_line('Valor de v_a: ' || v_a);
     v_a := v_a + 1;
     IF v_a > 15 THEn
      EXIT;
     END IF;
    END LOOP;
 END;  
 

SET serveroutput ON 
DECLARE
  v_a NUMBER(2) := 10;
BEGIN
  WHILE v_a < 20 LOOP
    dbms_output.put_line('Valor de v_a: ' || v_a);
    v_a := v_a +1;
    
    EXIT WHEN v_a >15;
    END LOOP;
END;    


--=========== CONTINUE força a próxima iteração do LOOP ==============

SET serveroutput ON
DECLARE 
  v_a NUMBER(2) := 10;
BEGIN
   WHILE v_a < 20 LOOP
     dbms_output.put_line('Valor de v_a: ' || v_a);
     v_a := v_a + 1;
     IF v_a = 15 THEN
       v_a := v_a +1;
      -- CONTINUE;
     END IF;
   END LOOP;
END;  


--============ GOTO ========== não é muito legal * NÂO ACONSELHADO 

SET serveroutput ON
DECLARE
  v_a   NUMBER(2) := 10;
BEGIN 
   <<inicio_loop>>
   WHILE v_a < 20 LOOP
  dbms_output.put_line('Valor de v_a eh: ' || v_a);
  v_a := v_a + 1;
  IF v_a = 15 THEN
    v_a :=v_a + 1;
    GOTO inicio_loop;
  END IF;
 END LOOP;
END; 

SET serveroutput ON
DECLARE 
  v_resultado  BOOLEAN;
  v_compare1   BOOLEAN;
  v_compare2   BOOLEAN;
BEGIN
  v_compare1 := true;
  v_compare2 := true;
  v_resultado := v_compare1 AND v_compare2;
  dbms_output.put_line('O valor de v_resultado é: ' || 
                       CASE v_resultado WHEN TRUE THEN 'TRUE' WHEN FALSE
                      THEN 'FALSE' ELSE 'NULL' END);
END;                      




