# --- ИНИЦИАЛИЗАЦИЯ ПЕРВОГО РАУНДА (KOLOK4P@) ---

# 1. Установка глобальных параметров
scoreboard players set #global game_state 1
scoreboard players set #global round 1

# 2. Сброс счета в Sidebar (обнуляем старые результаты)
scoreboard players set §9Спецназ_(CT) match_score 0
scoreboard players set §cТеррористы_(T) match_score 0

attribute @s minecraft:camera_distance base set 0
attribute @s minecraft:movement_speed base set 0.07

# 3. Переход к первой фазе закупки
function cs:phase_prep

# 4. Уведомление
title @a title {"text":"ИГРА НАЧАЛАСЬ!","color":"green"}