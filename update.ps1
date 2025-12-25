cd D:\Dropbox\AINext\Github-Hugo
Copy-Item -Path "D:\Dropbox\AINext\00.Writing\_outputs\AINEXT\*.md" -Destination "content\posts\" -Force
git add .
git commit -m "Update posts"
git push origin main
