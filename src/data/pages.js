// Importa a lista de áreas de atuação
const areas = require('./areas');

// Configurações de metadados das páginas institucionais principais
const corePages = [
  {
    filename: "index.html",
    layout: "home",
    title: "Advocacia Estratégica no Ceará | Rodrigo Parente Advogados",
    metaDescription: "Escritório de advocacia com atuação consultiva, administrativa e judicial em Fortaleza e Sobral/CE. Mais de 20 anos de experiência jurídica de excelência.",
    h1: "Advocacia Estratégica e Assessoria Jurídica Especializada no Ceará",
    breadcrumbs: []
  },
  {
    filename: "o-escritorio.html",
    layout: "about",
    title: "Sobre o Escritório | Rodrigo Parente Advogados Especializados",
    metaDescription: "Conheça a história de mais de 20 anos de excelência, nossa missão, visão, valores e diferenciais no atendimento jurídico estratégico no Ceará.",
    h1: "Conheça o Escritório Rodrigo Parente Advogados Especializados",
    breadcrumbs: [
      { label: "Home", href: "index.html" },
      { label: "O Escritório", href: "o-escritorio.html" }
    ]
  },
  {
    filename: "areas-de-atuacao.html",
    layout: "areas-hub",
    title: "Áreas de Atuação Jurídica | Rodrigo Parente Advogados",
    metaDescription: "Confira nossas especialidades jurídicas. Oferecemos assessoria consultiva, administrativa e judicial para pessoas físicas, empresas e instituições.",
    h1: "Áreas de Atuação Jurídica",
    breadcrumbs: [
      { label: "Home", href: "index.html" },
      { label: "Áreas de Atuação", href: "areas-de-atuacao.html" }
    ]
  },
  {
    filename: "equipe.html",
    layout: "team",
    title: "Nossa Equipe Jurídica | Rodrigo Parente Advogados",
    metaDescription: "Conheça nosso corpo jurídico multidisciplinar focado em ética, técnica e dedicação aos interesses de nossos clientes em Sobral e Fortaleza.",
    h1: "Nossa Equipe",
    breadcrumbs: [
      { label: "Home", href: "index.html" },
      { label: "Equipe", href: "equipe.html" }
    ]
  },
  {
    filename: "contato.html",
    layout: "contact",
    title: "Contato | Escritório Rodrigo Parente Advogados",
    metaDescription: "Fale com nossa equipe jurídica. Atendimento presencial nas unidades de Sobral e Fortaleza/CE, e atendimento consultivo online nacional.",
    h1: "Entre em Contato",
    breadcrumbs: [
      { label: "Home", href: "index.html" },
      { label: "Contato", href: "contato.html" }
    ]
  },
  // Páginas Legais
  {
    filename: "politica-de-privacidade.html",
    layout: "legal",
    title: "Política de Privacidade | Rodrigo Parente Advogados",
    metaDescription: "Política de privacidade do Escritório de Advocacia Dr. Rodrigo Parente Advogados Especializados em conformidade com a LGPD.",
    h1: "Política de Privacidade",
    breadcrumbs: [
      { label: "Home", href: "index.html" },
      { label: "Privacidade", href: "politica-de-privacidade.html" }
    ],
    legalType: "privacy"
  },
  {
    filename: "termos-de-uso.html",
    layout: "legal",
    title: "Termos de Uso | Rodrigo Parente Advogados",
    metaDescription: "Termos de uso do website institucional do Escritório de Advocacia Dr. Rodrigo Parente Advogados Especializados.",
    h1: "Termos de Uso",
    breadcrumbs: [
      { label: "Home", href: "index.html" },
      { label: "Termos de Uso", href: "termos-de-uso.html" }
    ],
    legalType: "terms"
  },
  {
    filename: "politica-de-cookies.html",
    layout: "legal",
    title: "Política de Cookies | Rodrigo Parente Advogados",
    metaDescription: "Saiba como e por que utilizamos cookies no site do Escritório de Advocacia Dr. Rodrigo Parente Advogados Especializados.",
    h1: "Política de Cookies",
    breadcrumbs: [
      { label: "Home", href: "index.html" },
      { label: "Cookies", href: "politica-de-cookies.html" }
    ],
    legalType: "cookies"
  }
];

// Gera dinamicamente as páginas individuais das áreas de atuação
const areaPages = areas.map(area => ({
  filename: `${area.id}.html`,
  layout: "area-detail",
  title: `${area.title} no Ceará | Rodrigo Parente Advogados`,
  metaDescription: `Assessoria e consultoria jurídica especializada em ${area.title} em Sobral, Fortaleza e Ceará. Atendimento consultivo, administrativo e judicial.`,
  h1: area.title,
  areaId: area.id,
  breadcrumbs: [
    { label: "Home", href: "index.html" },
    { label: "Áreas de Atuação", href: "areas-de-atuacao.html" },
    { label: area.title, href: `${area.id}.html` }
  ]
}));

// Combina todas as configurações de páginas em um único array
const allPages = [...corePages, ...areaPages];

module.exports = {
  pages: allPages,
  areas: areas
};
