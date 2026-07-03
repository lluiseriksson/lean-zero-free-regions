$ErrorActionPreference = "Stop"

$matches = & rg -n "\b(sorry|admit|axiom)\b|set_option\s+autoImplicit\s+true" `
  -g "*.lean" `
  -g "!/.lake/**" `
  .

if ($LASTEXITCODE -eq 0) {
  Write-Error "Forbidden Lean frontier marker found:`n$matches"
}
elseif ($LASTEXITCODE -eq 1) {
  exit 0
}
else {
  exit $LASTEXITCODE
}
