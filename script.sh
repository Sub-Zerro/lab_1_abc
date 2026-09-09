mkdir lab0
cd lab0
mkdir eleon
touch opening_day
cd eleon
mkdir victor hotel_office reception staff_room roof
cd victor
mkdir kitchen hall
cd kitchen
touch new_menu dinner_order
cd ../hall
touch opening_guests
cd ../../hotel_office
touch eleonora_order
cd ../reception
touch sofia_schedule guest_notes
cd ../staff_room
touch barinov_uniform kostya_message
cd ../roof
touch max_letter roof_event
cd ../

echo "Блюдо от Виктора Баринова
Закуска от Екатерины Семёновой
Десерт для гостей отеля Eleon
Новое блюдо Дениса на проверке у шефа" > victor/kitchen/new_menu
echo "На кухне подготовить утиную ножку
В зал отправить две рыбные закуски
Для Софии приготовить особый десерт" > victor/kitchen/dinner_order
echo "Элеонора Андреевна встречает первых гостей
София Яновна проверяет готовность зала
Виктор Баринов представляет новое меню
Костя помогает команде ресторана" > victor/hall/opening_guests
echo "Ресторан Victor должен открыться вовремя
Баринов отвечает за кухню
София встречает важных гостей
Персонал отеля помогает в зале" > hotel_office/eleonora_order
echo "Утром проверить ресторан Victor
Днём провести встречу с Элеонорой
Вечером принять первых гостей" > reception/sofia_schedule
echo "Гости попросили столик рядом с окном
Один гость хочет поговорить с Бариновым
Постоянные гости ждут знакомое блюдо" > reception/guest_notes
echo "Новый китель приготовлен для шефа
На форме вышито имя Виктор
Китель находится в комнате персонала" > staff_room/barinov_uniform
echo "Костя приехал помочь перед открытием
Бар готов к вечернему обслуживанию
После смены он ждёт Настю в холле" > staff_room/kostya_message
echo "Макс передал привет всей команде
Он помнит работу с Виктором Петровичем
Письмо оставлено на крыше отеля" > roof/max_letter
echo "Баринов поднялся на крышу после смены
Элеонора нашла его возле старого рояля
Команда ресторана собралась вместе" > roof/roof_event
echo "Ресторан Victor открывается вечером
Баринов проверяет работу кухни
София встречает гостей в зале" > ../opening_day

chmod 755 .
chmod u=rwx,g=r-x,o=--- victor/
chmod 750 victor/kitchen
chmod u=rw-,g=r--,o=r-- victor/kitchen/new_menu
chmod 640 victor/kitchen/dinner_order
chmod u=rwx,g=rwx,o=--- victor/hall/
chmod 644 victor/hall/opening_guests
chmod 710 hotel_office/
chmod u=r--,g=r--,o=--- hotel_office/eleonora_order
chmod u=rwx,g=r-x,o=--x reception/
chmod 640 reception/sofia_schedule
chmod u=rw-,g=r--,o=--- reception/guest_notes
chmod 750 staff_room/
chmod 600 staff_room/barinov_uniform
chmod u=r--,g=r--,o=--- staff_room/kostya_message
chmod u=rwx,g=r-x,o=--- roof/
chmod 640 roof/max_letter
chmod u=r--,g=r--,o=--- roof/roof_event
chmod 644 ../opening_day

cp hotel_office/eleonora_order victor/hall/owner_order
cp -r roof/ victor/roof_archive
cd staff_room
ln -s ../victor/kitchen/new_menu current_menu
cd ../../
ln -s reception/ hotel_reception
cd eleon/victor/hall/
ln ../../../opening_day opening_log
cd ../../
cat victor/hall/opening_guests reception/guest_notes > reception/all_guests
cat staff_room/kostya_message >> opening_day
mv roof/max_letter hotel_office/max_message

ls -lR eleon | grep "^-" | sort -k5 -n -r | head -6
grep -r -i -h "баринов\|софия" . | grep -v -i "гост" | sort | head -5
grep -r -l -i "гост" victor/hall/ reception/ | wc -l
ls -1 reception | while read file; do [ -f "reception/$file" ] && { head -n 1 "reception/$file"; tail -n 1 "reception/$file"; }; done | grep -i -E "гост|соф" | sort -r
grep -v -i "столик" reception/all_guests | sort -r | head -4 | wc -w
ls -lR ../ | grep "^-" | grep -E "^[^ ]+ 2 " | rev | cut -d' ' -f1 | rev
grep -r -l -i -E "баринов|макс" victor/roof_archive 2>/dev/null | wc -l

rm -f hotel_office/eleonora_order
rm -f staff_room/current_menu
rm ../hotel_reception
rm ../opening_day
rm victor/hall/opening_log
rm -f roof/roof_event
rmdir roof/
rm -rf victor/roof_archive