# --- ПОБЕДА СПЕЦНАЗА ---

# Оголошуємо перемогу КТ
title @a title {"text":"ПОБЕДА СПЕЦНАЗА","color":"blue"}
scoreboard players set #global game_state 4

# Очистка мусора на карте
kill @e[type=item]
kill @e[type=arrow]
kill @e[type=spectral_arrow]

# Видаємо нагороду (твои настройки)
give @a[team=CT] minecraft:emerald 4
give @a[team=T] minecraft:emerald 6

# Збільшуємо лічильник раундів на 1
scoreboard players add #global round 1

# Обновляем счет команды в Sidebar
scoreboard players add §9Спецназ_(CT) match_score 1

# Передаем решение Судье
function cs:check_match_end
