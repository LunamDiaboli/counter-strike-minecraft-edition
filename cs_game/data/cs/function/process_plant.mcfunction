# --- ПРОЦЕСС УСТАНОВКИ (KOLOK4P@) ---

# 1. Уменьшаем таймер на 1 каждый тик
scoreboard players remove @s plant_timer 1

# 2. Визуализация и звук (Пиканье во время установки)
# Оператор деления по модулю (каждые 10 тиков = 2 раза в секунду)
execute if score @s plant_timer matches 90 run playsound minecraft:ui.button.click master @a[distance=..10] ~ ~ ~ 1 1
execute if score @s plant_timer matches 70 run playsound minecraft:ui.button.click master @a[distance=..10] ~ ~ ~ 1 1.2
execute if score @s plant_timer matches 50 run playsound minecraft:ui.button.click master @a[distance=..10] ~ ~ ~ 1 1.4
execute if score @s plant_timer matches 30 run playsound minecraft:ui.button.click master @a[distance=..10] ~ ~ ~ 1 1.6
execute if score @s plant_timer matches 10 run playsound minecraft:ui.button.click master @a[distance=..10] ~ ~ ~ 1 1.8

# Показываем полосу прогресса террористу
title @a[tag=planting_player] actionbar {"text":"Установка бомбы... Не отходите!","color":"yellow"}

# 3. ПРОВЕРКА НА ОТМЕНУ
# Если в радиусе 3 блоков НЕТ живого игрока с тегом planting_player -> прерываем
execute unless entity @a[tag=planting_player,distance=..3,gamemode=adventure] run function cs:cancel_plant

# 4. ПРОВЕРКА НА УСПЕХ
# Если таймер дошел до 0 (или ниже) -> бомба установлена
execute if score @s plant_timer matches ..0 run function cs:finish_plant