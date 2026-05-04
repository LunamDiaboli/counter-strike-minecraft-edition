# --- ПРОВЕРКА ЗОНЫ УСТАНОВКИ ---

# --- УСПЕШНАЯ УСТАНОВКА (Начало процесса 5 сек) ---

# 1. Помечаем игрока, который начал установку
execute if entity @e[type=marker,tag=plant_zone,distance=..10] run tag @s add planting_player

# 2. Спавним маркер процесса прямо в координатах игрока
execute if entity @e[type=marker,tag=plant_zone,distance=..10] run summon armor_stand ~ ~ ~ {Tags:["planting_c4"],Invisible:1b,Marker:1b}

# 3. Задаем таймеру 100 тиков (5 секунд * 20 тиков)
execute if entity @e[type=marker,tag=plant_zone,distance=..10] run scoreboard players set @e[type=armor_stand,tag=planting_c4,distance=..2,limit=1] plant_timer 100

# 2. Если игрок слишком далеко от плэнта (нашел декоративную красную шерсть) -> отменяем
# Возвращаем кастомную С4 со всеми тегами
execute unless entity @e[type=marker,tag=plant_zone,distance=..10] run give @s tnt[unbreakable={},item_name={"text":"C4 (Бомба)","color":"dark_red","bold":true,"italic":false},can_place_on={blocks:["minecraft:red_wool"]}] 1

# 3. Расширяем зону сканирования для удаления ошибочного ТНТ до 5 блоков!
# Это покрывает абсолютный максимум длины рук игрока (4.5 блока). Скрипт больше не промахнется.
execute unless entity @e[type=marker,tag=plant_zone,distance=..10] run fill ~-5 ~-5 ~-5 ~5 ~5 ~5 air replace tnt

# 4. Выводим предупреждение
execute unless entity @e[type=marker,tag=plant_zone,distance=..10] run title @s actionbar {"text":"Здесь нельзя ставить бомбу! Ищите точку А или Б","color":"red"}