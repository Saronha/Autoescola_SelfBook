# Justificação · E3

**Normalização.** Partimos dos ecrãs e das regras de negócio e chegámos à 3FN.
Cada facto fica guardado num só sítio:

- O e-mail e o telefone dependem da unidade, não do instrutor, por isso estão
  em `unidade_ensino` e o instrutor guarda só `id_unidade`.
- O horário (`hora_inicio_turno`, `hora_fim_turno`, `hora_pausa`) depende do
  turno, não da escala. Sem a tabela `turno`, cada linha de `escala` repetiria
  as três horas, e mudar o horário da tarde obrigaria a corrigir centenas de
  linhas.
- Credenciais e dados pessoais são coisas diferentes: `utilizador` tem o e-mail,
  o hash da senha e o estado da conta (`ativo`), `aluno` tem o nome e o
  documento. Todo aluno é utilizador: a relação é 1:1 e obrigatória, e
  `UNIQUE (id_aluno)` em `utilizador` garante que cada aluno tem uma só conta.
- A aula guarda só `data_hora_inicio`: como dura sempre 1h, a hora de fim
  seria um valor calculado e não se guarda.

**Chaves.** Todas as tabelas têm chave primária automática (`INT AUTO_INCREMENT`).
As relações N:M resolvem-se com tabelas de ligação:

- `aula` liga aluno e instrutor (um aluno tem aulas com vários instrutores e
  vice-versa) e leva a data e a hora;
- `escala` liga instrutor e turno por data. Tem id próprio, como as regras
  pedem, e `UNIQUE (id_instrutor, data_escala)`, que impede dois turnos no mesmo
  dia.

As regras que se resolvem por chave ficam garantidas pela própria base: `aula`
tem `UNIQUE (id_instrutor, data_hora_inicio)` e `UNIQUE (id_aluno,
data_hora_inicio)`, por isso nem o instrutor nem o aluno têm duas aulas à mesma
hora, mesmo que o backend falhe. A relação instrutor–carro é 1:1 e opcional:
`instrutor.id_carro` é anulável e tem `UNIQUE`, o que permite instrutores sem
carro e carros sem instrutor, mas nunca um carro com dois instrutores. O
`CHECK` em `aula` garante aulas à hora certa (minutos e segundos a zero).

**Sistema de gestão.** Escolhemos o MySQL 8.0: é gratuito, corre localmente, o
InnoDB aplica chaves estrangeiras e, desde a 8.0.16, restrições `CHECK`. O
MySQL Workbench desenha o diagrama a partir da base e gera o script, o que ajuda
a confirmar que criámos o que desenhámos.

**Limitações.** Assumimos quatro:

1. As regras que dependem do tempo ou de contagens (máximo de 4 aulas por dia e
   2 seguidas, limite de 16 aulas, desmarcar com 24h, só marcar dentro do turno
   e fora da pausa, só com instrutores com estado `T`) são validadas pelo
   backend e não pela base. Se mais tarde forem necessárias na base, passam a
   *triggers*.
2. Seguindo a decisão tomada com o professor, a entidade `admin` não está no
   modelo, por isso `utilizador` só se liga a `aluno` e a `escala` não regista
   quem a fez (ver `riscos.md`).
3. A base não consegue obrigar a que todo aluno tenha utilizador (o MySQL não
   tem restrições diferidas: o aluno e a conta referem-se mutuamente).
4. `estado` do instrutor é um `ENUM('T','F','BM')`: simples enquanto a lista for
   fixa; se crescer, passa a tabela própria.