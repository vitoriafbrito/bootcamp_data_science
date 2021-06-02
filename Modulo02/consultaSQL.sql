USE coleta_dados;

-- Quantas pessoas do gênero masculino gostam de cachorro?
SELECT aes.animal, pe.genero, count(pe.cod_pessoa) AS qtd_pessoas
FROM pesquisa AS pesq
JOIN animal_estimacao aes ON pesq.cod_animal_estimacao = aes.cod_animal_estimacao
JOIN pessoa pe ON pesq.cod_pessoa = pe.cod_pessoa
WHERE aes.animal = 'cachorro' AND pe.genero = 'Masculino'
GROUP BY pe.genero;

-- Qual a média de idade das pessoas do gênero masculino e feminino, respectivamente, que gostam de chá e clima frio?
CREATE TEMPORARY TABLE idade
SELECT cod_pessoa, data_nascimento 
	,TIMESTAMPDIFF(YEAR, data_nascimento, NOW()) AS idade
FROM pessoa;

SELECT pe.genero, be.bebida, cl.clima, avg(ida.idade) AS media_idade
FROM pesquisa AS pesq
JOIN pessoa pe ON pesq.cod_pessoa = pe.cod_pessoa
JOIN bebida be ON pesq.cod_bebida = be.cod_bebida
JOIN clima cl ON pesq.cod_clima = cl.cod_clima
JOIN idade ida ON pe.cod_pessoa = ida.cod_pessoa
WHERE be.bebida = 'Chá' AND cl.clima = 'frio'
GROUP BY pe.genero, cl.clima, be.bebida;

-- Qual é a média de idade de homens e mulheres que gostam de tartaruga e tem como hobbie escrever?
CREATE TEMPORARY TABLE idade
SELECT cod_pessoa, data_nascimento, TIMESTAMPDIFF(YEAR, data_nascimento, NOW()) AS idade
FROM pessoa;

SELECT pe.genero, aes.animal, h.hobbie, AVG(ida.idade) AS media_idade
FROM pesquisa AS pesq
JOIN pessoa AS pe ON pesq.cod_pessoa = pe.cod_pessoa
JOIN animal_estimacao AS aes ON pesq.cod_animal_estimacao = aes.cod_animal_estimacao
JOIN hobbie AS h ON pesq.cod_hobbie = h.cod_hobbie
JOIN idade AS ida ON pesq.cod_pessoa = ida.cod_pessoa
WHERE aes.animal = 'tartaruga' AND h.hobbie = 'escrever'
GROUP BY pe.genero, aes.animal, h.hobbie;

-- Qual o hobbie de maior preferência entre as mulheres?
SELECT pe.genero, h.hobbie, COUNT(h.cod_hobbie) AS qtd_hobbie 
FROM pesquisa as pesq
JOIN pessoa pe ON pesq. cod_pessoa = pe.cod_pessoa
JOIN hobbie h ON pesq.cod_hobbie = h.cod_hobbie
WHERE pe.genero = 'Feminino'
GROUP BY pe.genero, h.hobbie;

-- Qual a bebida favorita entre os homens e mulheres, respectivamente?
SELECT pe.genero, be.bebida, COUNT(be.cod_bebida) AS qtd_bebida
FROM pesquisa pesq
JOIN pessoa pe ON pesq.cod_pessoa = pe.cod_pessoa
JOIN bebida be ON pesq.cod_bebida = be.cod_bebida
GROUP BY pe.genero, be.bebida
ORDER BY qtd_bebida desc;

-- Quantas pessoas tem como Hobbie assistir TV, e qual a sua média de idade?
SELECT h.hobbie, COUNT(pe.cod_pessoa) AS qtd_pessoas, AVG(id.idade) media_idade
FROM pesquisa AS pesq
JOIN pessoa AS pe ON pesq.cod_pessoa = pe.cod_pessoa
JOIN idade AS id ON pesq.cod_pessoa = id.cod_pessoa
JOIN hobbie AS h ON pesq.cod_hobbie = h.cod_hobbie
WHERE h.hobbie = 'assistir TV'
GROUP BY h.hobbie;
