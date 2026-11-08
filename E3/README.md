# Regras do negócio:

O *SelfBook* é um sistema gestor de horários de aulas para escolas de condução. nesse sistema:

- As entidades principais são unidade de ensino, aluno, admin, instrutor, aula, escala turno e carro.

- A escola de condução tem 3 **UNIDADES** de ensino em diferentes localidades. Cada unidade é identificada por seu ID e nome (para o nosso sistema não importa guardar o endereço).

- Cada unidade dispõe de carros e cada **CARRO** está associado à um único INSTRUTOR por vez. dos carros importa guardar seu ID, número de matrícula, data da primeira matrícula, data da última inspeção e disponibilidade (pode ser que tenham carros sem instrutores);

- Cada **INSTRUTOR** está associado à uma única unidade de ensino por vez. Do instrutor importa guardar seu próprio ID, o _ID de usuário_, o nome, número de documento, a data de admissão, a unidade de ensino e o carro associados à ele (pode ser que existam instrutores sem carro), se está trabalhando (T), de férias (F) ou baixa médica (BM);


- O **ADMIN** faz a ESCALA de trabalho dos INSTRUTORES e todas as unidades de ensino. Também pode adicionar, remover instrutores, trocá-los de unidades de ensino e trocar ou remover carros. Do admiin basta apenas guardar o id. Podem existir mais de um admin.

- Exstem 3 **TURNOS** possíveis para os INSTRUTORES, nomeadamente manhã (7h-16h com pausa das 11h às 12h), tarde (9h-18h com pausa das 13h às 14h) e noite (11h-20h com pausa das 15h às 16h);

- a **ESCALA** faz o relacionamento entre os INSTRUTORES e os TURNOS. Ela tem ID próprio e uma escala diz qual instrutor vai fazer qual turno em qual data. Um instrutor não pode fazer mais de um tuno no mesmo dia. Importa guardar quem foi o ADMIN que fez essa escala.

- Os **ALUNOS** marcam AULAs com INSTRUTORES. Do aluno importa guardar o seu próprio ID, o ID_usuário o nome, o numero de documento e a data de inscrição.

- As **AULAS** têm sempre 1h de duração. Das aulas importa guardar a data, a hora de inicio, o aluno que marcou e o instrutor que ele escolheu. Não podem existir duas aulas na mesma data e hora com o mesmo aluno, nem duas aulas na mesma dada e hora com o mesmo instrutor.


O modelo conceitual ficou assim:

![modelo conceptual](imagens/modelo_conceptual.png)


## UTILIZADOR

Do **UTILIZADOR** importa guardar email e senha (hash). Utilizadores podem ter ou permissoes de ADMIN, ou permissões de ALUNO. De momento, o sistema não inclui instrutores como utilizadores. 

Um utilizador corresponde a um único aluno/admin e um aluno/admin corresponde a um único utilizador. um aluno não pode ter permissões de admin e vice versa. 

Na escola podem existir alunos e admins que ainda não são utilziadores. mas nunca vai existir um utilizador que não está associado à um aluno ou a um admin.

Os utilziadores fazem login com email e senha (No protótipo estava login com google, porém mudamos de ideia pois não parece fazer muito sentido um admin fazer login com sua conta pessoal do google.).

Escolhemos por não represenhar a entidade UTILIZADOR no modelo conceptual, pois ao mesclar as duas entidades ALUNO e INSTRUTOR (ambos são utilizadores), o diagrama ficaria visualmente poluído e dificil de entender qual usuário tem permissão de realizar qual ação

![conceptual utilizador](imagens/conceptual_utilizador.png)
(Simplificação decomo ficaria)