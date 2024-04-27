#!/bin/bash
# Создание локального репозитория
svnadmin create repo
REPO_URL="file://$(pwd)/repo"

# Создаём структуру проекта
cd repo
svn mkdir $REPO_URL/trunk $REPO_URL/branches -m "Project structure"
cd ..

# Создание рабочей копии
svn checkout $REPO_URL/trunk wc
cd wc

# Начальная ревизия r0 (пользователь 1) {
echo $RANDOM > commit1.txt
svn add commit1.txt
svn commit -m "Initial commit (r0)" --username red
echo "- Ревизия 0 (red)"
# }

# Создание ветки branch2 и ревизия r1 (пользователь 2) {
svn copy $REPO_URL/trunk $REPO_URL/branches/branch2 -m "Creating branch2"
svn switch $REPO_URL/branches/branch2
echo $RANDOM > commit1.txt
svn add commit1.txt
svn commit -m "Revision 1 (r1)" --username blue
echo "- Ревизия 1 (blue)"
# }

# Возвращение к trunk и ревизии r2-r4 (пользователь 1) {
svn switch $REPO_URL/trunk
for i in 2 3 4; do
  echo $RANDOM > "commit$i.txt"
  svn add "commit$i.txt"
  svn commit -m "Revision $i (r$i)" --username red
  echo "- Ревизия $i (red)"
done
# }

# Ревизии r5-r6 (пользователь 2) на ветке branch2:
svn switch $REPO_URL/branches/branch2
for i in 5 6; do
  echo $RANDOM > "commit$i.txt"
  svn add "commit$i.txt"
  svn commit -m "Revision $i (r$i)" --username blue
  echo "- Ревизия $i (blue)"
done
# }

# Создание ветки branch3 и ревизии r7-r9 (пользователь 1):
svn copy $REPO_URL/trunk $REPO_URL/branches/branch3 -m "Creating branch3"
svn switch $REPO_URL/branches/branch3
echo $RANDOM > "commit7.txt"
svn add "commit7.txt"
svn commit -m "Revision 7 (r7)" --username red
echo "- Ревизия 7 (red)"

svn switch $REPO_URL/trunk
echo $RANDOM > "commit8.txt"
svn add "commit8.txt"
svn commit -m "Revision 8 (r8)" --username red
echo "- Ревизия 8 (red)"

svn switch $REPO_URL/branches/branch3
echo $RANDOM > "commit9.txt"
svn add "commit9.txt"
svn commit -m "Revision 9 (r9)" --username red
echo "- Ревизия 9 (red)"
# }

# Слияние ветки branch3 в branch2 и ревизия r10 (пользователь 2):
svn switch $REPO_URL/branches/branch2
svn merge --accept postpone $REPO_URL/branches/branch3
# Решение конфликтов здесь вручную, затем:
svn resolved commit10.txt
echo $RANDOM > commit10.txt
svn add commit10.txt
svn commit -m "Revision 10 (r10)" --username blue
echo "- Ревизия 10 (blue)"
# }

# Ревизии r11-r12 (пользователь 1) в trunk:
svn switch $REPO_URL/trunk
for i in 11 12; do
  echo $RANDOM > "commit$i.txt"
  svn add "commit$i.txt"
  svn commit -m "Revision $i (r$i)" --username red
  echo "- Ревизия $i (red)"
done
# }

# Ревизия r13 (пользователь 2) в branch2:
svn switch $REPO_URL/branches/branch2
echo $RANDOM > commit13.txt
svn add commit13.txt
svn commit -m "Revision 13 (r13)" --username blue
echo "- Ревизия 13 (blue)"
# }

# Слияние ветки branch2 в trunk и ревизия r14 (пользователь 1):
svn switch $REPO_URL/trunk
svn merge --accept postpone $REPO_URL/branches/branch2
# Решение конфликтов здесь вручную, затем:
svn resolved commit14.txt
echo $RANDOM > commit14.txt
svn add commit14.txt
svn commit -m "Revision 14 (r14)" --username red
echo "- Ревизия 14 (red)"
# }

# Обновление рабочей копии
svn update
echo "Рабочая копия обновлена"

cd ..
