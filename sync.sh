#!/bin/bash
REPO_DIR="$HOME/anandha_github"
BOT_DIR="$HOME/anandha_bot"
cd "$REPO_DIR" || exit 1
cp "$BOT_DIR/paper_trade_results.json"     data/equity.json    2>/dev/null
cp "$BOT_DIR/commodity_trade_results.json" data/commodity.json 2>/dev/null
tail -100 "$BOT_DIR/paper_trade.log"        > data/equity.log    2>/dev/null
tail -100 "$BOT_DIR/commodity_trade.log"    > data/commodity.log 2>/dev/null
git add data/
if ! git diff --cached --quiet; then
    git commit -m "live $(date '+%H:%M:%S')"
    git push origin main --quiet
fi
