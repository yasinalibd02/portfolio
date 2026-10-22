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
import profilePhoto from '../assets/profile.jpeg';

// ─── Profile & links ────────────────────────────────────────────────

export const site = {
  url: 'https://yasinali.vercel.app',
  title: 'MD Yasin Ali | Full Stack Developer — Flutter, Laravel & Next.js',
  description:
    'Full Stack Developer from Dhaka building fintech and business apps with Flutter, Laravel and Next.js. 5 live apps, 40+ projects. Available for freelance work.',
  ogImage: '/og-image.png',
  resume: '/Yasin-Ali-Resume.pdf',
};

export const profile = {
  name: 'MD Yasin Ali',
  title: 'Full Stack Developer — Flutter, Laravel & Next.js',
  location: 'Mirpur, Dhaka, Bangladesh',
  photo: profilePhoto,
  photoAlt: 'MD Yasin Ali at a desk, giving a thumbs up',
  available: true,
  hero: {
    headline: 'I build fintech & business apps that ship.',
    subtext:
      'Full Stack Developer working with Flutter, Laravel & Next.js. 5 apps live on Google Play & App Store, 40+ projects delivered.',
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
  { value: '4+', label: 'Years' },
  { value: '40+', label: 'Projects' },
  { value: '5', label: 'Live Apps' },
];

// ─── Services ───────────────────────────────────────────────────────

export type IconName = 'mobile' | 'web' | 'wallet' | 'automation';

export const services: { icon: IconName; title: string; description: string }[] = [
  {
    icon: 'mobile',
    title: 'Flutter App Development',
    description: 'Cross-platform apps plus Play Store & App Store publishing.',
  },
  {
    icon: 'web',
    title: 'Web Apps & Dashboards',
    description: 'Laravel and Next.js platforms, admin panels, SaaS.',
  },
  {
    icon: 'wallet',
    title: 'Fintech & Wallet Solutions',
    description: 'Wallet/payment app setup, customization and deployment (QRPay-style scripts).',
  },
  {
    icon: 'automation',
    title: 'AI Automation with n8n',
    description: 'WhatsApp, lead and order follow-up automations that save hours.',
  },
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
    description: 'Flutter fintech wallet app: send, receive and pay with QR codes.',
    role: 'Flutter development & Google Play deployment',
    tags: ['Flutter', 'Dart', 'Fintech', 'REST API'],
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
    role: 'Flutter development & App Store deployment',
    tags: ['Flutter', 'iOS', 'Fintech'],
    category: 'mobile',
    featured: true,
    link: { label: 'App Store', url: 'https://apps.apple.com/us/app/senpay-user/id6746039031' },
    image: senpayShot,
    imageFit: 'contain',
    imageBg: '#ecd9fb',
  },
  {
    title: 'QRPay Pro',
    description: 'Complete QRPay solution with all add-ons, sold on CodeCanyon.',
    role: 'Flutter app development & client customization',
    tags: ['Flutter', 'Laravel', 'Fintech'],
    category: 'mobile',
    featured: true,
    link: {
      label: 'CodeCanyon',
      url: 'https://codecanyon.net/item/qrpay-pro-complete-qrpay-solution-with-all-addons-bundle/56101909',
    },
    // TODO(Yasin): add a QRPay Pro screenshot to src/assets/projects/ and import it here.
  },
  {
    title: 'ShopGrow',
    description: 'Multi-channel AI agent SaaS: one agent deployed to WhatsApp, Instagram, Facebook and more.',
    role: 'Full stack development',
    tags: ['Next.js', 'SaaS', 'AI Agent', 'Automation'],
    category: 'web',
    link: { label: 'Visit site', url: 'https://shopgrow.net/' },
    image: shopgrowShot,
    imageFit: 'cover',
  },
  {
    title: 'Luxora Living',
    description: 'Premium real estate developer website with project showcases and progress tracking.',
    role: 'Full stack development',
    tags: ['Laravel', 'PHP', 'Real Estate'],
    category: 'web',
    link: { label: 'Visit site', url: 'https://luxoralivingbd.com/' },
    image: luxoraShot,
    imageFit: 'cover',
  },
  {
    title: 'Happy Vacation',
    description: 'Travel agency website for air tickets, tours and Hajj & Umrah packages.',
    role: 'Full stack development',
    tags: ['PHP', 'Booking', 'Travel'],
    category: 'web',
    link: { label: 'Visit site', url: 'https://happyvacationbd.com/' },
    image: happyVacationShot,
    imageFit: 'cover',
  },
  {
    title: 'Islah',
    description: 'Islamic lifestyle companion: prayer times, Qibla finder and daily routines.',
    role: 'Flutter development & Google Play deployment',
    tags: ['Flutter', 'Dart', 'Lifestyle'],
    category: 'mobile',
    link: { label: 'Google Play', url: 'https://play.google.com/store/apps/details?id=com.islahbd.app' },
    image: islahShot,
    imageFit: 'contain',
    imageBg: '#6e4d16',
  },
  {
    title: 'Poisa',
    description: 'Personal finance & budgeting app with expense tracking and clean charts.',
    role: 'Flutter development & Google Play deployment',
    tags: ['Flutter', 'Finance'],
    category: 'mobile',
    link: { label: 'Google Play', url: 'https://play.google.com/store/apps/details?id=com.kori.moneytracker' },
    image: poisaShot,
    imageFit: 'cover',
  },
  {
    title: 'AppDevs',
    description: 'Showcase app for AppDevs, a fintech software company.',
    role: 'Flutter development & Google Play deployment',
    tags: ['Flutter', 'Fintech', 'Business'],
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
  { id: 'web', label: 'Web & SaaS' },
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

export const skillGroups = [
  { title: 'Mobile', skills: ['Flutter', 'Dart', 'Play Store', 'App Store'] },
  { title: 'Backend & Web', skills: ['Laravel', 'PHP', 'Next.js', 'JavaScript', 'MySQL', 'REST API'] },
  { title: 'Automation & Tools', skills: ['n8n', 'Figma', 'GitHub', 'Prompt Engineering'] },
];

export const contact = {
  heading: "Have a project in mind? Let's talk.",
  subtext: 'Tell me what you want to build — an app, a web platform or an automation — and I will get back to you with next steps.',
};
