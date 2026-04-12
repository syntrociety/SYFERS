#!/bin/bash
# Run from: /Users/floris/Documents/GitHub/SYFERS
# Cleans up the repo structure and adds mirrored ORRI folders in all language dirs

set -e
REPO="/Users/floris/Documents/GitHub/SYFERS"
cd "$REPO"

echo "=== SYFERS repo structure cleanup ==="
echo ""

# ── 1. Remove 'ORRI plan' folder ──────────────────────────────────────────────
if [ -d "ORRI plan" ]; then
  rm -rf "ORRI plan"
  echo "✓ Removed: ORRI plan/"
else
  echo "- Skipped: ORRI plan/ (not found)"
fi

# ── 2. Define language dirs and ORRI subdirs ──────────────────────────────────
LANGS="en nl pt de es fr it"
ORRI_DIRS="1-governance 2-ecology 3-social 4-economy 5-energy 6-housing 7-tools 8-alignment 9-learning 10-orri-compliance"

# ── 3. Create mirrored ORRI subfolders in each language dir ───────────────────
echo ""
echo "Creating mirrored ORRI folders in language directories..."

for lang in $LANGS; do
  for orri in $ORRI_DIRS; do
    dir="$lang/$orri"
    if [ ! -d "$dir" ]; then
      mkdir -p "$dir"
      touch "$dir/.gitkeep"
      echo "  ✓ Created: $dir/"
    else
      echo "  - Exists:  $dir/"
    fi
  done
done

# ── 4. Print final structure summary ─────────────────────────────────────────
echo ""
echo "=== Structure check ==="
echo ""
echo "Root ORRI folders:"
for orri in $ORRI_DIRS; do
  echo "  $orri/ — $(ls $orri | grep -v .gitkeep | wc -l | tr -d ' ') file(s)"
done

echo ""
echo "Language folders:"
for lang in $LANGS; do
  count=$(find "$lang" -name "*.md" | wc -l | tr -d ' ')
  subdirs=$(ls "$lang" | wc -l | tr -d ' ')
  echo "  $lang/ — $count .md files, $subdirs entries"
done

echo ""
echo "=== Done. Now run: ==="
echo ""
echo "  git add ."
echo "  git commit -m 'Clean up repo structure — remove ORRI plan, mirror ORRI folders in lang dirs'"
echo "  git push"
