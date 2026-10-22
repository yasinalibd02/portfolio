// @ts-check
import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://yasinali.vercel.app',
  // Pages build to services.html etc.; Vercel's cleanUrls serves them at /services.
  trailingSlash: 'never',
  build: { format: 'file', inlineStylesheets: 'always' },
});
