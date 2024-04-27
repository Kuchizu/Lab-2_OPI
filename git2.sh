#!/bin/bash
# Создание репозитория и начальная ревизия (r0)
git init
git remote add origin https://github.com/Kuchizu/Lab-2_OPI.git
echo "- git init"

# Настройка .git/config
echo -e "\n[merge]\n\ttool = nano" >> .git/config

# Настройка пользователя
git config user.name "red"
git config user.email "red@example.com"
echo "- Пользователь red создан"

# Ревизия r0 (пользователь 1) {
unzip -o commits/commit0.zip -d src
git add .
git commit -m "Initial commit (r0)"
git push -u origin master
echo "- Коммит 0 (red)"
# }

# Ревизия r1 (пользователь 2) {
git checkout -b branch2
unzip -o commits/commit1.zip -d src
git add .
git commit --author="blue <blue@example.com>" -m "Revision 1 (r1)"
git push -u origin branch2
echo "- Коммит 1 (blue)"
# }

# Ревизии r2-r4 (пользователь 1) {
git checkout master
unzip -o commits/commit2.zip -d src
git add .
git commit -m "Revision 2 (r2)"
git push -u origin master
echo "- Коммит 2 (red)"
unzip -o --allow-empty commits/commit3.zip -d src
git add .
git commit --allow-empty -m "Revision 3 (r3)"
git push -u origin master
echo "- Коммит 3 (red)"
unzip -o --allow-empty commits/commit4.zip -d src
git add .
git commit --allow-empty -m "Revision 4 (r4)"
git push -u origin master
echo "- Коммит 4 (red)"
# }

# Ревизии r5-r6 (пользователь 2) {
git checkout branch2
unzip -o commits/commit5.zip -d src
git add .
git commit --allow-empty --author="blue <blue@example.com>" -m "Revision 5 (r5)"
git push -u origin branch2
echo "- Коммит 5 (blue)"
unzip -o commits/commit6.zip -d src
git add .
git commit --allow-empty --author="blue <blue@example.com>" -m "Revision 6 (r6)"
echo "- Коммит 6 (blue)"
git push -u origin branch2
# }

# Ревизии r7-r9 (пользователь 1) {
git checkout -b branch3
unzip -o commits/commit7.zip -d src
git add .
git commit --allow-empty -m "Revision 7 (r7)"
git push -u origin branch3

git checkout master
unzip -o commits/commit8.zip -d src
git add .
git commit --allow-empty -m "Revision 8 (r8)"
git push -u origin master

git checkout branch3
unzip -o commits/commit9.zip -d src
git add .
git commit --allow-empty -m "Revision 9 (r9)"
git push -u origin branch3
# }

# Ревизия r10 (пользователь 2) {
git checkout branch2
git merge --no-ff branch3 -m "Merging two branches -> r10"
unzip -o commits/commit10.zip -d src
git add .
git commit -m "Revision 10 (r10)"
git push -u origin branch2
# }

# Ревизии r11-r12 (пользователь 1) {
git checkout master
unzip -o commits/commit11.zip -d src
git add .
git commit -m "Revision 11 (r11)"
unzip -o commits/commit12.zip -d src
git add .
git commit -m "Revision 12 (r12)"
git push -u origin master
# }

# Ревизия r13 (пользователь 2) {
git checkout branch2
unzip -o commits/commit13.zip -d src
git add .
git commit --author="blue <blue@example.com>" -m "Revision 13 (r13)"
git push -u origin branch2
# }

# Ревизия r14 (пользователь 1) {
git checkout master
git checkout --ours src/UyhygCx71w.e3l
git merge branch2 -m "Merging two branches -> r14"
git push -u origin master
# }

git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all