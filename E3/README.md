# E3 · Base de dados do SelfBook

Base de dados MySQL do SelfBook, o sistema de marcação de aulas práticas de
condução. Esta pasta tem tudo o que é preciso para recriar a base de raiz
noutra máquina.

## Conteúdo

| Ficheiro | O que é |
|---|---|
| `diagrama-er.pdf` | Modelo conceptual (diagrama entidade-relação) |
| `modelo-logico.pdf` | Modelo lógico (tabelas, chaves e tipos) |
| `schema.sql` | Cria as tabelas, chaves e restrições |
| `dados.sql` | Povoa a base com dados de teste fictícios |
| `justificacao.md` | Normalização, chaves e escolha do MySQL |
| `riscos.md` | Plano de recursos e riscos atualizado |

## Requisitos

- **MySQL Community Server 8.0.16 ou superior.** As restrições `CHECK` só são
  aplicadas a partir da 8.0.16 (em versões anteriores são ignoradas sem aviso) e
  o `DEFAULT (curdate())` exige a 8.0.13. O esquema foi gerado na versão 8.0.44.
- MySQL Workbench (opcional, para ver o diagrama a partir da base).

## Como recriar a base

Correr os comandos **por esta ordem**, a partir da pasta `e3/`.
Cada comando pede a palavra-passe do utilizador `root`.

```bash
# 1. Apagar e criar a base vazia
mysql -u root -p -e "DROP DATABASE IF EXISTS selfbook; CREATE DATABASE selfbook CHARACTER SET utf8mb4;"

# 2. Criar as tabelas
mysql -u root -p selfbook < schema.sql

# 3. Inserir os dados de teste
mysql --default-character-set=utf8mb4 -u root -p selfbook < dados.sql
```

Notas:

- No **PowerShell** o operador `<` não funciona. Usar a linha de comandos
  clássica (`cmd`) ou, dentro do cliente `mysql`, `SOURCE schema.sql;` e
  `SOURCE dados.sql;`.
- A opção `--default-character-set=utf8mb4` evita que os acentos sejam
  estragados no Windows.
- No **MySQL Workbench**: abrir `schema.sql` e executar o ficheiro todo, depois
  abrir `dados.sql` e executar.

**Atenção:** o `schema.sql` apaga cada tabela antes de a criar. O `dados.sql`
só funciona numa base acabada de criar pelo `schema.sql` (usa identificadores
fixos); para repetir, recomeçar no passo 1.

## Como confirmar que correu bem

O fim do `dados.sql` corre consultas de verificação. Resultado esperado:

| Consulta | O que verifica | Esperado |
|---|---|---|
| 9.1 | Contagens | unidade_ensino 3 · turno 3 · carro 7 · utilizador 8 · aluno 8 · instrutor 7 · escala 50 · aula 27 |
| 9.2 | Aulas fora da escala, do turno ou na pausa | 0 linhas |
| 9.3 | Aulas com instrutor de férias ou de baixa | 0 linhas |
| 9.4 | Aulas por aluno | 8 linhas; o aluno 8 aparece com 0 |
| 9.5 | Instrutores por unidade e carro | 7 linhas; o instrutor 7 sem carro |
| 9.6 | Horas livres do instrutor 1 a 16-11-2026 | 07:00, 10:00, 12:00 e 15:00 |
| 9.7 | Alunos com mais de 4 aulas num dia | 0 linhas |
| 9.8 | Alunos com 3 aulas seguidas | 0 linhas |
| 9.9 | Utilizadores sem aluno correspondente | 0 linhas |
| 9.10 | Alunos sem utilizador | 0 linhas |
| 9.11 | Alunos com mais de uma conta | 0 linhas |

## Dados de teste

Todos os dados são fictícios.

- **Unidades:** 3 (Santarém, Lisboa, Setúbal), com 7 instrutores e 7 carros.
- **Contas:** 8 utilizadores, exatamente um por aluno (`beatriz.carvalho@exemplo.pt`,
  `joao.ferreira@exemplo.pt`, etc.).
- **Palavra-passe de todas as contas:** `Teste123!`, guardada como hash bcrypt.
- **Escala:** duas semanas úteis, de 9 a 13 e de 16 a 20 de novembro de 2026
  (5 instrutores × 10 dias = 50 linhas).
- **Aulas:** 27, algumas no passado e outras no futuro (dia de referência:
  12-11-2026), todas dentro do turno do instrutor e fora da pausa.

Casos-limite incluídos:

- instrutor sem carro (7) e carro sem instrutor e indisponível (7);
- instrutor de férias (5) e de baixa médica (7), ambos sem escala;
- utilizador inativo (`ana.costa@exemplo.pt`);
- aluno sem aulas (8), mas com conta, como todos os alunos;
- aluno com 4 aulas no mesmo dia (aluno 2, a 16-11), nunca mais de 2 seguidas;
- primeira e última aula do turno, e aulas logo antes e logo depois da pausa;
- instrutores que mudam de turno durante as duas semanas;
- nomes com acentos e um documento do tipo título de residência.

## Organização do esquema

```
utilizador ──1:1── aluno ──< aula >── instrutor >── unidade_ensino
                                          │  └── carro (1:1, opcional)
                                          └──< escala >── turno
```

As decisões estão em `justificacao.md`. O que ainda falta alinhar entre as
regras de negócio, o modelo e o esquema está em `riscos.md`.