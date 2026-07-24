# goatie-audit toolkit — paste-ready instruments

Everything here runs in the page context (browser JS eval). Measurements
come back as JSON; quote them in findings.

## 1. Color-vision simulation

Inject once, then apply/remove per mode. Screenshot each mode.

```js
// Inject SVG filters for CVD simulation (Machado-style matrices)
(() => {
  if (document.getElementById('goatie-cvd')) return 'already injected';
  const svg = document.createElementNS('http://www.w3.org/2000/svg','svg');
  svg.id = 'goatie-cvd'; svg.style.position='absolute'; svg.style.width='0'; svg.style.height='0';
  svg.innerHTML = `
    <filter id="g-protanopia"><feColorMatrix type="matrix" values="0.567 0.433 0 0 0  0.558 0.442 0 0 0  0 0.242 0.758 0 0  0 0 0 1 0"/></filter>
    <filter id="g-deuteranopia"><feColorMatrix type="matrix" values="0.625 0.375 0 0 0  0.7 0.3 0 0 0  0 0.3 0.7 0 0  0 0 0 1 0"/></filter>
    <filter id="g-tritanopia"><feColorMatrix type="matrix" values="0.95 0.05 0 0 0  0 0.433 0.567 0 0  0 0.475 0.525 0 0  0 0 0 1 0"/></filter>`;
  document.body.appendChild(svg); return 'injected';
})();
```

```js
// Apply one: 'g-protanopia' | 'g-deuteranopia' | 'g-tritanopia' | 'grayscale' | 'off'
(mode => {
  const h = document.documentElement;
  h.style.filter = mode === 'off' ? '' : mode === 'grayscale' ? 'saturate(0)' : `url(#${mode})`;
  return mode;
})('grayscale');
```

The check per mode: are states, series, links, and validation still
distinguishable? If two things differ only by hue, they are now the
same thing — finding.

## 2. Surface, grid & contrast measurement

Computed colors may come back as `lab()`/`oklab()`; normalize through a
canvas before doing math.

```js
(() => {
  const ctx = document.createElement('canvas').getContext('2d');
  const rgb = c => { ctx.fillStyle = '#000'; ctx.fillStyle = c;
    const m = ctx.fillStyle.match(/\d+(\.\d+)?/g); return m ? m.slice(0,3).map(Number) : null; };
  const lum = ([r,g,b]) => { [r,g,b]=[r,g,b].map(v=>{v/=255; return v<=0.03928? v/12.92 : ((v+0.055)/1.055)**2.4});
    return 0.2126*r+0.7152*g+0.0722*b; };
  const ratio = (a,b) => { const [x,y]=[lum(a),lum(b)].sort((p,q)=>q-p); return +((x+0.05)/(y+0.05)).toFixed(2); };
  const Lstar = c => { const y=lum(c); return +(y>0.008856 ? 116*Math.cbrt(y)-16 : 903.3*y).toFixed(1); };
  const bgOf = el => { for (let e=el; e; e=e.parentElement) {
    const c = rgb(getComputedStyle(e).backgroundColor);
    if (c && getComputedStyle(e).backgroundColor !== 'rgba(0, 0, 0, 0)') return c; } return rgb('#fff'); };
  const cs = el => el ? getComputedStyle(el) : null;

  // --- surfaces: canvas vs nav vs first cards ---
  const canvas = rgb(cs(document.body).backgroundColor);
  const header = document.querySelector('header, nav');
  const cards = [...document.querySelectorAll('main div, section, article')]
    .filter(d => { const s=cs(d); return s.borderRadius !== '0px' || s.boxShadow !== 'none'; }).slice(0,3);
  // --- one-grid: left edges of chrome vs content ---
  const edges = [...new Set(
    [header?.firstElementChild, document.querySelector('main'),
     ...document.querySelectorAll('[role=tablist], .tabs, main > div')]
    .filter(Boolean).map(e => Math.round(e.getBoundingClientRect().left)))];
  // --- contrast: body text, muted text, buttons (incl. disabled) ---
  const sample = el => el && { text: el.textContent.trim().slice(0,30),
    ratio: ratio(rgb(cs(el).color), bgOf(el)) };
  const p = document.querySelector('main p, p');
  const muted = [...document.querySelectorAll('p, span, small')].find(e => Lstar(rgb(cs(e).color)) > 35 && Lstar(rgb(cs(e).color)) < 65);
  const btns = [...document.querySelectorAll('button')].slice(0,4).map(sample);

  return JSON.stringify({
    canvasL: Lstar(canvas),
    headerL: header ? Lstar(bgOf(header)) : null,
    cardLs: cards.map(c => Lstar(bgOf(c))),
    leftEdges: edges,                    // >1 distinct value = grid finding
    bodyText: sample(p),                 // < 4.5 = finding
    mutedText: sample(muted),            // borderline = finding, not a pass
    buttons: btns,
  }, null, 1);
})();
```

Reading it: `canvasL` vs `headerL`/`cardLs` within ~3 L* = flat.
`canvasL` > ~97 or < ~5 with content sitting directly on it = glare /
void. `leftEdges` length > 1 = chrome and content off-grid.

## 3. Performance sampling (prod build only)

```js
// After a cold reload of the route under test:
JSON.stringify({
  nav: (({domContentLoadedEventEnd: dcl, loadEventEnd: load, responseStart: ttfb}) =>
        ({ttfb: Math.round(ttfb), dcl: Math.round(dcl), load: Math.round(load)}))
       (performance.getEntriesByType('navigation')[0]),
  paints: performance.getEntriesByType('paint').map(p => ({[p.name]: Math.round(p.startTime)})),
  lcp: Math.round(performance.getEntriesByType('largest-contentful-paint').pop()?.startTime ?? -1),
  cls: +performance.getEntriesByType('layout-shift')
        .filter(e => !e.hadRecentInput).reduce((s,e) => s+e.value, 0).toFixed(3),
}, null, 1)
```

For input delay: click the primary action, then read
`performance.getEntriesByType('event')` durations, or simply time
click→visible-feedback across two screenshots. Dev-mode numbers are
inadmissible — say "dev build, scored structurally" instead of quoting
them.

## 4. Evidence conventions

```
.goatie/
  evidence/<YYYY-MM-DD>/
    <route-with-dashes>--<viewport>--<mode>.png   e.g. play-score--mobile--dark.png
    <route-with-dashes>--<state>.png              e.g. play-home--empty.png
  audit-<YYYY-MM-DD>.json
```

Every finding cites its receipt filename. The gallery is publishable as
an artifact on request.

## 5. Baseline schema

```json
{
  "date": "YYYY-MM-DD",
  "commit": "<git sha if available>",
  "coverage": { "renderedPct": 0, "personasWalked": [], "modes": [], "build": "prod|dev" },
  "surfaces": { "<surface>": { "audience": "", "score": 0 } },
  "categories": { "purpose": 0, "workflow": 0, "navigation": 0, "cognitive": 0,
                  "hierarchy": 0, "feedback": 0, "onboarding": 0, "errors": 0,
                  "control": 0, "performance": 0 },
  "overall": 0,
  "findings": [ { "id": "kebab-slug", "file": "", "line": 0, "severity": "high|med|low",
                  "summary": "", "receipt": "" } ]
}
```

Diffing two baselines: category deltas, findings whose `id` disappeared
(fixed), appeared (new), persisted (still open). Open the report with
that delta.
