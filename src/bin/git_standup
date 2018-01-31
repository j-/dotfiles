#!/bin/bash

CURRENT_USER="$(git config user.name)"
SINCE="$(test "$(date +%u)" -eq 1 && echo 'last friday' || echo 'yesterday')"

# Log all commits made by the current user since yesterday (or last Friday if
# today is Monday). Checks all branches, not just the current one. Also
# accepts additional arguments (like `--until=midnight`). Do not quote the
# argument expansion or git will expect additional parameters.
git log \
  --author="${CURRENT_USER}" \
  --since="${SINCE}" \
  --all \
  ${*}
