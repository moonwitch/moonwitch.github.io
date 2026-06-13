/*
 * Site behaviour. Accessibility-first:
 *  - Motion is OFF by default when the OS asks for reduced motion.
 *  - Every animation is opt-in via the [data-motion="on"] flag and a visible toggle.
 *  - Reveal elements are visible by default (CSS); JS only hides them to animate,
 *    so the page is fully readable even if JS or the CDN-free libs fail to load.
 */
(function () {
  "use strict";

  var root = document.documentElement;
  var prefersReduce = window.matchMedia("(prefers-reduced-motion: reduce)");

  /* ---------- Theme toggle ---------- */
  function setupTheme() {
    var btn = document.getElementById("theme-toggle");
    if (!btn) return;
    function sync() {
      var dark = root.getAttribute("data-theme") === "dark";
      btn.setAttribute("aria-pressed", String(dark));
    }
    sync();
    btn.addEventListener("click", function () {
      var next = root.getAttribute("data-theme") === "dark" ? "light" : "dark";
      root.setAttribute("data-theme", next);
      try { localStorage.setItem("theme", next); } catch (e) {}
      sync();
    });
  }

  /* ---------- Mobile navigation ---------- */
  function setupNav() {
    var toggle = document.querySelector(".nav-toggle");
    var menu = document.getElementById("primary-menu");
    if (!toggle || !menu) return;
    function close() {
      toggle.setAttribute("aria-expanded", "false");
      menu.classList.remove("is-open");
    }
    toggle.addEventListener("click", function () {
      var open = toggle.getAttribute("aria-expanded") === "true";
      toggle.setAttribute("aria-expanded", String(!open));
      menu.classList.toggle("is-open", !open);
    });
    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape") close();
    });
    menu.addEventListener("click", function (e) {
      if (e.target.closest("a")) close();
    });
  }

  /* ---------- three.js hero ---------- */
  var hero = { renderer: null, raf: null, running: false };

  function startHero() {
    var canvas = document.getElementById("hero-canvas");
    if (!canvas || typeof THREE === "undefined" || hero.running) return;

    var scene = new THREE.Scene();
    var camera = new THREE.PerspectiveCamera(60, 1, 0.1, 100);
    camera.position.z = 14;

    var renderer;
    try {
      renderer = new THREE.WebGLRenderer({ canvas: canvas, alpha: true, antialias: true });
    } catch (e) {
      // No WebGL (blocked, low-end device, headless): keep the CSS gradient fallback.
      return;
    }
    renderer.setClearColor(0x000000, 0);
    hero.renderer = renderer;

    // A gentle, slow-drifting field of points in pride-inspired hues.
    var COUNT = 900;
    var positions = new Float32Array(COUNT * 3);
    var colors = new Float32Array(COUNT * 3);
    var palette = [
      [0.90, 0.22, 0.27], [0.96, 0.64, 0.38], [0.16, 0.62, 0.56],
      [0.27, 0.48, 0.62], [0.62, 0.31, 0.87], [0.43, 0.85, 0.78]
    ];
    for (var i = 0; i < COUNT; i++) {
      positions[i * 3] = (Math.random() - 0.5) * 36;
      positions[i * 3 + 1] = (Math.random() - 0.5) * 22;
      positions[i * 3 + 2] = (Math.random() - 0.5) * 18;
      var c = palette[(Math.random() * palette.length) | 0];
      colors[i * 3] = c[0]; colors[i * 3 + 1] = c[1]; colors[i * 3 + 2] = c[2];
    }
    var geo = new THREE.BufferGeometry();
    geo.setAttribute("position", new THREE.BufferAttribute(positions, 3));
    geo.setAttribute("color", new THREE.BufferAttribute(colors, 3));
    var mat = new THREE.PointsMaterial({
      size: 0.16, vertexColors: true, transparent: true, opacity: 0.85,
      depthWrite: false, blending: THREE.AdditiveBlending
    });
    var points = new THREE.Points(geo, mat);
    scene.add(points);

    function resize() {
      var w = canvas.clientWidth || canvas.offsetWidth || 1;
      var h = canvas.clientHeight || canvas.offsetHeight || 1;
      renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 2));
      renderer.setSize(w, h, false);
      camera.aspect = w / h;
      camera.updateProjectionMatrix();
    }
    resize();
    hero._resize = resize;
    window.addEventListener("resize", resize);

    var t = 0;
    function tick() {
      t += 0.0016;
      points.rotation.y = t;
      points.rotation.x = Math.sin(t * 0.6) * 0.12;
      renderer.render(scene, camera);
      hero.raf = requestAnimationFrame(tick);
    }
    hero.running = true;
    var wrap = canvas.closest(".hero__canvas-wrap");
    if (wrap) wrap.classList.add("is-live");
    hero.wrap = wrap;
    tick();
  }

  function stopHero() {
    if (hero.raf) cancelAnimationFrame(hero.raf);
    if (hero._resize) window.removeEventListener("resize", hero._resize);
    if (hero.renderer) { hero.renderer.dispose(); hero.renderer = null; }
    if (hero.wrap) hero.wrap.classList.remove("is-live");
    hero.running = false;
  }

  /* ---------- GSAP scroll reveals ---------- */
  function startReveals() {
    var els = Array.prototype.slice.call(document.querySelectorAll("[data-reveal]"));
    if (!els.length || typeof gsap === "undefined") return;
    if (window.ScrollTrigger) gsap.registerPlugin(ScrollTrigger);
    els.forEach(function (el) {
      gsap.set(el, { opacity: 0, y: 24 });
      gsap.to(el, {
        opacity: 1, y: 0, duration: 0.7, ease: "power2.out",
        scrollTrigger: window.ScrollTrigger
          ? { trigger: el, start: "top 88%", once: true }
          : undefined
      });
    });
  }

  function stopReveals() {
    if (typeof gsap === "undefined") return;
    if (window.ScrollTrigger && ScrollTrigger.getAll) {
      ScrollTrigger.getAll().forEach(function (s) { s.kill(); });
    }
    var els = document.querySelectorAll("[data-reveal]");
    els.forEach(function (el) { gsap.set(el, { clearProps: "all" }); });
  }

  /* ---------- Motion orchestration ---------- */
  function motionOn() { return root.getAttribute("data-motion") === "on"; }

  function applyMotion() {
    if (motionOn()) {
      startReveals();
      startHero();
    } else {
      stopReveals();
      stopHero();
    }
  }

  function setupMotionToggle() {
    var btn = document.getElementById("motion-toggle");
    if (!btn) return;
    function sync() { btn.setAttribute("aria-pressed", String(motionOn())); }
    sync();
    btn.addEventListener("click", function () {
      var next = motionOn() ? "off" : "on";
      root.setAttribute("data-motion", next);
      try { localStorage.setItem("motion", next); } catch (e) {}
      sync();
      applyMotion();
    });
    // If the OS preference changes mid-session and the user hasn't overridden it.
    prefersReduce.addEventListener("change", function (e) {
      var hasOverride = false;
      try { hasOverride = !!localStorage.getItem("motion"); } catch (err) {}
      if (hasOverride) return;
      root.setAttribute("data-motion", e.matches ? "off" : "on");
      sync();
      applyMotion();
    });
  }

  function init() {
    setupTheme();
    setupNav();
    setupMotionToggle();
    applyMotion();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
