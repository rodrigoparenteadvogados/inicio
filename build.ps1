# Script de Compilação do Site Institucional em PowerShell (Banco de Dados Expandido)
# Gerencia a criação das 29 páginas, sitemap, robots e cópia de ativos

$OutputEncoding = [System.Text.Encoding]::UTF8

# 1. Cria os diretórios necessários
New-Item -ItemType Directory -Path "css" -Force | Out-Null
New-Item -ItemType Directory -Path "js" -Force | Out-Null
New-Item -ItemType Directory -Path "img" -Force | Out-Null

Write-Host "Iniciando compilação do site institucional Rodrigo Parente Advogados..." -ForegroundColor Cyan

# 2. Definição do Banco de Dados de Áreas de Atuação (EXPANDIDO)
$areas = @(
  @{
      id = 'direito-administrativo'
      title = 'Direito Administrativo'
      href = 'direito-administrativo.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M4 10h3v7H4zm6.5 0h3v7h-3zM17 10h3v7h-3zm-15 9h20v2H2zm10-17L2 7v1h20V7L12 2z"/></svg>'
      summary = 'Atuação em licitações, contratos públicos, concessões, PPPs e defesas administrativas perante órgãos de controle.'
      comoAtuamos = 'Atuação especializada em demandas que envolvem a relação de cidadãos, servidores públicos e empresas com a Administração Pública. Nosso foco é assegurar a legalidade dos atos administrativos, reverter arbitrariedades e viabilizar contratações públicas seguras e em conformidade com as leis.<br><br>Atuamos na esfera consultiva e preventiva (elaboração de pareceres, estruturação de propostas e modelagem de parcerias) e na esfera contenciosa (ajuizamento de mandados de segurança, anulação de multas e defesas perante tribunais de contas).'
      foco = @(
        @{
          title = 'Licitações e Contratos'
          desc = 'Assessoria completa em editais, análise de riscos contratuais, impugnações, recursos, e pleitos de reequilíbrio econômico-financeiro de contratos públicos.'
        },
        @{
          title = 'Defesa de Servidores e Agentes'
          desc = 'Representação em Sindicâncias, Processos Administrativos Disciplinares (PAD), defesas em ações de improbidade e preservação de direitos e cargos.'
        },
        @{
          title = 'Concessões e Parcerias (PPPs)'
          desc = 'Estruturação regulatória e modelagem de Parcerias Público-Privadas (PPPs), concessões de serviços públicos e consórcios intermunicipais.'
        }
      )
      duvidas = @(
        @{
          q = 'Posso participar desta licitação?'
          a = 'A participação em licitações públicas exige o atendimento a regras objetivas de habilitação jurídica, fiscal, trabalhista e técnica contidas na Nova Lei de Licitações (Lei nº 14.133/2021). Uma análise preventiva da documentação ajuda a evitar desclassificações.'
        },
        @{
          q = 'Como impugnar um edital irregular?'
          a = 'Qualquer cidadão ou empresa licitante tem o direito de impugnar editais que tragam exigências excessivas ou restritivas que prejudiquem a ampla competitividade. A impugnação administrativa deve ser formalizada perante a comissão licitatória no prazo legal.'
        },
        @{
          q = 'O órgão público pode me desclassificar?'
          a = 'A desclassificação só é lícita se a empresa violar requisito essencial e insustentável do edital. Desclassificações motivadas por formalismo excessivo ou em contrariedade aos princípios constitucionais do contraditório e proporcionalidade podem ser revertidas judicialmente.'
        },
        @{
          q = 'Como recorrer de uma penalidade administrativa?'
          a = 'Ao receber uma notificação de penalidade (advertência, multa ou suspensão), cabe interpor recurso administrativo no prazo da lei, demonstrando ausência de dolo, falhas processuais no rito sancionador ou desproporcionalidade da sanção imposta.'
        },
        @{
          q = 'Como funciona uma concessão ou PPP?'
          a = 'São contratos complexos de longo prazo onde a iniciativa privada assume a prestação de serviços ou a construção de infraestrutura pública. Envolvem modelagem econômico-financeira de repasse de riscos, sujeita a regulação estatal estrita.'
        },
        @{
          q = 'Como contratar com o poder público?'
          a = 'A regra constitucional é a contratação mediante licitação pública regular. Excepcionalmente, a lei autoriza contratações diretas por dispensa (para baixos valores) ou inexigibilidade (casos de fornecedores exclusivos ou serviços singulares de notória especialização).'
        }
      )
      demandas = @(
        'Exclusão indevida em licitações',
        'Aplicação de multas e sanções administrativas',
        'Descumprimento de contratos administrativos',
        'Defesa em processos administrativos',
        'Anulação de atos ilegais da Administração Pública',
        'Regularização de contratos com órgãos públicos'
      )
      cenarios = @(
        @{
          title = 'Servidor Respondendo a Sindicância ou PAD'
          desc = 'Servidor público estadual ou municipal que recebeu intimação para responder a processo administrativo disciplinar sob risco de demissão.'
        },
        @{
          title = 'Atraso de Pagamentos em Contratos da Prefeitura'
          desc = 'Empresa de engenharia ou serviços que executa obra pública contratada por licitação e sofre com inadimplemento ou falta de reajuste econômico pelo município.'
        },
        @{
          title = 'Inabilitação Irregular em Licitação Pública'
          desc = 'Empresa desclassificada de um certame licitatório sob justificativa puramente formalista do pregoeiro, mesmo tendo apresentado o menor preço.'
        },
        @{
          title = 'Concessionária de Rodovia Cobrando Tarifa Abusiva'
          desc = 'Empresa de logística e transporte rodoviário sofrendo prejuízos por conta de cobranças e taxas unilaterais instituídas por concessionária pública.'
        }
      )
      glossario = @(
        @{
          term = 'Licitação pública'
          definition = 'Procedimento administrativo formal e obrigatório por meio do qual o poder público seleciona a proposta mais vantajosa para suas compras, obras e contratações.'
        },
        @{
          term = 'Processo Administrativo Disciplinar (PAD)'
          definition = 'Instrumento legal por meio do qual a administração pública apura eventuais faltas funcionais cometidas por seus servidores públicos, aplicando penalidades proporcionais.'
        },
        @{
          term = 'Improbidade Administrativa'
          definition = 'Ato ilegal e desonesto praticado por agente público que importa em enriquecimento ilícito, causa prejuízo ao erário ou viola os princípios da administração pública.'
        },
        @{
          term = 'Reequilíbrio Econômico-Financeiro'
          definition = 'Direito do contratado de restabelecer a relação de custos e lucros prevista no contrato administrativo inicial quando eventos imprevisíveis encarecem excessivamente a execução.'
        },
        @{
          term = 'Contrato de Concessão'
          definition = 'Delegação contratual por meio da qual o Estado transfere a uma empresa privada a prestação de um serviço público ou a exploração de um bem público, sob sua fiscalização.'
        }
      )
    },
  @{
      id = 'direito-tributario'
      title = 'Direito Tributário'
      href = 'direito-tributario.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M5 16c0 1.66 3.13 3 7 3s7-1.34 7-3v3c0 1.66-3.13 3-7 3s-7-1.34-7-3v-3zm0-5c0 1.66 3.13 3 7 3s7-1.34 7-3v3c0 1.66-3.13 3-7 3s-7-1.34-7-3v-3zm7-9c3.87 0 7 1.34 7 3s-3.13 3-7 3-7-1.34-7-3 3.13-3 7-3zm7 11c0 1.66-3.13 3-7 3s-7-1.34-7-3v-3h14v3z"/></svg>'
      summary = 'Assessoria tributária preventiva, planejamento fiscal, recuperação de créditos e defesas em execuções fiscais.'
      comoAtuamos = 'Assessoria jurídica tributária altamente estratégica para pessoas físicas e empresas. Atuamos de forma preventiva para reduzir custos tributários de forma lícita, recuperar tributos pagos indevidamente e defender contribuintes contra cobranças abusivas e ilegais.<br><br>Nossos serviços englobam auditoria fiscal de regimes tributários (Simples Nacional, Lucro Presumido e Lucro Real), defesas em execuções fiscais judiciais e representação em contenciosos administrativos federais (CARF), estaduais e municipais.'
      foco = @(
        @{
          title = 'Planejamento Tributário'
          desc = 'Análise e reestruturação de operações societárias e fluxos de caixa visando à redução legal e ética dos impostos e encargos sobre o faturamento.'
        },
        @{
          title = 'Recuperação de Créditos'
          desc = 'Auditoria de recolhimentos para identificar tributos federais ou estaduais recolhidos a mais nos últimos 5 anos, buscando compensação ou restituição.'
        },
        @{
          title = 'Defesa em Execuções Fiscais'
          desc = 'Apresentação de embargos e exceções de pré-executividade contra cobranças de ICMS, ISS, IRPJ ou PIS/COFINS, combatendo juros e penhoras ilegais.'
        }
      )
      duvidas = @(
        @{
          q = 'Estou pagando impostos indevidamente?'
          a = 'Com a alta complexidade do sistema de tributos no Brasil, muitas empresas recolhem impostos acima da alíquota devida por interpretação errônea da legislação ou falhas de enquadramento. Um diagnóstico de compliance fiscal pode revelar essas distorções.'
        },
        @{
          q = 'Posso recuperar tributos pagos a mais?'
          a = 'Sim. O Código Tributário Nacional (CTN) garante ao contribuinte o direito de reaver os valores pagos a maior ou indevidamente nos últimos 5 anos. O resgate pode ser feito por restituição direta ou compensação administrativa simplificada.'
        },
        @{
          q = 'Como reduzir a carga tributária da empresa?'
          a = 'A redução lícita e estruturada de impostos (elisão fiscal) baseia-se na escolha correta do regime de tributação (Lucro Real vs. Presumido), na utilização de benefícios fiscais regionais, e na correta classificação de mercadorias no estoque.'
        },
        @{
          q = 'Como funciona a compensação tributária?'
          a = 'É a quitação de débitos vencidos ou vincendos com o Fisco utilizando créditos tributários homologados de pagamentos anteriores indevidos. Deve ser realizada de forma criteriosa para evitar glosas e multas da Receita Federal.'
        },
        @{
          q = 'Como me defender de uma cobrança fiscal?'
          a = 'A defesa pode ser exercida via impugnação administrativa do auto de infração ou, no meio judicial, por Embargos à Execução Fiscal, Ação Anulatória ou Mandado de Segurança, visando afastar multas abusivas ou cobranças prescritas.'
        }
      )
      demandas = @(
        'Cobranças indevidas de tributos',
        'Recuperação de créditos tributários',
        'Planejamento tributário empresarial',
        'Defesa em execuções fiscais',
        'Redução de passivos tributários',
        'Regularização fiscal de empresas'
      )
      cenarios = @(
        @{
          title = 'Auto de Infração da Receita Federal'
          desc = 'Empresa do Lucro Real autuada com aplicação de multa isolada por divergência na classificação fiscal de insumos industriais.'
        },
        @{
          title = 'Exclusão Indevida do Simples Nacional'
          desc = 'Pequena empresa que sofreu exclusão administrativa de seu regime simplificado de tributação devido a suposto débito que já estava quitado ou parcelado.'
        },
        @{
          title = 'Dupla Tributação em Operação Interestadual'
          desc = 'Empresa cearense de e-commerce que teve mercadorias retidas no posto fiscal de fronteira pela cobrança arbitrária de diferencial de alíquota de ICMS.'
        },
        @{
          title = 'Execução Fiscal com Bloqueio de Contas'
          desc = 'Sócio de empresa surpreendido com bloqueio judicial via Sisbajud em suas contas pessoais por dívidas de ICMS de uma sociedade de que participava.'
        }
      )
      glossario = @(
        @{
          term = 'Elisão Fiscal'
          definition = 'Prática legítima de planejamento tributário que visa reduzir ou postergar o recolhimento de tributos com base na correta interpretação da legislação.'
        },
        @{
          term = 'Evasão Fiscal'
          definition = 'Prática ilícita (popularmente conhecida como sonegação) para ocultar ou dissimular a ocorrência de fatos geradores de impostos, configurando crime.'
        },
        @{
          term = 'Execução Fiscal'
          definition = 'Ação judicial promovida pela Fazenda Pública para cobrar forçadamente dos contribuintes as dívidas inscritas em Certidão de Dívida Ativa (CDA).'
        },
        @{
          term = 'Simples Nacional'
          definition = 'Regime tributário simplificado e unificado direcionado a microempresas e empresas de pequeno porte, consolidando vários tributos em uma única guia de recolhimento.'
        },
        @{
          term = 'Bitributação'
          definition = 'Fenômeno inconstitucional em que dois entes públicos diferentes (como um Estado e um Município) exigem simultaneamente o recolhimento de imposto sobre o mesmo fato gerador.'
        }
      )
    },
  @{
      id = 'direito-societario-empresarial'
      title = 'Direito Societário e Empresarial'
      href = 'direito-societario-empresarial.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5s-3 1.34-3 3 1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V20h14v-3.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V20h6v-3.5c0-2.33-4.67-3.5-7-3.5z"/></svg>'
      summary = 'Constituição e reorganização societária, acordos de sócios, governança e resolução de conflitos corporativos.'
      comoAtuamos = 'Assessoria jurídica corporativa para a estruturação de sociedades, governança, proteção patrimonial e resolução de conflitos entre sócios. Nosso objetivo é viabilizar negócios seguros e mitigar passivos comerciais.<br><br>Desenvolvemos projetos personalizados de reorganização societária (fusões, cisões, incorporações), contratos de governança interna e estruturação de holdings patrimoniais familiares para facilitação de sucessões e blindagem lícita contra riscos empresariais.'
      foco = @(
        @{
          title = 'Acordos de Sócios'
          desc = 'Redação e formalização de acordos parassociais (Estatutos e Contratos Sociais) disciplinando a entrada e saída de quotistas, apuração de haveres e tomada de decisões.'
        },
        @{
          title = 'M&A (Fusões e Aquisições)'
          desc = 'Condução de auditorias jurídicas (due diligence), redação de memorandos de entendimento (MoU) e fechamento de contratos de venda ou fusão de ativos.'
        },
        @{
          title = 'Holdings e Sucessões'
          desc = 'Criação de holdings patrimoniais para otimização fiscal na locação de imóveis próprios e organização de partilhas em vida de participações societárias.'
        }
      )
      duvidas = @(
        @{
          q = 'Como evitar conflitos entre os sócios?'
          a = 'O melhor instrumento é o Acordo de Sócios (ou acionistas). Nele, determinam-se as regras de votação, critérios de avaliação da empresa (valuation), regras de compra e venda de cotas, direito de preferência e soluções em caso de empate na tomada de decisões corporativas.'
        },
        @{
          q = 'Qual a melhor estrutura para o meu negócio?'
          a = 'A definição do tipo societário (como Sociedade Limitada - LTDA ou Sociedade Anônima - S/A) deve basear-se no volume de faturamento, quantidade de sócios, necessidade de captação de investimento público e nível de responsabilidade dos fundadores sobre as dívidas.'
        },
        @{
          q = 'O que é due diligence e quando fazer?'
          a = 'É um procedimento minucioso de auditoria jurídica de passivos e ativos. Deve ser feito antes da aquisição de empresas, fusões, captações de investimento relevantes ou na reestruturação do grupo societário para revelar riscos jurídicos ocultos.'
        },
        @{
          q = 'Holding patrimonial reduz imposto sobre imóveis?'
          a = 'Sim, a tributação da locação e venda de imóveis na pessoa jurídica (holding de administração de bens) costuma ser consideravelmente menor do que na pessoa física, além de evitar burocracias com inventários futuros em caso de morte.'
        },
        @{
          q = 'Como retirar legalmente um sócio da empresa?'
          a = 'A exclusão de sócio pode ocorrer judicialmente por falta grave ou extrajudicialmente (por justa causa prevista no contrato social), garantindo-se sempre a devida notificação prévia e a apuração justa e proporcional das cotas devidas.'
        }
      )
      demandas = @(
        'Mediação de conflitos societários',
        'Elaboração de acordos de quotistas',
        'Estruturação de fusões e incorporações (M&A)',
        'Planejamento sucessório e holdings familiares',
        'Dissolução parcial ou total de sociedades',
        'Assessoria em captação de aportes (Investimento Anjo)'
      )
      cenarios = @(
        @{
          title = 'Conflito entre Sócios Fundadores de Startup'
          desc = 'Desentendimento sobre o controle operacional e diluição de cotas societárias de fundadores de empresa inovadora após recebimento de aporte de capital externo.'
        },
        @{
          title = 'Fusão de Duas Empresas Familiares Tradicionais'
          desc = 'Necessidade de auditoria prévia e modelagem de novos contratos corporativos para fusão societária de indústrias alimentícias locais.'
        },
        @{
          title = 'Dissolução Parcial de Sociedade por Falecimento'
          desc = 'Morte de sócio majoritário de comércio varejista exigindo a apuração e o pagamento dos haveres patrimoniais devidos aos herdeiros sem quebrar a empresa.'
        },
        @{
          title = 'Entrada de Investidor Anjo com Cláusulas de Preferência'
          desc = 'Aporte financeiro em empresa local estruturado via contrato de mútuo conversível contendo cláusulas especiais de blindagem.'
        }
      )
      glossario = @(
        @{
          term = 'Acordo de Sócios'
          definition = 'Contrato parassocial celebrado de maneira reservada entre os sócios para definir o direito de voto, regras de gestão, direitos de preferência e compra de cotas.'
        },
        @{
          term = 'Holding Patrimonial'
          definition = 'Sociedade comercial criada com o propósito de possuir e administrar as ações, cotas ou patrimônio imobiliário de um grupo empresarial ou familiar.'
        },
        @{
          term = 'Fusão e Aquisição (M&A)'
          definition = 'Processo de reestruturação empresarial envolvendo a união de sociedades (fusão) ou a compra do controle de uma sociedade por outra (aquisição).'
        },
        @{
          term = 'Sociedade Limitada (Ltda)'
          definition = 'Tipo societário no qual a responsabilidade de cada sócio é restrita ao valor de suas quotas sociais, embora todos respondam solidariamente pela integralização do capital.'
        },
        @{
          term = 'Cláusula de Drag-Along'
          definition = 'Disposição em acordos que confere ao sócio minoritário o direito de obrigar os sócios minoritários a venderem suas participações em conjunto caso surja uma proposta de compra.'
        }
      )
    },
  @{
      id = 'direito-civel'
      title = 'Direito Cível'
      href = 'direito-civel.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M12 2a1 1 0 0 0-1 1v2.05C8.36 5.3 6.23 7.14 5.47 9.67L3 11v2h1.07c.53 3.4 3.43 6 6.93 6.93V21H9v2h6v-2h-2v-1.07c3.5-.93 6.4-3.53 6.93-6.93H21v-2l-2.47-1.33C17.77 7.14 15.64 5.3 13 5.05V3a1 1 0 0 0-1-1m0 5a4 4 0 0 1 4 4v1H8v-1a4 4 0 0 1 4-4m-4.87 7H9v2.82c-.97-.5-1.65-1.56-1.87-2.82M15 14h1.87c-.22 1.26-.9 2.32-1.87 2.82V14z"/></svg>'
      summary = 'Responsabilidade civil, indenizações, contratos em geral, recuperação de crédito e conflitos possessórios.'
      comoAtuamos = 'Ampla assessoria na prevenção e resolução de conflitos envolvendo obrigações cíveis, direitos reais e contratos em geral. Nossa atuação visa proteger os direitos fundamentais do cliente, a segurança patrimonial e a higidez das relações negociais.<br><br>Atuamos na cobrança e renegociação de dívidas, ações indenizatórias de danos morais e materiais, elaboração de contratos personalizados de alta segurança e defesas judiciais cíveis em todas as instâncias.'
      duvidas = @(
        @{
          q = 'Qual o prazo para cobrar uma dívida na Justiça?'
          a = 'O prazo prescricional geral para a cobrança judicial de dívidas líquidas constantes de instrumentos públicos ou particulares (como contratos e promissórias) é de 5 anos, contados a partir da data de vencimento da obrigação.'
        },
        @{
          q = 'O que caracteriza dano moral indenizável?'
          a = 'O dano moral indenizável vai além do mero aborrecimento cotidiano. Exige a comprovação de ofensa grave à dignidade, à honra, à reputação ou à integridade física do indivíduo, gerando sofrimento e abalo psicológico relevante.'
        },
        @{
          q = 'Como desfazer um contrato com segurança?'
          a = 'Para rescindir um contrato sem gerar passivos, deve-se analisar a existência de cláusula de arrependimento, notificar a outra parte por escrito (notificação extrajudicial) com aviso prévio e cumprir eventuais multas estipuladas de forma proporcional.'
        },
        @{
          q = 'Posso cobrar devedores de forma extrajudicial?'
          a = 'Sim. A cobrança extrajudicial (notificações por cartório, e-mail, ligações respeitosas e reuniões de mediação) é uma alternativa rápida e econômica que evita a morosidade e os custos judiciais de um processo cível de execução.'
        }
      )
      demandas = @(
        'Ações indenizatórias por danos morais e materiais',
        'Execução judicial de contratos e títulos de crédito',
        'Elaboração e revisão de contratos civis complexos',
        'Defesas em ações cíveis e de responsabilidade civil',
        'Notificações extrajudiciais e acordos preventivos',
        'Recuperação de créditos e renegociação de dívidas'
      )
      cenarios = @(
        @{
          title = 'Cobrança de Dívida Prescrita em Cartório'
          desc = 'Devedor que teve o nome protestado ilegalmente por conta de duplicata mercantil cuja data de vencimento ocorreu há mais de 6 anos.'
        },
        @{
          title = 'Danos Morais por Inclusão Indevida no SPC'
          desc = 'Cidadão negativado nos órgãos de proteção ao crédito por conta de fatura de celular gerada fraudulentamente em seu CPF.'
        },
        @{
          title = 'Litígio de Vizinhança por Obra Irregular'
          desc = 'Proprietário de residência que sofreu rachaduras na estrutura de seu imóvel causadas por escavação imprudente realizada em lote vizinho.'
        },
        @{
          title = 'Rescisão Contratual de Serviços Sem Multa'
          desc = 'Prestador de serviços que deseja rescindir contrato de fornecimento recorrendo a cláusula de força maior por indisponibilidade de insumos.'
        }
      )
      glossario = @(
        @{
          term = 'Danos Morais'
          definition = 'Prejuízos extrapatrimoniais consistentes na violação dos direitos de personalidade da pessoa física ou jurídica, como a honra, reputação ou imagem.'
        },
        @{
          term = 'Prescrição'
          definition = 'Perda do direito de propor uma ação judicial de cobrança ou reparação em virtude do transcurso do prazo legal estabelecido em lei.'
        },
        @{
          term = 'Notificação Extrajudicial'
          definition = 'Comunicação formal realizada fora do processo judicial para constituir o devedor em mora, exigir o cumprimento de uma obrigação ou cientificar sobre rescisão.'
        },
        @{
          term = 'Cláusula Penal'
          definition = 'Disposição contratual que estabelece previamente o valor da multa a ser paga pela parte que descumprir total ou parcialmente o acordo.'
        },
        @{
          term = 'Tutela de Urgência'
          definition = 'Medida judicial provisória concedida pelo juiz logo no início do processo quando demonstrados o perigo de dano irreparável e a probabilidade do direito.'
        }
      )
    },
  @{
      id = 'direito-trabalhista'
      title = 'Direito Trabalhista'
      href = 'direito-trabalhista.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M10 2h4a2 2 0 0 1 2 2v2h4a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4V4a2 2 0 0 1 2-2m4 4V4h-4v2h4z"/></svg>'
      summary = 'Prevenção de passivos trabalhistas, reclamações trabalhistas, assédio e acidentes de trabalho.'
      comoAtuamos = 'Atuação equilibrada focada no direito individual e coletivo do trabalho. Prestamos consultoria preventiva para empresas no desenho de contratos laborais mais seguros, e patrocinamos defesas de empregadores e trabalhadores em processos de reclamação trabalhista.<br><br>Atuamos na cobrança de verbas rescisórias em atraso, pedidos de horas extras, reconhecimento de vínculo empregatício de cooperados ou prestadores de serviços terceirizados, e indenizações de assédio moral ou acidentes ocupacionais.'
      duvidas = @(
        @{
          q = 'Quais são as verbas devidas na demissão sem justa causa?'
          a = 'O trabalhador tem direito ao saldo de salário, aviso prévio indenizado ou trabalhado, décimo terceiro salário proporcional, férias profissionais e vencidas acrescidas de 1/3, saque do FGTS com multa rescisória de 40% e seguro-desemprego.'
        },
        @{
          q = 'Como comprovar assédio moral no trabalho?'
          a = 'O assédio moral exige a conduta repetitiva e humilhante do superior ou colegas. Prova-se por conversas de WhatsApp, e-mails corporativos oficiais, gravações ambientais de áudio autorizadas e o depoimento de testemunhas presenciais do fato.'
        },
        @{
          q = 'O que é rescisão indireta do contrato de trabalho?'
          a = 'É a justa causa do empregador. Ocorre quando a empresa comete falta grave (como atraso recorrente de salários, não recolhimento de FGTS, exposição do empregado a perigos sem EPI ou agressões verbais), permitindo que o trabalhador saia recebendo todas as verbas rescisórias.'
        },
        @{
          q = 'Qual o prazo para propor uma reclamação trabalhista?'
          a = 'O prazo constitucional é de até 2 anos após o término da relação empregatícia (data da baixa da carteira), podendo-se cobrar verbas dos últimos 5 anos de vigência do contrato.'
        }
      )
      demandas = @(
        'Ações trabalhistas de cobrança de horas extras e adicionais',
        'Processos de reconhecimento de vínculo de emprego',
        'Defesas empresariais e auditorias trabalhistas preventivas',
        'Indenizações por acidentes de trabalho e doenças ocupacionais',
        'Ações judiciais de rescisão indireta do contrato',
        'Cálculo e cobrança judicial de verbas rescisórias devidas'
      )
      cenarios = @(
        @{
          title = 'Reclamação por Horas Extras Não Pagas'
          desc = 'Vendedor externo com jornada controlada via aplicativo de mensagens que realizava plantões de 10 horas sem folga ou pagamento correspondente.'
        },
        @{
          title = 'Doença Ocupacional por LER/DORT'
          desc = 'Digitador de banco acometido por dores severas nos punhos por conta de digitação ininterrupta em posto de trabalho sem ergonomia adequada.'
        },
        @{
          title = 'Demissão por Justa Causa Revertida'
          desc = 'Auxiliar de limpeza demitido sob acusação infundada de desídia que busca reverter a justa causa em demissão comum e obter o FGTS correspondente.'
        },
        @{
          title = 'Assédio Moral no Ambiente de Trabalho'
          desc = 'Gerente de loja submetido a metas abusivas com exposição vexatória de sua performance e humilhações em reuniões com demais funcionários.'
        }
      )
      glossario = @(
        @{
          term = 'Vínculo Empregatício'
          definition = 'Relação jurídica de trabalho caracterizada pela habitualidade, subordinação jurídica, onerosidade (salário) e pessoalidade do trabalhador contratado.'
        },
        @{
          term = 'Verbas Rescisórias'
          definition = 'Valores devidos ao trabalhador por ocasião da extinção do contrato de trabalho, variando conforme a modalidade de dispensa.'
        },
        @{
          term = 'Rescisão Indireta'
          definition = 'Modalidade de extinção do contrato motivada por descumprimento grave das obrigações por parte do empregador, correspondendo à justa causa patronal.'
        },
        @{
          term = 'Horas In Itinere'
          definition = 'Tempo de deslocamento do trabalhador até o local de trabalho que, em situações específicas de difícil acesso sem transporte público, podia integrar a jornada.'
        },
        @{
          term = 'Equiparação Salarial'
          definition = 'Direito de obter o mesmo salário do colega de trabalho que exerce função idêntica, com a mesma produtividade e perfeição técnica, no mesmo estabelecimento.'
        }
      )
    },
  @{
      id = 'direito-consumidor'
      title = 'Direito do Consumidor'
      href = 'direito-consumidor.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M17.25 18c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3zM6.75 18c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3zM21 4H6.27l-.43-2H1v2h3.18l3.6 15.06-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H8.79c-.14 0-.25-.11-.25-.25L8.5 20h12v-2H8.5l.7-1.35h7.45c.75 0 1.41-.41 1.75-1.03L21.8 7.3c.1-.17.15-.37.15-.56 0-.55-.45-1-1-1zm-2 2H8.16L6.5 6h12.5z"/></svg>'
      summary = 'Negativação indevida, defeitos em produtos ou serviços, atrasos em voos, cobranças abusivas e planos de saúde.'
      comoAtuamos = 'Defesa dos direitos do consumidor em face de abusividades praticadas por operadoras de telefonia, instituições financeiras, companhias aéreas, e-commerces e fornecedores em geral.<br><br>Atuamos em ações de cumprimento forçado de ofertas publicitárias, cancelamento de cobranças indevidas de serviços não contratados, indenizações por atraso e cancelamento de voos, e pleitos liminares para liberação de procedimentos em planos de saúde.'
      foco = @(
        @{
          title = 'Práticas Abusivas e Cobranças'
          desc = 'Ações contra bancos por cobrança indevida, juros abusivos, venda casada e inclusão indevida nos órgãos de proteção ao crédito (SPC/Serasa).'
        },
        @{
          title = 'Direito à Saúde (Planos)'
          desc = 'Ações judiciais de urgência contra planos de saúde e SUS para liberação de tratamentos, exames, medicamentos de alto custo e cirurgias negadas.'
        },
        @{
          title = 'Turismo e Aviação'
          desc = 'Reparação por cancelamento de voos, atrasos significativos, perda de conexões e extravio de bagagens sob regras de direitos de passageiros.'
        }
      )
      duvidas = @(
        @{
          q = 'O que é venda casada?'
          a = 'Venda casada é a prática abusiva e proibida pelo Código de Defesa do Consumidor (CDC) em que o fornecedor condiciona a compra de um produto ou serviço à aquisição obrigatória de outro (ex: condicionar o financiamento bancário à contratação de seguro residencial próprio).'
        },
        @{
          q = 'Qual o prazo de arrependimento em compras online?'
          a = 'O consumidor tem o prazo de 7 dias (direito de arrependimento), contados do recebimento do produto ou contratação do serviço, para desistir de compras realizadas fora do estabelecimento físico (internet, telefone), recebendo o valor total pago corrigido.'
        },
        @{
          q = 'Como agir diante de um produto com defeito?'
          a = 'O fornecedor tem o prazo máximo de 30 dias para sanar o vício do produto. Caso não o faça, o consumidor pode exigir à sua escolha: a substituição do produto por outro igual, a restituição imediata da quantia paga ou o abatimento proporcional do preço.'
        },
        @{
          q = 'Plano de saúde pode negar procedimento indicado por médico?'
          a = 'Não. A jurisprudência consolidada estabelece que a definição do melhor tratamento clínico cabe ao médico assistente do paciente e não à operadora do plano de saúde, sendo ilegal a exclusão de cobertura sob alegação de tratamento off-label ou fora do rol da ANS.'
        }
      )
      demandas = @(
        'Ação judicial contra planos de saúde para liberação de cirurgias',
        'Processos de indenização por atraso e cancelamento de voos',
        'Defesas em cobranças abusivas e de juros consumeristas',
        'Ação cível de indenização por negativação indevida no SPC',
        'Cancelamento de contratos de compras online por atrasos na entrega',
        'Cumprimento forçado de ofertas publicitárias e promoções'
      )
      cenarios = @(
        @{
          title = 'Cobrança Abusiva em Fatura de Energia'
          desc = 'Consumidor residencial que recebeu cobrança injustificada com valor 300% acima de sua média usual de consumo após troca de medidor.'
        },
        @{
          title = 'Negativa de Cobertura por Plano de Saúde'
          desc = 'Paciente idosa com recomendação médica de cirurgia oncológica de urgência cuja operadora de plano de saúde negou cobertura alegando carência contratual.'
        },
        @{
          title = 'Compra Cancelada Sem Reembolso pelo E-commerce'
          desc = 'Consumidor que comprou computador pela internet, teve o pedido cancelado unilateralmente pela loja por falta de estoque e não recebeu estorno.'
        },
        @{
          title = 'Produto com Vício Oculto Após Garantia'
          desc = 'Adquirente de televisão inteligente que apresentou queima total da tela de LED após 13 meses de uso, restando comprovado vício oculto de fabricação da marca.'
        }
      )
      glossario = @(
        @{
          term = 'Vício Oculto'
          definition = 'Defeito de fabricação que não é aparente no momento da aquisição do produto, manifestando-se apenas durante a utilização comum ao longo do tempo.'
        },
        @{
          term = 'Inversão do Ônus da Prova'
          definition = 'Facilitação de defesa no CDC que inverte o dever de produzir provas no processo, atribuindo-o ao fornecedor devido à hipossuficiência técnica e de informações do consumidor.'
        },
        @{
          term = 'Dano Moral Consumidor'
          definition = 'Prejuízo de ordem extrapatrimonial gerado por práticas abusivas que causam perturbação emocional relevante ou desvio produtivo do consumidor (tempo desperdiçado).'
        },
        @{
          term = 'Venda Casada'
          definition = 'Prática ilegal na qual o comerciante se recusa a vender um item a menos que o consumidor também compre outro serviço associado de forma compulsória.'
        },
        @{
          term = 'Direito de Arrependimento'
          definition = 'Faculdade garantida pelo art. 49 do CDC que permite a rescisão unilateral de contrato feito fora do estabelecimento físico, com restituição integral, em até 7 dias.'
        }
      )
    },
  @{
      id = 'direito-penal'
      title = 'Direito Penal'
      href = 'direito-penal.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M19.5 2.5c-.8-.8-2-.8-2.8 0l-6.4 6.4L7.5 6c-.8-.8-2-.8-2.8 0s-.8 2 0 2.8l2.8 2.8-5 5c-.8.8-.8 2 0 2.8s2 .8 2.8 0l5-5 2.8 2.8c.8.8 2 .8 2.8 0s.8-2 0-2.8l-2.8-2.8 6.4-6.4c.8-.8.8-2 0-2.8zM22 20h-8v2h8v-2z"/></svg>'
      summary = 'Habeas corpus, defesa em inquérito policial e processos criminais, crimes tributários, contra a honra e ambientais.'
      comoAtuamos = 'Defesa criminal técnica, combativa e intransigente em prol da garantia da liberdade e dos direitos fundamentais assegurados pela Constituição. Atuamos com sigilo absoluto e rapidez em situações emergenciais.<br><br>Prestamos acompanhamento e assessoria em inquéritos policiais de crimes tributários corporativos, calúnia e difamação digital, acidentes de trânsito culposos e impetração de Habeas Corpus preventivos e liberatórios contra ilegalidades flagrantes de prisão.'
      duvidas = @(
        @{
          q = 'O que fazer em caso de prisão em flagrante?'
          a = 'O detido tem direito ao silêncio constitucional e a não produzir provas contra si. Deve contatar advogado criminalista imediatamente para acompanhamento no depoimento perante o delegado de plantão e na subsequente audiência de custódia.'
        },
        @{
          q = 'Como responder a um inquérito policial?'
          a = 'O indiciado deve constituir advogado de confiança para ter acesso integral aos autos da investigação e orientar a coleta de depoimentos e perícias favoráveis à tese defensiva de ausência de justa causa ou atipicidade da conduta.'
        },
        @{
          q = 'O que é e como funciona a audiência de custódia?'
          a = 'É o ato judicial em que a pessoa detida em flagrante é apresentada em até 24 horas perante um juiz de direito. O magistrado avalia apenas a legalidade da prisão, indícios de maus-tratos, e decide se concede liberdade provisória ou decreta a prisão preventiva.'
        },
        @{
          q = 'Como agir contra ofensas virtuais graves na internet?'
          a = 'Deve-se reunir as provas (preservar URLs, tirar prints, registrar atas notariais dos comentários) e apresentar queixa-crime criminal dentro do prazo decadencial de 6 meses para apuração dos crimes contra a honra (calúnia, injúria e difamação).'
        }
      )
      demandas = @(
        'Impetração urgente de Habeas Corpus perante os Tribunais',
        'Acompanhamento em depoimentos e oitivas em delegacias de polícia',
        'Defesa técnica robusta em ações penais e processos de júri cível',
        'Representação em inquéritos policiais por crimes tributários e sonegação',
        'Ajuizamento de queixa-crime por calúnia e difamação na internet',
        'Acompanhamento e defesa jurídica em audiências de custódia emergenciais'
      )
      cenarios = @(
        @{
          title = 'Investigação por Crime de Sonegação Fiscal'
          desc = 'Empresário intimado a prestar esclarecimentos em delegacia especializada por suposta omissão dolosa de notas fiscais de entrada.'
        },
        @{
          title = 'Prisão em Flagrante por Acidente de Trânsito'
          desc = 'Motorista detido após colisão em avenida urbana, necessitando de concessão de fiança e liberação na audiência de custódia.'
        },
        @{
          title = 'Acusação Falsa de Calúnia em Redes Sociais'
          desc = 'Empresário vítima de postagens difamatórias coordenadas por concorrente em grupos locais de Facebook.'
        },
        @{
          title = 'Prisão Preventiva Decretada Sem Fundamentação'
          desc = 'Acusado de crime econômico com ordem de prisão decretada sem fatos novos que justificassem a periculosidade ou o risco à ordem pública.'
        }
      )
      glossario = @(
        @{
          term = 'Habeas Corpus'
          definition = 'Remédio constitucional destinado a tutelar e restabelecer a liberdade de locomoção do indivíduo quando esta sofrer ameaça ou coação ilegal.'
        },
        @{
          term = 'Prisão Preventiva'
          definition = 'Modalidade de prisão cautelar decretada pelo juiz de direito durante a investigação ou processo penal para resguardar a ordem pública ou assegurar a aplicação da lei.'
        },
        @{
          term = 'Presunção de Inocência'
          definition = 'Princípio constitucional basilar de direito penal segundo o qual ninguém será considerado culpado até o trânsito em julgado de sentença penal condenatória.'
        },
        @{
          term = 'Inquérito Policial'
          definition = 'Procedimento administrative preparatório inquisitivo conduzido pela Polícia Civil ou Federal para investigar a autoria e a materialidade do fato delitivo apontado.'
        },
        @{
          term = 'Acordo de Não Persecução Penal (ANPP)'
          definition = 'Negócio jurídico celebrado entre o Ministério Público e o investigado, acompanhado por advogado, em que se ajustam penas restritivas de direitos em troca do arquivamento.'
        }
      )
    },
  @{
      id = 'direito-familia-sucessoes'
      title = 'Direito de Família e Sucessões'
      href = 'direito-familia-sucessoes.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M12 4a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm-4.5 16h3v-6h3v6h3v-9.5c0-1.38-1.12-2.5-2.5-2.5h-4c-1.38 0-2.5 1.12-2.5 2.5V20zm-2-9a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3zm-2 9h2v-6h1v6h2V14.5c0-1.1-.9-2-2-2h-1c-1.1 0-2 .9-2 2V20zm17-7.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3zm-2.5 7.5h2v-5h1v5h2v-6.5c0-1.1-.9-2-2-2h-1c-1.1 0-2 .9-2 2V20z"/></svg>'
      summary = 'Divórcio consensual e litigioso, partilha de bens, pensão alimentícia, guarda de menores, inventários e testamentos.'
      comoAtuamos = 'Atuação acolhedora, sensível e altamente técnica em demandas familiares e sucessórias. Priorizamos a mediação e a composição de acordos consensuais em prol da paz de espírito dos envolvidos, atuando contundentemente quando o litígio for indispensável.<br><br>Conduzimos processos de divórcio (consensual e judicial), ações de fixação de alimentos de filhos, regulamentação de regimes de visitação, partilha de bens patrimoniais complexos, inventários extrajudiciais rápidos e planejamento de partilha de heranças em vida.'
      duvidas = @(
        @{
          q = 'Como fazer um divórcio rápido?'
          a = 'Caso o casal esteja em consenso, não tenha filhos menores ou incapazes e a cônjuge não esteja grávida, o divórcio pode ser realizado por Escritura Pública no Cartório de Notas de forma rápida, exigindo apenas o patrocínio de advogado comum.'
        },
        @{
          q = 'Qual o valor da pensão alimentícia?'
          a = 'Não existe um percentual fixo em lei (como os mitológicos 30%). O valor é estipulado pelo juiz de direito sopesando a necessidade do alimentando (despesas básicas de sobrevivência) e a possibilidade econômico-financeira do alimentante.'
        },
        @{
          q = 'Como funciona a guarda compartilhada?'
          a = 'A guarda compartilhada determina a corresponsabilidade dos genitores em relação às decisões fundamentais da vida do menor (escola, saúde, viagens), diferindo da convivência, que pode continuar sediada em uma residência de referência.'
        },
        @{
          q = 'Inventário em cartório é viável para todos os casos?'
          a = 'Não. O inventário extrajudicial em cartório exige obrigatoriamente a maioridade e capacidade civil de todos os herdeiros, a inexistência de testamento formal válido registrado e o consenso integral quanto à divisão da herança.'
        }
      )
      demandas = @(
        'Condução de divórcios consensuais extrajudiciais e litigiosos judiciais',
        'Processos de regulamentação de guarda e regime de visitas de menores',
        'Ação cível de alimentos (pensão alimentícia e revisões de valores)',
        'Inventários judiciais e escrituração extrajudicial de partilhas',
        'Ação judicial de reconhecimento e dissolução de união estável',
        'Planejamento sucessório, testamentos e holdings patrimoniais'
      )
      cenarios = @(
        @{
          title = 'Divórcio Litigioso com Partilha de Bens e Guarda'
          desc = 'Casal em desentendimento grave sobre a guarda de duas filhas menores e a divisão de duas empresas constituídas durante o matrimônio.'
        },
        @{
          title = 'Inventário de Bens Deixados por Genitor'
          desc = 'Herdeiros disputando judicialmente a divisão de cabeças de gado e fazendas deixadas pelo falecido pai sem testamento formal.'
        },
        @{
          title = 'Ação de Alimentos e Regulamentação de Visitas'
          desc = 'Mãe pleiteando alimentos provisórios e visitas paternas regulamentadas para filho recém-nascido após rompimento do relacionamento.'
        },
        @{
          title = 'Planejamento Sucessório Familiar de Bens'
          desc = 'Empresário local buscando estruturar a doação com cláusula de usufruto de seus imóveis residenciais aos filhos em vida para evitar litígios futuros.'
        }
      )
      glossario = @(
        @{
          term = 'Inventário Extrajudicial'
          definition = 'Procedimento simplificado realizado em Cartório de Notas para partilhar os bens do falecido entre herdeiros maiores de idade e em consenso.'
        },
        @{
          term = 'Alimentos'
          definition = 'Pensão pecuniária de natureza civil devida a parentes, cônjuges ou companheiros em virtude do dever de assistência familiar para sustento e educação.'
        },
        @{
          term = 'Guarda Compartilhada'
          definition = 'Regime de guarda em que os pais detêm igual responsabilidade e tomam em conjunto todas as decisões sobre a vida do filho menor de idade.'
        },
        @{
          term = 'União Estável'
          definition = 'Convivência pública, contínua e duradoura de duas pessoas estabelecida com o objetivo de constituição de família, regida pelas regras da comunhão parcial de bens por padrão.'
        },
        @{
          term = 'Herança Jacente'
          definition = 'Patrimônio deixado por falecido cujos herdeiros legítimos não são conhecidos ou que foi recusado expressamente pelos conhecidos.'
        }
      )
    },
  @{
      id = 'direito-bancario'
      title = 'Direito Bancário'
      href = 'direito-bancario.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M11.5 1L2 6v2h19V6m-5 4v7h3v-7m-9 0v7h3v-7m-6 0v7h3v-7M2 19v2h19v-2H2z"/></svg>'
      summary = 'Revisão de contratos de financiamento, juros abusivos, defesas em busca e apreensão e fraudes bancárias.'
      comoAtuamos = 'Atuação protetiva voltada a coibir e reverter abusividades contratuais perpetradas por bancos e cooperativas de crédito. Buscamos reduzir o saldo devedor de financiamentos e defender o patrimônio do cliente contra penhoras e buscas ilegais de bens.<br><br>Atuamos na revisão judicial de juros de contratos de capital de giro e financiamentos de automóveis, embargos a execuções de cédulas de crédito bancário e reparação civil de fraudes cometidas em contas correntes (como golpes eletrônicos do Pix).'
      duvidas = @(
        @{
          q = 'O que caracteriza juros abusivos em financiamentos?'
          a = 'A abusividade configura-se quando os juros previstos no contrato de financiamento ultrapassam de forma desarrazoada a taxa média de juros de mercado divulgada oficialmente pelo Banco Central do Brasil para a mesma modalidade operacional no respectivo mês de contratação.'
        },
        @{
          q = 'Como agir contra liminar de busca e apreensão de veículo?'
          a = 'O devedor deve contatar advogado especialista em até 5 dias úteis a contar da apreensão do bem para apresentar defesa. Aponta-se nulidades na notificação prévia de mora ou cobrança oculta de taxas abusivas que descaracterizam a mora e exigem a devolução do veículo.'
        },
        @{
          q = 'O banco responde por golpes de Pix ou boletos falsos?'
          a = 'Sim. A jurisprudência sedimentada (Súmula 479 do STJ) determina que as instituições financeiras respondem objetivamente por falhas de segurança internas na abertura de contas de laranjas e no processamento de transações que permitam a ocorrência de fraudes cibernéticas.'
        },
        @{
          q = 'O que é ação revisional de contrato bancário?'
          a = 'É o processo judicial que visa reavaliar as cláusulas de empréstimo ou financiamento, pleiteando o afastamento de juros acima do mercado, da capitalização diária ilícita e de taxas de cadastro duplicadas, objetivando a redução da parcela.'
        }
      )
      demandas = @(
        'Superendividamento',
        'Revisão de Juros Abusivos em Empréstimos Consignados de Servidores Públicos Concursados (Educação, Saúde e Segurança Pública)',
        'Revisão de Juros Abusivos Realizados por Funcionários Celetistas (CLT)',
        'Dívidas Bancárias Abusivas Realizadas por Aposentados e Pensionistas',
        'Dívidas Abusivas Relacionadas a Grandes Bancos (Banco do Brasil, Bradesco, Itaú, Santander, Nubank, C6 Bank)',
        'Repactuação de Dívidas e Elaboração de Planos de Pagamento',
        'Defesa de Ação Judicial de Cobrança de Empréstimos Realizados por Empresas e Microempresários',
        'Negociação e Defesa de Contratos de PRONAMPE',
        'Juros Abusivos em Financiamentos Habitacionais e de Veículos',
        'Defesas em Ações Judiciais de Busca e Apreensão de Bens',
        'Audiências Judiciais de Acordos Bancários',
        'Ação civil indenizatória por fraudes de Pix e golpes eletrônicos'
      )
      cenarios = @(
        @{
          title = 'Ação Revisional de Financiamento de Veículo'
          desc = 'Proprietário de táxi com contrato de financiamento contendo taxa de juros de 4.8% ao mês, enquanto a média de mercado fixada pelo BACEN era de 2.1%.'
        },
        @{
          title = 'Fraude e Golpe do Pix com Desvio de Saldo'
          desc = 'Aposentado que sofreu golpe do falso motoboy, tendo sua conta invadida com transferências de Pix de alto valor sem bloqueio preventivo pelo banco.'
        },
        @{
          title = 'Negativação Indevida por Cartão Não Solicitado'
          desc = 'Cidadão com nome inserido no Serasa por conta de tarifas de anuidade de cartão de crédito que nunca solicitou ou ativou.'
        },
        @{
          title = 'Juros Abusivos em Contrato de Capital de Giro'
          desc = 'Pequena indústria com limite de conta e crédito rotativo empresariais acumulando juros sobre juros acima do razoável.'
        }
      )
      glossario = @(
        @{
          term = 'Juros Abusivos'
          definition = 'Encargos cobrados por instituições financeiras em patamar manifestamente superior à taxa média fixada pelo Banco Central do Brasil para operações idênticas.'
        },
        @{
          term = 'Ação Revisional'
          definition = 'Processo em que se pleiteia a alteração das cláusulas financeiras abusivas de contrato de mútuo bancário para reduzir obrigações excessivas.'
        },
        @{
          term = 'Tabela Price'
          definition = 'Sistema de amortização caracterizado por parcelas iguais e sucessivas, onde os juros decrescem ao longo do tempo e a amortização aumenta na composição do pagamento.'
        },
        @{
          term = 'Tarifa Bancária Abusiva'
          definition = 'Taxas cobradas por serviços não contratados, taxas de cadastro ilegais ou vendas casadas de seguros inclusas no financiamento.'
        },
        @{
          term = 'Limite do Cheque Especial'
          definition = 'Modalidade de crédito rotativo pré-aprovado de alta taxa de juros que gera endividamento em bola de neve ao incidir encargos recorrentes na conta.'
        }
      )
    },
  @{
      id = 'direito-eleitoral'
      title = 'Direito Eleitoral'
      href = 'direito-eleitoral.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M5 10c-1.1 0-2 .9-2 2v9c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2v-9c0-1.1-.9-2-2-2H5zm7 9a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm3-13.8L13.8 2H10.2L9 5.2H4v2h16v-2h-5z"/></svg>'
      summary = 'Assessoria em campanhas eleitorais, registro de candidaturas, prestação de contas, defesas em ações eleitorais de improbidade.'
      comoAtuamos = 'Assessoria jurídica especializada para candidatos, partidos políticos e coligações durante o rito da campanha eleitoral e no contencioso judicial. Atuamos de forma a garantir a elegibilidade dos candidatos e a regularidade do pleito.<br><br>Atuamos em pedidos de registro de candidaturas, defesas em impugnações de adversários, auditorias preventivas em prestação de contas partidárias, representações contra fake news ofensivas e contencioso eleitoral complexo.'
      duvidas = @(
        @{
          q = 'O que invalida o registro de candidatura?'
          a = 'O registro de candidatura é invalidado pelo descumprimento de requisitos de elegibilidade (nacionalidade, alfabetização, pleno gozo dos direitos políticos) ou pela incidência das causas de inelegibilidade listadas na Lei da Ficha Limpa.'
        },
        @{
          q = 'Qual o impacto da rejeição da prestação de contas?'
          a = 'A rejeição das contas de campanha por irregularidades graves pode ensejar a suspensão de repasses do fundo partidário, a aplicação de multas severas e a instauração de representação judicial por abuso de poder econômico, colocando o mandato sob risco.'
        },
        @{
          q = 'Como remover postagens difamatórias durante a campanha?'
          a = 'O candidato afetado por propaganda eleitoral irregular ou fake news ofensivas na internet pode ajuizar representação eleitoral de urgência requerendo a remoção imediata dos links, sem prejuízo do direito de resposta.'
        },
        @{
          q = 'Quem se enquadra na inelegibilidade da Ficha Limpa?'
          a = 'A Lei Complementar nº 135/2010 veta a candidatura daqueles condenados por órgão colegiado por crimes graves (como corrupção, lavagem de dinheiro, improbidade dolosa), por renúncia de mandato sob investigação ou por contas públicas rejeitadas.'
        }
      )
      demandas = @(
        'Processo de registro de candidaturas de prefeitos e vereadores',
        'Defesa e propositura de Ação de Impugnação de Registro de Candidatura (AIRC)',
        'Assessoria jurídica preventiva em prestação de contas partidárias',
        'Representação contra propaganda irregular antecipada ou ilícita',
        'Representações por notícias falsas e difamações eleitorais na internet',
        'Defesa em Ação de Investigação Judicial Eleitoral (AIJE) por abusos'
      )
      cenarios = @(
        @{
          title = 'Impugnação de Registro de Candidatura'
          desc = 'Candidato a vereador que teve o pedido de registro contestado por coligação adversária alegando ausência de desincompatibilização tempestiva de cargo público.'
        },
        @{
          title = 'Acusação de Abuso de Poder Político e Econômico'
          desc = 'Prefeito candidato à reeleição respondendo a representação por suposta utilização de maquinário e funcionários do município em comício.'
        },
        @{
          title = 'Defesa de Candidato Contra Fake News em Campanha'
          desc = 'Candidato à prefeitura alvo de vídeo manipulado com computação gráfica ofensiva veiculado no YouTube.'
        },
        @{
          title = 'Prestação de Contas de Campanha Rejeitada'
          desc = 'Prefeito eleito intimado a prestar esclarecimentos perante o TRE após indicação técnica de doações originadas de fontes vedadas pela lei.'
        }
      )
      glossario = @(
        @{
          term = 'Ficha Limpa'
          definition = 'Lei que proíbe a candidatura por 8 anos de políticos que tiveram o mandato cassado, renunciaram para evitar cassação ou foram condenados por decisão colegiada.'
        },
        @{
          term = 'Impugnação de Candidatura'
          definition = 'Ação por meio da qual coligações, candidatos, partidos ou o Ministério Público contestam judicialmente o registro de candidatura de concorrente elegível.'
        },
        @{
          term = 'Abuso de Poder Econômico'
          definition = 'Uso excessivo de recursos financeiros públicos ou privados em benefício de determinada candidatura, quebrando a igualdade de oportunidades.'
        },
        @{
          term = 'Propaganda Antecipada'
          definition = 'Divulgação eleitoral explícita contendo pedido de voto direto realizada antes da data oficial autorizada pelo Tribunal Superior Eleitoral (TSE).'
        },
        @{
          term = 'Direito de Resposta'
          definition = 'Garantia judicial do candidato que foi ofendido em sua honra ou imagem por propaganda eleitoral de adversário nos meios de comunicação social.'
        }
      )
    },
  @{
      id = 'direito-digital'
      title = 'Direito Digital'
      href = 'direito-digital.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M20 18c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2H4c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2H0v2h24v-2h-4zM4 6h16v10H4V6z"/></svg>'
      summary = 'Adequação à LGPD, vazamento de dados, termos de uso e políticas de privacidade, pirataria digital e crimes cibernéticos.'
      comoAtuamos = 'Consultoria e contencioso jurídico especializados no ambiente digital e na proteção de ativos virtuais. Auxiliamos empresas e profissionais na conformidade com leis da internet e na reparação de danos digitais ocorridos no ambiente virtual.<br><br>Atuamos na implementação do programa de governança em privacidade da LGPD, elaboração de termos de uso de e-commerces e softwares SaaS, recuperação judicial de perfis de redes sociais hackeados e processos de pirataria cibernética.'
      duvidas = @(
        @{
          q = 'O que é adequação à LGPD?'
          a = 'É o processo de revisão e auditoria jurídica interna de fluxos corporativos para adequação à Lei Geral de Proteção de Dados, garantindo o correto tratamento de dados de clientes, funcionários e fornecedores sob regras claras de segurança.'
        },
        @{
          q = 'Como recuperar perfil hackeado no Instagram?'
          a = 'O perfil de empresa hackeado exige notificação rápida à plataforma. Diante da inércia em devolver o controle ou se houver golpes ativos sob o perfil, ajuíza-se ação com pedido liminar determinando que a rede social deva devolver o acesso sob pena de multa diária.'
        },
        @{
          q = 'O que deve constar nos Termos de Uso?'
          a = 'Os Termos de Uso devem delimitar a responsabilidade civil do proprietário do site ou app, a propriedade intelectual dos códigos e imagens, as condições de pagamentos e assinaturas, o foro para resolução de disputas e regras de comportamento.'
        },
        @{
          q = 'Como punir o plágio de infoprodutos e cursos?'
          a = 'O autor de obra de infoproduto plagiada e vendida indevidamente por terceiros na internet deve emitir notificação de takedown para as plataformas de hospedagem e propor ação requerendo a interrupção da venda e indenização de perdas.'
        }
      )
      demandas = @(
        'Projetos corporativos de adequação de conformidade com a LGPD',
        'Redação personalizada de Termos de Uso e Política de Privacidade',
        'Ação judicial de urgência para recuperação de contas corporativas hackeadas',
        'Notificação e processos contra plágio e pirataria de cursos online',
        'Ações indenizatórias por vazamento de dados e fraudes cibernéticas',
        'Consultoria de proteção e registro de patentes e marcas digitais'
      )
      cenarios = @(
        @{
          title = 'Vazamento de Dados Pessoais de Clientes'
          desc = 'Clínica médica local que teve seu banco de dados de prontuários exposto na internet após ataque de hackers nos computadores internos.'
        },
        @{
          title = 'Perfil de Empresa Hackeado no Instagram'
          desc = 'Loja de roupas de Fortaleza que teve a página de Instagram com 50 mil seguidores invadida, com criminosos postando golpes de Pix nos Stories.'
        },
        @{
          title = 'Plágio de Curso Online de Infoprodutor'
          desc = 'Professor cearense que identificou cópia integral de suas aulas gravadas e PDFs de apoio sendo distribuídos e vendidos em canais de Telegram.'
        },
        @{
          title = 'Implementação de Programa de Governança LGPD'
          desc = 'Empresa de contabilidade local adequando seus procedimentos internos de manuseio de folhas de pagamento dos colaboradores.'
        }
      )
      glossario = @(
        @{
          term = 'LGPD'
          definition = 'Lei Geral de Proteção de Dados (Lei nº 13.709/2018), que regulamenta as atividades de tratamento de dados pessoais no Brasil, tanto no meio físico quanto digital.'
        },
        @{
          term = 'Marco Civil da Internet'
          definition = 'Lei nº 12.965/2014, considerada a constituição da internet brasileira, disciplinando direitos de privacidade, limites de responsabilidade de provedores e neutralidade de rede.'
        },
        @{
          term = 'Termos de Uso'
          definition = 'Contrato eletrônico de adesão que rege a utilização de determinado portal, e-commerce ou sistema de software por parte do usuário final.'
        },
        @{
          term = 'Engenharia Social'
          definition = 'Tática de manipulação psicológica de pessoas usada por criminosos cibernéticos para obter senhas, dados de acessos e dinheiro de forma fraudulenta.'
        },
        @{
          term = 'Criptografia'
          definition = 'Método de codificação de dados e informações legíveis de forma que apenas o emissor e o receptor consigam lê-la, garantindo segurança na internet.'
        }
      )
    },
  @{
      id = 'contratos'
      title = 'Contratos'
      href = 'contratos.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M14 2H6c-1.1 0-1.99.9-1.99 2L4 20c0 1.1.89 2 1.99 2H18c1.1 0 2-.9 2-2V8l-6-6zm2 16H8v-2h8v2zm0-4H8v-2h8v2zm-3-5V3.5L18.5 9H13z"/></svg>'
      summary = 'Elaboração e revisão de contratos civis e comerciais, acordos de confidencialidade (NDA) e resolução de disputas contratuais.'
      comoAtuamos = 'Redação minuciosa e revisão de contratos cíveis, imobiliários e comerciais personalizados para mitigação de riscos e garantia do equilíbrio econômico-financeiro dos negócios.<br><br>Desenvolvemos contratos de prestação de serviços corporativos, acordos de confidencialidade de tecnologia (NDAs), instrumentos de compra e venda de ativos e assessoria em litígios de inadimplemento contratual.'
      duvidas = @(
        @{
          q = 'Por que não usar modelos de contrato prontos da internet?'
          a = 'Modelos genéricos costumam ser desatualizados, não consideram a realidade tributária específica do negócio, trazem brechas quanto à responsabilidade civil e não possuem cláusulas precisas de rescisão de multas proporcionais.'
        },
        @{
          q = 'Qual a função de um Acordo de Confidencialidade (NDA)?'
          a = 'O NDA serve para proteger informações estratégicas de mercado, códigos de programação, segredos de processos industriais ou carteiras de clientes de vazamento por parceiros comerciais sob severas penalidades financeiras.'
        },
        @{
          q = 'Como exigir a rescisão contratual com segurança?'
          a = 'Exige-se por meio de notificação extrajudicial respeitando o aviso prévio contratual e negociando a apuração de débitos e créditos com emissão mútua de termo de distrato para evitar demandas judiciais futuras.'
        },
        @{
          q = 'O que é cláusula de arbitragem?'
          a = 'É a convenção de arbitragem no contrato determinando que eventuais conflitos oriundos daquele negócio serão dirimidos por câmaras de mediação e arbitragem privadas, acelerando a resolução.'
        }
      )
      demandas = @(
        'Elaboração personalizada de contratos de prestação de serviços',
        'Redação de Acordos de Confidencialidade (NDA) e não concorrência',
        'Revisão técnica de contratos comerciais de compra e venda',
        'Resolução de disputas por inadimplemento contratual',
        'Criação de minutas padrão e termos de distrato de parcerias',
        'Assessoria contratual em operações de franquias corporativas'
      )
      cenarios = @(
        @{
          title = 'Contrato de Prestação de Serviços de TI'
          desc = 'Software house contratada para desenvolver sistema corporativo de gestão interna cujo adquirente fez sucessivas solicitações sem aditivos de custos.'
        },
        @{
          title = 'Contrato de Franquia com Cláusulas Abusivas'
          desc = 'Franqueado de rede de cosméticos local buscando revisar a circular de oferta de franquia devido a cobranças ocultas de verba de marketing.'
        },
        @{
          title = 'Contrato de Compra de Maquinário Agrícola'
          desc = 'Fazendeiro que comprou trator industrial com atraso de 90 dias na entrega, buscando aplicar a multa por inadimplemento unilateral.'
        },
        @{
          title = 'Contrato de Parceria e Confidencialidade'
          desc = 'Agência de publicidade estruturando parceria estratégica com designer para desenvolvimento de marca confidencial de concorrente.'
        }
      )
      glossario = @(
        @{
          term = 'NDA (Non-Disclosure Agreement)'
          definition = 'Contrato legal de confidencialidade assinado entre duas partes para proibir o compartilhamento de segredos de mercado com terceiros.'
        },
        @{
          term = 'Pacta Sunt Servanda'
          definition = 'Princípio do direito civil segundo o qual os contratos valem como lei entre as partes, devendo ser integralmente cumpridos conforme pactuado.'
        },
        @{
          term = 'Cláusula de Não Concorrência'
          definition = 'Disposição limitadora que proíbe o parceiro ou ex-funcionário de atuar na mesma área de mercado do negócio por período determinado.'
        },
        @{
          term = 'Caso Fortuito e Força Maior'
          definition = 'Eventos imprevisíveis e inevitáveis (como epidemias, enchentes ou guerras) que afastam a responsabilidade pelo descumprimento de obrigações contratuais.'
        },
        @{
          term = 'Rescisão Contratual'
          definition = 'Extinção da relação contratual decorrente do inadimplemento culposo de uma das partes ou de acordo de distrato mútuo voluntário.'
        }
      )
    },
  @{
      id = 'compliance'
      title = 'Compliance'
      href = 'compliance.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M12 2L1 6v6c0 6.14 4.7 11.31 12 12 7.3-2.69 12-7.86 12-12V6L12 2m-2 15l-4-4 1.41-1.42L10 14.17l6.59-6.59L18 9l-8 8z"/></svg>'
      summary = 'Programas de integridade corporativa, canais de denúncias, códigos de conduta e auditorias internas contra fraudes.'
      comoAtuamos = 'Implementação e gestão de programas de integridade corporativa e compliance para empresas. Mitigamos passivos regulatórios e ambientais por meio do desenho de boas práticas de transparência, gestão de riscos operacionais e treinamentos éticos.<br><br>Desenvolvemos códigos de conduta personalizados, estruturamos canais internos de recepção de denúncias, realizamos investigações de fraudes internas e conduzimos background checks em parceiros comerciais estratégicos.'
      duvidas = @(
        @{
          q = 'O que é compliance e quais os benefícios?'
          a = 'Compliance significa estar em conformidade. O programa mitiga multas regulatórias e fiscais, reduz fraudes e roubos internos, protege a reputação da marca e valoriza a empresa perante investidores internacionais.'
        },
        @{
          q = 'Como funciona um Canal de Denúncias seguro?'
          a = 'Deve garantir o sigilo absoluto da identidade do denunciante, proibir qualquer tipo de retaliação e ser conduzido por comitê independente de ética que investigue os fatos de forma técnica.'
        },
        @{
          q = 'Compliance se aplica a empresas de pequeno porte?'
          a = 'Sim. Práticas simplificadas de integridade ajudam a empresa de pequeno porte a contratar com o poder público (exigido em várias licitações) e a ser selecionada como fornecedora homologada por multinacionais.'
        },
        @{
          q = 'O que é due diligence de compliance de parceiros?'
          a = 'É a análise de reputação e histórico jurídico do fornecedor ou associado antes de fechar o contrato, evitando que a empresa seja responsabilizada solidariamente por infrações éticas de terceiros.'
        }
      )
      demandas = @(
        'Implementação completa de Programas de Compliance e Integridade',
        'Redação e difusão de Código de Conduta Ética corporativo',
        'Estruturação e triagem jurídica de Canais de Denúncias Internas',
        'Auditorias e background checks corporativos (Due Diligence)',
        'Investigações corporativas internas por indícios de fraudes financeiras',
        'Treinamento de conformidade legal de colaboradores e gerências'
      )
      cenarios = @(
        @{
          title = 'Implantação de Canal de Denúncias Internas'
          desc = 'Rede de supermercados cearense estruturando canal independente para investigar relatos de assédio ocorridos em filiais.'
        },
        @{
          title = 'Auditoria para Contratar Fornecedor sob Riscos'
          desc = 'Indústria química realizando investigação reputacional detalhada de transportadora de combustíveis antes de homologar contrato.'
        },
        @{
          title = 'Investigação Interna de Desvio Financeiro'
          desc = 'Empresa de agronegócio que identificou transferências e saques suspeitos efetuados por ex-colaborador do setor de contas a pagar.'
        },
        @{
          title = 'Treinamento Anticorrupção para Colaboradores'
          desc = 'Empresa de engenharia instruindo a equipe comercial sobre as regras de relacionamento ético com servidores municipais.'
        }
      )
      glossario = @(
        @{
          term = 'Due Diligence'
          definition = 'Processo criterioso de auditoria prévia realizado sobre uma empresa ou parceiro comercial para apurar passivos jurídicos e riscos gerais.'
        },
        @{
          term = 'Código de Conduta'
          definition = 'Documento oficial que reúne as diretrizes éticas, comportamentais e operacionais que todos os colaboradores de uma empresa devem seguir.'
        },
        @{
          term = 'Canal de Denúncias'
          definition = 'Ferramenta de recepção de relatos de condutas irregulares internas, garantindo sigilo e imunidade contra retaliações ao denunciante.'
        },
        @{
          term = 'ESG'
          definition = 'Conjunto de critérios e melhores práticas voltadas para a sustentabilidade ambiental, responsabilidade social e governança ética nas corporações.'
        },
        @{
          term = 'Background Check'
          definition = 'Pesquisa sistemática de histórico criminal, fiscal, processual e reputacional de candidatos a vagas críticas ou futuros parceiros comerciais.'
        }
      )
    },
  @{
      id = 'improbidade-administrativa'
      title = 'Improbidade Administrativa'
      href = 'improbidade-administrativa.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M12 2L1 6v6c0 6.14 4.7 11.31 12 12 7.3-2.69 12-7.86 12-12V6L12 2m1 16h-2v-2h2v2m0-4h-2V8h2v6z"/></svg>'
      summary = 'Defesa de prefeitos, secretários e servidores públicos em Ações Civis Públicas por ato de improbidade administrativa.'
      comoAtuamos = 'Defesa de prefeitos, secretários e servidores públicos em Ações Civis Públicas por ato de improbidade administrativa. Focamos na demonstração de ausência de dolo e no respeito ao devido processo legal.<br><br>Conduzimos defesas em representações de órgãos de controle, auditoria de contas rejeitadas por tribunais de contas estaduais e federais, e recursos contra bloqueios de bens e perda de funções públicas decretados em liminares cíveis.'
      duvidas = @(
        @{
          q = 'Quais as penalidades para ato de improbidade administrativa?'
          a = 'As sanções do art. 12 da Lei nº 8.429/92 englobam perda de bens acrescidos ilicitamente, perda da função pública, suspensão dos direitos políticos, pagamento de multa civil severa e proibição de contratar com o poder público.'
        },
        @{
          q = 'Mera negligência ou erro culposo caracteriza improbidade?'
          a = 'Não. Com a reforma promovida pela Lei nº 14.230/2021, exige-se obrigatoriamente a comprovação da vontade livre e consciente (dolo) do agente público de cometer o ato ilícito. Erros formais culposos não configuram improbidade administrativa.'
        },
        @{
          q = 'Como funciona a indisponibilidade liminar de bens?'
          a = 'É o bloqueio de ativos decretado pelo juiz no início da ação para garantir o ressarcimento do erário. Com a nova lei, exige-se a demonstração de perigo concreto de dilapidação do patrimônio do réu para validade da medida.'
        },
        @{
          q = 'Empresas privadas podem responder por improbidade?'
          a = 'Sim, os particulares e empresas parceiras do poder público que induzam ou concorram para a prática do ato ilegal também estão sujeitos às duras penalidades da lei, inclusive multas civis.'
        }
      )
      demandas = @(
        'Defesa preliminar e contestação em Ações Civis Públicas de Improbidade',
        'Defesas de prefeitos e vereadores perante câmaras municipais de fiscalização',
        'Recursos de apelação e tribunais superiores contra suspensão de direitos',
        'Defesas em inquéritos civis instaurados pelo Ministério Público (MP)',
        'Recursos administrativos perante Tribunais de Contas Estaduais (TCE/TCM)',
        'Ações judiciais de cancelamento e redução de multas civis abusivas'
      )
      cenarios = @(
        @{
          title = 'Prefeito Acusado de Dispensa de Licitação'
          desc = 'Ex-gestor municipal acionado pelo Ministério Público por suposta contratação emergencial irregular de transporte escolar.'
        },
        @{
          title = 'Servidor Respondendo por Enriquecimento Ilícito'
          desc = 'Funcionário de autarquia intimado a justificar evolução patrimonial não condizente com vencimentos em declaração de bens.'
        },
        @{
          title = 'Defesa de Secretário contra Rejeição de Contas'
          desc = 'Secretário municipal de saúde com contas de convênio contestadas sob argumento de falta de comprovação de serviços.'
        },
        @{
          title = 'Empresa de Construção Citada em Ação Pública'
          desc = 'Empreiteira de obras públicas com bens bloqueados liminarmente em ação movida contra ex-prefeito por suposto superfaturamento.'
        }
      )
      glossario = @(
        @{
          term = 'Enriquecimento Ilícito'
          definition = 'Aferição de vantagem patrimonial indevida por parte do agente em razão do exercício de cargo, mandato, emprego ou atividade no poder público.'
        },
        @{
          term = 'Dolo'
          definition = 'Vontade livre, consciente e deliberada de praticar o ato ilícito descrito na lei de improbidade administrativa, sendo requisito obrigatório de condenação.'
        },
        @{
          term = 'Ação Civil Pública'
          definition = 'Instrumento processual judicial utilizado para proteger interesses difusos e coletivos, como a integridade do patrimônio público e da moralidade.'
        },
        @{
          term = 'Suspensão de Direitos Políticos'
          definition = 'Perda temporária do direito de votar e de ser votado decretada pelo juiz de direito em sentença condenatória definitiva de improbidade.'
        },
        @{
          term = 'Acordo de Leniência'
          definition = 'Negócio jurídico celebrado entre o poder público e a empresa envolvida em ilícitos para reduzir penalidades em troca de colaboração e ressarcimento.'
        }
      )
    },
  @{
      id = 'recuperacao-judicial'
      title = 'Recuperação Judicial'
      href = 'recuperacao-judicial.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M12 2a10 10 0 0 0-10 10 10 10 0 0 0 10 10 10 10 0 0 0 10-10A10 10 0 0 0 12 2m3 10a3 3 0 0 1-3 3 3 3 0 0 1-3-3 3 3 0 0 1 3-3 3 3 0 0 1 3 3m3 0a6 6 0 0 0-6-6V4a8 8 0 0 1 8 8h-2m-6 6a6 6 0 0 0 6-6h2a8 8 0 0 1-8 8v-2m-6-6a6 6 0 0 0 6 6v2a8 8 0 0 1-8-8h2m6-6a6 6 0 0 0-6 6H4a8 8 0 0 1 8-8v2z"/></svg>'
      summary = 'Reestruturação de empresas in crise, suspensão de execuções e leilões, negociação coletiva e elaboração de planos de recuperação.'
      comoAtuamos = 'Assessoria estratégica e jurídica integral no processo de Recuperação Judicial para empresas em crise econômica. Protegemos as operações da empresa, blindando ativos cruciais de bloqueios judiciais imediatos e negociando planos de pagamento viáveis com credores.<br><br>Redigimos a petição inicial de recuperação, pleiteamos o stay period de 180 dias de blindagem, estruturamos planos de recuperação realistas e defendemos os interesses de credores que tenham títulos inadimplidos de empresas em recuperação.'
      duvidas = @(
        @{
          q = 'O que é e quem pode pedir Recuperação Judicial?'
          a = 'É o mecanismo jurídico (Lei nº 11.101/2005) para evitar a falência. Podem requerer empresas em atividade regular há mais de 2 anos, incluindo cooperativas e produtores rurais, demonstrando viabilidade de recuperação.'
        },
        @{
          q = 'Qual a função do stay period de 180 dias?'
          a = 'O stay period é a suspensão temporária de todas as execuções, cobranças judiciais e atos de constrição (como penhoras e buscas e apreensões) contra a empresa, garantindo fôlego de caixa para operacionalizar o plano de reestruturação.'
        },
        @{
          q = 'Como aprovar o Plano de Recuperação?'
          a = 'O plano descreve prazos de carência e descontos (deságio) da dívida. Deve ser submetido à votação na Assembleia Geral de Credores, exigindo aprovação por quórum específico definido em lei por classes (trabalhista, garantia real, quirografários).'
        },
        @{
          q = 'O que acontece com os impostos na recuperação?'
          a = 'Os créditos tributários (impostos federais, estaduais e municipais) não entram no plano geral da recuperação judicial, exigindo parcelamentos específicos disciplinados em leis tributárias próprias.'
        }
      )
      demandas = @(
        'Ajuizamento do pedido e processamento de Recuperação Judicial',
        'Redação e modelagem financeira do Plano de Recuperação',
        'Blindagem judicial de ativos e suspensão de leilões (Stay Period)',
        'Representação em Assembleias Gerais de Credores (AGC)',
        'Impugnações e habilitações judiciais de créditos na lista do administrador',
        'Defesa de interesses de credores quirografários e garantia real'
      )
      cenarios = @(
        @{
          title = 'Indústria de Alimentos Pedindo Recuperação Judicial'
          desc = 'Fábrica com endividamento bancário acumulado de R$ 15 milhões solicitando processamento de reestruturação para manter folha em dia.'
        },
        @{
          title = 'Negociação com Credores em Assembleia Geral'
          desc = 'Comércio varejista conduzindo votação do plano de desconto de 60% com carência de 24 meses perante credores.'
        },
        @{
          title = 'Credor com Título Não Listado na Recuperação'
          desc = 'Fornecedor de matéria-prima que identificou exclusão de sua duplicata na lista oficial e busca habilitação judicial urgente.'
        },
        @{
          title = 'Blindagem de Execuções Individuais por 180 Dias'
          desc = 'Empresa de transportes sob risco de ter sua frota de caminhões apreendida por execuções que obteve tutela protetiva.'
        }
      )
      glossario = @(
        @{
          term = 'Recuperação Judicial'
          definition = 'Processo judicial regulamentado que concede prazo e condições especiais de renegociação para empresas viáveis superarem crises conjunturais.'
        },
        @{
          term = 'Administrador Judicial'
          definition = 'Profissional de confiança nomeado pelo juiz para fiscalizar a atividade da empresa devedora e intermediar a relação com os credores.'
        },
        @{
          term = 'Assembleia de Credores'
          definition = 'Órgão que reúne todos os detentores de créditos contra a empresa em recuperação para votar o plano ou deliberar sobre assuntos de interesse coletivo.'
        },
        @{
          term = 'Plano de Recuperação'
          definition = 'Proposta elaborada pela empresa detalhando a reorganização de operações e as formas de quitação e refinanciamento do passivo devedor.'
        },
        @{
          term = 'Stay Period'
          definition = 'Prazo de suspensão temporária e obrigatória de ações judiciais de cobrança e apreensões contra o devedor autorizado pelo processamento da recuperação.'
        }
      )
    },
  @{
      id = 'direito-previdenciario'
      title = 'Direito Previdenciário'
      href = 'direito-previdenciario.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M12 2a9 9 0 0 1 9 9h-8v8a3 3 0 0 1-3 3 3 3 0 0 1-3-3h2a1 1 0 0 0 1 1 1 1 0 0 0 1-1v-8H3a9 9 0 0 1 9-9z"/></svg>'
      summary = 'Planejamento previdenciário, aposentadorias (tempo, idade, especial), auxílio-doença, BPC/LOAS e revisões de benefícios.'
      comoAtuamos = 'Orientação e condução de processos administrativos e judiciais contra o INSS para a concessão de aposentadorias e benefícios sociais de forma justa. Nosso objetivo é garantir o melhor benefício financeiro possível para o segurado.<br><br>Realizamos planejamento previdenciário minucioso (análise do CNIS), patrocínio em indeferimentos administrativos de aposentadoria especial, revisões de aposentadorias existentes e ações para concessão de BPC/LOAS para idosos.'
      duvidas = @(
        @{
          q = 'O que mudou com a Reforma da Previdência?'
          a = 'A Emenda Constitucional nº 103/2019 instituiu idade mínima geral de aposentadoria (65 anos homens, 62 anos mulheres), novas regras de transição de pedágio de 50% e 100%, e alterou a fórmula do cálculo do benefício médio.'
        },
        @{
          q = 'O que é aposentadoria especial e quem tem direito?'
          a = 'É o benefício concedido àqueles segurados expostos a agentes nocivos químicos, físicos ou biológicos acima dos limites tolerados (como metalúrgicos, médicos, eletricistas), reduzindo o tempo de contribuição exigido.'
        },
        @{
          q = 'Como reverter auxílio-doença negado na perícia?'
          a = 'O segurado com benefício indeferido deve reunir laudos médicos, exames de imagem recentes de especialista e receituários de uso contínuo, ajuizando ação de concessão de auxílio por incapacidade com perícia judicial.'
        },
        @{
          q = 'Quem tem direito ao benefício BPC/LOAS?'
          a = 'Idosos acima de 65 anos ou portadores de deficiência grave de qualquer idade que comprovem miserabilidade da família (renda mensal per capita do grupo familiar inferior a 1/4 do salário mínimo).'
        }
      )
      demandas = @(
        'Realização de Planejamento Previdenciário detalhado (simulações)',
        'Aposentadoria por tempo de contribuição (regras de transição)',
        'Aposentadoria especial por exposição a ruído e insalubridade',
        'Processo judicial de concessão de auxílio-doença e aposentadoria por invalidez',
        'Ação cível para concessão de BPC / LOAS de idosos e deficientes',
        'Ação judicial de Revisão da Vida Toda de aposentados antigos'
      )
      cenarios = @(
        @{
          title = 'Pedido de Aposentadoria Especial de Metalúrgico'
          desc = 'Operador de caldeira industrial exposto a calor extremo e ruído intermitente de 92 dB cuja aposentadoria foi negada sob pretexto de falta de perfil profissiográfico.'
        },
        @{
          title = 'Auxílio-Doença Negado pelo INSS Após Perícia'
          desc = 'Trabalhadora de fábrica operada de hérnia de disco lombar declarada apta a retornar ao trabalho pelo perito do INSS mesmo sem conseguir andar.'
        },
        @{
          title = 'Revisão da Vida Toda para Beneficiário'
          desc = 'Aposentado desde 2018 buscando incluir na média salarial do benefício todas as contribuições efetuadas antes de julho de 1994.'
        },
        @{
          title = 'BPC/LOAS Negado para Idoso em Extrema Pobreza'
          desc = 'Idoso de 68 anos residindo em casa emprestada e sustentado por ajuda de vizinhos que teve o benefício negado por problemas de documentação.'
        }
      )
      glossario = @(
        @{
          term = 'Carência INSS'
          definition = 'Número mínimo de contribuições mensais indispensáveis para que o segurado faça jus a determinado benefício previdenciário.'
        },
        @{
          term = 'Aposentadoria Especial'
          definition = 'Benefício concedido aos segurados expostos de forma habitual a agentes nocivos que prejudicam a saúde ou integridade física.'
        },
        @{
          term = 'Perícia Médica'
          definition = 'Exame clínico presencial obrigatório realizado por perito para constatação técnica da existência ou não de incapacidade laboral.'
        },
        @{
          term = 'BPC / LOAS'
          definition = 'Benefício de Prestação Continuada da Lei Orgânica da Assistência Social, garantindo salário mínimo sem exigência de contribuição ao INSS.'
        },
        @{
          term = 'Fator Previdenciário'
          definition = 'Fórmula matemática que reduzia o valor das aposentadorias de quem se aposentava jovem, baseando-se no tempo de contribuição, idade e expectativa de vida.'
        }
      )
    },
  @{
      id = 'direito-imobiliario'
      title = 'Direito Imobiliário'
      href = 'direito-imobiliario.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/></svg>'
      summary = 'Regularização de imóveis, usucapião, distrato de imóvel na planta, assessoria em compras e vendas e despejos.'
      comoAtuamos = 'Assessoria jurídica especializada em transações de aquisição, regularização e defesa da posse de imóveis urbanos e rurais. Protegemos investidores contra passivos ocultos e atuamos firmemente na defesa possessória cível.<br><br>Atuamos na esfera consultiva e preventiva (due diligence, contratos de promessa de compra e venda) e na esfera contenciosa (ações de despejo, reintegração de posse e usucapião).'
      duvidas = @(
        @{
          q = 'O que é usucapião e quais as formas?'
          a = 'É a aquisição de propriedade imóvel decorrente da posse mansa, pacífica e ininterrupta por determinado tempo. As formas comuns são a Extraordinária (15 anos), Ordinária (10 anos com justo título) e Constitucional Urbana (5 anos).'
        },
        @{
          q = 'O que é due diligence imobiliária?'
          a = 'Trata-se de uma auditoria de riscos jurídicos realizada antes da aquisição de imóveis, analisando certidões negativas do bem, dos proprietários e eventuais riscos de penhora oculta.'
        },
        @{
          q = 'Como desfazer a compra de um imóvel na planta?'
          a = 'A desistência (distrato imobiliário) é permitida, devendo o comprador receber a patrimônio de afetação em caso de incorporação sob regras da Lei do Distrato.'
        },
        @{
          q = 'Como recuperar a posse de imóvel invadido?'
          a = 'O proprietário ou possuidor legítimo prejudicado pode propor ação cível de reintegração de posse com pedido de liminar (tutela de urgência) para desocupação rápida, demonstrando a posse anterior e a ocorrência do esbulho.'
        }
      )
      demandas = @(
        'Ação de usucapião judicial e encaminhamento extrajudicial em cartório',
        'Processos de reintegração de posse e imissão na posse',
        'Ação de despejo por atraso de aluguel e rescisão locatícia',
        'Auditoria jurídica e due diligence em transações imobiliárias',
        'Assessoria jurídica cível em convenções de condomínio e cobranças',
        'Elaboração de contratos de promessa de compra e venda e permuta'
      )
      cenarios = @(
        @{
          title = 'Usucapião Extrajudicial de Terreno Urbano'
          desc = 'Família que reside em loteamento há 12 anos sem oposição e busca registrar a escritura formal diretamente no Cartório de Registro de Imóveis.'
        },
        @{
          title = 'Atraso de Entrega de Apartamento com Pedido de Danos Morais'
          desc = 'Comprador de imóvel na planta cuja construtora extrapolou o prazo de tolerância de 180 dias e se recusa a pagar multa de atraso.'
        },
        @{
          title = 'Contrato de Locação Comercial com Renovatória'
          desc = 'Supermercado em ponto comercial tradicional que precisa ajuizar ação renovatória de locação para assegurar a permanência do negócio por mais 5 anos.'
        },
        @{
          title = 'Ação de Despejo por Falta de Pagamento'
          desc = 'Proprietário de imóvel residencial com inquilino inadimplente há 3 meses que se recusa a desocupar o bem amigavelmente.'
        }
      )
      glossario = @(
        @{
          term = 'Adjudicação Compulsória'
          definition = 'Ação judicial que supre a recusa do vendedor em outorgar a escritura definitiva de compra de imóvel quitado, transferindo o registro ao comprador.'
        },
        @{
          term = 'Patrimônio de Afetação'
          definition = 'Segregação patrimonial que mantém as receitas e o terreno da obra isolados das contas gerais da construtora, protegendo a obra contra falências cíveis.'
        },
        @{
          term = 'Usucapião'
          definition = 'Forma originária de aquisição da propriedade pelo exercício da posse prolongada e qualificada pelo decurso de prazo legal.'
        },
        @{
          term = 'Registro de Imóveis'
          definition = 'Cartório público responsável pelo histórico jurídico de propriedade do bem, mantendo a matrícula imobiliária atualizada.'
        },
        @{
          term = 'Distrato Imobiliário'
          definition = 'Rescisão do contrato de compra de imóvel por comum acordo ou culpa de uma das partes, disciplinando a retenção legal de valores pagos.'
        }
      )
    },
  @{
      id = 'direito-notarial-registral'
      title = 'Direito Notarial e Registral'
      href = 'direito-notarial-registral.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M14 2H6c-1.1 0-1.99.9-1.99 2L4 20c0 1.1.89 2 1.99 2H18c1.1 0 2-.9 2-2V8l-6-6zm2 16H8v-2h8v2zm0-4H8v-2h8v2zm-3-5V3.5L18.5 9H13z"/></svg>'
      summary = 'Retificação de registros públicos, procedimentos em cartórios de notas e de imóveis, e regularização documental.'
      comoAtuamos = 'Regularização de certidões, retificação de nomes jurídicos, procedimentos perante cartórios de notas, protestos, registro civil de pessoas e registro imobiliário.<br><br>Atuamos na retificação extrajudicial e judicial de certidões civis, procedimentos de suscitação de dúvidas registrais contra exigências excessivas de oficiais de cartórios, assessoria em escrituras públicas e atas notariais.'
      duvidas = @(
        @{
          q = 'Como corrigir erro em registro de nascimento ou casamento?'
          a = 'Erros evidentes de digitação ou grafia de nomes podem ser retificados diretamente no cartório de registro civil. Erros complexos que dependam de provas exigem ação cível de retificação de registro.'
        },
        @{
          q = 'O que é suscitação de dúvida registral?'
          a = 'Procedimento administrativo que ocorre quando o Oficial do Cartório de Imóveis faz exigências documentais com as quais o cidadão discorda, sendo o caso enviado ao juiz corregedor para decisão definitiva.'
        },
        @{
          q = 'Qual a diferença entre escritura e registro de imóveis?'
          a = 'A escritura pública é o contrato feito no Cartório de Notas que atesta a vontade do negócio. O Registro é o ato oficial feito no Cartório de Imóveis que transfere de fato a propriedade do bem.'
        },
        @{
          q = 'O que é uma ata notarial e para que serve?'
          a = 'Instrumento público pelo qual o tabelião constata e registra fatos (como conversas de WhatsApp, e-mails ou invasão de terrenos) para servir como prova de alta força jurídica em processos.'
        }
      )
      demandas = @(
        'Ação cível de retificação de registro civil (nome, sobrenome e erros)',
        'Assessoria e condução em procedimentos de suscitação de dúvida registral',
        'Assessoria em escrituras públicas de união estável, divórcios e testamentos',
        'Regularização de averbações de construções e demolições nas matrículas',
        'Procedimentos extrajudiciais de inventário, divórcio e usucapião',
        'Assessoria jurídica em cartórios de protestos e cancelamento de títulos'
      )
      cenarios = @(
        @{
          title = 'Retificação de Sobrenome para Cidadania Italiana'
          desc = 'Descendente de italianos com divergências na grafia do sobrenome nas certidões de nascimento dos ascendentes que travam o processo consular.'
        },
        @{
          title = 'Impasse de Registro de Escritura por Divergência de Área'
          desc = 'Comprador de fazenda que teve o registro da escritura negado pelo oficial porque a medição na matrícula difere da medição física atual do terreno.'
        },
        @{
          title = 'Suscitação de Dúvida contra Exigência de Oficial'
          desc = 'Empresa que comprou lote urbano comercial e recebeu exigência de certidão inviável para efetuar o registro da escritura pública.'
        },
        @{
          title = 'Ata Notarial para Prova de Ofensa no Facebook'
          desc = 'Cidadão que busca registrar e certificar a existência de comentários caluniosos sofridos em página local de rede social para fundamentar ação cível.'
        }
      )
      glossario = @(
        @{
          term = 'Ata Notarial'
          definition = 'Documento oficial lavrado em Cartório de Notas pelo tabelião que confere fé pública à existência de fatos digitais ou presenciais.'
        },
        @{
          term = 'Matrícula do Imóvel'
          definition = 'Documento exclusivo mantido no Cartório de Registro de Imóveis que funciona como a certidão de nascimento do bem, contendo todo o seu histórico cível.'
        },
        @{
          term = 'Escritura Pública'
          definition = 'Ato notarial que reflete a declaração de vontade de partes contratantes lavrada perante tabelião, servindo de base para transferência de posse.'
        },
        @{
          term = 'Suscitação de Dúvida'
          definition = 'Procedimento administrativo submetido ao juiz corregedor para resolver discordância entre o apresentante do título e o oficial registrador sobre exigência cartorária.'
        },
        @{
          term = 'Averbação'
          definition = 'Ato que anota modificações ou fatos novos à margem da matrícula imobiliária ou registro civil já existentes (como averbação de casamento ou demolição).'
        }
      )
    },
  @{
      id = 'direito-canabico'
      title = 'Direito Canábico'
      href = 'direito-canabico.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M17 2h-3c-5.5 0-10 4.5-10 10 0 5.5 4.5 10 10 10 5.5 0 10-4.5 10-10 0 0 0-10-7-10m0 10c-1.1 0-2-.9-2-2 0-1.1.9-2 2-2 1.1 0 2 .9 2 2 0 1.1-.9 2-2 2z"/></svg>'
      summary = 'Habeas corpus para cultivo doméstico de Cannabis medicinal e assessoria regulatória para importação de medicamentos.'
      comoAtuamos = 'Ações judiciais para salvo-conduto de cultivo de cannabis medicinal e consultoria jurídica regulatória sob as normas sanitárias vigentes (Anvisa).<br><br>Atuamos na impetração de Habeas Corpus preventivos para salvo-conduto de autocultivo para extração do óleo medicinal, ações civis de fornecimento de extrato contra SUS e planos de saúde e assessoria a associações.'
      duvidas = @(
        @{
          q = 'Como conseguir autorização judicial para cultivar Cannabis?'
          a = 'A autorização é obtida por meio de Habeas Corpus cível-criminal, demonstrando a necessidade terapêutica (receita médica), eficácia do extrato, autorização da Anvisa para importação e prescrição detalhada.'
        },
        @{
          q = 'O cultivo de Cannabis medicinal sem autorização é crime?'
          a = 'Sim. O cultivo sem prévia autorização judicial de salvo-conduto pode ser enquadrado na Lei de Drogas (tráfico ou cultivo ilícito para consumo), sujeitando o indivíduo a processos criminais e prisão.'
        },
        @{
          q = 'Como obter remédios à base de canabidiol pelo SUS?'
          a = 'O fornecimento pelo SUS ou pelo plano de saúde é pleiteado por ação judicial em caso de recusa administrativa, comprovando a eficácia clínica, a incapacidade financeira do paciente e a falta de alternativas.'
        },
        @{
          q = 'Quais são as exigências da Anvisa para importar CBD?'
          a = 'Exige-se a realização de cadastro no portal do Governo Federal, apresentação de prescrição médica atualizada por profissional habilitado, especificando marca e quantidade do medicamento.'
        }
      )
      demandas = @(
        'Impetração de Habeas Corpus para cultivo doméstico (salvo-conduto)',
        'Ação judicial contra SUS e planos de saúde para fornecimento de CBD',
        'Assessoria regulatória administrativa para autorização de importação na Anvisa',
        'Consultoria jurídica a associações de pacientes de Cannabis medicinal',
        'Assessoria jurídica para médicos na prescrição segura de fitocanabinoides',
        'Defesa jurídica criminal em acusações de cultivo indevido não recreativo'
      )
      cenarios = @(
        @{
          title = 'Salvo-Conduto para Cultivo Doméstico (Criança com Epilepsia)'
          desc = 'Família cujo filho tem epilepsia refratária grave e precisa de óleo de CBD de alto custo para controle de crises convulsivas diárias.'
        },
        @{
          title = 'Pedido de Fornecimento de Óleo pelo Estado (SUS)'
          desc = 'Paciente de esclerose múltipla com recomendação médica de canabidiol sem recursos financeiros para custear a importação do frasco.'
        },
        @{
          title = 'Habeas Corpus Preventivo para Cultivo de Adulto'
          desc = 'Paciente acometido por dores crônicas severas e ansiedade refratária com prescrição de extrato que deseja cultivar plantas em casa sem risco de prisão.'
        },
        @{
          title = 'Regulamentação de Associação de Pacientes'
          desc = 'Grupo de pacientes de Cannabis medicinal organizando associação local para distribuição coletiva e extração sob supervisão técnica.'
        }
      )
      glossario = @(
        @{
          term = 'Salvo-Conduto Judicial'
          definition = 'Ordem emitida por juiz em Habeas Corpus preventivo que proíbe as forças policiais de prenderem ou apreenderem o paciente que cultiva Cannabis sob fins estritamente médicos.'
        },
        @{
          term = 'Canabidiol (CBD)'
          definition = 'Substância química não psicoativa encontrada na planta da Cannabis sativa que possui amplo potencial de tratamento neuropsiquiátrico reconhecido cientificamente.'
        },
        @{
          term = 'Tetraidrocanabinol (THC)'
          definition = 'Composto químico psicoativo da Cannabis que, em doses terapêuticas combinadas específicas, é fundamental para o alívio de dor crônica e espasticidade.'
        },
        @{
          term = 'Habeas Corpus Canábico'
          definition = 'Ação judicial impetrada para resguardar a liberdade física e o direito de saúde do paciente que cultiva Cannabis para fins exclusivos de tratamento médico.'
        },
        @{
          term = 'Associação de Pacientes'
          definition = 'Entidade associativa civil sem fins lucrativos que reúne pessoas que fazem uso de fitoterápicos de Cannabis para viabilizar cultivo coletivo e suporte mútuo.'
        }
      )
    },
  @{
      id = 'direito-jogos-apostas'
      title = 'Direito dos Jogos e Apostas'
      href = 'direito-jogos-apostas.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-7 14h-2v-2h2v2zm0-4h-2v-2h2v2zm0-4h-2V7h2v2zm5 8h-2v-2h2v2zm0-4h-2v-2h2v2zm0-4h-2V7h2v2z"/></svg>'
      summary = 'Assessoria jurídica para plataformas de apostas (bets), adequação regulatória e conformidade com a legislação federal.'
      comoAtuamos = 'Consultoria regulatória para operadoras de apostas, adequação à lei federal de apostas de quota fixa, gestão de licenciamento no Ministério da Fazenda e contencioso cível.<br><br>Atuamos no processo de obtenção de outorga federal de apostas, adequação de termos de uso dos sites à legislação de jogo responsável e defesas no contencioso cível-consumidor (liberação de saques).'
      duvidas = @(
        @{
          q = 'Como obter licença de operação para Bets no Brasil?'
          a = 'A licença exige o protocolo de requerimento no Ministério da Fazenda, comprovação de capacidade técnica, financeira, reputação ilibada dos acionistas, sede no Brasil e pagamento da taxa de outorga regulatória.'
        },
        @{
          q = 'Quais as principais obrigações tributárias das Bets?'
          a = 'As bets estão sujeitas a tributação específica sobre o GGR (Gross Gaming Revenue), contribuição para segurança social, taxas de fiscalização da Fazenda e retenção de imposto de renda sobre prêmios dos apostadores.'
        },
        @{
          q = 'Como funciona a política de Jogo Responsável?'
          a = 'Trata-se de uma série de medidas preventivas obrigatórias para coibir o vício (ludopatia), limitando depósitos, permitindo a autoexclusão de apostadores e proibindo a participação de menores de 18 anos.'
        },
        @{
          q = 'É permitido fazer propaganda de apostas na internet?'
          a = 'A publicidade é permitida, contudo deve seguir regras rígidas, abstendo-se de associar jogos a sucesso financeiro, de veicular conteúdo direcionado a menores ou usar mensagens enganosas de ganho garantido.'
        }
      )
      demandas = @(
        'Consultoria regulatória para adequação à Lei de Apostas (Quota Fixa)',
        'Assessoria no processo de licenciamento e outorga federal de Bets',
        'Redação e conformidade de termos de uso de sites e plataformas de jogos',
        'Assessoria em tributação tributária específica de GGR corporativo',
        'Estruturação de políticas internas de jogo responsável e KYC',
        'Contencioso cível-consumidor de plataformas e liberação de saques'
      )
      cenarios = @(
        @{
          title = 'Adequação de Plataforma Estrangeira à Lei das Bets'
          desc = 'Operadora de apostas com sede em Curaçao que deseja abrir filial societária no Brasil e obter licença nacional do Ministério da Fazenda.'
        },
        @{
          title = 'Impasse de Saque Bloqueado por Suspeita de Fraude'
          desc = 'Plataforma de jogos que identificou padrões de apostas automatizadas em um perfil de usuário e necessita de assessoria para conduzir o bloqueio lícito da conta.'
        },
        @{
          title = 'Redação de Termos de Uso e Jogo Responsável'
          desc = 'Plataforma nacional de apostas esportivas necessitando desenhar sua política interna obrigatória de proteção ao apostador (ludopatia).'
        },
        @{
          title = 'Defesa de Operadora em Processo Administrativo'
          desc = 'Plataforma de apostas esportivas notificada por suposta publicidade indevida direcionada a público infanto-juvenil.'
        }
      )
      glossario = @(
        @{
          term = 'KYC (Know Your Customer)'
          definition = 'Políticas internas de verificação de identidade dos clientes usadas pelas bets para evitar a lavagem de dinheiro, fraudes de cartões e uso de contas por laranjas.'
        },
        @{
          term = 'Gross Gaming Revenue (GGR)'
          definition = 'Receita bruta da operadora de jogos calculada pela diferença entre o total de apostas arrecadadas e a soma dos prêmios pagos aos jogadores.'
        },
        @{
          term = 'Jogo Responsável'
          definition = 'Regras e ferramentas adotadas pelas operadoras para mitigar danos sociais dos jogos, como limite de tempo de jogo e autoexclusão de usuários viciados.'
        },
        @{
          term = 'Outorga Regulatória'
          definition = 'Licença oficial concedida pelo Ministério da Fazenda que autoriza e valida a exploração de jogos de apostas em território nacional.'
        },
        @{
          term = 'Ludopatia'
          definition = 'Compulsa ou transtorno psiquiátrico de vício compulsivo em jogos de azar e apostas, exigindo proteção ativa dos portais de jogos.'
        }
      )
    },
  @{
      id = 'direito-desportivo'
      title = 'Direito Desportivo'
      href = 'direito-desportivo.html'
      icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" fill="currentColor"><path d="M18 2H6v3c0 2.76 2.24 5 5 5v4H9v2h6v-2h-2v-4c2.76 0 5-2.24 5-5V2zm-2 3H8V4h8v1z"/></svg>'
      summary = 'Contratos especiais de trabalho esportivo, transferências de atletas e representação na Justiça Desportiva.'
      comoAtuamos = 'Atuação em contratos esportivos, negociação de atletas, litígios desportivos, assessoria para clubes, federações e profissionais do esporte.<br><br>Atuamos na redação de contratos especiais de trabalho desportivo (lei geral do esporte), transferências nacionais e internacionais de atletas e defesas disciplinares perante STJD.'
      duvidas = @(
        @{
          q = 'Como elaborar contratos de atletas?'
          a = 'Os contratos devem ser redigidos em conformidade com as leis desportivas específicas (Lei Pelé e Lei Geral do Esporte), regulamentando direitos de imagem, cláusulas indenizatórias e prazos contratuais de forma clara.'
        },
        @{
          q = 'Como resolver conflitos esportivos?'
          a = 'Conflitos podem ser resolvidos por meio de instâncias da Justiça Desportiva (como o STJD) ou câmaras arbitrais de federações nacionais e internacionais especializadas no setor desportivo.'
        },
        @{
          q = 'Quais são os direitos de clubes e atletas?'
          a = 'Atletas possuem direitos trabalhistas específicos de sua categoria profissional. Clubes possuem direitos de formação e preferência na primeira contratação, além de participação na receita de transferências.'
        }
      )
      demandas = @(
        'Elaboração e negociação de contratos especiais de trabalho desportivo',
        'Defesa e acompanhamento em litígios perante tribunais desportivos',
        'Assessoria jurídica na gestão de carreira e contratos de imagem de atletas',
        'Consultoria regulatória para clubes, ligas e federações esportivas'
      )
      cenarios = @(
        @{
          title = 'Transferência de Jogador de Futebol com Direitos Cedidos'
          desc = 'Atleta de futebol profissional negociado entre clubes da série B nacional, necessitando de elaboração segura de cessão de direitos federativos e econômicos.'
        },
        @{
          title = 'Julgamento de Atleta em Tribunal de Doping (Justiça Desportiva)'
          desc = 'Atleta de vôlei com teste positivo para substância proibida presente em suplemento contaminado, necessitando de tese defensiva urgente perante o STJD.'
        },
        @{
          title = 'Cláusula de Rescisão de Contrato de Treinador'
          desc = 'Clube de futebol buscando afastar multa de rescisão de técnico desportivo alegando falta de performance e indisciplina.'
        },
        @{
          title = 'Disputa de Direito de Imagem de Patrocinador'
          desc = 'Atleta olímpico com conflito de patrocínio individual em choque com a marca oficial da federação desportiva.'
        }
      )
      glossario = @(
        @{
          term = 'Cláusula Indenizatória Desportiva'
          definition = 'Valor pactuado no contrato especial de trabalho do atleta devido ao clube formador ou contratante em caso de transferência nacional ou internacional antes do fim do prazo.'
        },
        @{
          term = 'SAF (Sociedade Anônima do Futebol)'
          definition = 'Estrutura societária específica autorizada por lei que permite a clubes de futebol migrar seu modelo de associação civil sem fins lucrativos para o formato de empresa mercantil.'
        },
        @{
          term = 'STJD'
          definition = 'Superior Tribunal de Justiça Desportiva, órgão autônomo responsável por julgar infrações disciplinares e disputas ocorridas em competições esportivas.'
        },
        @{
          term = 'Direito de Arena'
          definition = 'Direito de imagem coletivo dos atletas que garante percentual de repasse decorrente da comercialização de transmissão televisiva dos jogos.'
        },
        @{
          term = 'Contrato de Imagem'
          definition = 'Contrato de natureza civil firmado entre o atleta e a empresa ou clube para cessão do uso de voz, nome e imagem para campanhas publicitárias.'
        }
      )
    }
)

# Reordenação e renomeação de Direito Penal para Direito Criminal
$desiredOrderIds = @(
  'direito-bancario',
  'direito-consumidor',
  'direito-penal',
  'direito-familia-sucessoes',
  'direito-administrativo',
  'direito-tributario',
  'direito-societario-empresarial',
  'direito-civel',
  'direito-trabalhista',
  'direito-eleitoral',
  'direito-digital',
  'contratos',
  'compliance',
  'improbidade-administrativa',
  'recuperacao-judicial',
  'direito-previdenciario',
  'direito-imobiliario',
  'direito-notarial-registral',
  'direito-canabico',
  'direito-jogos-apostas',
  'direito-desportivo'
)

foreach ($a in $areas) {
  if ($a.id -eq 'direito-penal') {
    $a.title = 'Direito Criminal'
  }
}

$reorderedAreas = @()
foreach ($id in $desiredOrderIds) {
  foreach ($a in $areas) {
    if ($a.id -eq $id) {
      $reorderedAreas += $a
      break
    }
  }
}
$areas = $reorderedAreas

# 3. Definição do Banco de Dados de Páginas e Metadados
$pages = @(
  @{ filename = "index.html"; layout = "home"; title = "Advocacia Estratégica no Ceará | Rodrigo Parente Advogados"; metaDescription = "Escritório de advocacia com atuação consultiva, administrativa e judicial em Fortaleza e Sobral/CE. Mais de 20 anos de experiência jurídica de excelência."; h1 = "Advocacia Estratégica e Assessoria Jurídica Especializada no Ceará"; breadcrumbs = @() },
  @{ filename = "o-escritorio.html"; layout = "about"; title = "Sobre o Escritório | Rodrigo Parente Advogados Especializados"; metaDescription = "Conheça a história de mais de 20 anos de excelência, nossa missão, visão, valores e diferenciais no atendimento jurídico estratégico no Ceará."; h1 = "Conheça o Escritório Rodrigo Parente Advogados Especializados"; breadcrumbs = @(@{label="Home"; href="index.html"}, @{label="O Escritório"; href="o-escritorio.html"}) },
  @{ filename = "areas-de-atuacao.html"; layout = "areas-hub"; title = "Áreas de Atuação Jurídica | Rodrigo Parente Advogados"; metaDescription = "Confira nossas especialidades jurídicas. Oferecemos assessoria consultiva, administrativa e judicial para pessoas físicas, empresas e instituições."; h1 = "Áreas de Atuação Jurídica"; breadcrumbs = @(@{label="Home"; href="index.html"}, @{label="Áreas de Atuação"; href="areas-de-atuacao.html"}) },
  @{ filename = "equipe.html"; layout = "team"; title = "Nossa Equipe Jurídica | Rodrigo Parente Advogados"; metaDescription = "Conheça nosso corpo jurídico multidisciplinar focado em ética, técnica e dedicação aos interesses de nossos clientes em Sobral e Fortaleza."; h1 = "Nossa Equipe"; breadcrumbs = @(@{label="Home"; href="index.html"}, @{label="Equipe"; href="equipe.html"}) },
  @{ filename = "contato.html"; layout = "contact"; title = "Contato | Escritório Rodrigo Parente Advogados"; metaDescription = "Fale com nossa equipe jurídica. Atendimento presencial nas unidades de Sobral e Fortaleza/CE, e atendimento consultivo online nacional."; h1 = "Entre em Contato"; breadcrumbs = @(@{label="Home"; href="index.html"}, @{label="Contato"; href="contato.html"}) },
  
  # Páginas Legais
  @{ filename = "politica-de-privacidade.html"; layout = "legal"; title = "Política de Privacidade | Rodrigo Parente Advogados"; metaDescription = "Política de privacidade do Escritório de Advocacia Dr. Rodrigo Parente Advogados Especializados em conformidade com a LGPD."; h1 = "Política de Privacidade"; breadcrumbs = @(@{label="Home"; href="index.html"}, @{label="Privacidade"; href="politica-de-privacidade.html"}); legalType = "privacy" },
  @{ filename = "termos-de-uso.html"; layout = "legal"; title = "Termos de Uso | Rodrigo Parente Advogados"; metaDescription = "Termos de uso do website institucional do Escritório de Advocacia Dr. Rodrigo Parente Advogados Especializados."; h1 = "Termos de Uso"; breadcrumbs = @(@{label="Home"; href="index.html"}, @{label="Termos de Uso"; href="termos-de-uso.html"}); legalType = "terms" },
  @{ filename = "politica-de-cookies.html"; layout = "legal"; title = "Política de Cookies | Rodrigo Parente Advogados"; metaDescription = "Saiba como e por que utilizamos cookies no site do Escritório de Advocacia Dr. Rodrigo Parente Advogados Especializados."; h1 = "Política de Cookies"; breadcrumbs = @(@{label="Home"; href="index.html"}, @{label="Cookies"; href="politica-de-cookies.html"}); legalType = "cookies" }
)

# Adiciona as 21 páginas de áreas de atuação
foreach ($area in $areas) {
  $pages += @{
    filename = ($area.id + ".html")
    layout = "area-detail"
    title = ($area.title + " no Ceará | Rodrigo Parente Advogados")
    metaDescription = ("Assessoria e consultoria jurídica especializada em " + $area.title + " em Sobral, Fortaleza e Ceará. Atendimento consultivo, administrativo e judicial.")
    h1 = $area.title
    areaId = $area.id
    breadcrumbs = @(
      @{label="Home"; href="index.html"},
      @{label="Áreas de Atuação"; href="areas-de-atuacao.html"},
      @{label=$area.title; href=($area.id + ".html")}
    )
  }
}

# 4. Funções Auxiliares de Componentes HTML

function Render-Breadcrumbs($crumbs) {
  if ($crumbs.Count -eq 0) { return "" }
  $html = ""
  for ($i = 0; $i -lt $crumbs.Count; $i++) {
    $c = $crumbs[$i]
    if ($i -eq ($crumbs.Count - 1)) {
      $html += "<span class='current'>$($c.label)</span>"
    } else {
      $html += "<a href='$($c.href)'>$($c.label)</a> <span class='separator'>/</span> "
    }
  }
  return @"
    <div class="breadcrumbs-container">
      <div class="container">
        <nav class="breadcrumbs" aria-label="Breadcrumb">
          $html
        </nav>
      </div>
    </div>
"@
}

function Render-DropdownItems($areaList) {
  $html = ""
  foreach ($a in $areaList) {
    $html += "<li class='dropdown-item'><a href='$($a.href)' class='dropdown-link'>$($a.title)</a></li>"
  }
  return $html
}

function Render-AreaCards($areaList, $limit = $null) {
  $html = ""
  $count = 0
  foreach ($a in $areaList) {
    if ($null -ne $limit -and $count -ge $limit) { break }
    $html += @"
    <div class="card">
      <div class="card-icon">
        $($a.icon)
      </div>
      <h3 class="card-title">$($a.title)</h3>
      <p class="card-text">$($a.summary)</p>
      <a href="$($a.href)" class="card-link">
        Saiba Mais
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path d="M12 4l-1.41 1.41L16.17 11H4v2h12.17l-5.58 5.59L12 20l8-8z"/></svg>
      </a>
    </div>
"@
    $count++
  }
  return $html
}

function Render-TeamCards($limit = $null) {
  $team = @(
    @{
      name = "Dr. Rodrigo Parente"
      role = "Advogado e Proprietário"
      oab = "OAB/CE 38.940"
      bio = '
        <h3 class="bio-title">Dr. Rodrigo Parente Bezerra</h3>
        <p class="bio-subtitle">Proprietário do Escritório</p>
        <div class="bio-text">
          <p>Com vasta experiência jurídica. Proprietário do Escritório.</p>
          <p><strong>Palestrante:</strong> Realiza palestras nos principais simpósios de debates jurídicos do País.</p>
          <p><strong>Escritor:</strong> Escreve para os principais Jornais e Revistas do País.</p>
          <p><strong>Professor:</strong> Professor das principais universidades do País.</p>
          <p><strong>Mentor:</strong> Responsável pelo programa de mentoria para Jovens Advogados.</p>
          <p><strong>Clientes:</strong> Clientes Satisfeitos em 25 Estados.</p>
          
          <ul class="bio-highlights">
            <li><span>🌐</span> Dr. Rodrigo Parente é um Profissional altamente Qualificado e preparado com participação nos principais simpósios jurídicos do País</li>
            <li><span>🌐</span> Advogado com amplo conhecimento fluxo jurídico em Direito Constitucional, Direito Civil e Processo Civil, Direito Bancário, Direito de Família, Direito Contratual e Direito Empresarial</li>
            <li><span>🌐</span> Profissional extremamente competente e preparado em constante processo de Aperfeiçoamento</li>
            <li><span>🌐</span> Presente nos debates jurídicos em Rádios e Revistas</li>
            <li><span>🌐</span> Profissional extremamente competente e preparado com ampla participação nas reuniões da Ordem dos Advogados do Brasil</li>
            <li><span>🌐</span> Estudioso de teses inovadoras e contemporâneas no Âmbito do Direito Constitucional, Direito Empresarial, Direito Bancário, Direito do Consumidor e Direito de Família</li>
          </ul>
        </div>
      '
    },
    @{
      name = "Dra. Laura Grangeiro"
      role = "Advogada Associada"
      oab = "OAB/CE 32.465"
      bio = '
        <h3 class="bio-title">Dra. Laura Grangeiro</h3>
        <p class="bio-subtitle">Equipe do Escritório</p>
        <div class="bio-text">
          <p>Advogada com vasta experiência jurídica.</p>
          <p>Especializada em diversas áreas do conhecimento jurídica.</p>
          <ul class="bio-highlights">
            <li><span>🌐</span> Advogada extremamente competente e preparada com vasta experiência em Soluções Jurídicas Inovadoras</li>
            <li><span>🌐</span> Profissional extremamente competente e preparada</li>
          </ul>
        </div>
      '
    },
    @{
      name = "Dra. Evelin Rodrigues"
      role = "Advogada Associada"
      oab = "OAB/CE 54.390"
      bio = '
        <h3 class="bio-title">Dra. Evelin Rodrigues</h3>
        <p class="bio-subtitle">Equipe do Escritório</p>
        <div class="bio-text">
          <p>Advogada com vasta Experiência Jurídica.</p>
          <p>Com diversas Especializações.</p>
          <ul class="bio-highlights">
            <li><span>🌐</span> Profissional extremamente competente e preparada</li>
            <li><span>🌐</span> Presente nos principais simpósios jurídicos</li>
            <li><span>🌐</span> Escritora de Artigos Jurídicos</li>
          </ul>
        </div>
      '
    },
    @{
      name = "Dr. Johnathan Marques"
      role = "Corpo Jurídico"
      oab = "Economista & Graduando em Direito"
      bio = '
        <h3 class="bio-title">Dr. Johnathan Marques</h3>
        <p class="bio-subtitle">Corpo Jurídico / Economista</p>
        <div class="bio-text">
          <p>Economista formado pela Universidade Federal do Ceará UFC e Graduando em Direito pelo Centro Universitário Uninta Ceará. Responsável pelo processo de Superendividamento.</p>
          
          <ul class="bio-highlights">
            <li><span>🌐</span> Estudos aprofundados em avaliação de juros Abusivos e empréstimos consignados</li>
            <li><span>🌐</span> Estudos aprofundados na avaliação do comportamento dos Bancos sobre Taxas de Juros</li>
            <li><span>🌐</span> Mentor de Jovens Economistas, Advogados e Estagiários</li>
            <li><span>🌐</span> Estudioso no Âmbito do Direito Constitucional, Direito Empresarial, Direito do Consumidor, Direito Societário, Criminal e Bancário</li>
            <li><span>🌐</span> Estudioso do processo de aperfeiçoamento para Defesa de Empresas e Empresários no processo de repactuação de Dívidas</li>
            <li><span>🌐</span> Experiência profissional competente e preparada</li>
          </ul>
        </div>
      '
    },
    @{ name = "Dr. Paiva Oliveira"; role = "Assistente Jurídico"; oab = "Graduando em Direito" },
    @{ name = "Dra. Andreyna Kettlen"; role = "Assistente Jurídica"; oab = "Graduanda em Direito" }
  )
  
  $html = ""
  $count = 0
  foreach ($m in $team) {
    if ($null -ne $limit -and $count -ge $limit) { break }
    $hasBio = $null -ne $m.bio
    $hasBioAttr = ""
    $bioDiv = ""
    if ($hasBio) {
      $hasBioAttr = 'data-has-bio="true"'
      $bioDiv = "<div class='member-bio-data' style='display: none;'>$($m.bio)</div>"
    }
    $html += @"
    <div class="member-card" $hasBioAttr>
      <div class="member-img-wrap">
        <div class="member-placeholder">
          <svg viewBox="0 0 24 24">
            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
          </svg>
          <span>Espaço para Foto</span>
        </div>
      </div>
      <div class="member-info">
        <h3 class="member-name">$($m.name)</h3>
        <p class="member-role">$($m.role)</p>
        <span class="member-oab">$($m.oab)</span>
      </div>
      $bioDiv
    </div>
"@
    $count++
  }
  return $html
}

function Render-ValuesCards {
  $values = @(
    @{ title = "Ética e Integridade"; text = "Atuação intransigente sob os mais estritos princípios morais e regras da OAB." },
    @{ title = "Transparência"; text = "Manter o cliente plenamente informado e atualizado sobre o andamento e estratégias do seu caso." },
    @{ title = "Excelência Técnica"; text = "Estudo aprofundado de cada causa para oferecer soluções jurídicas precisas e eficazes." },
    @{ title = "Comprometimento"; text = "Dedicação integral no alcance dos melhores interesses dos clientes em todas as instâncias." },
    @{ title = "Respeito às Pessoas"; text = "Atendimento acolhedor, empático e humanizado voltado a compreender as demandas individuais." },
    @{ title = "Inovação e Atualização"; text = "Uso de novas tecnologias e constante atualização perante a jurisprudência contemporânea." },
    @{ title = "Responsabilidade e Confiança"; text = "Relações pautadas pela segurança jurídica, lealdade profissional e confidencialidade." }
  )
  $html = ""
  foreach ($v in $values) {
    $html += @"
    <div class="value-card">
      <h3>$($v.title)</h3>
      <p>$($v.text)</p>
    </div>
"@
  }
  return $html
}

function Render-DiferenciaisCards {
  $diffs = @(
    @{ title = "Atendimento Personalizado"; text = "Projetos de consultoria e patrocínio desenhados sob medida para o perfil do cliente." },
    @{ title = "Estratégias Jurídicas Sob Medida"; text = "Defesas técnicas elaboradas a partir do contexto econômico e fático específico de cada caso." },
    @{ title = "Equipe Multidisciplinar"; text = "Profissionais com conhecimentos integrados em Direito, Economia e Negócios para assessoria completa." },
    @{ title = "Atuação Consultiva, Administrativa e Judicial"; text = "Amplo espectro de atuação cobrindo desde a prevenção até o contencioso mais complexo." },
    @{ title = "Experiência em Demandas Complexas"; text = "Histórico consolidado de êxito na condução de processos burocráticos e regulatórios desafiadores." },
    @{ title = "Rede de Parceiros em todo o Brasil"; text = "Parcerias consolidadas com escritórios correspondentes para atendimento ágil em todo território nacional." },
    @{ title = "Visão Empresarial e Estratégica"; text = "Foco prático em viabilizar operações comerciais reduzindo custos tributários e burocráticos." }
  )
  $html = ""
  foreach ($d in $diffs) {
    $html += @"
    <div class="value-card">
      <h3>$($d.title)</h3>
      <p>$($d.text)</p>
    </div>
"@
  }
  return $html
}

function Render-FAQ($duvidasList) {
  if ($null -eq $duvidasList -or $duvidasList.Count -eq 0) { return "" }
  $html = ""
  foreach ($d in $duvidasList) {
    $html += @"
    <div class="faq-item">
      <button class="faq-question" aria-expanded="false">
        $($d.q)
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20"><path d="M7 10l5 5 5-5z"/></svg>
      </button>
      <div class="faq-answer">
        <div class="faq-answer-inner">
          <p>$($d.a)</p>
        </div>
      </div>
    </div>
"@
  }
  return $html
}

function Render-Demandas($demandasList) {
  if ($null -eq $demandasList -or $demandasList.Count -eq 0) { return "" }
  $html = ""
  foreach ($d in $demandasList) {
    $html += @"
    <div class="demanda-item">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="18" height="18"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
      <span>$d</span>
    </div>
"@
  }
  return $html
}

function Render-Scenarios($cenariosList) {
  if ($null -eq $cenariosList -or $cenariosList.Count -eq 0) { return "" }
  $html = ""
  foreach ($c in $cenariosList) {
    $html += @"
        <div class="scenario-card">
          <h3 class="scenario-title">$($c.title)</h3>
          <p class="scenario-desc">$($c.desc)</p>
        </div>
"@
  }
  return @"
    <div class="scenarios-list">
      $html
    </div>
"@
}

function Render-Glossary($glossarioList) {
  if ($null -eq $glossarioList -or $glossarioList.Count -eq 0) { return "" }
  $html = ""
  foreach ($g in $glossarioList) {
    $html += @"
        <div class="glossary-item">
          <strong class="glossary-term">$($g.term)</strong>: 
          <span class="glossary-definition">$($g.definition)</span>
        </div>
"@
  }
  return @"
    <div class="glossary-list">
      $html
    </div>
"@
}

function Render-FocusGrid($focoList) {
  if ($null -eq $focoList -or $focoList.Count -eq 0) { return "" }
  $html = ""
  foreach ($f in $focoList) {
    $html += @"
    <div class="focus-card">
      <h3 class="focus-card-title">$($f.title)</h3>
      <p class="focus-card-desc">$($f.desc)</p>
    </div>
"@
  }
  return @"
    <div class="focus-grid">
      $html
    </div>
"@
}

function Render-WorkflowTimeline {
  return @"
    <div class="workflow-timeline">
      <div class="timeline-step">
        <div class="step-num">01</div>
        <div class="step-content">
          <h3 class="step-title">Consulta Inicial</h3>
          <p class="step-desc">Primeira reunião (presencial ou virtual) para compreender as demandas e fatos.</p>
        </div>
      </div>
      <div class="timeline-step">
        <div class="step-num">02</div>
        <div class="step-content">
          <h3 class="step-title">Análise de Provas</h3>
          <p class="step-desc">Estudo criterioso de documentos, certidões e contratos para fundamentação legal.</p>
        </div>
      </div>
      <div class="timeline-step">
        <div class="step-num">03</div>
        <div class="step-content">
          <h3 class="step-title">Tática Jurídica</h3>
          <p class="step-desc">Elaboração técnica e minuciosa de petições, defesas ou pareceres consultivos.</p>
        </div>
      </div>
      <div class="timeline-step">
        <div class="step-num">04</div>
        <div class="step-content">
          <h3 class="step-title">Acompanhamento</h3>
          <p class="step-desc">Protocolo de ações e envio sistemático de informativos e andamentos ao cliente.</p>
        </div>
      </div>
    </div>
"@
}

function Render-ContactForm($areaList) {
  $options = ""
  foreach ($a in $areaList) {
    $options += "<option value='$($a.id)'>$($a.title)</option>"
  }
  return @"
    <form id="contact-form" class="contact-form" novalidate>
      <div class="form-row">
        <div class="form-group">
          <label for="form-name" class="form-label">Nome Completo *</label>
          <input type="text" id="form-name" class="form-control" placeholder="Seu nome" required>
        </div>
        <div class="form-group">
          <label for="form-email" class="form-label">E-mail Corporativo/Pessoal *</label>
          <input type="email" id="form-email" class="form-control" placeholder="Seu e-mail" required>
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label for="form-whatsapp" class="form-label">WhatsApp *</label>
          <input type="tel" id="form-whatsapp" class="form-control" placeholder="(85) 99999-9999" required>
        </div>
        <div class="form-group">
          <label for="form-city" class="form-label">Cidade / Estado *</label>
          <select id="form-city" class="form-control" required>
            <option value="" disabled selected>Selecione sua cidade</option>
            <option value="Sobral/CE">Sobral / CE</option>
            <option value="Fortaleza/CE">Fortaleza / CE</option>
            <option value="Outra">Outra Cidade / CE</option>
            <option value="Outro Estado">Outro Estado (Brasil)</option>
          </select>
        </div>
      </div>
      
      <div class="form-group">
        <label for="form-area" class="form-label">Área de Interesse *</label>
        <select id="form-area" class="form-control" required>
          <option value="" disabled selected>Selecione a área jurídica</option>
          $options
          <option value="Outros">Outras Demandas / Consultoria Geral</option>
        </select>
      </div>
      
      <div class="form-group">
        <label for="form-message-text" class="form-label">Mensagem *</label>
        <textarea id="form-message-text" class="form-control" placeholder="Descreva brevemente sua situação para direcionamento adequado." required></textarea>
      </div>
      
      <button type="submit" class="btn btn-primary" style="width:100%;">Enviar Mensagem</button>
      
      <div id="form-message" class="form-message" role="alert"></div>
    </form>
"@
}

# 5. Textos das Páginas Legais
$legalTexts = @{
  privacy = @"
    <section>
      <p><em>Última atualização: 18 de Junho de 2026</em></p>
      <p>O Escritório de Advocacia Dr. Rodrigo Parente Advogados Especializados está comprometido com a proteção e a privacidade dos seus dados pessoais. Esta Política de Privacidade descreve como tratamos as informações coletadas por meio de nosso site, em conformidade com a Lei Geral de Proteção de Dados (Lei nº 13.709/2018 - LGPD).</p>
    </section>
    
    <section>
      <h2>1. Coleta de Dados Pessoais</h2>
      <p>Coletamos dados que você nos fornece voluntariamente quando preenche nosso formulário de contato ou inicia uma conversa pelos botões de WhatsApp. Esses dados podem incluir:</p>
      <ul>
        <li>Nome completo</li>
        <li>Endereço de e-mail</li>
        <li>Número de telefone/WhatsApp</li>
        <li>Cidade e Estado</li>
        <li>Área de interesse e informações descritas na mensagem</li>
      </ul>
    </section>

    <section>
      <h2>2. Finalidade do Tratamento de Dados</h2>
      <p>Os dados pessoais coletados são utilizados exclusivamente para:</p>
      <ul>
        <li>Responder às suas solicitações de contato e mensagens de dúvidas;</li>
        <li>Prestar informações jurídicas institucionais requisitadas por você;</li>
        <li>Cumprir obrigações legais ou regulatórias decorrentes da nossa prestação de serviços.</li>
      </ul>
      <p>Não compartilhamos, vendemos ou divulgamos seus dados a terceiros para fins publicitários ou mercadológicos.</p>
    </section>

    <section>
      <h2>3. Armazenamento e Segurança</h2>
      <p>Adotamos medidas técnicas e administrativas aptas a proteger os dados pessoais de acessos não autorizados e de situações acidentais ou ilícitas de destruição, perda, alteração ou difusão. Seus dados são guardados apenas pelo tempo necessário para cumprir as finalidades descritas nesta política.</p>
    </section>

    <section>
      <h2>4. Direitos do Titular</h2>
      <p>Nos termos da LGPD, você possui o direito de confirmar a existência de tratamento de seus dados, obter acesso aos mesmos, corrigir dados incompletos ou inexatos, e requerer a exclusão ou anonimização de dados desnecessários, mediante solicitação formal pelo e-mail: <strong>advrodrigoparente2025@gmail.com</strong>.</p>
    </section>
"@
  terms = @"
    <section>
      <p><em>Última atualização: 18 de Junho de 2026</em></p>
      <p>Seja bem-vindo ao site institucional do Escritório de Advocacia Dr. Rodrigo Parente Advogados Especializados. Ao acessar e navegar por este site, você concorda em cumprir e sujeitar-se aos seguintes Termos de Uso.</p>
    </section>

    <section>
      <h2>1. Natureza Informativa do Conteúdo</h2>
      <p>Todo o conteúdo disponibilizado neste site possui finalidade puramente informativa e institucional. As publicações, resumos de áreas de atuação e respostas a dúvidas frequentes não constituem pareceres jurídicos, consultas formais ou aconselhamento legal aplicável a casos concretos.</p>
    </section>

    <section>
      <h2>2. Ética Profissional e OAB</h2>
      <p>Este site é desenvolvido em estrita conformidade com as regras estabelecidas pelo Código de Ética e Disciplina da Ordem dos Advogados do Brasil (OAB) e pelo Provimento nº 205/2021 do Conselho Federal da OAB, abstendo-se de fazer captação indevida de clientela ou promessas infundadas de resultados jurídicos.</p>
    </section>

    <section>
      <h2>3. Propriedade Intelectual</h2>
      <p>O design, a estrutura, as marcas, logotipos e os textos disponibilizados neste website são de propriedade do escritório ou de seus licenciadores, sendo proibida a reprodução ou distribuição sem autorização prévia por escrito.</p>
    </section>

    <section>
      <h2>4. Limitação de Responsabilidade</h2>
      <p>O escritório envida esforços para manter as informações do site atualizadas e precisas. Contudo, não nos responsabilizamos por eventuais perdas decorrentes de decisões tomadas com base no conteúdo geral deste portal sem a contratação de uma assessoria jurídica formal customizada.</p>
    </section>
"@
  cookies = @"
    <section>
      <p><em>Última atualização: 18 de Junho de 2026</em></p>
      <p>Este site utiliza cookies para otimizar sua experiência de navegação. Ao continuar navegando em nosso portal, você concorda com o uso de cookies conforme detalhado nesta política.</p>
    </section>

    <section>
      <h2>1. O que são Cookies?</h2>
      <p>Cookies são pequenos arquivos de texto enviados e armazenados no seu computador ou dispositivo móvel pelo navegador de internet. Eles servem para lembrar suas preferências, melhorar a performance do site e analisar métricas básicas de tráfego de forma anônima.</p>
    </section>

    <section>
      <h2>2. Quais Cookies utilizamos?</h2>
      <ul>
        <li><strong>Cookies Necessários:</strong> Essenciais para o funcionamento seguro e navegação das páginas.</li>
        <li><strong>Cookies Analíticos:</strong> Coletam dados de tráfego (como páginas visitadas e tempo de permanência) de forma agregada e anônima, ajudando-nos a melhorar a estrutura do site.</li>
      </ul>
    </section>

    <section>
      <h2>3. Como gerenciar os Cookies?</h2>
      <p>Você pode desativar ou apagar os cookies a qualquer momento alterando as configurações de privacidade do seu próprio navegador. Note que a desativação de cookies necessários pode afetar o funcionamento correto de algumas páginas ou formulários do site.</p>
    </section>
"@
}

# 6. Renderizador de Layout Comum

function Render-Layout($page, $contentHTML) {
  $dropdownHTML = Render-DropdownItems($areas)
  $breadcrumbsHTML = Render-Breadcrumbs($page.breadcrumbs)
  
  # Estrutura do layout HTML5
  return @"
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$($page.title)</title>
  <meta name="description" content="$($page.metaDescription)">
  <meta name="robots" content="index, follow">
  <link rel="canonical" href="https://drrodrigoparente.adv.br/$($page.filename)">
  
  <!-- Favicon -->
  <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>⚖️</text></svg>">

  <!-- CSS Principal -->
  <link rel="stylesheet" href="css/style.css">
  
  <!-- Schema.org JSON-LD para SEO -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "LegalService",
    "name": "Escritório de Advocacia Dr. Rodrigo Parente Advogados Especializados",
    "description": "Escritório de advocacia especializado no Ceará, com atuação em Sobral e Fortaleza. Mais de 20 anos de história de excelência nas esferas consultiva, administrativa e judicial.",
    "url": "https://drrodrigoparente.adv.br/",
    "telephone": "+55-85-3104-2419",
    "email": "advrodrigoparente2025@gmail.com",
    "address": [
      {
        "@type": "PostalAddress",
        "streetAddress": "Rua Tabelião Idelfonso Cavalcante, nº 102, Centro",
        "addressLocality": "Sobral",
        "addressRegion": "CE",
        "postalCode": "62011-200",
        "addressCountry": "BR"
      },
      {
        "@type": "PostalAddress",
        "streetAddress": "Torre Empresarial Iguatemi, Sala 307, 3º andar, Avenida Washington Soares",
        "addressLocality": "Fortaleza",
        "addressRegion": "CE",
        "postalCode": "60811-341",
        "addressCountry": "BR"
      }
    ],
    "geo": [
      {
        "@type": "GeoCoordinates",
        "latitude": "-3.689624",
        "longitude": "-40.349692"
      },
      {
        "@type": "GeoCoordinates",
        "latitude": "-3.755490",
        "longitude": "-38.488970"
      }
    ],
    "openingHoursSpecification": {
      "@type": "OpeningHoursSpecification",
      "dayOfWeek": [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday"
      ],
      "opens": "08:00",
      "closes": "18:00"
    },
    "sameAs": [
      "https://www.instagram.com/dr.rodrigo.parente/",
      "https://www.instagram.com/dr.rodrigo.parenteadvogados/"
    ]
  }
  </script>
</head>
<body>

  <!-- HEADER -->
  <header class="header">
    <div class="container navbar">
      <a href="index.html" class="logo" aria-label="Ir para a Home">
        <img src="img/logo.webp" alt="Rodrigo Parente Advogados Especializados" class="logo-img">
      </a>
      
      <nav class="nav-wrap" aria-label="Navegação Principal">
        <ul class="nav-menu">
          <li class="nav-item"><a href="index.html" class="nav-link">Home</a></li>
          <li class="nav-item"><a href="o-escritorio.html" class="nav-link">O Escritório</a></li>
          <li class="nav-item dropdown">
            <a href="areas-de-atuacao.html" class="nav-link dropdown-trigger">
              Áreas de Atuação
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path d="M7 10l5 5 5-5z"/></svg>
            </a>
            <ul class="dropdown-menu">
              $dropdownHTML
            </ul>
          </li>
          <li class="nav-item"><a href="equipe.html" class="nav-link">Equipe</a></li>
          <li class="nav-item"><a href="contato.html" class="nav-link">Contato</a></li>
          <li class="nav-item nav-cta">
            <a href="https://wa.me/5585992046060" target="_blank" rel="noopener noreferrer" class="btn btn-accent btn-sm">Fale Conosco</a>
          </li>
        </ul>
      </nav>

      <button class="burger" aria-label="Abrir Menu Móvel" aria-expanded="false">
        <span></span>
        <span></span>
        <span></span>
      </button>
    </div>
  </header>

  <!-- MAIN CONTENT -->
  <main id="main-content">
    $breadcrumbsHTML
    $contentHTML
  </main>

  <!-- FOOTER -->
  <footer class="footer">
    <div class="container footer-top">
      <div>
        <div class="footer-logo">
          <a href="index.html" class="logo">
            <img src="img/logo.webp" alt="Rodrigo Parente Advogados Especializados" class="footer-logo-img">
          </a>
        </div>
        <p class="footer-desc">
          Com mais de 20 anos de história de excelência e ética, oferecemos assessoria e atuação estratégica jurídica (consultiva, administrativa e judicial) no Ceará e em todo o território nacional.
        </p>
        <div class="footer-socials">
          <a href="https://www.instagram.com/dr.rodrigo.parente/" target="_blank" rel="noopener noreferrer" class="social-link" aria-label="Acompanhe o Dr. Rodrigo Parente no Instagram">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/></svg>
          </a>
          <a href="https://www.instagram.com/dr.rodrigo.parenteadvogados/" target="_blank" rel="noopener noreferrer" class="social-link" aria-label="Acompanhe o escritório no Instagram">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/></svg>
          </a>
        </div>
      </div>
      
      <div>
        <h4 class="footer-title">Menu Rápido</h4>
        <ul class="footer-links">
          <li><a href="index.html" class="footer-link">Home</a></li>
          <li><a href="o-escritorio.html" class="footer-link">O Escritório</a></li>
          <li><a href="areas-de-atuacao.html" class="footer-link">Áreas de Atuação</a></li>
          <li><a href="equipe.html" class="footer-link">Equipe</a></li>
          <li><a href="contato.html" class="footer-link">Contato</a></li>
        </ul>
      </div>
      
      <div>
        <h4 class="footer-title">Áreas Principais</h4>
        <ul class="footer-links">
          <li><a href="direito-administrativo.html" class="footer-link">Direito Administrativo</a></li>
          <li><a href="direito-tributario.html" class="footer-link">Direito Tributário</a></li>
          <li><a href="direito-societario-empresarial.html" class="footer-link">Direito Societário</a></li>
          <li><a href="direito-civel.html" class="footer-link">Direito Cível</a></li>
          <li><a href="direito-trabalhista.html" class="footer-link">Direito Trabalhista</a></li>
          <li><a href="direito-penal.html" class="footer-link">Direito Penal</a></li>
        </ul>
      </div>
      
      <div>
        <h4 class="footer-title">Nossas Unidades</h4>
        <div class="footer-contact-item">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/></svg>
          <div class="footer-contact-text">
            <strong>Unidade Sobral</strong>
            <span>Rua Tabelião Idelfonso Cavalcante, nº 102, Centro, Sobral/CE</span>
          </div>
        </div>
        <div class="footer-contact-item">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/></svg>
          <div class="footer-contact-text">
            <strong>Unidade Fortaleza</strong>
            <span>Torre Empresarial Iguatemi, Sala 307, 3º andar, Avenida Washington Soares, Fortaleza/CE</span>
          </div>
        </div>
        <div class="footer-contact-item">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path d="M6.62 10.79c1.44 2.83 3.76 5.14 6.59 6.59l2.2-2.2c.27-.27.67-.36 1.02-.24 1.12.37 2.33.57 3.57.57.55 0 1 .45 1 1V20c0 .55-.45 1-1 1-9.39 0-17-7.61-17-17 0-.55.45-1 1-1h3.5c.55 0 1 .45 1 1 0 1.25.2 2.45.57 3.57.11.35.03.74-.25 1.02l-2.2 2.2z"/></svg>
          <div class="footer-contact-text">
            <strong>Telefone e E-mail</strong>
            <span>85 3104-2419</span><br>
            <span><a href="mailto:advrodrigoparente2025@gmail.com">advrodrigoparente2025@gmail.com</a></span>
          </div>
        </div>
      </div>
    </div>
    
    <div class="container footer-bottom">
      <p>&copy; 2026 Rodrigo Parente Advogados Especializados. Todos os direitos reservados. Em conformidade com o Código de Ética e Disciplina da OAB.</p>
      <div class="footer-bottom-links">
        <a href="politica-de-privacidade.html">Privacidade</a>
        <a href="termos-de-uso.html">Termos de Uso</a>
        <a href="politica-de-cookies.html">Cookies</a>
      </div>
    </div>
  </footer>

  <!-- FLOATING WHATSAPP -->
  <a href="https://wa.me/5585992046060" class="whatsapp-float" target="_blank" rel="noopener noreferrer" aria-label="Fale conosco no WhatsApp">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32"><path d="M.057 24l1.687-6.163c-1.041-1.804-1.588-3.849-1.587-5.946C.06 5.348 5.397.01 12.008.01c3.202.001 6.212 1.246 8.477 3.514 2.266 2.268 3.507 5.28 3.505 8.484-.004 6.657-5.34 11.997-11.953 11.997-2.005-.001-3.973-.502-5.724-1.457L0 24zm6.59-3.483l.362.215c1.6.95 3.797 1.45 6.05 1.451 5.52 0 10.011-4.493 10.014-10.014.002-2.674-1.038-5.188-2.928-7.08C18.2 3.2 15.698 2.16c-5.528 0-10.026 4.495-10.03 10.017-.002 2.27.596 4.484 1.732 6.425l.233.394L4.01 22.188l3.637-1.67zM16.9 14.19c-.27-.134-1.59-.783-1.836-.874-.247-.09-.427-.135-.607.135-.18.27-.697.874-.853 1.054-.158.18-.315.203-.585.07-2.483-1.246-3.842-2.24-5.328-4.793-.134-.23-.202-.455-.07-.585.12-.116.27-.315.405-.472.134-.158.18-.27.27-.45.09-.18.045-.337-.022-.472-.068-.135-.608-1.464-.833-2.005-.22-.528-.439-.456-.607-.464-.157-.008-.337-.009-.517-.009-.18 0-.472.067-.72.337-.247.27-.945.923-.945 2.25s.967 2.61 1.103 2.79c.135.18 1.9 2.9 4.606 4.07.644.278 1.147.445 1.54.57.647.206 1.236.177 1.702.108.52-.078 1.592-.65 1.82-1.28.225-.63.225-1.17.157-1.283-.07-.112-.248-.18-.518-.315z"/></svg>
  </a>

  <!-- Modal de Biografia do Profissional -->
  <div id="bio-modal" class="modal" aria-hidden="true" role="dialog">
    <div class="modal-overlay"></div>
    <div class="modal-container">
      <button class="modal-close" aria-label="Fechar Modal">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"/></svg>
      </button>
      <div class="modal-content">
        <!-- O conteúdo da biografia será inserido aqui via JS -->
      </div>
    </div>
  </div>

  <!-- JS -->
  <script src="js/main.js"></script>
</body>
</html>
"@
}

# 7. Geração de cada Página

foreach ($page in $pages) {
  $innerContent = ""

  switch ($page.layout) {
    "home" {
      $areaCardsHTML = Render-AreaCards $areas 6
      $teamCardsHTML = Render-TeamCards 3
      $valuesCardsHTML = Render-ValuesCards
      
      $innerContent = @"
        <!-- Hero Principal -->
        <section class="hero">
          <div class="container hero-content">
            <span class="hero-tagline">Mais de 20 anos de excelência jurídica</span>
            <h1>Advocacia Estratégica e Assessoria Jurídica Especializada no Brasil</h1>
            <p class="hero-subtitle">Atuação consultiva, administrativa e judicial para pessoas, empresas e instituições, com atendimento em todo o território nacional.</p>
            <div class="btn-group">
              <a href="https://wa.me/5585992046060" class="btn btn-accent" target="_blank" rel="noopener noreferrer">Fale pelo WhatsApp</a>
              <a href="areas-de-atuacao.html" class="btn btn-outline-white">Conheça nossas áreas de atuação</a>
            </div>
          </div>
        </section>

        <!-- Apresentação do Escritório -->
        <section class="section">
          <div class="container grid-2">
            <div>
              <h2 class="section-title-left">Sobre o Nosso Escritório</h2>
              <p>O Escritório de Advocacia Dr. Rodrigo Parente Advogados Especializados é um moderno escritório advocatício localizado em Fortaleza/CE e Sobral/CE, reconhecido pela excelência no atendimento ao cliente e pela vasta experiência na prestação de serviços jurídicos em diferentes ramos do Direito.</p>
              <p>Com mais de 20 anos de história, nos destacamos pela forma de conduzir as situações apresentadas pelos clientes, pelo profissionalismo na análise de cada demanda e pela elaboração de estratégias jurídicas adequadas a cada caso.</p>
              <p>Nossa atuação equilibra o respeito à tradição e às normas éticas com a agilidade, dinamismo e inovação exigidos pelo cenário corporativo contemporâneo.</p>
              <div style="margin-top: 24px;">
                <a href="o-escritorio.html" class="btn btn-outline" style="margin-bottom: 20px; display: inline-block;">Conheça nossa história completa</a>
                <ul style="list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 12px; border-top: 1px solid var(--border-color); padding-top: 20px;">
                  <li style="display: flex; align-items: center; gap: 10px;">
                    <span style="background-color: var(--accent-color); color: var(--primary-color); font-weight: bold; padding: 2px 8px; border-radius: 4px; font-size: 0.85rem;">1+</span>
                    <a href="areas-de-atuacao.html" style="color: var(--primary-color); font-weight: 600; text-decoration: none; border-bottom: 1px solid transparent; transition: var(--transition-fast);" onmouseover="this.style.borderBottomColor='var(--accent-color)'" onmouseout="this.style.borderBottomColor='transparent'">Conheça nossas áreas de atuação</a>
                  </li>
                  <li style="display: flex; align-items: center; gap: 10px;">
                    <span style="background-color: var(--accent-color); color: var(--primary-color); font-weight: bold; padding: 2px 8px; border-radius: 4px; font-size: 0.85rem;">2+</span>
                    <a href="equipe.html" style="color: var(--primary-color); font-weight: 600; text-decoration: none; border-bottom: 1px solid transparent; transition: var(--transition-fast);" onmouseover="this.style.borderBottomColor='var(--accent-color)'" onmouseout="this.style.borderBottomColor='transparent'">Conheça nossa equipe de profissionais</a>
                  </li>
                </ul>
              </div>
            </div>
            <div style="background-color: var(--primary-color); border-radius: 4px; padding: 40px; color: var(--text-light); text-align: center; border-bottom: 4px solid var(--accent-color);">
              <h3 style="color: var(--text-light); margin-bottom: 16px; font-size: 1.8rem; font-family: var(--font-serif);">Atuação Nacional</h3>
              <p style="color: rgba(248,249,250,0.85); font-size: 0.95rem; margin-bottom: 24px;">Além de nossas sedes físicas no Ceará, dispomos de uma rede de parceiros estratégicos que nos permite oferecer atendimento de excelência em todo o território nacional.</p>
              <ul style="text-align: left; display: flex; flex-direction: column; gap: 12px; margin-bottom: 24px; font-size: 0.9rem;">
                <li style="display: flex; gap: 8px; align-items: center;"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="var(--accent-color)"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg> Clientes Satisfeitos em 25 Estados</li>
                <li style="display: flex; gap: 8px; align-items: center;"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="var(--accent-color)"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg> Equipe de Profissionais altamente Qualificados e Preparados</li>
                <li style="display: flex; gap: 8px; align-items: center;"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="var(--accent-color)"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg> Advogados e Advogadas Especializados em constante processo de Aperfeiçoamento</li>
              </ul>
              <a href="contato.html" class="btn btn-accent" style="width: 100%;">Falar com um Advogado</a>
            </div>
          </div>
        </section>

        <!-- Destaques Institucionais (Diferenciais Curtos) -->
        <section class="section section-bg">
          <div class="container">
            <h2 class="section-title text-center" style="margin-bottom: 60px;">Diferenciais do Escritório</h2>
            <div class="grid-3">
              <div class="value-card">
                <h3>Atendimento Personalizado</h3>
                <p>Análise aprofundada do contexto de cada cliente para formulação de respostas adequadas e focadas na realidade do caso.</p>
              </div>
              <div class="value-card">
                <h3>Estratégias Sob Medida</h3>
                <p>Soluções desenhadas para mitigar riscos burocráticos e financeiros, seja no contencioso ou em ambiente consultivo.</p>
              </div>
              <div class="value-card">
                <h3>Equipe Multidisciplinar</h3>
                <p>Advogados de excelência com conhecimentos complementares em diversas áreas jurídicas, econômicas e regulatórias.</p>
              </div>
            </div>
          </div>
        </section>

        <!-- Áreas de Atuação Principais -->
        <section class="section">
          <div class="container">
            <h2 class="section-title text-center" style="margin-bottom: 20px;">Áreas de Atuação Principais</h2>
            <p class="text-center" style="max-width: 700px; margin: 0 auto 60px; color: var(--text-muted);">
              Prestamos assessoria de alto nível nas esferas consultiva, preventiva e de contencioso em diversos segmentos da área jurídica.
            </p>
            <div class="grid-3">
              $areaCardsHTML
            </div>
            <div class="text-center" style="margin-top: 48px;">
              <a href="areas-de-atuacao.html" class="btn btn-outline">Ver Todas as Áreas Jurídicas</a>
            </div>
          </div>
        </section>

        <!-- Equipe Jurídica Destaque -->
        <section class="section section-bg">
          <div class="container">
            <h2 class="section-title text-center" style="margin-bottom: 60px;">Corpo Jurídico</h2>
            <div class="team-grid">
              $teamCardsHTML
            </div>
            <div class="text-center" style="margin-top: 48px;">
              <a href="equipe.html" class="btn btn-outline">Conhecer a Equipe Completa</a>
            </div>
          </div>
        </section>

        <!-- Unidades Física no Ceará -->
        <section class="section">
          <div class="container">
            <h2 class="section-title text-center" style="margin-bottom: 60px;">Nossas Unidades</h2>
            <div class="grid-2">
              <div class="location-card">
                <h3 class="location-name">
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" fill="var(--accent-color)"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/></svg>
                  Sobral / CE
                </h3>
                <p class="location-address">Rua Tabelião Idelfonso Cavalcante, nº 102, Centro, Sobral/CE</p>
                <p>Unidade moderna e estruturada, pronta para oferecer soluções jurídicas de forma ágil para a Região Norte do Estado.</p>
                <div class="map-placeholder">
                  <svg viewBox="0 0 24 24"><path d="M20.5 3l-.16.03L15 5.1 9 3 3.36 4.9c-.21.07-.36.25-.36.48V20.5c0 .28.22.5.5.5l.16-.03L9 18.9l6 2.1 5.64-1.9c.21-.07.36-.25.36-.48V3.5c0-.28-.22-.5-.5-.5zM15 19l-6-2.11V5l6 2.11V19z"/></svg>
                  <span>Mapa da Unidade Sobral</span>
                </div>
              </div>
              <div class="location-card">
                <h3 class="location-name">
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" fill="var(--accent-color)"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/></svg>
                  Fortaleza / CE
                </h3>
                <p class="location-address">Torre Empresarial Iguatemi, Sala 307, 3º andar, Avenida Washington Soares, Fortaleza/CE</p>
                <p>Localizada em importante polo executivo, oferecendo total discrição, conforto e excelência nos atendimentos agendados.</p>
                <div class="map-placeholder">
                  <svg viewBox="0 0 24 24"><path d="M20.5 3l-.16.03L15 5.1 9 3 3.36 4.9c-.21.07-.36.25-.36.48V20.5c0 .28.22.5.5.5l.16-.03L9 18.9l6 2.1 5.64-1.9c.21-.07.36-.25.36-.48V3.5c0-.28-.22-.5-.5-.5zM15 19l-6-2.11V5l6 2.11V19z"/></svg>
                  <span>Mapa da Unidade Fortaleza</span>
                </div>
              </div>
            </div>
          </div>
        </section>

        <!-- Chamada para Ação Final -->
        <section class="section section-bg text-center">
          <div class="container" style="max-width: 800px;">
            <h2>Precisa de suporte jurídico estratégico?</h2>
            <p style="font-size: 1.1rem; margin-bottom: 30px; color: var(--text-muted);">
              Dispomos de profissionais de excelência aptos a analisar suas demandas. Fale conosco por meio de nossos canais oficiais ou formulário.
            </p>
            <div class="btn-group" style="justify-content: center;">
              <a href="https://wa.me/5585992046060" class="btn btn-accent" target="_blank" rel="noopener noreferrer">WhatsApp Central</a>
              <a href="contato.html" class="btn btn-primary">Formulário de Contato</a>
            </div>
          </div>
        </section>
"@
    }
    "about" {
      $valuesCardsHTML = Render-ValuesCards
      $diferenciaisCardsHTML = Render-DiferenciaisCards
      
      $innerContent = @"
        <section class="page-header">
          <div class="container">
            <h1>$($page.h1)</h1>
          </div>
        </section>

        <!-- Apresentação Detalhada -->
        <section class="section">
          <div class="container grid-2">
            <div>
              <h2 class="section-title-left">Nossa História</h2>
              <p>O Escritório de Advocacia Dr. Rodrigo Parente Advogados Especializados é um moderno escritório advocatício localizado em Fortaleza/CE e Sobral/CE, reconhecido pela excelência no atendimento ao cliente e pela vasta experiência na prestação de serviços jurídicos em diferentes ramos do Direito.</p>
              <p>Com mais de 20 anos de história, o escritório se destaca pela forma como conduz as situações apresentadas pelos clientes, pelo profissionalismo na análise de cada demanda e pela elaboração de estratégias jurídicas adequadas a cada caso.</p>
              <p>Valorizamos o relacionamento de longo prazo com nossos clientes, pautando nossa atuação na ética inegociável, na total transparência informativa e na busca constante de soluções técnicas inovadoras.</p>
            </div>
            <div style="background-color: var(--bg-gray); padding: 40px; border-radius: 4px; border: 1px solid var(--border-color); border-top: 3px solid var(--accent-color);">
              <h2 class="section-title-left" style="font-size: 1.5rem; margin-bottom: 24px;">Diretrizes Institucionais</h2>
              
              <div style="margin-bottom: 24px;">
                <h2 style="font-family: var(--font-serif); font-size: 1.5rem; margin-bottom: 8px; font-weight: 600; color: var(--primary-color);">Missão</h2>
                <p style="font-size: 0.95rem; margin-bottom: 0;">Buscar resultados para o cliente, superando expectativas por meio de serviços jurídicos de alta qualidade, proporcionando oportunidades aos colaboradores e garantindo um ambiente de trabalho ético, produtivo e colaborativo.</p>
              </div>
              
              <div>
                <h2 style="font-family: var(--font-serif); font-size: 1.5rem; margin-bottom: 8px; font-weight: 600; color: var(--primary-color);">Visão</h2>
                <p style="font-size: 0.95rem; margin-bottom: 0;">Ser referência em soluções jurídicas, agregando valor aos clientes e parceiros com ética, transparência e excelência na prestação dos serviços.</p>
              </div>
            </div>
          </div>
        </section>

        <!-- Grid de Valores -->
        <section class="section section-bg">
          <div class="container">
            <h2 class="section-title text-center" style="margin-bottom: 60px;">Valores</h2>
            <div class="grid-3">
              $valuesCardsHTML
            </div>
          </div>
        </section>

        <!-- Grid de Diferenciais -->
        <section class="section">
          <div class="container">
            <h2 class="section-title text-center" style="margin-bottom: 60px;">Diferenciais</h2>
            <div class="grid-3">
              $diferenciaisCardsHTML
            </div>
          </div>
        </section>
"@
    }
    "areas-hub" {
      $areaCardsHTML = Render-AreaCards $areas
      
      $innerContent = @"
        <section class="page-header">
          <div class="container">
            <h1>$($page.h1)</h1>
          </div>
        </section>

        <section class="section">
          <div class="container">
            <p class="text-center" style="max-width: 800px; margin: 0 auto 60px; font-size: 1.1rem; line-height: 1.8; color: var(--text-muted);">
              O Escritório de Advocacia Dr. Rodrigo Parente Advogados Especializados atua em diferentes ramos do Direito, oferecendo assessoria jurídica consultiva, administrativa e judicial para pessoas físicas, empresas e instituições.
            </p>
            <div class="grid-3">
              $areaCardsHTML
            </div>
          </div>
        </section>
"@
    }
    "team" {
      $teamCardsHTML = Render-TeamCards
      
      $innerContent = @"
        <section class="page-header">
          <div class="container">
            <h1>$($page.h1)</h1>
          </div>
        </section>

        <section class="section">
          <div class="container">
            <p class="text-center" style="max-width: 850px; margin: 0 auto 60px; font-size: 1.1rem; line-height: 1.8; color: var(--text-muted);">
              O escritório conta com uma equipe multidisciplinar, preparada para atuar em demandas jurídicas consultivas, administrativas e judiciais, com ética, técnica e compromisso com os interesses dos clientes.
            </p>
            <div class="team-grid">
              $teamCardsHTML
            </div>
          </div>
        </section>
"@
    }
    "contact" {
      $contactFormHTML = Render-ContactForm $areas
      
      $innerContent = @"
        <section class="page-header">
          <div class="container">
            <h1>$($page.h1)</h1>
          </div>
        </section>

        <section class="section">
          <div class="container contact-grid">
            
            <!-- Canais e Informações de Unidades -->
            <div class="contact-info-wrap">
              <div>
                <h2 class="section-title-left" style="font-size: 1.5rem; margin-bottom: 24px;">Canais de Atendimento</h2>
                
                <div class="contact-item">
                  <div class="contact-item-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M6.62 10.79c1.44 2.83 3.76 5.14 6.59 6.59l2.2-2.2c.27-.27.67-.36 1.02-.24 1.12.37 2.33.57 3.57.57.55 0 1 .45 1 1V20c0 .55-.45 1-1 1-9.39 0-17-7.61-17-17 0-.55.45-1 1-1h3.5c.55 0 1 .45 1 1 0 1.25.2 2.45.57 3.57.11.35.03.74-.25 1.02l-2.2 2.2z"/></svg>
                  </div>
                  <div>
                    <h3 class="contact-item-title">Telefone</h3>
                    <p class="contact-item-value">85 3104-2419</p>
                  </div>
                </div>

                <div class="contact-item" style="margin-top: 20px;">
                  <div class="contact-item-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M20 2H4c-1.1 0-1.99.9-1.99 2L2 22l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 9h12v2H6V9zm8 5H6v-2h8v2zm4-6H6V6h12v2z"/></svg>
                  </div>
                  <div>
                    <h3 class="contact-item-title">WhatsApp de Contato</h3>
                    <p class="contact-item-value">
                      <a href="https://wa.me/5585992046060" target="_blank" rel="noopener noreferrer">85 99204-6060 (Unidade Sobral)</a><br>
                      <a href="https://wa.me/5585992193636" target="_blank" rel="noopener noreferrer">85 99219-3636 (Unidade Fortaleza)</a>
                    </p>
                  </div>
                </div>

                <div class="contact-item" style="margin-top: 20px;">
                  <div class="contact-item-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/></svg>
                  </div>
                  <div>
                    <h3 class="contact-item-title">E-mail Oficial</h3>
                    <p class="contact-item-value"><a href="mailto:advrodrigoparente2025@gmail.com">advrodrigoparente2025@gmail.com</a></p>
                  </div>
                </div>

                <div class="contact-item" style="margin-top: 20px;">
                  <div class="contact-item-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073z"/></svg>
                  </div>
                  <div>
                    <h3 class="contact-item-title">Instagram</h3>
                    <p class="contact-item-value">
                      <a href="https://www.instagram.com/dr.rodrigo.parente/" target="_blank" rel="noopener noreferrer">@dr.rodrigo.parente</a><br>
                      <a href="https://www.instagram.com/dr.rodrigo.parenteadvogados/" target="_blank" rel="noopener noreferrer">@dr.rodrigo.parenteadvogados</a>
                    </p>
                  </div>
                </div>
              </div>

              <!-- Unidades e endereços detalhados -->
              <div style="margin-top: 20px; border-top: 1px solid var(--border-color); padding-top: 32px;">
                <h2 class="section-title-left" style="font-size: 1.5rem; margin-bottom: 24px;">Nossas Unidades</h2>
                
                <div style="margin-bottom: 24px;">
                  <h3 style="font-family: var(--font-sans); font-size: 1.1rem; margin-bottom: 4px; font-weight: 600;">Unidade Sobral</h3>
                  <p style="font-size: 0.95rem; margin-bottom: 12px; color: var(--text-muted);">Rua Tabelião Idelfonso Cavalcante, nº 102, Centro, Sobral/CE</p>
                  <a href="https://wa.me/5585992046060" target="_blank" rel="noopener noreferrer" class="btn btn-outline" style="padding: 8px 16px; font-size: 0.75rem;">Conversar no WhatsApp</a>
                </div>
                
                <div>
                  <h3 style="font-family: var(--font-sans); font-size: 1.1rem; margin-bottom: 4px; font-weight: 600;">Unidade Fortaleza</h3>
                  <p style="font-size: 0.95rem; margin-bottom: 12px; color: var(--text-muted);">Torre Empresarial Iguatemi, Sala 307, 3º andar, Avenida Washington Soares, Fortaleza/CE</p>
                  <a href="https://wa.me/5585992193636" target="_blank" rel="noopener noreferrer" class="btn btn-outline" style="padding: 8px 16px; font-size: 0.75rem;">Conversar no WhatsApp</a>
                </div>
              </div>
            </div>

            <!-- Formulário de Contato -->
            <div>
              <div class="contact-form-wrap">
                <h2 style="font-size: 1.6rem; margin-bottom: 8px; color: var(--primary-color);">Envie uma Mensagem</h2>
                <p style="font-size: 0.9rem; margin-bottom: 24px; color: var(--text-muted);">Preencha com seus dados para darmos andamento à sua solicitação jurídica.</p>
                $contactFormHTML
              </div>
            </div>
            
          </div>
        </section>

        <!-- Espaços de Mapas Incorporados -->
        <section class="section section-bg">
          <div class="container">
            <h2 class="section-title text-center" style="margin-bottom: 60px;">Localização das Nossas Unidades</h2>
            <div class="grid-2">
              <div style="background-color: var(--bg-light); border: 1px solid var(--border-color); padding: 24px; border-radius: 4px;">
                <h3 style="font-family: var(--font-sans); font-size: 1.2rem; font-weight: 600; margin-bottom: 16px;">Sede Sobral</h3>
                <div class="map-placeholder">
                  <svg viewBox="0 0 24 24"><path d="M20.5 3l-.16.03L15 5.1 9 3 3.36 4.9c-.21.07-.36.25-.36.48V20.5c0 .28.22.5.5.5l.16-.03L9 18.9l6 2.1 5.64-1.9c.21-.07.36-.25.36-.48V3.5c0-.28-.22-.5-.5-.5zM15 19l-6-2.11V5l6 2.11V19z"/></svg>
                  <span>Mapa Interativo Google Maps (Sobral/CE)</span>
                </div>
              </div>
              <div style="background-color: var(--bg-light); border: 1px solid var(--border-color); padding: 24px; border-radius: 4px;">
                <h3 style="font-family: var(--font-sans); font-size: 1.2rem; font-weight: 600; margin-bottom: 16px;">Sede Fortaleza</h3>
                <div class="map-placeholder">
                  <svg viewBox="0 0 24 24"><path d="M20.5 3l-.16.03L15 5.1 9 3 3.36 4.9c-.21.07-.36.25-.36.48V20.5c0 .28.22.5.5.5l.16-.03L9 18.9l6 2.1 5.64-1.9c.21-.07.36-.25.36-.48V3.5c0-.28-.22-.5-.5-.5zM15 19l-6-2.11V5l6 2.11V19z"/></svg>
                  <span>Mapa Interativo Google Maps (Fortaleza/CE)</span>
                </div>
              </div>
            </div>
          </div>
        </section>
"@
    }
    "legal" {
      $legalTextHTML = $legalTexts[$page.legalType]
      
      $innerContent = @"
        <section class="page-header">
          <div class="container">
            <h1>$($page.h1)</h1>
          </div>
        </section>
        
        <section class="section">
          <div class="container legal-content">
            $legalTextHTML
            
            <div style="margin-top: 50px; border-top: 1px solid var(--border-color); padding-top: 30px; text-align: left;">
              <a href="index.html" class="btn btn-outline btn-sm" style="display: inline-flex; align-items: center; gap: 8px;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="currentColor" style="transform: rotate(180deg);"><path d="M5 13h11.86l-5.43 5.43 1.42 1.42L21.14 12l-8.29-8.29-1.42 1.42 5.43 5.43H5v2z"/></svg>
                Voltar para a P&aacute;gina Inicial
              </a>
            </div>
          </div>
        </section>
"@
    }
    "area-detail" {
      # Localiza o objeto de dados da área
      $a = $null
      foreach ($candidate in $areas) {
        if ($candidate.id -eq $page.areaId) {
          $a = $candidate
          break
        }
      }
      
      if ($null -ne $a) {
        $faqHTML = Render-FAQ $a.duvidas
        $demandasHTML = Render-Demandas $a.demandas
        
        $focoHTML = ""
        if ($null -ne $a.foco -and $a.foco.Count -gt 0) {
          $focoGrid = Render-FocusGrid $a.foco
          $focoHTML = @"
                <div class="area-content-section">
                  <h2>Subsegmentos de Foco Especializado</h2>
                  $focoGrid
                </div>
"@
        }

        $cenariosHTML = ""
        if ($null -ne $a.cenarios -and $a.cenarios.Count -gt 0) {
          $cenariosGrid = Render-Scenarios $a.cenarios
          $cenariosHTML = @"
                <div class="area-content-section">
                  <h2>Cenários Comuns de Atendimento</h2>
                  $cenariosGrid
                </div>
"@
        }

        $glossarioHTML = ""
        if ($null -ne $a.glossario -and $a.glossario.Count -gt 0) {
          $glossarioList = Render-Glossary $a.glossario
          $glossarioHTML = @"
                <div class="area-content-section">
                  <h2>Glossário de Termos Relevantes</h2>
                  $glossarioList
                </div>
"@
        }
        
        $innerContent = @"
          <section class="page-header">
            <div class="container">
              <h1>$($a.title)</h1>
            </div>
          </section>

          <section class="section">
            <div class="container area-layout">
              <div class="area-main-content">
                
                                <div class="area-content-section">
                  <h2>Como Atuamos</h2>
                  <p>$($a.comoAtuamos)</p>
                </div>

                $focoHTML

                <div class="area-content-section">
                  <h2>Principais Demandas Atendidas</h2>
                  <div class="demandas-list">
                    $demandasHTML
                  </div>
                </div>

                $cenariosHTML

                <div class="area-content-section">
                  <h2>Principais Dúvidas</h2>
                  <div class="faq-list">
                    $faqHTML
                  </div>
                </div>

                $glossarioHTML

                <div class="area-content-section">
                  <h2>Fale com Nossa Equipe</h2>
                  <p>Caso tenha alguma dúvida ou precise de suporte jurídico especializado nesta área, entre em contato direto conosco pelo WhatsApp. Nosso atendimento é ágil e personalizado.</p>
                  <div style="margin-top: 24px;">
                    <a href="https://wa.me/5585992046060" target="_blank" rel="noopener noreferrer" class="btn btn-accent" style="display: inline-flex; align-items: center; gap: 8px;">
                      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M.057 24l1.687-6.163c-1.041-1.804-1.588-3.849-1.587-5.946C.06 5.348 5.397.01 12.008.01c3.202.001 6.212 1.246 8.477 3.514 2.266 2.268 3.507 5.28 3.505 8.484-.004 6.657-5.34 11.997-11.953 11.997-2.005-.001-3.973-.502-5.724-1.457L0 24zm6.59-3.483l.362.215c1.6.95 3.797 1.45 6.05 1.451 5.52 0 10.011-4.493 10.014-10.014.002-2.674-1.038-5.188-2.928-7.08C18.2 3.2 15.698 2.16 13.033 2.16c-5.528 0-10.026 4.495-10.03 10.017-.002 2.27.596 4.484 1.732 6.425l.233.394L4.01 22.188l3.637-1.67zM16.9 14.19c-.27-.134-1.59-.783-1.836-.874-.247-.09-.427-.135-.607.135-.18.27-.697.874-.853 1.054-.158.18-.315.203-.585.07-2.483-1.246-3.842-2.24-5.328-4.793-.134-.23-.202-.455-.07-.585.12-.116.27-.315.405-.472.134-.158.18-.27.27-.45.09-.18.045-.337-.022-.472-.068-.135-.608-1.464-.833-2.005-.22-.528-.439-.456-.607-.464-.157-.008-.337-.009-.517-.009-.18 0-.472.067-.72.337-.247.27-.945.923-.945 2.25s.967 2.61 1.103 2.79c.135.18 1.9 2.9 4.606 4.07.644.278 1.147.445 1.54.57.647.206 1.236.177 1.702.108.52-.078 1.592-.65 1.82-1.28.225-.63.225-1.17.157-1.283-.07-.112-.248-.18-.518-.315z"/></svg>
                      Falar com um advogado pelo WhatsApp
                    </a>
                  </div>
                </div>

              </div>

              <!-- Sidebar de Contato Direto -->
              <aside class="area-sidebar">
                <div class="sidebar-box">
                  <h3>Atendimento Especializado</h3>
                  <p>Caso tenha dúvidas em relação a este tema, fale com um advogado de nossa equipe especializada.</p>
                  <a href="https://wa.me/5585992046060" target="_blank" rel="noopener noreferrer" class="btn btn-accent" style="width: 100%; margin-bottom: 16px;">Falar pelo WhatsApp</a>
                  <a href="contato.html" class="btn btn-outline-white" style="width: 100%;">Ficha de Contato</a>
                </div>
              </aside>
              
            </div>
          </section>
"@
      }
    }
  }

  $fullHtml = Render-Layout $page $innerContent
  
  # Salva o arquivo HTML estático em formato UTF8
  $outputPath = Join-Path $PSScriptRoot $page.filename
  [System.IO.File]::WriteAllText($outputPath, $fullHtml, [System.Text.Encoding]::UTF8)
  Write-Host "Página gerada com sucesso: $($page.filename)" -ForegroundColor Green
}

# 8. Copia arquivos de CSS e JS
Copy-Item -Path "src/css/style.css" -Destination "css/style.css" -Force
Copy-Item -Path "src/js/main.js" -Destination "js/main.js" -Force
Write-Host "Ativos estáticos de CSS e JS copiados para a publicação." -ForegroundColor Green

# 9. Geração de Sitemap.xml
$urlsXML = ""
foreach ($p in $pages) {
  $priority = "0.6"
  if ($p.filename -eq "index.html") { $priority = "1.0" }
  elseif ($p.layout -eq "area-detail") { $priority = "0.8" }
  
  $urlsXML += @"
  <url>
    <loc>https://drrodrigoparente.adv.br/$($p.filename)</loc>
    <lastmod>2026-06-18</lastmod>
    <changefreq>monthly</changefreq>
    <priority>$priority</priority>
  </url>

"@
}

$sitemap = @"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
$urlsXML</urlset>
"@
[System.IO.File]::WriteAllText((Join-Path $PSScriptRoot "sitemap.xml"), $sitemap, [System.Text.Encoding]::UTF8)
Write-Host "sitemap.xml gerado com sucesso." -ForegroundColor Green

# 10. Geração de Robots.txt
$robots = @"
User-agent: *
Allow: /
Disallow: /css/
Disallow: /js/

Sitemap: https://drrodrigoparente.adv.br/sitemap.xml
"@
[System.IO.File]::WriteAllText((Join-Path $PSScriptRoot "robots.txt"), $robots, [System.Text.Encoding]::UTF8)
Write-Host "robots.txt gerado com sucesso." -ForegroundColor Green

Write-Host "Processo de compilação finalizado com êxito!" -ForegroundColor Green
