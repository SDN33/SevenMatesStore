import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }

// Pop-up de consentement aux cookies
document.addEventListener('DOMContentLoaded', function () {
  if (!getCookie('cookiesAccepted') && !getCookie('cookiesRejected')) {
    document.getElementById('cookie-popup').style.display = 'block';
  }

  document.getElementById('accept-cookies').addEventListener('click', function () {
    setCookie('cookiesAccepted', 'true', 365);
    document.getElementById('cookie-popup').style.display = 'none';
    enableTrackingCookies();
  });

  document.getElementById('reject-cookies').addEventListener('click', function () {
    setCookie('cookiesRejected', 'true', 365);
    document.getElementById('cookie-popup').style.display = 'none';
    disableTrackingCookies();
  });

  function setCookie(name, value, days) {
    var expires = "";
    if (days) {
      var date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
      expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
  }

  function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0) === ' ') c = c.substring(1, c.length);
      if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
  }

  function enableTrackingCookies() {
    // Insérez ici le code pour activer les cookies de suivi, comme Google Analytics
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-XXXXX-Y', 'auto');
    ga('send', 'pageview');
  }

  function disableTrackingCookies() {
    // Désactivez les cookies de suivi en bloquant les scripts de suivi
    // Pour Google Analytics, vous pouvez ajouter le script suivant
    window['ga-disable-UA-XXXXX-Y'] = true;

    // Supprimez les cookies existants de Google Analytics
    document.cookie = '_ga=; Max-Age=-99999999;';
    document.cookie = '_gid=; Max-Age=-99999999;';
    document.cookie = '_gat=; Max-Age=-99999999;';
  }
});

// Pop-up code promo
document.addEventListener('DOMContentLoaded', function() {
  var userSignedIn = document.body.getAttribute('data-user-signed-in') === 'true';

  // Vérifie si le pop-up a déjà été affiché
  var promoPopupShown = getCookie('promoPopupShown');

  // Si l'utilisateur n'est pas connecté et que le pop-up n'a pas été montré
  if (!userSignedIn && !promoPopupShown) {
    setTimeout(function() {
      var popup = document.getElementById('codepromo-popup');
      if (popup) {
        popup.classList.remove('hidden');
      }
    }, 15000);

    // Marquer le pop-up comme affiché dans les cookies
    setCookie('promoPopupShown', 'true', 0.5); // 0.5 jour = 12 heures
  }

  var closeBtn = document.getElementById('codepromo-popup-close');
  if (closeBtn) {
    closeBtn.addEventListener('click', function() {
      var popup = document.getElementById('codepromo-popup');
      if (popup) {
        popup.classList.add('hidden');
      }

      // Réafficher le pop-up toutes les 30 minutes après la première fermeture
      setTimeout(function() {
        setCookie('promoPopupShown', '', 0); // Supprimer le cookie
      }, 30 * 60 * 1000); // 30 minutes
    });
  }

  function setCookie(name, value, days) {
    var expires = "";
    if (days) {
      var date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
      expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
  }

  function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0) === ' ') c = c.substring(1, c.length);
      if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
  }
});
