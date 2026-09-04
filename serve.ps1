$port = 8080
$dir = $PSScriptRoot

Write-Host "Starting server at http://localhost:$port" -ForegroundColor Green
Write-Host "Press Ctrl+C to stop" -ForegroundColor Yellow
Write-Host ""

function Test-RealPython($cmd) {
    # The Microsoft Store python3/python stubs live in WindowsApps and only
    # print an install hint. Treat them as "not found".
    try {
        $resolved = (Get-Command $cmd -ErrorAction Stop).Source
        if ($resolved -like "*WindowsApps*") { return $false }
        & $cmd --version *> $null
        return $?
    } catch {
        return $false
    }
}

if (Test-RealPython "py") {
    py -3 -m http.server $port --directory $dir
} elseif (Test-RealPython "python") {
    python -m http.server $port --directory $dir
} elseif (Get-Command npx -ErrorAction SilentlyContinue) {
    npx serve $dir -p $port -s --no-clipboard
} elseif (Test-RealPython "python3") {
    python3 -m http.server $port --directory $dir
} else {
    Write-Host "ERROR: Neither Python nor Node.js found. Install one of them first." -ForegroundColor Red
    exit 1
}
