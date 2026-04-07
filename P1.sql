-- Enunciado 1 -  Base de dados e criação de tabela 
-- A base a ser utilizada pode ser obtida a partir do link a seguir. 
-- https://www.kaggle.com/datasets/yasserh/titanic-dataset 
-- Ela deve ser importada para uma base de dados gerenciada pelo PostgreSQL. Os dados 
-- devem ser armazenados em uma tabela apropriada para as análises desejadas. Você deve 
-- identificar as colunas necessárias, de acordo com a descrição de cada item da prova. 
-- Além, é claro, de uma chave primária (de auto incremento). Neste item, portanto, você 
-- deve desenvolver o script de criação da tabela. 
-- Mensagem de commit: feat(p1): cria base e importa dados


DROP TABLE IF EXISTS titanic;
CREATE TABLE titanic(

PassengerId SERIAL PRIMARY KEY,

Survived BOOLEAN,
Pclass INT,
Name VARCHAR,
Sex VARCHAR,
Age INT,
SibSp INT,
Parch BOOLEAN,
Ticket INT,
Fare NUMERIC,
Cabin VARCHAR,
Embarked VARCHAR

);

ALTER TABLE titanic
DROP COLUMN Name;
DROP COLUMN Age;
DROP COLUMN SibSp;
DROP COLUMN Parch;
DROP COLUMN Ticket;
DROP COLUMN Cabin;


-- Enunciado 2 - Sobrevivência em função da classe social 
-- Escreva um cursor não vinculado que mostra o número de passageiros sobreviventes que 
-- viajavam na primeira classe (Pclass = 1). 
-- Mensagem de commit: feat(p1): encontra sobreviventes da primeira classe 

DO $$
DECLARE
    cur REFCURSOR;
    var_passageiro INT;
    passageiros INT := 0;
BEGIN
    OPEN cur FOR SELECT PassengerId FROM titanic WHERE Survived = true AND Pclass = 1;
        WHILE FOUND LOOP
            passageiros := n_passageiros + 1;
            FETCH cur INTO var_passageiro;
            EXIT WHEN NOT FOUND;
        END LOOP;
        RAISE NOTICE 'Passageiros sobreviventes que viajavam na primeira classe: %',passageiros;
    CLOSE cur;
END;
$$


-- Enunciado 3 -  Sobrevivência em função do gênero 
-- Escreva um cursor com query dinâmica que mostra o número de passageiros 
-- sobreviventes dentre as mulheres (Sex = 'female'). Escreva um condicional para que, se 
-- não existir nenhuma, o valor -1 seja exibido. 
-- Mensagem de commit: feat(p1): encontra sobreviventes do sexo feminino 

DO $$
DECLARE
    cur REFCURSOR;
    nome_tabela VARCHAR := 'titanic';
    var_id_passageiro INT;
    passageiros INT := 0;
    sexo VARCHAR := 'female'; 
BEGIN
    OPEN cur FOR EXECUTE format('SELECT PassengerId FROM %s WHERE Sex = $1',nome_tabela) USING sexo;
        WHILE FOUND LOOP
            passageiros := n_passageiros + 1;
            FETCH cur INTO var_id_passageiro;
            EXIT WHEN NOT FOUND;
        END LOOP;
        IF passageiros = 0 THEN
            RAISE NOTICE '-1';
        ELSE
            RAISE NOTICE 'Número de passageiros: %',passageiros;
        END IF;
    CLOSE cur;
END;
$$

-- Enunciado 4 -  Tarifa versus embarque 
-- Dentre os passageiros que pagaram tarifa (Fare) maior que 50, quantos embarcaram em 
-- Cherbourg (Embarked = 'C')? Escreva um cursor vinculado que exiba esse valor. 
-- Mensagem de commit: feat(p1): encontra passageiros de Cherbourg com tarifa alta

DO $$
DECLARE
    cur CURSOR FOR SELECT PassengerId FROM titanic WHERE Fare > 50 AND Embarked = 'C';
    passageiros INT := 0;
    var_id_passageiro INT;
BEGIN
    OPEN cur;
        FETCH cur INTO var_id_passageiro;
        WHILE FOUND LOOP
            passageiros := passageiros + 1;
            FETCH cur INTO var_id_passageiro;
        END LOOP;
    CLOSE cur;
    RAISE NOTICE 'Passageiros que pagaram tarifa > 50 e embarcaram e Cherbourg: %',passageiros;
END;
$$

