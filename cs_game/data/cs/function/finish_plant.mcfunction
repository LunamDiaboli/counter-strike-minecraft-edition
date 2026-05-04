# --- УСПЕШНОЕ ЗАВЕРШЕНИЕ УСТАНОВКИ (KOLOK4P@) ---

# 1. Переквалифицируем временный маркер в боевую бомбу
tag @s add c4_entity
tag @s remove planting_c4

# 2. Снимаем системный тег с игрока
tag @a remove planting_player

# 3. Вызываем твой готовый скрипт начала 40-секундного отсчета
function cs:trigger_bomb