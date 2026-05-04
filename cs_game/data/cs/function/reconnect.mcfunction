# --- ОБРАБОТЧИК ПЕРЕПОДКЛЮЧЕНИЙ (KOLOK4P@) ---

# 1. Сбрасываем триггер, чтобы код не зациклился
scoreboard players set @s quit_game 0

# 2. Если игра в ЛОББИ (game_state 0)
# Игрок просто перезашел. Очищаем его, снимаем заморозку (если он вышел во время закупки) и кидаем на спавн.
execute if score #global game_state matches 0 run clear @s
execute if score #global game_state matches 0 run team leave @s
execute if score #global game_state matches 0 run gamemode adventure @s
execute if score #global game_state matches 0 run effect clear @s
execute if score #global game_state matches 0 run attribute @s minecraft:movement_speed base set 0.1
execute if score #global game_state matches 0 run attribute @s minecraft:jump_strength base set 0.42
execute if score #global game_state matches 0 at @e[type=marker,tag=lobby_spawn,limit=1] run tp @s ~ ~ ~

# 3. Если игра ИДЕТ (game_state 1, 2, 3)
# Игрок вышел во время закупки, боя или заложенной бомбы.
# Справедливое наказание: ставим ему 1 смерть. 
# Твоя родная логика в tick.mcfunction моментально переведет его в наблюдатели, 
# удалит пушки и выбросит C4 (если она была у него), чтобы команда не пострадала.
execute if score #global game_state matches 1..3 run scoreboard players set @s deaths 1

# 4. Если идет ПАУЗА между раундами (game_state 4)
# Прощаем его, так как через пару секунд начнется новый раунд и система его сама телепортирует
execute if score #global game_state matches 4 run scoreboard players set @s deaths 0

# 5. Уведомление в чат (если игра идет)
execute if score #global game_state matches 1..3 run tellraw @a [{"text":"[Анти-Лив] ","color":"red"},{"selector":"@s"},{"text":" покинул игру и признан убитым в этом раунде.","color":"gray"}]