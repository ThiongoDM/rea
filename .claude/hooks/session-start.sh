#!/bin/bash
# Install locked dependencies for Claude Code cloud sessions.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/../..}"

# Reuse a cached install when it matches package-lock.json; otherwise install
# the exact locked dependencies without rewriting the lockfile.
if ! node scripts/check-dependency-install.mjs >/dev/null 2>&1; then
  npm ci --no-audit --no-fund
fi
