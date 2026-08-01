param(
  [Parameter(Mandatory = $true)]
  [string]$Name
)

$ErrorActionPreference = "Stop"

try {
  $postName = $Name.Trim()
  if ($postName.EndsWith(".md", [System.StringComparison]::OrdinalIgnoreCase)) {
    $postName = $postName.Substring(0, $postName.Length - 3).Trim()
  }

  if ([string]::IsNullOrWhiteSpace($postName)) {
    throw "The file name cannot be empty."
  }

  if ($postName -in @(".", "..") -or
      $postName.IndexOfAny([System.IO.Path]::GetInvalidFileNameChars()) -ge 0) {
    throw "The file name contains characters that Windows does not allow."
  }

  $reservedNames = @(
    "CON", "PRN", "AUX", "NUL",
    "COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8", "COM9",
    "LPT1", "LPT2", "LPT3", "LPT4", "LPT5", "LPT6", "LPT7", "LPT8", "LPT9"
  )
  if ($reservedNames -contains $postName.ToUpperInvariant()) {
    throw "'$postName' is a reserved Windows name. Choose another file name."
  }

  $projectRoot = Split-Path -Parent $PSScriptRoot
  $postsDirectory = Join-Path $projectRoot "src\content\posts"
  $targetPath = Join-Path $postsDirectory "$postName.md"

  if (Test-Path -LiteralPath $targetPath) {
    throw "The post already exists: $targetPath"
  }

  $chinaTimeZone = [System.TimeZoneInfo]::FindSystemTimeZoneById("China Standard Time")
  $now = [System.TimeZoneInfo]::ConvertTime([System.DateTimeOffset]::UtcNow, $chinaTimeZone)
  $timestamp = $now.ToString("yyyy-MM-dd'T'HH:mm:sszzz")
  $yamlTitle = $postName.Replace("'", "''")

  $content = @"
---
title: '$yamlTitle'
pubDatetime: $timestamp
modDatetime: $timestamp
tags: []
draft: true
description: ''
---

"@

  [System.IO.Directory]::CreateDirectory($postsDirectory) | Out-Null
  [System.IO.File]::WriteAllText(
    $targetPath,
    $content + [Environment]::NewLine,
    [System.Text.UTF8Encoding]::new($false)
  )

  Write-Host "Created: $targetPath" -ForegroundColor Green
}
catch {
  Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
  exit 1
}
