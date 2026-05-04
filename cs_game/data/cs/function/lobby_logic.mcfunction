# --- ЛОГИКА ВЫБОРА КОМАНД ---

# 1. Проверка синего бетона (Спецназ)
# Если игрок стоит на синем бетоне и он еще не в команде CT — добавляем его
execute as @a[team=!CT] at @s if block ~ ~-1 ~ minecraft:blue_concrete run function cs:join_ct

# 2. Проверка красного бетона (Террористы)
# Если игрок стоит на красном бетоне и он еще не в команде T — добавляем его
execute as @a[team=!T] at @s if block ~ ~-1 ~ minecraft:red_concrete run function cs:join_t