
-- Criando um Banco de Dados com usando o padrão UTF-8 para caracteres com acentuação:
CREATE DATABASE db_Biblioteca
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_general_ci;

-- Chamando o Banco de Dados para ser usado:
USE db_Biblioteca;

-- Criando uma tabela dentro do banco
CREATE TABLE IF NOT EXISTS tbl_Livro(

-- Declarando os atributos da tabela para formar um SCHEMA
ID_Livro SMALLINT AUTO_INCREMENT PRIMARY KEY,
Nome_Livro VARCHAR(50) NOT NULL,
ISBN VARCHAR(30) NOT NULL,
ID_Autor SMALLINT NOT NULL,
Data_Pub DATE NOT NULL,
Preco_Livro DECIMAL NOT NULL
);

-- Mostrando as tabelas existetes no banco
SHOW TABLES;

CREATE TABLE IF NOT EXISTS tbl_Autores(

ID_Autor SMALLINT PRIMARY KEY,
Nome_Autor VARCHAR(50),
Sobrenome_Autor VARCHAR(60)
);

CREATE TABLE tbl_Editoras(

ID_Editora SMALLINT PRIMARY KEY AUTO_INCREMENT,
Nome_Editora VARCHAR(50) NOT NULL
);

SHOW TABLES;

-- Deletando uma coluna na tabela
ALTER TABLE tbl_Livro
DROP COLUMN ID_Autor;

-- Mostrando tudo (*) da tabela
SELECT * FROM tbl_Livro;

-- Adicionando uma coluna
ALTER TABLE tbl_Livro
ADD ID_Autor SMALLINT NOT NULL;

-- Adicionando uma FOREING KEY (Constraint = 'Chave Estrangeira')
ALTER TABLE tbl_Livro
ADD CONSTRAINT fk_ID_Autor
FOREIGN KEY (ID_Autor)
REFERENCES tbl_Autores (ID_Autor);

SELECT * FROM tbl_Livro;

ALTER TABLE tbl_Livro
ADD ID_Editora SMALLINT NOT NULL;

ALTER TABLE tbl_Livro
ADD CONSTRAINT fk_ID_Editora
FOREIGN KEY (ID_Editora)
REFERENCES tbl_Editoras (ID_Editora);

SELECT * FROM tbl_Livro;

-- Inserindo registros (valores) no SCHEMA
INSERT INTO tbl_Autores(ID_Autor,Nome_Autor,SobreNome_Autor)VALUES(1,'Daniel','Barret');
INSERT INTO tbl_Autores(ID_Autor,Nome_Autor,SobreNome_Autor)VALUES(2,'Gerald','Carter');
INSERT INTO tbl_Autores(ID_Autor,Nome_Autor,SobreNome_Autor)VALUES(3,'Mark','Sobel');
INSERT INTO tbl_Autores(ID_Autor,Nome_Autor,SobreNome_Autor)VALUES(4,'Willian','Stanek');
INSERT INTO tbl_Autores(ID_Autor,Nome_Autor,SobreNome_Autor)VALUES(5,'Richard','Blum');

SELECT * FROM tbl_Autores;

INSERT INTO tbl_Editoras(Nome_Editora) VALUES ('Prentice Hall');
INSERT INTO tbl_Editoras(Nome_Editora) VALUES ('Ó Reilly');
INSERT INTO tbl_Editoras(Nome_Editora) VALUES ('Microsoft Press');
INSERT INTO tbl_Editoras(Nome_Editora) VALUES ('Wiley');

SELECT * FROM tbl_Editoras;

INSERT INTO tbl_Livro(Nome_Livro, ISBN, Data_Pub, Preco_Livro, ID_Autor, ID_Editora) VALUES ('Linux Command Line and Shell Scripting', 091287346, 20091221, 68.35, 5, 4);
INSERT INTO tbl_Livro(Nome_Livro, ISBN, Data_Pub, Preco_Livro, ID_Autor, ID_Editora) VALUES ('SSH, The Secure Shell', 347654908, 20100212, 78.90, 1, 2);
INSERT INTO tbl_Livro(Nome_Livro, ISBN, Data_Pub, Preco_Livro, ID_Autor, ID_Editora) VALUES ('Using Samba', 234556098, 20191113, 49.90, 2, 2);

-- Selecionar mais de uma coluna:
SELECT Nome_Livro, ISBN
FROM tbl_Livro;

-- Selecionar e ordenar de forma ASCendente(Padão) e DESCendente:
SELECT Nome_Livro, ID_Editora
FROM tbl_Livro
ORDER BY ID_Editora DESC;

-- PRIMARY KEY, FOREIGN KEY E UNIQUE já são INDEXADOS de forma nativa.
-- Nota-se pela função EXPLAIN(Explicando) que houve um um ganho de eficiência nas linhas afetadas quando se usa o INDEX.
SHOW INDEX FROM tbl_Editoras;

EXPLAIN SELECT * FROM tbl_Editoras
WHERE Nome_Editora = 'Springer';

CREATE INDEX idx_Editora ON tbl_Editoras(Nome_Editora);

SHOW INDEX FROM tbl_Editoras;

EXPLAIN SELECT * FROM tbl_Editoras
WHERE Nome_Editora = 'Springer';

DROP INDEX idx_Editora on tbl_Editoras;

-- Selecionando duas colunas de um registros cujo ID é 1:
SELECT Nome_Livro, Data_Pub FROM tbl_Livro WHERE ID_Autor = 1;
-- Selecionando duas colunas de um registros cujo valor da coluna Sobrenome é 'Stanek':
SELECT ID_Autor, Nome_Autor FROM tbl_Autores WHERE Sobrenome_Autor = 'Stanek';
-- Selecionando uma tabela como referência e mostrando a intersecção dos registros cujo ID_Livro é maior que 2 e ID_Autor é menor que 3:
SELECT * FROM tbl_Livro WHERE ID_Livro > 2 AND ID_Autor < 3;
-- Selecionando uma tabela como referência e mostrando todos os registros cujo ID_Livro é maior que 2 ou ID_Autor é menor que 3:
SELECT * FROM tbl_Livro WHERE ID_Livro > 2 OR ID_Autor < 3;
-- Selecionando uma tabela como referência e mostrando todos os registros cujo ID_Livro é maior que 1 exceto os que o ID_Autor é menor que 3:
SELECT * FROM tbl_Livro WHERE ID_Livro > 1 AND NOT ID_Autor < 3;

-- TRUNCATE TABLE Nome_Da_Tabela deleta todos os registros da tabela mas não a tabela em si. para isso usa-se o DROP.
-- DELETE FROM Nome_Da_Tabela WHERE Nome_Coluna = Valor_Do_Registro.

-- Renomeando (Aliases) a coluna Nome_Livro como Livros e a coluna Preco_Livro como Preços, ambas da tabela tbl_Livro
SELECT Nome_Livro AS Livros, Preco_Livro AS Preços FROM tbl_Livro;
-- Contando todos os registros da tbl_Autores
SELECT COUNT(*) FROM tbl_Autores;
-- Contando todos os registros exclusivos de autores
SELECT COUNT(DISTINCT ID_Autor) FROM tbl_Livro;
-- Retornando o valor máximo da coluna Preco_Livro
SELECT MAX(Preco_Livro) FROM tbl_Livro;
-- Retornando o valor mínimo da coluna Preco_Livro
SELECT MIN(Preco_Livro) FROM tbl_Livro;
-- Retornando a média dos valores da coluna Preco_Livro
SELECT AVG(Preco_Livro) FROM tbl_Livro;
-- Retornando a soma dos valores da coluna Preco_Livro
SELECT SUM(Preco_Livro) FROM tbl_Livro;

-- RENAME TABLE Nome_Antigo_Da_Tabela TO Nome_Novo_Da_Tabela

-- Atualizando o nome do livro cujo ID é igual a 2 
UPDATE tbl_Livro SET Nome_Livro = 'SSH, O Shell Seguro' WHERE ID_Livro = 2;
-- Mostrando os registros cujos valores da coluna Preco_Livro estão entre 49.90 e 78.90  
SELECT ID_Livro, Nome_Livro FROM tbl_Livro WHERE Preco_Livro BETWEEN 49.90 AND 78.90;

-- Mostrando todos os registros cujos valores da coluna começam com o caracter 'L', independente do que vier na sequência
SELECT * FROM tbl_Livro WHERE Nome_Livro LIKE 'L%';
-- Mostrando todos os registros cujos valores da coluna não começam com o caracter 'L', independente do que vier na sequência
SELECT * FROM tbl_Livro WHERE Nome_Livro NOT LIKE 'L%';
-- Mostrando todos os registros cujos valores da coluna começam com um caracter qualquer, seguido necessáriamente do 'S', independente do que vier na sequência
SELECT * FROM tbl_Livro WHERE Nome_Livro LIKE '_S%';
-- Mostrando todos os registros cujos valores da coluna começam (^) com o caracter 'U' ou 'S'
SELECT Nome_Livro FROM tbl_Livro WHERE Nome_Livro REGEXP '^[US]'; 
-- Mostrando todos os registros cujos valores da coluna não (^) começam (^) com o caracter 'U' ou 'S'
SELECT Nome_Livro FROM tbl_Livro WHERE Nome_Livro REGEXP '^[^US]'; 
-- Mostrando todos os registros cujos valores da coluna que terminam ($) com 'ao' necessariamente nesta ordem
SELECT Nome_Livro FROM tbl_Livro WHERE Nome_Livro REGEXP '[ao]$'; 
-- Mostrando todos os registros cujos valores da coluna começam com o caracter 'U' ou 'S' ou 'Li'
SELECT Nome_Livro FROM tbl_Livro WHERE Nome_Livro REGEXP '^[US]|Li'; 

-- Modificando a coluna Sobrenome_Autor para incluir um padrão caso não seja inserido nenhum valor
ALTER TABLE tbl_Autores MODIFY COLUMN Sobrenome_Autor VARCHAR(60) DEFAULT 'da Silva';
-- Inserindo registro sem sobrenome
INSERT INTO tbl_Autores(ID_Autor, Nome_Autor) VALUES (6, 'João');
-- Mostrando o padão de sobrenome
SELECT * FROM tbl_Autores;
-- Tirando o valor padrão
ALTER TABLE tbl_Autores MODIFY COLUMN Sobrenome_Autor VARCHAR(60);

-- Criando uma tabela temporaria para fazer buscas
CREATE TABLE vendas(

ID SMALLINT PRIMARY KEY,
Nome_Vendedor Varchar(20),
Quantidade int,
Produto VARCHAR(20),
Cidade VARCHAR(20)
);

INSERT INTO Vendas(ID, Nome_Vendedor, Quantidade, Produto, Cidade) VALUES
(10,'Jorge',1400,'Mouse','São Paulo'),
(12,'Tatiana',1220,'Teclado','São Paulo'),
(14,'Ana',1700,'Teclado','Rio de Janeiro'),
(15,'Rita',2120,'Webcam','Recife'),
(18,'Marcos',980,'Mouse','São Paulo'),
(19,'Carla',1120,'Webcam','Recife'),
(22,'Roberto',3145,'Mouse','São Paulo');
-- Mostrar tudo da tabela Vendas cujo Produto for 'Mouse'
SELECT * FROM Vendas WHERE Produto = 'Mouse';
-- Mostrar a soma dos registros da coluna Quantidade da tabela Vendas onde a coluna Produto for igual a Mouse e nomeando a operação desta busca de TotalMouses
SELECT SUM(Quantidade) AS TotalMouses FROM Vendas WHERE Produto = 'Mouse';
-- Somando os registros da coluna Quantidade, agrupando-os por cidade e dando o nome da busca de Total
SELECT Cidade, SUM(Quantidade) AS Total FROM Vendas GROUP BY Cidade;
-- Contando a frequência que cada registro aparece agrupando-os por Cidade e dando o noma da busca de Vendas
SELECT Cidade, COUNT(*) AS Total FROM Vendas GROUP BY Cidade;
/* Somando os registros da coluna Quantidade, agrupando-os por cidade,
mostrando apenas cidades cujo valor da soma da coluna Quantidade for menor que 2500 e dando o nome da busca de Vendas*/
SELECT Cidade, SUM(Quantidade) AS Total FROM Vendas GROUP BY Cidade  HAVING SUM(Quantidade) < 2500;
/* Somando os registros da coluna Quantidade, agrupando-os por cidade,
mostrando apenas cidades cujo valor da soma de venda de 'Mouse' da coluna Quantidade for maior que 1500 e dando o nome da busca de TotalMouses*/
SELECT Cidade, SUM(Quantidade) AS TotalMouses FROM  Vendas WHERE Produto = 'Mouse' GROUP BY Cidade HAVING SUM(Quantidade) > 1500;

/*Criando uma 'Visualização' ou 'Visão' de nome vw_LivroAutores e relacionando a coluna Nome_Livro da tabela tbl_livro (chamando-a de Livro), que é a principal,
 e a coluna Nome_Autor da tabela tbl_autores (chamando-a de Autor)*/
CREATE VIEW vw_LivroAutores
AS SELECT tbl_livro.Nome_Livro AS Livro, tbl_autores.Nome_Autor
AS Autor FROM tbl_livro JOIN tbl_autores ON tbl_livro.ID_Autor = tbl_autores.ID_Autor;
-- Mostrando a visualização ordenada por Autor
SELECT Livro, Autor FROM vw_LivroAutores ORDER BY Autor;

-- Para alterar: ALTER VIEW nome_da_view;
-- Para deletar: DROP VIEW nome_da_view;

/* INNER JOIN é um relacionamento que mostra apenas registros que estão completos e contidos nas duas ou mais tabelas de referência(Intersecção),
 sendo a tabela principal chamada depois da função FROM*/
SELECT * FROM tbl_livro
INNER JOIN tbl_autores
ON tbl_livro.ID_Autor = tbl_autores.ID_Autor;

SELECT tbl_livro.Nome_Livro, tbl_livro.ISBN, tbl_autores.Nome_Autor
FROM tbl_livro
INNER JOIN tbl_autores
ON tbl_livro.ID_Autor = tbl_autores.ID_Autor;

SELECT L.Nome_Livro AS Livros, E.Nome_Editora AS Editoras
FROM tbl_livro AS L
INNER JOIN tbl_editoras AS E
ON L.ID_Editora = E.ID_EDitora
WHERE E.Nome_Editora LIKE 'W%';

SELECT L.Nome_Livro AS Livro, A.Nome_Autor AS Autor,
E.Nome_Editora AS Editora
FROM tbl_livro AS L
INNER JOIN tbl_autores AS A
ON L.ID_Autor = A.ID_Autor
INNER JOIN tbl_editoras AS E
ON L.ID_Editora = E.ID_Editora;

-- OUTER JOIN mostra todos os registros que está contido na tabela de referência da esquerda (LEFT JOIN) ou da direita (RIGHT JOIN).
/* LEFT JOIN faz um relacionamento entre duas ou mais tabelas que mostra a intersecção entre as mesmas e todas as colunas da tabela principal
(tabela após a função FROM) com ou sem registros completos*/

SELECT * FROM tbl_autores
LEFT JOIN tbl_livro
ON tbl_livro.ID_Autor = tbl_autores.ID_Autor;

SELECT * FROM tbl_autores
LEFT JOIN tbl_livro
ON tbl_livro.ID_Autor = tbl_autores.ID_Autor
WHERE tbl_livro.ID_Autor IS NULL;

INSERT INTO tbl_editoras (ID_Editora, Nome_Editora)
VALUES (5, 'Companhia das Letras');

/* RIGHT JOIN faz um relacionamento entre duas ou mais tabelas que mostra a intersecção entre as mesmas e todas as colunas da secundaria
(tabela após a função RIGHT JOIN) com ou sem registros completos*/

SELECT * FROM tbl_livro AS Li
RIGHT JOIN tbl_editoras AS Ed
ON Li.ID_Editora = Ed.ID_Editora;

SELECT * FROM tbl_livro AS Li
RIGHT JOIN tbl_editoras AS Ed
ON Li.ID_Editora = Ed.ID_Editora
WHERE Li.ID_Editora IS NULL;

-- Junta (concatena) dois ou mais argumentos

-- Juntando nome e sobrenome do autor e lhe dando o nome da aplicação de Nome Completo da tabela tbl_autores
SELECT CONCAT(Nome_Autor, ' ', Sobrenome_Autor)
AS 'Nome Completo' FROM tbl_autores;

-- Criando uma tabela se não existe
CREATE TABLE IF NOT EXISTS Testes_Nulos(

ID SMALLINT PRIMARY KEY auto_increment,
Item VARCHAR(20),
Quantidade SMALLINT NULL);

INSERT INTO Testes_Nulos (ID, Item, Quantidade) VALUES
(1, 'Pendrive', 5),
(2, 'Monitor', 7),
(3, 'Teclado', NULL);

-- Se uma concatenação possui um valor nulo, o valor da operação será nulo.
-- A função IFNULL substitui o valor nulo por outro valor escolhido.

SELECT CONCAT('A quantidade adquirida é', ' ', IFNULL(Quantidade, 0))
FROM Testes_Nulos WHERE Item = 'Teclado';

-- A função COALESCE retorna o 1º valor não nulo encontrado.

SELECT CONCAT('A quantidade adquirida é', ' ', COALESCE(NULL, Quantidade, NULL, 0))
FROM Testes_Nulos WHERE Item = 'Monitor';

-- Operadores (+) Adição, (-) Subtração, (/) Divisão, (DIV) Divisão Inteira, (% | MOD) Resto da Divisão
-- CEILING() Arredonda para cima, FLOOR() Aredonda para baixo, PI() Valor de PI, POW(n1, n2) Potência, SQRT() Raiz Quadrada, SIN() seno, COS() Coseno, HEX() Hexadecimal;

CREATE FUNCTION Nome_Funcao (x DECIMAL(10,2), y INT)
RETURNS INT -- Retorna apenas valores inteiros
RETURN x * y;

SELECT Nome_Funcao(2.5, 4) AS Resultado;

SELECT Nome_Livro, Nome_Funcao(Preco_Livro, 6) AS 'Preço de 6 unidades'
FROM tbl_livro WHERE ID_Livro = 2;

DROP FUNCTION Nome_Funcao;

/* Criando uma rotina ou procedimento chamada de verPreco que quando chamada recebe um valor que é lido como ID_Livro
 e concatena 'O preço é' 'Preco_Livro do ID procurado'*/
CREATE PROCEDURE verPreco (varLivro SMALLINT)
SELECT CONCAT('O preço é ', Preco_Livro) AS Preço
FROM tbl_livro WHERE ID_Livro = varLivro;

CALL verPreco(3); -- A função CALL executa procedimentos(PROCEDURE)

DROP PROCEDURE verPreco;

DELIMITER // -- DELIMITER é usado para mudar o ';' para qualquer outro caracter não reservado, permitindo que o bloco BEGIN, END seja executado completamente

-- Criando um procedimento que mostra o preço do livro ao passar o ID do livro para o procedimento verPreco 
CREATE PROCEDURE verPreco (verLivro SMALLINT)
BEGIN
	SELECT CONCAT('O preço é ', Preco_Livro) AS Preço
    FROM tbl_livro WHERE ID_Livro = verLivro;
    SELECT 'Procedimento executado com sucesso!';
END //
DELIMITER ; -- Voltando o DELIMITER para o padrão (;)

CALL verPreco(3);

-- Exemplo IN 1 (O camando IN permite apenas a entrada de dados)


/*Criando um procedimento que faz um relacionamento entre as colunas Nome_Livro da tabela tbl_Livro
 e Nome_Editora da tabela tbl_Editora passando como parâmetro o nome da editora*/
 DELIMITER //
 CREATE PROCEDURE Editora_Livro(IN editora VARCHAR(50))
BEGIN 
	SELECT L.Nome_Livro, E.Nome_Editora
    FROM tbl_Livro AS L
    INNER JOIN tbl_Editoras AS E
    ON L.ID_Editora = E.ID_Editora
    WHERE E.Nome_Editora = editora;
END //
DELIMITER ;



select * from tbl_Editoras;

-- Chamando a função 1
CALL Editora_Livro('wiley');

-- Chamando a função 2
SET @minhaeditora = 'wiley';-- Colocado o nome 'wiley' na variável @minhaeditora
CALL Editora_Livro(@minhaeditora);-- Executando o procedimento Editora_Livro passando como parâmetro @minhaeditora que é 'wiley'

-- Exemplo IN 2
DELIMITER //

/*Criando o procedimento Aumenta_Preco que pega o valor do parâmetro codigo e o inseri no ID_Livro para ser inserido na variável Preco_Livro, 
que por sua vez será armazenado com o acrescimo da taxa*/ 
CREATE PROCEDURE Aumenta_Preco(IN codigo INT, IN taxa DECIMAl(10,2))
BEGIN
	UPDATE tbl_Livro
    SET Preco_Livro = tbl_Livro.Preco_Livro + tbl_Livro.Preco_Livro * taxa / 100
    WHERE ID_Livro = codigo;
END //
DELIMITER ;

-- Verificando o ID_Livro = 1 antes da aplicação
SELECT * FROM tbl_Livro WHERE ID_Livro = 1;

SET @livro = 4;-- Inserindo o valor do parâmetro código na variável @livro
SET @aumento = 20;-- Inserindo o valor do parâmetro taxa na variável @aumento
CALL Aumenta_Preco(@livro, @aumento); -- Aumenta_Preco(codigo, taxa)

-- Verificando o ID_Livro = 1 depois da aplicação
SELECT * FROM tbl_livro WHERE ID_Livro = 1;

-- Exemplo OUT (O camando OUT permite apenas a saída de dados)
DELIMITER //

-- Criando um procedimento que pega os valores do ID_Livro e Nome_Livro e insere no parâmetro id e livro respectivamente
CREATE PROCEDURE teste_out (IN id INT, OUT livro VARCHAR(50))
BEGIN 
	SELECT Nome_Livro
    INTO livro 
    FROM tbl_Livro
    WHERE ID_Livro = id;
END //
DELIMITER ;

CALL teste_out(3, @livro); -- Executando o procedimento teste_out com a entrada do id e mostrando o valor de @livro
SELECT @livro;

-- Exemplo INOUT (O camando INOUT permite a entrada e saída de dados do mesmo parâmetro)

DELIMITER //

-- Criando um procedimento que usa a variável valor para sobre-escrever sua entrada como sáida
CREATE PROCEDURE aumento (INOUT valor DECIMAL(10, 2), taxa DECIMAL(10, 2))
BEGIN
	SET valor = valor + valor * taxa / 100;
END //
DELIMITER ;

SET @valorinicial = 20;-- Insere um valor na variável @valorinicial
SELECT @valorinicial;-- Mostra o valor da variável @valorinicial

CALL aumento(@valorinicial, 15.00);-- Executa o procedimento aumento com os parâmetros 20 e 15 (valor, taxa)

SELECT @valorinicial;

DELIMITER //
-- Criando função que declara a variável preco e a subtrai de desconto para inserir seu valor no parâmetro livro 
CREATE FUNCTION calcula_desconto(livro INT, desconto DECIMAL (10, 2))
RETURNS DECIMAL (10, 2)
BEGIN 
	DECLARE preco DECIMAL (10, 2);
    SELECT Preco_Livro FROM tbl_Livro
    WHERE ID_Livro = livro into preco;
    RETURN preco - desconto;
END //
DELIMITER ; 

-- Verificando o ID_Livro = 1 antes da aplicação
SELECT * FROM tbl_Livro WHERE ID_Livro = 1;
SELECT calcula_desconto(1, 10.00);

-- Verificando o ID_Livro = 1 depois da aplicação
SELECT * FROM tbl_Livro WHERE ID_Livro = 1;

-- Usando IF, ELSE, ELSEIF

-- Criando uma função que calcula o imposto de um funcionário de acordo com seu salário
DELIMITER //
CREATE FUNCTION  calcula_imposto(salario DEC(8,2))
RETURNS DEC(8, 2)
BEGIN 
	DECLARE valor_imposto DEC (8, 2);
    IF salario > 1000 THEN 
		SET valor_imposto = salario * 0.00;
	ELSEIF salario > 2000 THEN
		SET valor_imposto = salario * 0.10;
	ELSEIF salario > 3000 THEN
		SET valor_imposto = salario * 0.15;
	ELSEIF salario > 4000 THEN
		SET valor_imposto = salario * 0.20;
	ELSE 
		SET valor_imposto = salario * 0.27;
	END IF;
    RETURN valor_imposto;
END //
DELIMITER ;

SELECT calcula_imposto(900);
SELECT calcula_imposto(1200);
SELECT calcula_imposto(2200);
SELECT calcula_imposto(3300);
SELECT calcula_imposto(5000);

-- Usando CASE
DELIMITER //
CREATE FUNCTION  calcula_imposto_case(salario DEC(8,2))
RETURNS DEC(8, 2)
BEGIN 
	DECLARE valor_imposto DEC (8, 2);
    CASE
    WHEN salario > 1000 THEN 
		SET valor_imposto = salario * 0.00;
	WHEN salario > 2000 THEN
		SET valor_imposto = salario * 0.10;
	WHEN salario > 3000 THEN
		SET valor_imposto = salario * 0.15;
	WHEN salario > 4000 THEN
		SET valor_imposto = salario * 0.20;
	ELSE 
		SET valor_imposto = salario * 0.27;
	END CASE;
    RETURN valor_imposto;
END //
DELIMITER ;

SELECT calcula_imposto(900);
SELECT calcula_imposto(1200);
SELECT calcula_imposto(2200);
SELECT calcula_imposto(3300);
SELECT calcula_imposto(5000);

-- Usando LOOP
DELIMITER //

-- Criando procedimento que acresce valores a variável soma até chegar a 10 e mostra seu valor
CREATE PROCEDURE acumula (limite INT)
BEGIN 
	DECLARE contador INT DEFAULT 0;
    DECLARE soma INT DEFAULT 0;
    loop_teste: LOOP
		SET contador = contador + 1;
        SET soma = soma + contador;
        IF contador >= limite THEN 
			LEAVE loop_teste;
		END IF; 
	END LOOP loop_teste;
    SELECT soma;
END //
DELIMITER ; 

CALL acumula(10);
CALL acumula(0);-- Erro. Ver os próximos exemplos

-- Usuando REPEAT

DELIMITER //

-- Criando procedimento que acresce valores a variável soma até chegar a 10 e mostra seu valor
CREATE PROCEDURE acumula_repita(limite TINYINT UNSIGNED)
main : BEGIN
	DECLARE contador TINYINT UNSIGNED DEFAULT 0;
    DECLARE soma INT DEFAULT 0;
    IF limite < 1 THEN
		SELECT 'O valor deve ser maior que zero.' AS Erro;
        LEAVE main;
	END IF;
    REPEAT
		SET contador = contador + 1;
        SET soma = soma + contador;
	UNTIL contador >= limite
    END REPEAT;
    SELECT soma;
END //
DELIMITER ;

CALL acumula_repita(10);
CALL acumula_repita(0);-- Funciona

DROP PROCEDURE acumula_repita;

DELIMITER //

-- Criando procedimento que acresce valores a variável soma até chegar a 10 e mostra seu valor
CREATE PROCEDURE acumula_while(limite TINYINT UNSIGNED)
BEGIN 
	DECLARE contador TINYINT UNSIGNED DEFAULT 0;
    DECLARE soma INT DEFAULT 0;
    WHILE contador < limite DO
		SET contador = contador + 1;
        SET soma = soma + contador;
	END WHILE;
	SELECT soma;
END //
DELIMITER ;

CALL acumula_while(10);
CALL acumula_while(0);-- Funciona	

-- Usando ITERATE o comando volta automaticamente para o início da aplicação (LOOP, REPEAT, WHILE)
DELIMITER //
CREATE PROCEDURE acumula_iterate (limite INT)
BEGIN 
	DECLARE contador TINYINT UNSIGNED DEFAULT 0;
    DECLARE soma INT UNSIGNED DEFAULT 0;
    teste: LOOP
		SET contador = contador + 1;
        SET soma = soma + contador;
        IF contador >= limite THEN 
			ITERATE teste;
		END IF; 
		LEAVE teste;
    END LOOP teste;
    SELECT soma;
END //
DELIMITER ; 

CALL acumula(10);

DELIMITER //

-- Criando procedimento para imprimir valores pares usando WHILE...DO
CREATE PROCEDURE pares(limite TINYINT UNSIGNED)
main: /* RÓTULO*/BEGIN
	DECLARE contador TINYINT DEFAULT 0;
    /* RÓTULO*/ meuloop: WHILE contador < limite DO
		SET contador = contador + 1;
		IF MOD(contador, 2) THEN
			ITERATE  meuloop;
		END IF;
		SELECT CONCAT(contador, 'é número par') AS Valor;
	END WHILE;
END //
DELIMITER ;

CALL pares(20);

