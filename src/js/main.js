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
  // ==========================================================================
  // GALLERY CAROUSEL CONTROL (SEAMLESS INFINITE LOOP CAROUSEL WITH 2s AUTOPLAY)
  // ==========================================================================
  const track = document.querySelector('.gallery-track');
  const prevBtn = document.querySelector('.prev-btn');
  const nextBtn = document.querySelector('.next-btn');
  
  if (track && prevBtn && nextBtn) {
    const originalCards = Array.from(track.children);
    if (originalCards.length > 0) {
      // 1. Clone elements to create seamless infinite loop
      const firstClone = originalCards[0].cloneNode(true);
      const lastClone = originalCards[originalCards.length - 1].cloneNode(true);
      
      firstClone.classList.add('clone');
      lastClone.classList.add('clone');
      
      track.appendChild(firstClone);
      track.insertBefore(lastClone, originalCards[0]);
      
      const cards = Array.from(track.children);
      let currentIndex = 1; // Start on first original slide
      let isTransitioning = false;
      let autoPlayInterval;
      
      // Set initial position immediately without transition
      track.style.transition = 'none';
      const initialWidth = originalCards[0].getBoundingClientRect().width;
      track.style.transform = `translateX(-${currentIndex * initialWidth}px)`;
      // Force reflow
      track.offsetHeight;
      
      function updateCarousel(withTransition = true) {
        if (cards.length > 0) {
          const width = cards[0].getBoundingClientRect().width;
          if (withTransition) {
            track.style.transition = 'transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94)';
          } else {
            track.style.transition = 'none';
          }
          track.style.transform = `translateX(-${currentIndex * width}px)`;
        }
      }
      
      function nextSlide() {
        if (isTransitioning) return;
        isTransitioning = true;
        currentIndex++;
        updateCarousel(true);
      }
      
      function prevSlide() {
        if (isTransitioning) return;
        isTransitioning = true;
        currentIndex--;
        updateCarousel(true);
      }
      
      // Listen to transitionend to handle instant jumps at loop boundaries
      track.addEventListener('transitionend', () => {
        isTransitioning = false;
        
        // If we reach the clone of the first slide, jump back to index 1 (the real first slide)
        if (currentIndex === cards.length - 1) {
          currentIndex = 1;
          updateCarousel(false);
        }
        
        // If we reach the clone of the last slide, jump forward to index cards.length - 2 (the real last slide)
        if (currentIndex === 0) {
          currentIndex = cards.length - 2;
          updateCarousel(false);
        }
      });
      
      // Auto-play wrapping logic (automatically transitions every 2 seconds)
      function startAutoPlay() {
        stopAutoPlay();
        autoPlayInterval = setInterval(nextSlide, 2000);
      }
      
      function stopAutoPlay() {
        if (autoPlayInterval) {
          clearInterval(autoPlayInterval);
        }
      }
      
      prevBtn.addEventListener('click', () => {
        prevSlide();
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
          updateCarousel(false);
        }, 100);
      });
      
      // Initial load
      startAutoPlay();
    }
  }
});
