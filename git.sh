#!/bin/bash
# Создание репозитория и начальная ревизия (r0)
git init
echo "- git init"

# Настройка .git/config
echo -e "\n[merge]\n\ttool = nano" >> .git/config

# Настройка пользователя
git config user.name "red"
git config user.email "red@example.com"
echo "- Пользователь red создан"
git checkout -b branch1

# Ревизия r0 (пользователь 1) {
echo $RANDOM > commit0.txt
git add .
git commit -m "Initial commit (r0)"
echo "- Коммит 0 (red)"
# }

# Ревизия r1 (пользователь 2) {
git checkout -b branch2
echo $RANDOM > commit1.txt
git add .
git commit --author="blue <blue@example.com>" -m "Revision 1 (r1)"
echo "- Коммит 1 (blue)"
# }

# Ревизии r2-r4 (пользователь 1) {
git checkout branch1
echo $RANDOM > commit2.txt
git add .
git commit -m "Revision 2 (r2)"
echo "- Коммит 2 (red)"
echo $RANDOM > commit3.txt
git add .
git commit -m "Revision 3 (r3)"
echo "- Коммит 3 (red)"
echo $RANDOM > commit4.txt
git add .
git commit -m "Revision 4 (r4)"
echo "- Коммит 4 (red)"
# }

# Ревизии r5-r6 (пользователь 2) {
git checkout branch2
echo $RANDOM > commit5.txt
git add .
git commit --author="blue <blue@example.com>" -m "Revision 5 (r5)"
echo "- Коммит 5 (blue)"
echo $RANDOM > commit6.txt
git add .
git commit --author="blue <blue@example.com>" -m "Revision 6 (r6)"
echo "- Коммит 6 (blue)"
# }

# Ревизии r7-r9 (пользователь 1) {
git checkout -b branch3
echo $RANDOM > commit7.txt
git add .
git commit -m "Revision 7 (r7)"

git checkout branch1
echo $RANDOM > commit8.txt
git add .
git commit -m "Revision 8 (r8)"

git checkout branch3
echo $RANDOM > commit9.txt
git add .
git commit -m "Revision 9 (r9)"
# }

# Ревизия r10 (пользователь 2) {
git checkout branch2
git merge branch3
echo $RANDOM > commit10.txt
git add .
git commit --author="blue <blue@example.com>" -m "Revision 10 (r10)"
# }

# Ревизии r11-r12 (пользователь 1) {
git checkout branch1
echo $RANDOM > commit11.txt
git add .
git commit -m "Revision 11 (r11)"
echo $RANDOM > commit12.txt
git add .
git commit -m "Revision 12 (r12)"
# }

# Ревизия r13 (пользователь 2) {
git checkout branch2
echo $RANDOM > commit13.txt
git add .
git commit --author="blue <blue@example.com>" -m "Revision 13 (r13)"
# }

# Ревизия r14 (пользователь 1) {
git checkout branch1
git merge branch2
echo $RANDOM > commit14.txt
git add .
git commit -m "Revision 14 (r14)"
# }

git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all
