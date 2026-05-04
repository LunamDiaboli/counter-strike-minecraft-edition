# --- СТАРТ МАТЧА (Одна карта) ---

# 1. Проверка условий (Нужны обе команды)
execute as @p unless entity @a[team=CT] run tellraw @s {"text":"Ошибка: Нет игроков за Спецназ!","color":"red"}
execute as @p unless entity @a[team=T] run tellraw @s {"text":"Ошибка: Нет игроков за Террористов!","color":"red"}

# 2. Если все условия соблюдены -> Запускаем инициализацию первого раунда
execute if entity @a[team=CT] if entity @a[team=T] run function cs:init_first_round