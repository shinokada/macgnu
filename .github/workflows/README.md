# CI Workflow Badge

Add this badge to your README.md to show the CI status. Place it in the badges section near the top of your README.

## Badge Markdown

```markdown
[![CI](https://github.com/shinokada/macgnu/actions/workflows/ci.yml/badge.svg)](https://github.com/shinokada/macgnu/actions/workflows/ci.yml)
```

## Suggested README.md Update

Add the badge in your existing badges section (around line 12-14):

```markdown
<p align="center">
<a href="https://twitter.com/shinokada" rel="nofollow"><img src="https://img.shields.io/badge/created%20by-@shinokada-4BBAAB.svg" alt="Created by Shin Okada"></a>
<a href="https://opensource.org/licenses/MIT" rel="nofollow"><img src="https://img.shields.io/github/license/shinokada/macgnu" alt="License"></a>
<a href="https://github.com/shinokada/macgnu/actions/workflows/ci.yml"><img src="https://github.com/shinokada/macgnu/actions/workflows/ci.yml/badge.svg" alt="CI"></a>
</p>
```

The badge will show:
- ✅ Green "passing" when all tests pass
- ❌ Red "failing" when tests fail
- 🟡 Yellow "running" when tests are in progress
