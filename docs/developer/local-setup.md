# Local Setup

## Prerequisites

- [Node.js](https://nodejs.org/) (v18+)
- [Git](https://git-scm.com/)

## Clone and Run

```bash
git clone https://github.com/KunaalAgarwal/niBuild.git
cd niBuild
npm install
npm run dev
```

The development server starts at `http://localhost:5173`.

## Build for Production

```bash
npm run build
```

Output goes to `dist/`. The production build is deployed to GitHub Pages via the `gh-pages` npm package.

## Project Structure

```
niBuild/
├── src/
│   ├── main.jsx              # App entry, CWL preloading, workspace management
│   ├── components/           # React components (canvas, menus, modals, node rendering)
│   ├── context/              # Context providers (toast, custom workflows, scatter, wired inputs)
│   ├── hooks/                # Custom hooks (workspaces, CWL build, ZIP export, node lookup)
│   ├── utils/                # Utilities (CWL parser, tool registry, annotations, BIDS parser)
│   └── styles/               # CSS files (paired per component, background.css for theme)
├── public/
│   └── cwl/                  # CWL tool definitions (155 files across 11 library subdirectories)
├── scripts/                  # Build/export scripts
├── package.json
└── vite.config.js            # Vite config (base: /niBuild/ for GitHub Pages)
```

## Tech Stack

| Package | Version | Purpose |
|---|---|---|
| React | 18.3 | UI framework |
| ReactFlow | 11.11 | Drag-and-drop node/edge canvas |
| React Bootstrap | 2.10 | UI components |
| js-yaml | 4.1 | YAML parse/stringify for CWL |
| JSZip | 3.10 | ZIP bundle creation |
| file-saver | 2.0 | Trigger browser downloads |
| Vite | 5.4 | Build tooling |

## Contributing

1. Create a feature branch from `main`:
   ```bash
   git checkout -b feature/your-feature
   ```
2. Make changes and test thoroughly.
3. Open a pull request to `main`. PRs are reviewed before merging.
4. On merge to `main`, GitHub Actions automatically deploys to GitHub Pages.
