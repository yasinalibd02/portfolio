/**
 * All portfolio content lives here. Edit this file to update the site —
 * components only read from it, so no component changes are needed.
 */
import type { ImageMetadata } from 'astro';

import qrpayShot from '../assets/projects/qrpay_shot.jpg';
import senpayShot from '../assets/projects/senpay_shot.jpg';
import islahShot from '../assets/projects/islah_shot.jpg';
import appdevsShot from '../assets/projects/appdevs_shot.jpg';
import poisaShot from '../assets/projects/poisa.webp';
import shopgrowShot from '../assets/projects/shopgrow.webp';
import luxoraShot from '../assets/projects/luxora.webp';
import happyVacationShot from '../assets/projects/happy_vacation.webp';
import profilePhoto from '../assets/profile-hero.png';

// ─── Profile & links ────────────────────────────────────────────────

export const site = {
  url: 'https://yasinali.vercel.app',
  title: 'MD Yasin Ali | Full Stack Developer — Apps, Web, SaaS & AI Automation',
  description:
    'Full Stack Developer from Dhaka building mobile apps, web platforms, SaaS products, AI agents and automations. 50+ live apps, 40+ projects. Available for freelance work.',
  ogImage: '/og-image.png',
  resume: '/Yasin-Ali-Resume.pdf',
};

export const profile = {
  name: 'MD Yasin Ali',
  title: 'Full Stack Developer — Apps, Web, SaaS & AI Automation',
  location: 'Mirpur, Dhaka, Bangladesh',
  photo: profilePhoto,
  photoAlt: 'MD Yasin Ali at a desk, giving a thumbs up',
  available: true,
  hero: {
    /** The rotating words after "I build". The first one is also used in the static <h1> text. */
    rotating: ['Mobile Apps', 'Web Platforms', 'SaaS Products', 'AI Agents', 'Automations'],
    headlineEnd: 'that ship.',
    subtext:
      'From idea to launch: mobile apps, web platforms, SaaS products, AI agents and automations that save your team hours. 50+ apps live on Google Play & App Store.',
  },
};

export const links = {
  email: 'yasinali.dev@gmail.com',
  phone: '+8801308985262',
  whatsapp: 'https://wa.me/8801308985262',
  linkedin: 'https://www.linkedin.com/in/yasinalibd02',
  github: 'https://github.com/yasinalibd02',
};

export const stats = [
  { value: 4, suffix: '+', label: 'Years experience' },
  { value: 40, suffix: '+', label: 'Projects delivered' },
  { value: 50, suffix: '+', label: 'Live apps' },
];

/** Scrolling ticker on the home page. */
export const capabilities = [
  'Mobile Apps',
  'Web Platforms',
  'SaaS Products',
  'AI Agents',
  'n8n Automation',
  'Fintech & Wallets',
  'Admin Dashboards',
  'WhatsApp Bots',
  'Play Store & App Store',
  'E-commerce',
];

// ─── Services ───────────────────────────────────────────────────────

export type IconName =
  | 'mobile'
  | 'web'
  | 'saas'
  | 'bot'
  | 'automation'
  | 'wallet'
  | 'search'
  | 'pen'
  | 'code'
  | 'rocket'
  | 'chat';

export interface Service {
  icon: IconName;
  title: string;
  description: string;
  points: string[];
}

export const services: Service[] = [
  {
    icon: 'mobile',
    title: 'Mobile App Development',
    description: 'Android & iOS apps from one codebase, published on Google Play & the App Store.',
    points: ['Android & iOS from one codebase', 'Pixel-perfect UI from your design', 'API & payment integration', 'Store publishing & updates'],
  },
  {
    icon: 'web',
    title: 'Web Platforms & Dashboards',
    description: 'Business websites, admin panels, booking and e-commerce platforms.',
    points: ['Fast, SEO-friendly websites', 'Admin panels & dashboards', 'Booking & e-commerce flows', 'Hosting & deployment'],
  },
  {
    icon: 'saas',
    title: 'SaaS Products',
    description: 'From MVP to launch: subscriptions, user roles, dashboards and billing.',
    points: ['MVP scoping & build', 'Subscriptions & billing', 'Multi-user roles', 'Analytics dashboards'],
  },
  {
    icon: 'bot',
    title: 'AI Agents & Chatbots',
    description: 'AI assistants for WhatsApp, Messenger and your website that answer customers 24/7.',
    points: ['Trained on your business info', 'WhatsApp, Facebook & web chat', 'Lead capture & handoff', 'Prompt design & tuning'],
  },
  {
    icon: 'automation',
    title: 'Automation with n8n',
    description: 'WhatsApp, lead and order follow-up automations that save hours every week.',
    points: ['Lead & order follow-ups', 'CRM, sheets & email sync', 'Notifications & reports', 'AI steps inside workflows'],
  },
  {
    icon: 'wallet',
    title: 'Fintech & Wallet Solutions',
    description: 'Wallet and payment app setup, customization and deployment (QRPay-style scripts).',
    points: ['Wallet app setup & branding', 'Custom features for clients', 'Payment gateway integration', 'Store deployment'],
  },
];

export const process: { icon: IconName; title: string; description: string }[] = [
  { icon: 'search', title: 'Discover', description: 'We talk through your goals, users and budget, and agree on scope.' },
  { icon: 'pen', title: 'Design', description: 'Screens and flows are planned before any code is written.' },
  { icon: 'code', title: 'Build', description: 'Development with regular demo builds, so you can see progress as it happens.' },
  { icon: 'rocket', title: 'Launch', description: 'Deployment to the stores or your server, ready for real users.' },
  { icon: 'chat', title: 'Support', description: 'Fixes, updates and new features after launch.' },
];

export const whyMe = [
  { title: 'Shipped, not just built', description: '50+ apps live on Google Play & App Store.' },
  { title: 'One person, full stack', description: 'App, web, backend, AI and deployment, without hand-offs.' },
  { title: 'Fintech experience', description: 'Wallet and payment products used by real customers.' },
  { title: 'AI-first workflow', description: 'AI agents and automations built into products from day one.' },
];

// ─── Projects ───────────────────────────────────────────────────────

export type ProjectCategory = 'mobile' | 'web';

export interface Project {
  title: string;
  description: string;
  role: string;
  tags: string[];
  category: ProjectCategory;
  featured?: boolean;
  link: { label: string; url: string };
  /** Omit to show a branded placeholder. */
  image?: ImageMetadata;
  /** 'contain' for tall phone screenshots, 'cover' for wide website shots. */
  imageFit?: 'contain' | 'cover';
  /** Background behind 'contain' images. */
  imageBg?: string;
}

// TODO(Yasin): double-check each "role" line below matches what you actually did.
export const projects: Project[] = [
  {
    title: 'QRPay – Money Transfer',
    description: 'Fintech wallet app: send, receive and pay with QR codes.',
    role: 'App development & Google Play deployment',
    tags: ['Fintech', 'Mobile App', 'Flutter'],
    category: 'mobile',
    featured: true,
    link: { label: 'Google Play', url: 'https://play.google.com/store/apps/details?id=net.appdevs.qrpayuser' },
    image: qrpayShot,
    imageFit: 'contain',
    imageBg: '#1d2a6b',
  },
  {
    title: 'SenPay',
    description: 'Fintech wallet app on the App Store: transfers, top-ups and virtual cards.',
    role: 'App development & App Store deployment',
    tags: ['Fintech', 'iOS', 'Flutter'],
    category: 'mobile',
    featured: true,
    link: { label: 'App Store', url: 'https://apps.apple.com/us/app/senpay-user/id6746039031' },
    image: senpayShot,
    imageFit: 'contain',
    imageBg: '#ecd9fb',
  },
  {
    title: 'ShopGrow',
    description: 'Multi-channel AI agent SaaS: one agent deployed to WhatsApp, Instagram, Facebook and more.',
    role: 'Full stack development',
    tags: ['AI Agent', 'SaaS', 'Automation'],
    category: 'web',
    featured: true,
    link: { label: 'Visit site', url: 'https://shopgrow.net/' },
    image: shopgrowShot,
    imageFit: 'cover',
  },
  {
    title: 'QRPay Pro',
    description: 'Complete QRPay solution with all add-ons, sold on CodeCanyon.',
    role: 'App development & client customization',
    tags: ['Fintech', 'Mobile App', 'Web Admin'],
    category: 'mobile',
    link: {
      label: 'CodeCanyon',
      url: 'https://codecanyon.net/item/qrpay-pro-complete-qrpay-solution-with-all-addons-bundle/56101909',
    },
    // TODO(Yasin): add a QRPay Pro screenshot to src/assets/projects/ and import it here.
  },
  {
    title: 'Luxora Living',
    description: 'Premium real estate developer website with project showcases and progress tracking.',
    role: 'Full stack development',
    tags: ['Website', 'Real Estate', 'Laravel'],
    category: 'web',
    link: { label: 'Visit site', url: 'https://luxoralivingbd.com/' },
    image: luxoraShot,
    imageFit: 'cover',
  },
  {
    title: 'Happy Vacation',
    description: 'Travel agency website for air tickets, tours and Hajj & Umrah packages.',
    role: 'Full stack development',
    tags: ['Website', 'Booking', 'Travel'],
    category: 'web',
    link: { label: 'Visit site', url: 'https://happyvacationbd.com/' },
    image: happyVacationShot,
    imageFit: 'cover',
  },
  {
    title: 'Islah',
    description: 'Islamic lifestyle companion: prayer times, Qibla finder and daily routines.',
    role: 'App development & Google Play deployment',
    tags: ['Mobile App', 'Lifestyle'],
    category: 'mobile',
    link: { label: 'Google Play', url: 'https://play.google.com/store/apps/details?id=com.islahbd.app' },
    image: islahShot,
    imageFit: 'contain',
    imageBg: '#6e4d16',
  },
  {
    title: 'Poisa',
    description: 'Personal finance & budgeting app with expense tracking and clean charts.',
    role: 'App development & Google Play deployment',
    tags: ['Mobile App', 'Finance'],
    category: 'mobile',
    link: { label: 'Google Play', url: 'https://play.google.com/store/apps/details?id=com.kori.moneytracker' },
    image: poisaShot,
    imageFit: 'cover',
  },
  {
    title: 'AppDevs',
    description: 'Showcase app for AppDevs, a fintech software company.',
    role: 'App development & Google Play deployment',
    tags: ['Mobile App', 'Fintech', 'Business'],
    category: 'mobile',
    link: { label: 'Google Play', url: 'https://play.google.com/store/apps/details?id=net.appdevs' },
    image: appdevsShot,
    imageFit: 'contain',
    imageBg: '#ede9fe',
  },
];

export const projectFilters: { id: 'all' | ProjectCategory; label: string }[] = [
  { id: 'all', label: 'All' },
  { id: 'mobile', label: 'Mobile Apps' },
  { id: 'web', label: 'Web, SaaS & AI' },
];

// ─── Experience & education ─────────────────────────────────────────

export interface Company {
  company: string;
  roles: { title: string; period: string; points: string[] }[];
}

/** Most recent first. A company with several roles shows them as one promotion track. */
export const experience: Company[] = [
  {
    company: 'TechVen',
    roles: [
      {
        title: 'Full Stack Developer & CTO',
        period: '04/2026 – Present',
        points: [
          'Lead technical execution across mobile apps, web platforms, SaaS products and n8n AI automation.',
          'Own product and technical decision-making.',
        ],
      },
    ],
  },
  {
    company: 'AppDevs',
    roles: [
      {
        title: 'Software Developer (Flutter)',
        period: '05/2023 – 03/2026',
        points: [
          'End-to-end app deployments on App Store & Google Play (QRPay, SenPay, AppDevs).',
          'Bug fixing and client customizations for fintech products.',
        ],
      },
      {
        title: 'Jr. Software Developer (Flutter)',
        period: '10/2022 – 04/2023',
        points: ['Pixel-perfect Flutter UI from Figma.', 'REST API integrations.'],
      },
    ],
  },
];

export const education = [
  { degree: 'B.Sc in CSE', school: 'Sonargaon University', period: '2022 – 2026' },
  { degree: 'Diploma in Computer Technology', school: 'Magura Polytechnic Institute', period: '2017 – 2021' },
];

// ─── Skills ─────────────────────────────────────────────────────────

export const skillGroups: { icon: IconName; title: string; description: string; skills: string[] }[] = [
  {
    icon: 'mobile',
    title: 'Apps',
    description: 'Cross-platform mobile apps, built and published.',
    skills: ['Flutter', 'Dart', 'Android & iOS', 'Google Play', 'App Store'],
  },
  {
    icon: 'web',
    title: 'Web & SaaS',
    description: 'Websites, dashboards and SaaS backends.',
    skills: ['Laravel', 'PHP', 'Next.js', 'JavaScript', 'MySQL', 'REST API'],
  },
  {
    icon: 'bot',
    title: 'AI & Automation',
    description: 'AI agents and workflows that do the repetitive work.',
    skills: ['n8n', 'AI Agents', 'LLM APIs', 'Prompt Engineering', 'WhatsApp Automation', 'Webhooks'],
  },
  {
    icon: 'pen',
    title: 'Design & Delivery',
    description: 'From design file to production.',
    skills: ['Figma', 'GitHub', 'Store Publishing', 'Server Deployment'],
  },
];

// ─── Contact ────────────────────────────────────────────────────────

export const contact = {
  heading: "Have a project in mind? Let's talk.",
  subtext: 'Tell me what you want to build: an app, a website, a SaaS product, an AI agent or an automation.',
  projectTypes: ['Mobile App', 'Website / Web Platform', 'SaaS Product', 'AI Agent / Chatbot', 'Automation (n8n)', 'Fintech / Wallet', 'Other'],
};
