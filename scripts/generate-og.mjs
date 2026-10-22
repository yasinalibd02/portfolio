// Generates public/og-image.png (1200x630) and the favicons from src/assets/avatar.png.
// Run with `npm run og` after changing the name, title or photo. Output files are committed.
import sharp from 'sharp';

const out = (f) => new URL(`../public/${f}`, import.meta.url);
const photo = new URL('../src/assets/profile.jpeg', import.meta.url);

const name = 'MD Yasin Ali';
const font = "'Helvetica Neue', Helvetica, Arial, sans-serif";

// ── OG image (the title is split over two lines to fit beside the photo) ──
const photoSize = 340;
const circle = Buffer.from(
  `<svg width="${photoSize}" height="${photoSize}"><circle cx="${photoSize / 2}" cy="${photoSize / 2}" r="${photoSize / 2}"/></svg>`,
);
const avatar = await sharp(photo.pathname)
  .extract({ left: 480, top: 120, width: 760, height: 760 })
  .resize(photoSize, photoSize)
  .composite([{ input: circle, blend: 'dest-in' }])
  .png()
  .toBuffer();

const og = `
<svg width="1200" height="630" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="accent" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#F4795B"/><stop offset="1" stop-color="#F25C3B"/>
    </linearGradient>
    <radialGradient id="glow" cx="0.85" cy="0.5" r="0.55">
      <stop offset="0" stop-color="#F4795B" stop-opacity="0.35"/><stop offset="1" stop-color="#F4795B" stop-opacity="0"/>
    </radialGradient>
    <pattern id="grid" width="48" height="48" patternUnits="userSpaceOnUse">
      <path d="M48 0H0V48" fill="none" stroke="#ffffff" stroke-opacity="0.05"/>
    </pattern>
  </defs>
  <rect width="1200" height="630" fill="#0A0A0F"/>
  <rect width="1200" height="630" fill="url(#grid)"/>
  <rect width="1200" height="630" fill="url(#glow)"/>
  <rect x="0" y="0" width="1200" height="10" fill="url(#accent)"/>

  <rect x="80" y="112" width="64" height="64" rx="16" fill="url(#accent)"/>
  <text x="112" y="157" text-anchor="middle" font-family="${font}" font-size="36" font-weight="700" fill="#0A0A0F">Y</text>
  <text x="162" y="155" font-family="${font}" font-size="26" font-weight="500" fill="#A3AEC2">yasinali.vercel.app</text>

  <text x="80" y="290" font-family="${font}" font-size="84" font-weight="800" fill="#FFFFFF" letter-spacing="-2">${name}</text>
  <text x="80" y="356" font-family="${font}" font-size="34" font-weight="600" fill="#F4795B">Full Stack Developer</text>
  <text x="80" y="402" font-family="${font}" font-size="34" font-weight="500" fill="#E2E8F0">Apps, Web, SaaS &amp; AI Automation</text>

  <text x="80" y="522" font-family="${font}" font-size="26" font-weight="500" fill="#A3AEC2">4+ years  ·  40+ projects  ·  50+ live apps</text>

  <circle cx="${1200 - 80 - photoSize / 2}" cy="315" r="${photoSize / 2 + 8}" fill="url(#accent)"/>
</svg>`;

await sharp(Buffer.from(og))
  .composite([{ input: avatar, left: 1200 - 80 - photoSize, top: 315 - photoSize / 2 }])
  .png({ compressionLevel: 9 })
  .toFile(out('og-image.png').pathname);

// ── Favicons: the circular profile photo ──
const avatarIcon = new URL('../src/assets/avatar.png', import.meta.url).pathname;
await sharp(avatarIcon).resize(32, 32).png().toFile(out('favicon.png').pathname);
await sharp(avatarIcon).resize(192, 192).png().toFile(out('icon-192.png').pathname);
// iOS ignores transparency, so give the touch icon a solid background.
await sharp(avatarIcon).resize(180, 180).flatten({ background: '#ffffff' }).png().toFile(out('apple-touch-icon.png').pathname);

console.log('Generated og-image.png, favicon.png, icon-192.png, apple-touch-icon.png');
