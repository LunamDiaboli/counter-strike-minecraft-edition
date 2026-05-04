# --- ЗАВЕРШЕНИЕ МАТЧА (KOLOK4P@) ---

# 1. Определение победителя (MR12)
execute if score §9Спецназ_(CT) match_score matches 13.. run title @a title {"text":"ПОБЕДА: СПЕЦНАЗ","color":"blue"}
execute if score §cТеррористы_(T) match_score matches 13.. run title @a title {"text":"ПОБЕДА: ТЕРРОРИСТЫ","color":"red"}
execute if score §9Спецназ_(CT) match_score matches 12 if score §cТеррористы_(T) match_score matches 12 run title @a title {"text":"НИЧЬЯ 12:12","color":"yellow"}

# 2. Убираем Actionbar с таймером
title @a actionbar {"text":""}

# 3. Остановка движка и сброс глобальных данных
scoreboard players set #global game_state 0
scoreboard players set #global round 1

# 4. Сброс личного счета игроков
scoreboard players set @a kills 0
scoreboard players set @a deaths 0

# 5. СБРОС СЧЕТА КОМАНД (обнуляем Sidebar для нового матча)
scoreboard players set §9Спецназ_(CT) match_score 0
scoreboard players set §cТеррористы_(T) match_score 0

# 6. Полная очистка игроков
clear @a
effect clear @a
effect give @a instant_health 2 255 true

# 7. Сброс режимов (воскрешаем тех, кто был в спектаторе)
gamemode adventure @a

# 8. Финальное уведомление в чат
tellraw @a [{"text":"[!] ","color":"gold"},{"text":"Матч официально завершен. Все данные обнулены.","color":"gray"}]

# 9. Выключаем ПВП после окончания игры
gamerule pvp false

# --- ВОЗВРАТ В ЛОББИ (KOLOK4P@) ---

# 10. Исключаем всех игроков из команд (чтобы они могли выбрать их заново)
team leave @a

# 11. Телепортируем всех на маркер лобби
execute at @e[type=marker,tag=lobby_spawn,limit=1] run tp @a ~ ~ ~

# 12. Сбрасываем точку возрождения обратно на лобби
execute as @a at @s run spawnpoint @s ~ ~ ~