# AINEXT Auto Sync Script
$SourcePath = "D:\Dropbox\AINext\00.Writing\_outputs\AINEXT"
$HugoPath = "D:\Dropbox\AINext\Github-Hugo"
$PostsPath = "$HugoPath\content\posts"

if (!(Test-Path $PostsPath)) {
    New-Item -ItemType Directory -Path $PostsPath -Force
}

$mdFiles = Get-ChildItem -Path $SourcePath -Filter "*.md"
Write-Host "Found $($mdFiles.Count) markdown files" -ForegroundColor Cyan

$processedCount = 0

foreach ($file in $mdFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    if ($content -match "^---\s*\n") {
        Write-Host "Skip (has front matter): $($file.Name)" -ForegroundColor Yellow
        Copy-Item -Path $file.FullName -Destination "$PostsPath\$($file.Name)" -Force
        $processedCount++
        continue
    }
    
    $title = ""
    if ($content -match "^#\s+(.+)$" ) {
        $title = $Matches[1].Trim()
    } else {
        $title = $file.BaseName -replace "^\d{8}-", "" -replace "-", " "
    }
    
    $fileDate = $file.CreationTime.ToString("yyyy-MM-ddTHH:mm:ss+08:00")
    
    $descContent = $content -replace "^#.+\n", "" -replace "\n", " " -replace "\s+", " "
    $descLength = [Math]::Min(150, $descContent.Length)
    $description = $descContent.Substring(0, $descLength).Trim() -replace '"', '\"'
    
    $frontMatter = "---`ntitle: `"$title`"`ndate: $fileDate`ndescription: `"$description`"`ntags: [`"AI`"]`ncategories: [`"AI`"]`ndraft: false`n---`n`n"
    
    $bodyContent = $content -replace "^#.+\n", ""
    $newContent = $frontMatter + $bodyContent
    
    $destFile = "$PostsPath\$($file.Name)"
    [System.IO.File]::WriteAllText($destFile, $newContent, [System.Text.Encoding]::UTF8)
    
    Write-Host "Processed: $($file.Name)" -ForegroundColor Green
    $processedCount++
}

Write-Host "`nTotal: $processedCount files" -ForegroundColor Cyan

Set-Location $HugoPath
$status = git status --porcelain
if ($status) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    git add .
    git commit -m "Auto sync: $timestamp"
    git push origin main
    Write-Host "Pushed to GitHub!" -ForegroundColor Green
} else {
    Write-Host "No changes to push" -ForegroundColor Yellow
}
