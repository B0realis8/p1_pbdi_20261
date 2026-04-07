-- Enunciado 1 -  Base de dados e criação de tabela 
-- A base a ser utilizada pode ser obtida a partir do link a seguir. 
-- https://www.kaggle.com/datasets/yasserh/titanic-dataset 
-- Ela deve ser importada para uma base de dados gerenciada pelo PostgreSQL. Os dados 
-- devem ser armazenados em uma tabela apropriada para as análises desejadas. Você deve 
-- identificar as colunas necessárias, de acordo com a descrição de cada item da prova. 
-- Além, é claro, de uma chave primária (de auto incremento). Neste item, portanto, você 
-- deve desenvolver o script de criação da tabela. 
-- Mensagem de commit: feat(p1): cria base e importa dados

-- Inserir apenas colunas necessárias

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
