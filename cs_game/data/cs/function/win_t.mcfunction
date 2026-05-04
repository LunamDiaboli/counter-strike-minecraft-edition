# --- ПОБЕДА ТЕРРОРИСТОВ ---

# Оголошуємо перемогу Т
title @a title {"text":"ПОБЕДА ТЕРРОРИСТОВ","color":"red"}
scoreboard players set #global game_state 4

# Очистка мусора на карте
kill @e[type=item]
kill @e[type=arrow]
kill @e[type=spectral_arrow]

# --- ЭКОНОМИКА: ВЫДАЧА НАГРАД ---
give @a[team=T] minecraft:emerald 3
give @a[team=CT] minecraft:emerald 6

# Збільшуємо лічильник раундів на 1
scoreboard players add #global round 1

# Обновляем счет команды в Sidebar
scoreboard players add §cТеррористы_(T) match_score 1

# Передаем решение Судье
function cs:check_match_end