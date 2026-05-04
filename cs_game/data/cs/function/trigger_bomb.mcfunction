# 1. Запускаємо фазу бомби (змінить game_state на 3 і таймер на 40)
function cs:phase_bomb

# 2. Видаємо нагороду терористу за встановлення (1 смарагд)
give @s emerald 1

# 3. Обнуляємо скорборд гравця, щоб код не спрацьовував безкінечно
scoreboard players set @s plant_c4 0

# 4. Перетворюємо поставлений блок TNT на сутність (для розмінування)
# Ми шукаємо блок TNT поруч з гравцем і замінюємо його на невидимого Armor Stand'а.
# Це потрібно, щоб ми могли взаємодіяти з бомбою ножицями.
execute align xyz run summon armor_stand ~0.1 ~ ~0.1 {Tags:["c4_entity"],Invisible:1b,Marker:1b,NoGravity:1b}