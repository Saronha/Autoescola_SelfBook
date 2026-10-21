Sinal Verde — Acessibilidade e Responsividade
Contraste
Todo o texto usa pares testados contra as normas WCAG AA, sobre o fundo branco #FFFFFF:

Uso	Cor	Contraste
Texto principal	#212D37	14,0 : 1 (AAA)
Texto secundário / legendas	#63717D	5,0 : 1 (AA)
Verde escuro para texto pequeno	#036819	7,0 : 1 (AAA)
Verde primário (títulos, botões grandes)	#299236	4,0 : 1 (texto ≥ 14 px a negrito)
O amarelo #FCCA21, o verde vivo #50BE34 e o vermelho #F54842 nunca servem de cor de texto: são apenas acentos (barras de progresso, chips, avisos), sempre com texto escuro #212D37 por cima — 9,1 : 1 no amarelo. A informação nunca depende só da cor: os estados das aulas (disponível, marcada, erro) combinam cor com texto, contorno tracejado e role="alert". Cada instrutor tem um tom escuro próprio (verde #067132, azul #0064B9, laranja #A74A00, rosa #A82F74, roxo #7444B4, turquesa #007A7B, vermelho #BA2B2E, castanho #7E522C, cinzento #5A656E) — todos acima de 5 : 1 sobre branco ou sobre o seu fundo claro.

Tipografia e foco por teclado
Fredoka (títulos) e Nunito (corpo) têm peso e tamanho confortáveis: corpo 14–16 px, títulos 27–42 px, line-height ≥ 1,16. Todas as ações são <button> ou <a> nativos (navegação por Tab, ativação por Enter/Espaço), com aria-label nos botões só de ícone (menu, semanas) e aria-pressed nos chips de instrutor. O pop-up de detalhes da aula usa um diálogo com foco preso, fecho por Esc e ordem de tabulação correta; os cartões de aula na lista respondem também a Enter. Os erros aparecem com role="alert", lidos pelos leitores de ecrã.

Ecrãs pequenos
A partir dos 700 px a barra lateral desaparece e o menu vira hambúrguer (com aria-label "Abrir/Fechar menu"); a página de entrada empilha a ilustração e o formulário; a página Sobre passa o texto para baixo da foto. O calendário semanal mantém um mínimo de 680 px e rola horizontalmente, em vez de esmagar as células. Os alvos de toque têm no mínimo ~44 px (botões de 44–49 px de altura). Pontos a melhorar: os botões só de ícone ainda têm 36 px, e o menu aberto podia fechar com Esc.