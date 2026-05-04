# Отключаем ПВП по умолчанию (для лобби)
gamerule pvp false

# Детектор выхода с сервера (KOLOK4P@)
scoreboard objectives add quit_game minecraft.custom:minecraft.leave_game

# Включаем сохранение инвентаря
gamerule keep_inventory true

# --- СОЗДАНИЕ КОМАНД ---
team add CT "Спецназ"
team modify CT color blue
team modify CT friendlyFire false
team modify CT collisionRule always
team modify CT nametagVisibility hideForOtherTeams

team add T "Террористы"
team modify T color red
team modify T friendlyFire false
team modify T collisionRule always
team modify T nametagVisibility hideForOtherTeams

# --- СОЗДАНИЕ СКОРБОРДОВ ---
# 1. Глобальные таймеры и состояния (используем фейкового игрока #global)
scoreboard objectives add timer dummy "Время"
scoreboard objectives add ticks dummy "Тики"
scoreboard objectives add round dummy "Раунд"
scoreboard objectives add game_state dummy "Статус игры"

# Статусы game_state: 
# 0 = Игра остановлена
# 1 = Разминка / Закупка (20 сек)
# 2 = Основной раунд (180 сек)
# 3 = Бомба установлена (40 сек)

# 2. Скорборды для отслеживания статистики (понадобятся для выдачи изумрудов)
scoreboard objectives add kills playerKillCount "Убийства"
scoreboard objectives add deaths deathCount "Смерти"

# Задаем начальные значения
scoreboard players set #global round 1
scoreboard players set #global game_state 0

scoreboard objectives add plant_c4 minecraft.used:minecraft.tnt

scoreboard objectives add sneak minecraft.custom:minecraft.sneak_time
scoreboard objectives add defuse_progress dummy

# 1. Выводим количество убийств в Tab-лист (список игроков при нажатии Tab)
scoreboard objectives setdisplay list kills

# 2. Выводим количество смертей под никнеймом игрока (над головой персонажа)
scoreboard objectives setdisplay below_name deaths

# --- НАСТРОЙКА SIDEBAR (KOLOK4P@) ---

# Создаем задачу для отображения счета с красивым заголовком
scoreboard objectives add match_score dummy "§6§l— МАТЧ —"

# Устанавливаем отображение на боковую панель
scoreboard objectives setdisplay sidebar match_score

# Инициализируем "фиктивных игроков" для команд со стартовым счетом 0
# Использование цветовых кодов (§) делает названия команд в списке цветными
scoreboard players set §9Спецназ_(CT) match_score 0
scoreboard players set §cТеррористы_(T) match_score 0