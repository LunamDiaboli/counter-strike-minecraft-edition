# --- РАБОТА ТАЙМЕРА ---
# Прибавляем 1 тик (в 1 секунде 20 тиков)
scoreboard players add #global ticks 1

scoreboard objectives add plant_timer dummy

# Каждые 20 тиков (1 секунду) отнимаем 1 секунду от таймера и обнуляем тики
execute if score #global ticks matches 20.. run scoreboard players remove #global timer 1
execute if score #global ticks matches 20.. run scoreboard players set #global ticks 0

# Чтобы таймер не уходил в минус:
execute if score #global timer matches ..0 run scoreboard players set #global timer 0

# --- АНТИ-ЛИВ СИСТЕМА (KOLOK4P@) ---
# Если игрок вернулся на сервер после выхода, запускаем обработчик
execute as @a[scores={quit_game=1..}] run function cs:reconnect


# --- ЛОГИКА СМЕНЫ ФАЗ ---
# Если идет фаза 1 (Начало раунда, 20 сек) и таймер дошел до 0 -> Запускаем основной раунд
execute if score #global game_state matches 1 if score #global timer matches 0 run function cs:phase_main

# Если идет фаза 2 (Основной раунд, 180 сек) и таймер дошел до 0 -> Время вышло, побеждают КТ
execute if score #global game_state matches 2 if score #global timer matches 0 run function cs:win_ct

# Если идет фаза 3 (Бомба, 40 сек) и таймер дошел до 0 -> Бомба взрывается, побеждают Т
execute if score #global game_state matches 3 if score #global timer matches 0 run function cs:win_t_bomb

# Отображение таймера на экране (Actionbar)
execute if score #global game_state matches 1.. run title @a actionbar [{"text":"Осталось времени: ","color":"gold"},{"score":{"name":"#global","objective":"timer"},"color":"white"},{"text":" сек.","color":"white"}]


# --- ПРОВЕРКА ЖИВЫХ ИГРОКОВ ---
# Если идет основной раунд (game_state 2) и нет живых Т -> победа КТ
execute if score #global game_state matches 2 unless entity @a[team=T,gamemode=adventure] run function cs:win_ct

# Если идет основной раунд (game_state 2) и нет живых КТ -> победа Т
execute if score #global game_state matches 2 unless entity @a[team=CT,gamemode=adventure] run function cs:win_t

# Если бомба установлена (game_state 3) и нет живых КТ -> мгновенная победа Т
execute if score #global game_state matches 3 unless entity @a[team=CT,gamemode=adventure] run function cs:win_t

# --- ЭКОНОМИКА В БОЮ ---

# 1. Награда за убийство противника (+1 изумруд)
# Работает для всех, у кого счетчик kills увеличился хотя бы на 1
execute as @a[scores={kills=1..}] run give @s minecraft:emerald 1

# 2. Штраф за тимкилл (-2 изумруда)
# Проверяем: если игрок из CT убил кого-то, и в этот же момент в радиусе 10 блоков умер союзник из CT
# Мы используем clear, чтобы забрать изумруды. Если их нет — баланс просто останется нулевым.
execute as @a[team=CT,scores={kills=1..}] at @s if entity @a[team=CT,scores={deaths=1..},distance=..10] run clear @s minecraft:emerald 2

# Аналогичная проверка для команды Террористов
execute as @a[team=T,scores={kills=1..}] at @s if entity @a[team=T,scores={deaths=1..},distance=..10] run clear @s minecraft:emerald 2

# --- СИСТЕМА ДРОПА И АНТИ-ДРОПА (KOLOK4P@) ---

# 1. Анти-дроп для живых игроков (Всё, кроме бомбы)
# Если выброшенный предмет НЕ является ТНТ, мы моментально обнуляем его задержку подбора (PickupDelay).
# Предмет немедленно "всасывается" обратно в инвентарь владельца.
execute as @e[type=item,nbt=!{Item:{id:"minecraft:tnt"}}] run data modify entity @s PickupDelay set value 0

# 2. Блокировка подбора бомбы для Спецназа
# Ванильная задержка броска — 40 тиков (2 секунды). Когда она истекает (становится 0),
# мы принудительно ставим задержку на 32767 тиков (около 27 минут). Это делает бомбу "неподнимаемой".
execute as @e[type=item,nbt={Item:{id:"minecraft:tnt"}}] if data entity @s {PickupDelay:0s} run data modify entity @s PickupDelay set value 32767

# 3. Разрешение подбора бомбы только для Террористов
# Если рядом с бомбой (в радиусе 1.5 блоков) есть живой Террорист, 
# мы обнуляем задержку, позволяя ему подобрать её. Спецназ этого сделать не сможет.
execute as @e[type=item,nbt={Item:{id:"minecraft:tnt"}}] at @s if entity @a[team=T,gamemode=adventure,distance=..1.5] run data modify entity @s PickupDelay set value 0


# --- ЛОГИКА СМЕРТИ И ДРОП БОМБЫ (KOLOK4P@) ---
# Проверяется каждый тик до перевода игрока в spectator

# 1. Если умирает Террорист и у него в инвентаре есть ТНТ — спавним сущность бомбы на месте его смерти.
# Мы вручную задаем все NBT-компоненты для версии 1.21.1 (имя, цвет, возможность ставить на красную шерсть).
# 1. Спавним бомбу с задержкой подбора 2 секунды (PickupDelay:40s)
# 1. Спавним бомбу с задержкой подбора 2 секунды (PickupDelay:40s)
execute as @a[scores={deaths=1..},team=T] at @s if items entity @s container.* minecraft:tnt run summon item ~ ~1 ~ {PickupDelay:40s,Item:{id:"minecraft:tnt",count:1,components:{"minecraft:item_name":'{"italic":false,"color":"dark_red","bold":true,"text":"C4 (Бомба)"}',"minecraft:can_place_on":[{blocks:"minecraft:red_wool"}]}}}

# 2. Принудительно удаляем бомбу из инвентаря убитого (чтобы из-за keepInventory она не осталась у него после возрождения)
execute as @a[scores={deaths=1..}] run clear @s minecraft:tnt

# --- АБСОЛЮТНАЯ ЗАЩИТА БОМБЫ (KOLOK4P@) ---
# Если Спецназовец чудом подобрал бомбу (стоял в упор с Террористом), выбиваем её из инвентаря.
# 1. Спавним бомбу обратно в мир (прямо в координатах Спецназовца, который её схватил)
execute as @a[team=CT] at @s if items entity @s container.* minecraft:tnt run summon item ~ ~1 ~ {PickupDelay:40s,Item:{id:"minecraft:tnt",count:1,components:{"minecraft:item_name":'{"italic":false,"color":"dark_red","bold":true,"text":"C4 (Бомба)"}',"minecraft:can_place_on":[{blocks:"minecraft:red_wool"}]}}}

# 2. Моментально удаляем её из инвентаря CT
execute as @a[team=CT] run clear @s minecraft:tnt

# 3. СБРОС СЧЕТЧИКА УБИЙСТВ
# --- СБРОС СЧЕТЧИКА УБИЙСТВ И ЛОГИКА СМЕРТИ ---
scoreboard players set @a[scores={kills=1..}] kills 0

# ИЗЪЯТИЕ СНАРЯЖЕНИЯ У УБИТЫХ (KOLOK4P@)
# Мы удаляем пушки, гранаты и покупную броню. Изумруды остаются в инвентаре!
execute as @a[scores={deaths=1..}] run clear @s #minecraft:swords
execute as @a[scores={deaths=1..}] run clear @s bow
execute as @a[scores={deaths=1..}] run clear @s crossbow
execute as @a[scores={deaths=1..}] run clear @s arrow
execute as @a[scores={deaths=1..}] run clear @s splash_potion
execute as @a[scores={deaths=1..}] run clear @s lingering_potion
execute as @a[scores={deaths=1..}] run clear @s chainmail_helmet
execute as @a[scores={deaths=1..}] run clear @s chainmail_chestplate
execute as @a[scores={deaths=1..}] run clear @s iron_helmet
execute as @a[scores={deaths=1..}] run clear @s iron_chestplate
execute as @a[scores={deaths=1..}] run clear @s shears

# Переводим только что убитых игроков в режим наблюдателя
execute as @a[scores={deaths=1..}] run gamemode spectator @s
execute as @a[scores={deaths=1..}] run scoreboard players set @s deaths 0

# --- МЕХАНИКА УСТАНОВКИ С4 (ПЛЭНТЫ) ---
# Если игрок поставил бомбу (plant_c4 >= 1), запускаем проверку, находится ли он на Плэнте
execute as @a[scores={plant_c4=1..}] at @s run function cs:check_plant_zone

# Обязательно сбрасываем скорборд всем после проверки (чтобы код не зацикливался)
scoreboard players set @a[scores={plant_c4=1..}] plant_c4 0


# --- ЭФФЕКТЫ С4 ---
# Если идет фаза бомбы (game_state 3), каждую секунду воспроизводим звук "пик" у бомбы
execute if score #global game_state matches 3 if score #global ticks matches 20 at @e[type=armor_stand,tag=c4_entity] run playsound minecraft:block.note_block.bit master @a ~ ~ ~ 1 1.5

# Визуальные частицы дыма вокруг бомбы (постоянно)
execute if score #global game_state matches 3 at @e[type=armor_stand,tag=c4_entity] run particle minecraft:smoke ~ ~0.5 ~ 0.2 0.2 0.2 0.01 2


# --- МЕХАНИКА РАЗМИНИРОВАНИЯ ---
# 1. Если игрок не крадется (sneak = 0), обнуляем его прогресс дефьюза
execute as @a[team=CT] if score @s sneak matches 0 run scoreboard players set @s defuse_progress 0

# 2. Процесс разминирования (работает только в фазе 3 возле бомбы)
# Без дефузов (обычный прогресс +1 за тик)
execute if score #global game_state matches 3 as @a[team=CT,scores={sneak=1..}] at @s if entity @e[type=armor_stand,tag=c4_entity,distance=..2] unless items entity @s weapon.mainhand minecraft:shears run scoreboard players add @s defuse_progress 1

# С дефузами (ускоренный прогресс +2 за тик)
execute if score #global game_state matches 3 as @a[team=CT,scores={sneak=1..}] at @s if entity @e[type=armor_stand,tag=c4_entity,distance=..2] if items entity @s weapon.mainhand minecraft:shears run scoreboard players add @s defuse_progress 2

# 3. Звуковое сопровождение дефьюза (щелчки)
execute if score #global game_state matches 3 as @a[team=CT,scores={defuse_progress=1..}] at @s if score #global ticks matches 10 run playsound minecraft:block.stone_button.click_on master @a ~ ~ ~ 1 2

# 4. Проверка на успешное разминирование (когда накопилось 200 очков)
execute if score #global game_state matches 3 as @a[team=CT,scores={defuse_progress=200..}] run function cs:win_ct_defuse

# 5. ОЧЕНЬ ВАЖНО: Обнуляем скорборд Shift'а каждый тик, чтобы отслеживать именно удержание клавиши
scoreboard players set @a sneak 0

# Выполнять логику лобби только если игра не запущена (game_state 0)
execute if score #global game_state matches 0 run function cs:lobby_logic

# Обработка процесса установки бомбы (KOLOK4P@)
execute as @e[type=armor_stand,tag=planting_c4] at @s run function cs:process_plant

# Если идет фаза подготовки (1) или пауза (4) — удаляем любые предметы на земле каждую секунду
# (Проверка раз в 20 тиков для оптимизации)
execute if score #global game_state matches 1 if score #global timer matches ..200 run kill @e[type=item]

# --- ЗАЩИТА БОМБЫ ОТ ВЫЛЕТА ЗА КАРТУ (KOLOK4P@) ---

# Если выброшенная С4 оказалась дальше 150 блоков от базы Террористов (т.е. в лобби),
# мы мгновенно телепортируем её обратно на спавн T. 
execute as @e[type=item,nbt={Item:{id:"minecraft:tnt"}}] at @s unless entity @e[type=marker,tag=spawn_t,distance=..150] run tp @s @e[type=marker,tag=spawn_t,limit=1]