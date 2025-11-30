# Yasin Ali

A responsive portfolio website built with Flutter Web.

## Features

- **Responsive Design**: Works on Mobile, Tablet, and Desktop.
- **Modern UI**: Clean interface with animations and dark mode support.
- **Project Showcase**: Grid/List view of projects loaded from JSON.
- **Contact Form**: Integrated `mailto` link for easy contact.
- **Routing**: Managed by `go_router` for deep linking and navigation.

## Getting Started

### Prerequisites

- Flutter SDK (Latest Stable)
- Chrome (for web debugging)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yasinali/portfolio.git
   cd portfolio
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run locally:
   ```bash
   flutter run -d web-server --web-port=8080
   ```
   Open [http://localhost:8080](http://localhost:8080) in your browser.

## Deployment

### GitHub Pages

This project includes a GitHub Actions workflow to automatically deploy to GitHub Pages.

1. Go to Settings > Pages in your GitHub repository.
2. Set the source to `gh-pages` branch (this branch is created by the action).
3. Update the `base-href` in `.github/workflows/flutter_web.yml` if your repository name is not `portfolio`.
   ```yaml
   - run: flutter build web --release --base-href "/<REPO_NAME>/"
   ```

### Firebase Hosting

1. Install Firebase CLI:
   ```bash
   npm install -g firebase-tools
   ```

2. Login and Initialize:
   ```bash
   firebase login
   firebase init hosting
   ```
   - Select `build/web` as the public directory.
   - Configure as a single-page app (Yes).

3. Build and Deploy:
   ```bash
   flutter build web
   firebase deploy
   ```

## Customization

- **Projects**: Edit `assets/projects.json` to add your own projects.
- **Theme**: Modify `lib/theme.dart` to change colors and fonts.
- **Bio/Skills**: Update `lib/pages/home_page.dart` and `lib/pages/about_page.dart`.
