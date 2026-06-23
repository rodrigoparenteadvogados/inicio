document.addEventListener('DOMContentLoaded', () => {
  // ==========================================================================
  // HEADER SCROLL EFFECT
  // ==========================================================================
  const header = document.querySelector('.header');
  const handleScroll = () => {
    if (window.scrollY > 50) {
      header.classList.add('scrolled');
    } else {
      header.classList.remove('scrolled');
    }
  };
  window.addEventListener('scroll', handleScroll);
  handleScroll(); // Check on load

  // ==========================================================================
  // MOBILE MENU (BURGER) TOGGLE
  // ==========================================================================
  const burger = document.querySelector('.burger');
  const navMenu = document.querySelector('.nav-menu');
  
  if (burger && navMenu) {
    burger.addEventListener('click', () => {
      burger.classList.toggle('toggle');
      navMenu.classList.toggle('active');
      
      // Close dropdowns if menu is closed
      if (!navMenu.classList.contains('active')) {
        document.querySelectorAll('.nav-item').forEach(item => {
          item.classList.remove('dropdown-active');
        });
      }
    });
  }

  // ==========================================================================
  // MOBILE DROPDOWN TOGGLE
  // ==========================================================================
  const dropdownTrigger = document.querySelector('.dropdown-trigger');
  
  if (dropdownTrigger) {
    dropdownTrigger.addEventListener('click', (e) => {
      // Only trigger on mobile viewports
      if (window.innerWidth <= 992) {
        e.preventDefault();
        const parentItem = dropdownTrigger.closest('.nav-item');
        if (parentItem) {
          parentItem.classList.toggle('dropdown-active');
        }
      }
    });
  }

  // Close menu when clicking on a standard nav link (on mobile)
  const navLinks = document.querySelectorAll('.nav-link:not(.dropdown-trigger)');
  navLinks.forEach(link => {
    link.addEventListener('click', () => {
      if (window.innerWidth <= 992) {
        burger.classList.remove('toggle');
        navMenu.classList.remove('active');
      }
    });
  });

  // ==========================================================================
  // FAQ / ACCORDION TOGGLE
  // ==========================================================================
  const faqQuestions = document.querySelectorAll('.faq-question');
  
  faqQuestions.forEach(question => {
    question.addEventListener('click', () => {
      const item = question.parentElement;
      const answer = question.nextElementSibling;
      const isActive = item.classList.contains('active');
      
      // Close all other active FAQ items
      document.querySelectorAll('.faq-item').forEach(otherItem => {
        otherItem.classList.remove('active');
        otherItem.querySelector('.faq-answer').style.maxHeight = null;
      });
      
      if (!isActive) {
        item.classList.add('active');
        answer.style.maxHeight = answer.scrollHeight + 'px';
      }
    });
  });

  // ==========================================================================
  // CONTACT FORM VALIDATION & SIMULATED SUBMISSION
  // ==========================================================================
  const contactForm = document.getElementById('contact-form');
  const formMessage = document.getElementById('form-message');
  
  if (contactForm) {
    contactForm.addEventListener('submit', (e) => {
      e.preventDefault();
      
      // Basic fields validation
      const name = document.getElementById('form-name').value.trim();
      const email = document.getElementById('form-email').value.trim();
      const whatsapp = document.getElementById('form-whatsapp').value.trim();
      const city = document.getElementById('form-city').value;
      const area = document.getElementById('form-area').value;
      const message = document.getElementById('form-message-text').value.trim();
      
      if (!name || !email || !whatsapp || !city || !area || !message) {
        showFormMessage('Por favor, preencha todos os campos obrigatórios.', 'error');
        return;
      }
      
      if (!validateEmail(email)) {
        showFormMessage('Por favor, insira um e-mail válido.', 'error');
        return;
      }
      
      // Show simulated success message
      showFormMessage('Mensagem enviada com sucesso! Nossa equipe entrará em contato em breve.', 'success');
      contactForm.reset();
    });
  }
  
  function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
  }
  
  function showFormMessage(msg, type) {
    if (formMessage) {
      formMessage.textContent = msg;
      formMessage.className = 'form-message ' + type;
      
      // Scroll to the message
      formMessage.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
      
      // Hide error messages after 5 seconds, keep success messages visible
      if (type === 'error') {
        setTimeout(() => {
          formMessage.style.display = 'none';
        }, 5000);
      }
    }
  }

  // ==========================================================================
  // ACTIVE NAV ITEM ON SCROLL / LOCATION
  // ==========================================================================
  const currentPath = window.location.pathname;
  let pageName = currentPath.substring(currentPath.lastIndexOf('/') + 1);
  if (!pageName || pageName === 'index.html' || pageName === 'index') {
    pageName = 'index';
  } else {
    pageName = pageName.replace('.html', '');
  }
  
  document.querySelectorAll('.nav-item').forEach(item => {
    const link = item.querySelector('.nav-link');
    if (link) {
      let href = link.getAttribute('href');
      if (href) {
        let normalizedHref = href.replace('.html', '');
        if (normalizedHref === './' || normalizedHref === '/' || normalizedHref === '') {
          normalizedHref = 'index';
        }
        if (normalizedHref === pageName) {
          item.classList.add('active');
        } else {
          item.classList.remove('active');
        }
      }
    }
  });

  // ==========================================================================
  // BIOGRAPHY MODAL INTERACTION
  // ==========================================================================
  const modal = document.getElementById('bio-modal');
  if (modal) {
    const modalContent = modal.querySelector('.modal-content');
    const modalClose = modal.querySelector('.modal-close');
    const modalOverlay = modal.querySelector('.modal-overlay');
    const memberCards = document.querySelectorAll('.member-card[data-has-bio="true"]');
    
    if (modalContent && memberCards.length > 0) {
      memberCards.forEach(card => {
        card.addEventListener('click', () => {
          const bioData = card.querySelector('.member-bio-data');
          if (bioData) {
            modalContent.innerHTML = bioData.innerHTML;
            modal.style.display = 'flex';
            // Force reflow
            modal.offsetHeight;
            modal.classList.add('active');
            document.body.style.overflow = 'hidden'; // Lock background scroll
          }
        });
      });
      
      const closeModal = () => {
        modal.classList.remove('active');
        setTimeout(() => {
          modal.style.display = 'none';
          modalContent.innerHTML = '';
          document.body.style.overflow = ''; // Unlock background scroll
        }, 300);
      };
      
      if (modalClose) modalClose.addEventListener('click', closeModal);
      if (modalOverlay) modalOverlay.addEventListener('click', closeModal);
      
      document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && modal.classList.contains('active')) {
          closeModal();
        }
      });
    }
  }

  // ==========================================================================
  // GALLERY CAROUSEL CONTROL (1-BY-1 LARGE SLIDER WITH AUTOPLAY & WRAP-AROUND)
  // ==========================================================================
  const track = document.querySelector('.gallery-track');
  const prevBtn = document.querySelector('.prev-btn');
  const nextBtn = document.querySelector('.next-btn');
  
  if (track && prevBtn && nextBtn) {
    const cards = Array.from(track.children);
    let currentIndex = 0;
    const maxIndex = cards.length - 1;
    let autoPlayInterval;
    
    function getGapSize() {
      return 0; // no gap for full-width layout
    }
    
    function updateCarousel() {
      if (currentIndex > maxIndex) currentIndex = maxIndex;
      if (currentIndex < 0) currentIndex = 0;
      
      if (cards.length > 0) {
        const cardWidth = cards[0].getBoundingClientRect().width;
        const gap = getGapSize();
        const amountToMove = currentIndex * (cardWidth + gap);
        
        track.style.transform = `translateX(-${amountToMove}px)`;
      }
    }
    
    function nextSlide() {
      if (currentIndex < maxIndex) {
        currentIndex++;
      } else {
        currentIndex = 0; // wrap-around to start
      }
      updateCarousel();
    }
    
    // Auto-play wrapping logic (automatically transitions every 3 seconds)
    function startAutoPlay() {
      stopAutoPlay();
      autoPlayInterval = setInterval(nextSlide, 3000);
    }
    
    function stopAutoPlay() {
      if (autoPlayInterval) {
        clearInterval(autoPlayInterval);
      }
    }
    
    prevBtn.addEventListener('click', () => {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = maxIndex; // wrap-around to end
      }
      updateCarousel();
      startAutoPlay(); // reset timer
    });
    
    nextBtn.addEventListener('click', () => {
      nextSlide();
      startAutoPlay(); // reset timer
    });
    
    // Pause autoplay on mouse enter, resume on mouse leave
    const wrapper = document.querySelector('.gallery-carousel-wrapper');
    if (wrapper) {
      wrapper.addEventListener('mouseenter', stopAutoPlay);
      wrapper.addEventListener('mouseleave', startAutoPlay);
    }
    
    // Handle window resize dynamically
    let resizeTimeout;
    window.addEventListener('resize', () => {
      clearTimeout(resizeTimeout);
      resizeTimeout = setTimeout(() => {
        updateCarousel();
      }, 100);
    });
    
    // Initial load
    updateCarousel();
    startAutoPlay();
  }
});
