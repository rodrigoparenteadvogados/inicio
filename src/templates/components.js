// Gerador de componentes HTML modulares para reutilização nas páginas.

// 1. Gera os itens de breadcrumb
function renderBreadcrumbs(breadcrumbs) {
  if (!breadcrumbs || breadcrumbs.length === 0) return '';
  
  const itemsHTML = breadcrumbs.map((crumb, idx) => {
    const isLast = idx === breadcrumbs.length - 1;
    if (isLast) {
      return `<span class="current" aria-current="page">${crumb.label}</span>`;
    }
    return `<a href="${crumb.href}">${crumb.label}</a> <span class="separator">/</span>`;
  }).join(' ');

  return `
    <div class="breadcrumbs-container">
      <div class="container">
        <nav class="breadcrumbs" aria-label="Breadcrumb">
          ${itemsHTML}
        </nav>
      </div>
    </div>
  `;
}

// 2. Gera os links do dropdown de áreas de atuação
function renderDropdownItems(areas) {
  return areas.map(area => `
    <li class="dropdown-item">
      <a href="${area.href}" class="dropdown-link">${area.title}</a>
    </li>
  `).join('');
}

// 3. Gera os cards das áreas de atuação
function renderAreaCards(areas, limit = null) {
  const list = limit ? areas.slice(0, limit) : areas;
  return list.map(area => `
    <div class="card">
      <div class="card-icon">
        ${area.icon}
      </div>
      <h3 class="card-title">${area.title}</h3>
      <p class="card-text">${area.summary}</p>
      <a href="${area.href}" class="card-link">
        Saiba Mais
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path d="M12 4l-1.41 1.41L16.17 11H4v2h12.17l-5.58 5.59L12 20l8-8z"/></svg>
      </a>
    </div>
  `).join('');
}

function renderTeamCards(limit = null) {
  const team = [
    {
      name: "Dr. Rodrigo Parente",
      role: "Advogado e Proprietário",
      oab: "OAB/CE 38.940",
      isStudent: false,
      image: "img/rodrigo.webp",
      bio: `
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
            <li><span>🌐</span> Advogado com amplo conhecimento jurídico em Direito Constitucional, Direito Civil e Processo Civil, Direito Bancário, Direito de Família, Direito Contratual e Direito Empresarial</li>
            <li><span>🌐</span> Profissional extremamente competente e preparado em constante processo de Aperfeiçoamento</li>
            <li><span>🌐</span> Presente nos debates jurídicos em Rádios e Revistas</li>
            <li><span>🌐</span> Profissional extremamente competente e preparado com ampla participação nas reuniões da Ordem dos Advogados do Brasil</li>
            <li><span>🌐</span> Estudioso de teses inovadoras e contemporâneas no Âmbito do Direito Constitucional, Direito Empresarial, Direito Bancário, Direito do Consumidor e Direito de Família</li>
          </ul>
        </div>
      `
    },
    {
      name: "Dra. Laura Grangeiro",
      role: "Advogada Associada",
      oab: "OAB/CE 32.465",
      isStudent: false,
      image: "img/laura.webp",
      bio: `
        <h3 class="bio-title">Dra. Laura Grangeiro</h3>
        <p class="bio-subtitle">Equipe do Escritório</p>
        <div class="bio-text">
          <p>Advogada com vasta experiência jurídica.</p>
          <p>Especializada em diversas áreas do conhecimento jurídico.</p>
          <ul class="bio-highlights">
            <li><span>🌐</span> Advogada extremamente competente e preparada com vasta experiência em Soluções Jurídicas Inovadoras</li>
            <li><span>🌐</span> Profissional extremamente competente e preparada</li>
          </ul>
        </div>
      `
    },
    {
      name: "Dra. Evelin Rodrigues",
      role: "Advogada Associada",
      oab: "OAB/CE 54.390",
      isStudent: false,
      image: "img/evelin.webp",
      bio: `
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
      `
    },
    {
      name: "Dr. Jhonatan Marques",
      role: "Corpo Jurídico",
      oab: "Economista & Graduando em Direito",
      isStudent: false,
      image: "img/johnatan.webp",
      bio: `
        <h3 class="bio-title">Dr. Jhonatan Marques</h3>
        <p class="bio-subtitle">Corpo Jurídico / Economista</p>
        <div class="bio-text">
          <p>Economista formado pela Universidade Federal do Ceará e Graduando em Direito. Especialista na análise de juros abusivos e defesa contratual de pessoas físicas, servidores públicos e empresários.</p>
          <ul class="bio-highlights">
            <li><span>🌐</span> Economista graduado pela UFC com vasta experiência em análise de juros e avaliação de contratos bancários complexos</li>
            <li><span>🌐</span> Estudos aprofundados em Juros Bancários, Práticas Abusivas dos Bancos e o processo de Superendividamento</li>
            <li><span>🌐</span> Avaliação de juros abusivos em empréstimos bancários e contratos de empresas e empresários</li>
            <li><span>🌐</span> Estudo sobre os impactos do juros abusivos na vida dos Servidores Públicos Concursados</li>
            <li><span>🌐</span> Graduando em Direito com estudos aprofundados sobre Direito Constitucional e Direito Bancário</li>
          </ul>
        </div>
      `
    },
    {
      name: "Dra. Ketyllem Vasconcelos",
      role: "Advogada Associada",
      oab: "Graduanda em Direito",
      isStudent: false,
      image: "img/ketyllem.webp",
      bio: `
        <h3 class="bio-title">Dra. Ketyllem Vasconcelos</h3>
        <p class="bio-subtitle">Equipe do Escritório / Graduanda em Direito</p>
        <div class="bio-text">
          <p>Graduanda em Direito com foco em estudos regulatórios, direito contratual e bancário.</p>
          <ul class="bio-highlights">
            <li><span>🌐</span> Experiência em avaliação de Contratos de Financiamento de Veículos e Financiamento Habitacional</li>
            <li><span>🌐</span> Avaliação preliminar de contratos de Financiamento de Veículos e Financiamento Habitacional</li>
            <li><span>🌐</span> Análise de juros em Empréstimos Consignados e Empréstimos Pessoais</li>
            <li><span>🌐</span> Estudos avançados em Direito Bancário, Direito Constitucional, Direito Civil e Direito Tributário</li>
            <li><span>🌐</span> Profissional em constante processo de aperfeiçoamento</li>
          </ul>
        </div>
      `
    },
    {
      name: "Dra. Ana Laura Braz de Oliveira",
      role: "Especializada em Transações Imobiliárias",
      oab: "",
      isStudent: false,
      image: "img/andreyna.webp"
    }
  ];

  const list = limit ? team.slice(0, limit) : team;
  return list.map(member => {
    const hasBio = !!member.bio;
    let width = 640;
    let height = 480;
    if (member.image === 'img/rodrigo.webp') { width = 640; height = 640; }
    else if (member.image === 'img/laura.webp') { width = 639; height = 428; }
    else if (member.image === 'img/evelin.webp') { width = 1283; height = 1283; }
    else if (member.image === 'img/andreyna.webp') { width = 426; height = 639; }
    else if (member.image === 'img/ketyllem.webp') { width = 1161; height = 913; }
    else if (member.image === 'img/johnatan.webp') { width = 1200; height = 1285; }

    const imgHTML = member.image
      ? `<img src="${member.image}" alt="${member.name}" class="member-img" width="${width}" height="${height}" loading="lazy">`
      : `<div class="member-placeholder">
          <svg viewBox="0 0 24 24">
            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
          </svg>
          <span>Espaço para Foto</span>
        </div>`;
    return `
    <div class="member-card" ${hasBio ? 'data-has-bio="true"' : ''}>
      <div class="member-img-wrap">
        ${imgHTML}
        ${hasBio ? `
        <div class="member-bio-overlay">
          <span class="btn btn-accent btn-sm">Ver Biografia</span>
        </div>
        ` : ''}
      </div>
      <div class="member-info">
        <h3 class="member-name">${member.name}</h3>
        <p class="member-role">${member.role}</p>
        <span class="member-oab">${member.oab}</span>
        ${hasBio ? `<div class="member-bio-link">Ver Biografia &rarr;</div>` : ''}
      </div>
      ${hasBio ? `<div class="member-bio-data" style="display: none;">${member.bio}</div>` : ''}
    </div>
  `;
  }).join('');
}

// 5. Gera os cards de Valores
function renderValuesCards() {
  const values = [
    { title: "Ética e Integridade", text: "Atuação intransigente sob os mais estritos princípios morais e regras da OAB." },
    { title: "Transparência", text: "Manter o cliente plenamente informado e atualizado sobre o andamento e estratégias do seu caso." },
    { title: "Excelência Técnica", text: "Estudo aprofundado de cada causa para oferecer soluções jurídicas precisas e eficazes." },
    { title: "Comprometimento", text: "Dedicação integral no alcance dos melhores interesses dos clientes em todas as instâncias." },
    { title: "Respeito às Pessoas", text: "Atendimento acolhedor, empático e humanizado voltado a compreender as demandas individuais." },
    { title: "Inovação e Atualização", text: "Uso de novas tecnologias e constante atualização perante a jurisprudência contemporânea." },
    { title: "Responsabilidade e Confiança", text: "Relações pautadas pela segurança jurídica, lealdade profissional e confidencialidade." }
  ];
  return values.map(val => `
    <div class="value-card">
      <h3>${val.title}</h3>
      <p>${val.text}</p>
    </div>
  `).join('');
}

// 6. Gera os cards de Diferenciais
function renderDiferenciaisCards() {
  const diffs = [
    { title: "Atendimento Personalizado", text: "Projetos de consultoria e patrocínio desenhados sob medida para o perfil do cliente." },
    { title: "Estratégias Jurídicas Sob Medida", text: "Defesas técnicas elaboradas a partir do contexto econômico e fático específico de cada caso." },
    { title: "Equipe Multidisciplinar", text: "Profissionais com conhecimentos integrados em Direito, Economia e Negócios para assessoria completa." },
    { title: "Atuação Consultiva, Administrativa e Judicial", text: "Amplo espectro de atuação cobrindo desde a prevenção até o contencioso mais complexo." },
    { title: "Experiência em Demandas Complexas", text: "Histórico consolidado de êxito na condução de processos burocráticos e regulatórios desafiadores." },
    { title: "Rede de Parceiros em todo o Brasil", text: "Parcerias consolidadas com escritórios correspondentes para atendimento ágil em todo território nacional." },
    { title: "Visão Empresarial e Estratégica", text: "Foco prático em viabilizar operações comerciais reduzindo custos tributários e burocráticos." }
  ];
  return diffs.map(diff => `
    <div class="value-card">
      <h3>${diff.title}</h3>
      <p>${diff.text}</p>
    </div>
  `).join('');
}

// 7. Gera sanfonas do FAQ (Perguntas Frequentes) para áreas de atuação
function renderFAQ(duvidas) {
  if (!duvidas || duvidas.length === 0) return '';
  return duvidas.map(d => `
    <div class="faq-item">
      <button class="faq-question" aria-expanded="false">
        ${d.q}
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" aria-hidden="true" focusable="false"><path d="M7 10l5 5 5-5z"/></svg>
      </button>
      <div class="faq-answer">
        <div class="faq-answer-inner">
          <p>${d.a}</p>
        </div>
      </div>
    </div>
  `).join('');
}

// 8. Gera lista de demandas atendidas com marcadores dourados
function renderDemandas(demandas) {
  if (!demandas || demandas.length === 0) return '';
  return demandas.map(dem => `
    <div class="demanda-item">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="18" height="18" aria-hidden="true" focusable="false"><path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/></svg>
      <span>${dem}</span>
    </div>
  `).join('');
}

// 9. Gera o formulário de contato padrão
function renderContactForm(areas) {
  const optionsHTML = areas.map(area => `
    <option value="${area.id}">${area.title}</option>
  `).join('');
  
  return `
    <form id="contact-form" class="contact-form" novalidate>
      <!-- Configuração do Formspree para envio de e-mail (Crie seu formulário em formspree.io e insira o ID abaixo) -->
      <input type="hidden" name="formspree_id" value="YOUR_FORMSPREE_ID_HERE">
      
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
          ${optionsHTML}
          <option value="Outros">Outras Demandas / Consultoria Geral</option>
        </select>
      </div>
      
      <div class="form-group">
        <label for="form-message-text" class="form-label">Mensagem *</label>
        <textarea id="form-message-text" class="form-control" placeholder="Descreva brevemente sua situação para direcionamento adequado." required></textarea>
      </div>
      
      <button type="submit" class="btn btn-primary btn-block">Enviar Mensagem</button>
      
      <div id="form-message" class="form-message" role="alert"></div>
    </form>
  `;
}

// 9.5. Gera o formulário de Trabalhe Conosco
function renderJobsForm() {
  return `
    <form id="job-form" class="contact-form" enctype="multipart/form-data" novalidate>
      <!-- Configuração do Formspree para envio de e-mail -->
      <input type="hidden" name="formspree_id" value="YOUR_FORMSPREE_ID_HERE">
      
      <div class="form-row">
        <div class="form-group">
          <label for="job-name" class="form-label">Nome Completo *</label>
          <input type="text" id="job-name" name="name" class="form-control" placeholder="Seu nome completo" required>
        </div>
        <div class="form-group">
          <label for="job-email" class="form-label">E-mail *</label>
          <input type="email" id="job-email" name="email" class="form-control" placeholder="Seu e-mail" required>
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label for="job-whatsapp" class="form-label">WhatsApp *</label>
          <input type="tel" id="job-whatsapp" name="whatsapp" class="form-control" placeholder="(85) 99999-9999" required>
        </div>
        <div class="form-group">
          <label for="job-area" class="form-label">Área de Interesse *</label>
          <select id="job-area" name="area" class="form-control" required>
            <option value="" disabled selected>Selecione a área</option>
            <option value="Advogado">Advogado(a)</option>
            <option value="Estagiário">Estagiário(a)</option>
            <option value="Administrativo">Setor Administrativo</option>
            <option value="Outro">Outra Área</option>
          </select>
        </div>
      </div>
      
      <div class="form-group">
        <label for="job-cv" class="form-label">Anexar Currículo (PDF, DOC ou DOCX) *</label>
        <input type="file" id="job-cv" name="cv" accept=".pdf,.doc,.docx" class="form-control" required>
      </div>
      
      <div class="form-group">
        <label for="job-message" class="form-label">Mensagem de Apresentação (Opcional)</label>
        <textarea id="job-message" name="message" class="form-control" placeholder="Fale brevemente sobre sua trajetória ou objetivos profissionais."></textarea>
      </div>
      
      <button type="submit" class="btn btn-primary btn-block">Enviar Currículo</button>
      
      <div id="job-form-message" class="form-message" role="alert"></div>
    </form>
  `;
}

// 10. Gera a lista de cenários comuns de atendimento
function renderScenarios(cenarios) {
  if (!cenarios || cenarios.length === 0) return '';
  return `
    <div class="scenarios-list">
      ${cenarios.map(c => `
        <div class="scenario-card">
          <h3 class="scenario-title">${c.title}</h3>
          <p class="scenario-desc">${c.desc}</p>
        </div>
      `).join('')}
    </div>
  `;
}

// 11. Gera a lista do glossário jurídico
function renderGlossary(glossario) {
  if (!glossario || glossario.length === 0) return '';
  return `
    <div class="glossary-list">
      ${glossario.map(g => `
        <div class="glossary-item">
          <strong class="glossary-term">${g.term}</strong>: 
          <span class="glossary-definition">${g.definition}</span>
        </div>
      `).join('')}
    </div>
  `;
}

// 12. Gera a grade de subsegmentos de foco especializado
function renderFocusGrid(foco) {
  if (!foco || foco.length === 0) return '';
  const cards = foco.map(f => `
    <div class="focus-card">
      <h3 class="focus-card-title">${f.title}</h3>
      <p class="focus-card-desc">${f.desc}</p>
    </div>
  `).join('');
  return `
    <div class="focus-grid">
      ${cards}
    </div>
  `;
}

module.exports = {
  renderBreadcrumbs,
  renderDropdownItems,
  renderAreaCards,
  renderTeamCards,
  renderValuesCards,
  renderDiferenciaisCards,
  renderFAQ,
  renderDemandas,
  renderContactForm,
  renderScenarios,
  renderGlossary,
  renderFocusGrid
};

