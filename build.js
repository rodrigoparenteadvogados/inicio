const fs = require('fs');
const path = require('path');
const { pages, areas } = require('./src/data/pages');
const renderLayout = require('./src/templates/layout');
const {
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
} = require('./src/templates/components');

// Cria diretórios de saída se não existirem
fs.mkdirSync(path.join(__dirname, 'css'), { recursive: true });
fs.mkdirSync(path.join(__dirname, 'js'), { recursive: true });
fs.mkdirSync(path.join(__dirname, 'img'), { recursive: true });

console.log('Compilando páginas do site Rodrigo Parente Advogados...');

// --------------------------------------------------------------------------
// TEXTOS DAS PÁGINAS LEGAIS (LGPD E TERMOS)
// --------------------------------------------------------------------------
const legalTexts = {
  privacy: `
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
  `,
  terms: `
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
  `,
  cookies: `
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
  `
};

// --------------------------------------------------------------------------
// PROCESSAMENTO E RENDERIZAÇÃO DAS PÁGINAS
// --------------------------------------------------------------------------
pages.forEach(page => {
  let innerContent = '';

  switch (page.layout) {
    case 'home':
      innerContent = `
        <!-- Hero Principal -->
        <section class="hero">
          <div class="container hero-content">
            <span class="hero-tagline">Mais de 20 anos de excelência jurídica</span>
            <h1>Escritório de Advocacia<br>Dr Rodrigo Parente<br>Advogados Especializados</h1>
            <p class="hero-subtitle">Assessoria jurídica estratégica nas esferas consultiva, administrativa e judicial para pessoas, empresas e instituições, com atendimento de excelência em todo o território nacional.</p>
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
              ${renderAreaCards(areas, 6)}
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
              ${renderTeamCards(3)}
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
      `;
      break;

    case 'about':
      innerContent = `
        <section class="page-header">
          <div class="container">
            <h1>${page.h1}</h1>
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
            <div style="background: linear-gradient(rgba(11, 37, 69, 0.9), rgba(11, 37, 69, 0.9)), url('img/escritorio.webp') center/cover no-repeat; padding: 40px; border-radius: 4px; border: 1px solid var(--border-color); border-top: 3px solid var(--accent-color); color: var(--text-light);">
              <h2 class="section-title-left" style="font-size: 1.5rem; margin-bottom: 24px; color: var(--text-light);">Diretrizes Institucionais</h2>
              
              <div style="margin-bottom: 24px;">
                <h2 style="font-family: var(--font-serif); font-size: 1.5rem; margin-bottom: 8px; font-weight: 600; color: var(--accent-color);">Missão</h2>
                <p style="font-size: 0.95rem; margin-bottom: 0; color: rgba(255, 255, 255, 0.95);">Buscar resultados para o cliente, superando expectativas por meio de serviços jurídicos de alta qualidade, proporcionando oportunidades aos colaboradores e garantindo um ambiente de trabalho ético, produtivo e colaborativo.</p>
              </div>
              
              <div>
                <h2 style="font-family: var(--font-serif); font-size: 1.5rem; margin-bottom: 8px; font-weight: 600; color: var(--accent-color);">Visão</h2>
                <p style="font-size: 0.95rem; margin-bottom: 0; color: rgba(255, 255, 255, 0.95);">Ser referência em soluções jurídicas, agregando valor aos clientes e parceiros com ética, transparência e excelência na prestação dos serviços.</p>
              </div>
            </div>
          </div>
        </section>

        <!-- Carrossel de Fotos do Escritório (Full Width) -->
        <section class="office-gallery-section" style="padding: 0 0 80px 0; overflow: hidden;">
          <div class="container" style="margin-bottom: 20px;">
            <div class="gallery-header" style="display: flex; justify-content: space-between; align-items: center;">
              <h2 class="section-title-left" style="margin-bottom: 0;">Ambiente do Nosso Escritório</h2>
              <div class="gallery-nav" style="display: flex; gap: 12px;">
                <button class="gallery-btn prev-btn" aria-label="Foto anterior" style="background: var(--primary-color); border: 1px solid var(--border-color); color: var(--accent-color); width: 44px; height: 44px; border-radius: 50%; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.3s ease; box-shadow: 0 4px 10px rgba(0,0,0,0.05);">
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="currentColor" style="transform: rotate(180deg);"><path d="M5 13h11.86l-5.43 5.43 1.42 1.42L21.14 12l-8.29-8.29-1.42 1.42 5.43 5.43H5v2z"/></svg>
                </button>
                <button class="gallery-btn next-btn" aria-label="Próxima foto" style="background: var(--primary-color); border: 1px solid var(--border-color); color: var(--accent-color); width: 44px; height: 44px; border-radius: 50%; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.3s ease; box-shadow: 0 4px 10px rgba(0,0,0,0.05);">
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M5 13h11.86l-5.43 5.43 1.42 1.42L21.14 12l-8.29-8.29-1.42 1.42 5.43 5.43H5v2z"/></svg>
                </button>
              </div>
            </div>
          </div>
          
          <div class="gallery-carousel-wrapper" style="overflow: hidden; width: 100%;">
            <div class="gallery-track" style="display: flex; gap: 0; transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94); will-change: transform;">
              <div class="gallery-card">
                <img src="img/escritorio.webp" alt="Recepção do Escritório Rodrigo Parente Advogados">
              </div>
              <div class="gallery-card">
                <img src="img/escritorio2.webp" alt="Sala de Reuniões do Escritório">
              </div>
              <div class="gallery-card">
                <img src="img/escritorio3.webp" alt="Estações de Trabalho">
              </div>
              <div class="gallery-card">
                <img src="img/escritorio4.webp" alt="Fachada e Identidade Visual">
              </div>
            </div>
          </div>
        </section>

        <!-- Grid de Valores -->
        <section class="section section-bg">
          <div class="container">
            <h2 class="section-title text-center" style="margin-bottom: 60px;">Valores</h2>
            <div class="grid-3">
              ${renderValuesCards()}
            </div>
          </div>
        </section>

        <!-- Grid de Diferenciais -->
        <section class="section">
          <div class="container">
            <h2 class="section-title text-center" style="margin-bottom: 60px;">Diferenciais</h2>
            <div class="grid-3">
              ${renderDiferenciaisCards()}
            </div>
          </div>
        </section>
      `;
      break;

    case 'areas-hub':
      innerContent = `
        <section class="page-header">
          <div class="container">
            <h1>${page.h1}</h1>
          </div>
        </section>

        <section class="section">
          <div class="container">
            <p class="text-center" style="max-width: 800px; margin: 0 auto 60px; font-size: 1.1rem; line-height: 1.8; color: var(--text-muted);">
              O Escritório de Advocacia Dr. Rodrigo Parente Advogados Especializados atua em diferentes ramos do Direito, oferecendo assessoria jurídica consultiva, administrativa e judicial para pessoas físicas, empresas e instituições.
            </p>
            <div class="grid-3">
              ${renderAreaCards(areas)}
            </div>
          </div>
        </section>
      `;
      break;

    case 'area-detail':
      // Localiza a área específica no banco de dados de áreas
      const area = areas.find(a => a.id === page.areaId);
      if (area) {
        innerContent = `
          <section class="page-header">
            <div class="container">
              <h1>${area.title}</h1>
            </div>
          </section>

          <section class="section">
            <div class="container area-layout">
              <div class="area-main-content">
                
                <div class="area-content-section">
                  <h2>Como Atuamos</h2>
                  <p>${area.comoAtuamos}</p>
                </div>

                ${area.foco && area.foco.length > 0 ? `
                <div class="area-content-section">
                  <h2>Subsegmentos de Foco Especializado</h2>
                  ${renderFocusGrid(area.foco)}
                </div>
                ` : ''}

                <div class="area-content-section">
                  <h2>Principais Demandas Atendidas</h2>
                  <div class="demandas-list">
                    ${renderDemandas(area.demandas)}
                  </div>
                </div>

                ${area.cenarios && area.cenarios.length > 0 ? `
                <div class="area-content-section">
                  <h2>Cenários Comuns de Atendimento</h2>
                  ${renderScenarios(area.cenarios)}
                </div>
                ` : ''}

                <div class="area-content-section">
                  <h2>Principais Dúvidas</h2>
                  <div class="faq-list">
                    ${renderFAQ(area.duvidas)}
                  </div>
                </div>

                ${area.glossario && area.glossario.length > 0 ? `
                <div class="area-content-section">
                  <h2>Glossário de Termos Relevantes</h2>
                  ${renderGlossary(area.glossario)}
                </div>
                ` : ''}

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
        `;
      }
      break;

    case 'team':
      innerContent = `
        <section class="page-header">
          <div class="container">
            <h1>${page.h1}</h1>
          </div>
        </section>

        <section class="section">
          <div class="container">
            <p class="text-center" style="max-width: 850px; margin: 0 auto 60px; font-size: 1.1rem; line-height: 1.8; color: var(--text-muted);">
              O escritório conta com uma equipe multidisciplinar, preparada para atuar em demandas jurídicas consultivas, administrativas e judiciais, com ética, técnica e compromisso com os interesses dos clientes.
            </p>
            <div class="team-grid">
              ${renderTeamCards()}
            </div>
          </div>
        </section>
      `;
      break;

    case 'contact':
      innerContent = `
        <section class="page-header">
          <div class="container">
            <h1>${page.h1}</h1>
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
                      <a href="https://wa.me/5585992193636" target="_blank" rel="noopener noreferrer">(85) 99219-3636</a><br>
                      <a href="https://wa.me/5585992046060" target="_blank" rel="noopener noreferrer">(85) 99204-6060</a><br>
                      <a href="https://wa.me/5585993652222" target="_blank" rel="noopener noreferrer">(85) 99365-2222</a>
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
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="currentColor"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/></svg>
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
                ${renderContactForm(areas)}
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
      `;
      break;

    case 'legal':
      innerContent = `
        <section class="page-header">
          <div class="container">
            <h1>${page.h1}</h1>
          </div>
        </section>
        
        <section class="section">
          <div class="container legal-content">
            ${legalTexts[page.legalType]}
            
            <div style="margin-top: 50px; border-top: 1px solid var(--border-color); padding-top: 30px; text-align: left;">
              <a href="index.html" class="btn btn-outline btn-sm" style="display: inline-flex; align-items: center; gap: 8px;">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="currentColor" style="transform: rotate(180deg);"><path d="M5 13h11.86l-5.43 5.43 1.42 1.42L21.14 12l-8.29-8.29-1.42 1.42 5.43 5.43H5v2z"/></svg>
                Voltar para a Página Inicial
              </a>
            </div>
          </div>
        </section>
      `;
      break;
  }

  // Gera a página completa usando o layout
  const fullHtml = renderLayout(page, innerContent, areas);
  
  // Remove a extensão .html de links internos para URLs limpas (clean URLs)
  const cleanHtml = fullHtml.replace(/(href|action)="([^"]+)\.html"/g, (match, attr, val) => {
    // Se for um link absoluto de outro domínio, mantém intacto
    if ((val.startsWith('http://') || val.startsWith('https://')) && !val.includes('drrodrigoparente.adv.br')) {
      return match;
    }
    
    // Normaliza o caminho do link removendo o domínio se houver
    const pathPart = val.replace('https://drrodrigoparente.adv.br/', '');
    
    // Se for index, mapeia para a raiz
    if (pathPart === 'index') {
      return val.includes('https://') ? `${attr}="https://drrodrigoparente.adv.br/"` : `${attr}="./"`;
    }
    
    return `${attr}="${val}"`;
  });
  
  // Escreve o arquivo na raiz
  const outputPath = path.join(__dirname, page.filename);
  fs.writeFileSync(outputPath, cleanHtml);
  console.log(`Página gerada com sucesso: ${page.filename}`);
});

// --------------------------------------------------------------------------
// CÓPIA DOS ATIVOS ESTÁTICOS
// --------------------------------------------------------------------------
fs.copyFileSync(
  path.join(__dirname, 'src', 'css', 'style.css'),
  path.join(__dirname, 'css', 'style.css')
);
fs.copyFileSync(
  path.join(__dirname, 'src', 'js', 'main.js'),
  path.join(__dirname, 'js', 'main.js')
);
console.log('Ativos estáticos (CSS e JS) copiados com sucesso.');

// --------------------------------------------------------------------------
// GERADOR DO SITEMAP.XML
// --------------------------------------------------------------------------
const sitemapUrlList = pages.map(p => {
  const locPath = p.filename === 'index.html' ? '' : p.filename.replace('.html', '');
  return `  <url>
    <loc>https://drrodrigoparente.adv.br/${locPath}</loc>
    <lastmod>2026-06-18</lastmod>
    <changefreq>monthly</changefreq>
    <priority>${p.filename === 'index.html' ? '1.0' : p.layout === 'area-detail' ? '0.8' : '0.6'}</priority>
  </url>`;
}).join('\n');

const sitemapContent = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${sitemapUrlList}
</urlset>`;

fs.writeFileSync(path.join(__dirname, 'sitemap.xml'), sitemapContent);
console.log('sitemap.xml gerado com sucesso.');

// --------------------------------------------------------------------------
// GERADOR DO ROBOTS.TXT
// --------------------------------------------------------------------------
const robotsContent = `User-agent: *
Allow: /
Disallow: /css/
Disallow: /js/

Sitemap: https://drrodrigoparente.adv.br/sitemap.xml
`;

fs.writeFileSync(path.join(__dirname, 'robots.txt'), robotsContent);
console.log('robots.txt gerado com sucesso.');

console.log('Processo de compilação finalizado com sucesso!');
