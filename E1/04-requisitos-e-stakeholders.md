# 04 · Requisitos e stakeholders

## Requisitos (MoSCoW)

| #   | requisito                                                                     | Prioridade                | Quem o usa               |
| --- | ----------------------------------------------------------------------------- | ------------------------- | ------------------------ |
| R1  | A escola define e edita os horários de disponibilidade de cada instrutor      | Essencial (Must)          | Recepção / administração |
| R2  | O aluno consulta a disponibilidade de todos os instrutores                    | Essencial (Must)          | Aluno                    |
| R3  | O aluno seleciona um horário livre e marca a aula sem intervenção da recepção | Essencial (Must)          | Aluno                    |
| R4  | O aluno consulta o seu percurso: aulas já feitas e aulas em falta             | Desejável (Should)        | Aluno                    |
| R5  | O aluno dá feedback sobre cada aula                                           | Opcional (Could)          | Aluno                    |
| R6  | Pagamento de aulas extras na aplicação                                        | Fora desta versão (Won't) |                          |

### Requisitos de qualidade 

- A lista de disponibilidades abre em menos de 3 segundos.

- Um horário já marcado não pode ser marcado por outro aluno (sem marcações duplicadas).

## Stakeholders

| Grupo | Quem | Papel  |
| ----- | -----|------- |
| *Usam*   | Alunos, recepcionistas, instrutores | Alunos marcam; recepção gere horários; instrutores têm a disponibilidade registada |
| *Decidem*| Direção da escola de condução       | Aprova a utilização do sistema e o que se guarda sobre os alunos                   |
| *Sentem os efeitos* | A escola e os alunos     | A escola não precisa mais de um funcionário que se dedique a marcar as aulas obrigatórias para os alunos. Os alunos não precisam informar toda sua disponibilidade para escola |

*Consequência:* perfis diferentes precisam de permissões diferentes. O aluno só marca e consulta; a escola gere horários.
