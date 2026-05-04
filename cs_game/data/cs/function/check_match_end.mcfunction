# --- ПРОВЕРКА ЗАВЕРШЕНИЯ МАТЧА MR12 (KOLOK4P@) ---

# 1. Условие победы Спецназа (13 очков)
execute if score §9Спецназ_(CT) match_score matches 13.. run return run function cs:end_game

# 2. Условие победы Террористов (13 очков)
execute if score §cТеррористы_(T) match_score matches 13.. run return run function cs:end_game

# 3. Условие ничьи (12-12)
execute if score §9Спецназ_(CT) match_score matches 12 if score §cТеррористы_(T) match_score matches 12 run return run function cs:end_game

# 4. Продолжаем игру (Если никто не победил)
schedule function cs:phase_prep 5s