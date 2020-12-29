-- PL/SQL

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
