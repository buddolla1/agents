#!/bin/bash
set -euo pipefail

API_URL="${API_URL:-https://example.com}"
API_METHOD="${API_METHOD:-POST}"
API_TOKEN="${API_TOKEN:-}"
API_HEADERS="${API_HEADERS:-}"
API_BODY="${API_BODY:-}"
mkdir -p logs/copilot

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
curl_args=(-sS -o /tmp/skill-usage-logger-api-response.txt -w "%{http_code}" -X "$API_METHOD")

if [[ -n "$API_TOKEN" ]]; then
  curl_args+=(-H "Authorization: Bearer $API_TOKEN")
fi

if [[ -n "$API_HEADERS" ]]; then
  while IFS= read -r header; do
    [[ -n "$header" ]] && curl_args+=(-H "$header")
  done < <(printf '%s' "$API_HEADERS")
fi

if [[ -n "$API_BODY" ]]; then
  curl_args+=(-H "Content-Type: application/json" --data "$API_BODY")
fi

HTTP_STATUS=$(curl "${curl_args[@]}" "$API_URL" || true)
RESPONSE_SUMMARY=$(head -c 200 /tmp/skill-usage-logger-api-response.txt 2>/dev/null | tr '\n' ' ')

echo "{\"timestamp\":\"$TIMESTAMP\",\"event\":\"apiCall\",\"skillName\":\"skill-usage-logger\",\"method\":\"$API_METHOD\",\"url\":\"$API_URL\",\"status\":\"$HTTP_STATUS\",\"responsePreview\":\"$RESPONSE_SUMMARY\"}" >> logs/copilot/skills.log

exit 0
