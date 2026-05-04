# --- ФАЗА ПОДГОТОВКИ ---

# 0. Очистка карты перед началом нового цикла
function cs:cleanup

# 1. Устанавливаем статус "Подготовка" и таймер на 20 секунд
scoreboard players set #global game_state 1
scoreboard players set #global timer 20

# 2. Воскрешаем только участников команд
gamemode adventure @a[team=CT]
gamemode adventure @a[team=T]

# 3. Полностью лечим игроков перед новым раундом (оставлен один экземпляр)
effect give @a instant_health 5 255 true

# 4. Очищаем "призраки" старой бомбы
execute at @e[type=armor_stand,tag=c4_entity] run fill ~-3 ~-3 ~-3 ~3 ~3 ~3 air replace tnt
kill @e[type=armor_stand,tag=c4_entity]

# 5. Сбрасываем попытки установки бомбы
scoreboard players set @a plant_c4 0

# 6. Эксклюзивная телепортация на базы (Одна карта)

# 6.1. Очищаем технический тег со всех игроков перед началом
tag @a remove placed

# 6.2. Распределение Спецназа
execute as @e[type=marker,tag=spawn_ct] at @s as @r[team=CT,tag=!placed] run tp @s ~ ~ ~
execute as @e[type=marker,tag=spawn_ct] at @s run tag @a[team=CT,tag=!placed,distance=..1] add placed

# 6.3. Распределение Террористов
execute as @e[type=marker,tag=spawn_t] at @s as @r[team=T,tag=!placed] run tp @s ~ ~ ~
execute as @e[type=marker,tag=spawn_t] at @s run tag @a[team=T,tag=!placed,distance=..1] add placed

# 6.4. Система Fallback (Если игроков больше, чем маркеров)
execute as @a[team=CT,tag=!placed] at @s run tp @s @e[type=marker,tag=spawn_ct,sort=random,limit=1]
execute as @a[team=T,tag=!placed] at @s run tp @s @e[type=marker,tag=spawn_t,sort=random,limit=1]

# 6.5. Финальная очистка
tag @a remove placed

# 6.6. Привязываем точку возрождения к карте (Защита от бага с лобби)
# Это заставит игроков возрождаться на базе (в режиме наблюдателя), а не улетать далеко
execute as @a at @s run spawnpoint @s ~ ~ ~

# 7. Замораживаем игроков (Блокировка X, Y, Z)
effect give @a minecraft:slowness 20 255 true
execute as @a run attribute @s minecraft:jump_strength base set 0.0

# 8. ПЕРСОНАЛЬНЫЕ МАГАЗИНЫ (Решение проблемы с 1 торговцем)
# Спавн для CT (перед лицом каждого игрока)
execute as @a[team=CT] at @s anchored eyes run summon villager ^ ^-1 ^ {Tags:["shop_npc"],Silent:1b,Invulnerable:1b,CustomNameVisible:1b,NoAI:1b,CustomName:{"color":"green","text":"Магаз"},VillagerData:{level:99,profession:"minecraft:weaponsmith",type:"minecraft:plains"},Offers:{Recipes:[{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:3},sell:{id:"minecraft:stone_sword",count:1,components:{"minecraft:unbreakable":{}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:6},sell:{id:"minecraft:iron_sword",count:1,components:{"minecraft:unbreakable":{}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:1},sell:{id:"minecraft:chainmail_helmet",count:1,components:{"minecraft:damage":115}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:2},sell:{id:"minecraft:chainmail_chestplate",count:1,components:{"minecraft:damage":190}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:2},sell:{id:"minecraft:iron_helmet",count:1,components:{"minecraft:damage":115}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:4},sell:{id:"minecraft:iron_chestplate",count:1,components:{"minecraft:damage":190}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:1},sell:{id:"minecraft:shears",count:1,components:{"minecraft:unbreakable":{},"minecraft:custom_name":'{"text":"Дефуза"}'}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:5},sell:{id:"minecraft:crossbow",count:1,components:{"minecraft:unbreakable":{},"minecraft:custom_name":{"color":"aqua","text":"Пистолет"},"minecraft:enchantments":{"quick_charge":3}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:10},sell:{id:"minecraft:crossbow",count:1,components:{"minecraft:unbreakable":{},"minecraft:custom_name":{"color":"gold","text":"Автомат"},"minecraft:enchantments":{"quick_charge":6,"piercing":2}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:18},sell:{id:"minecraft:bow",count:1,components:{"minecraft:unbreakable":{},"minecraft:custom_name":{"color":"dark_red","text":"Снайперская винтовка"},"minecraft:enchantments":{"power":5,"piercing":3}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:2},sell:{id:"minecraft:arrow",count:16,components:{"minecraft:custom_name":{"color":"dark_gray","text":"Патроны"}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:2},sell:{id:"minecraft:splash_potion",count:1,components:{"minecraft:potion_contents":{custom_color:10329495,custom_effects:[{id:"minecraft:blindness",amplifier:1,duration:200}]}, "minecraft:custom_name":{"color":"gray","text":"Флешка"}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:3},sell:{id:"minecraft:splash_potion",count:1,components:{"minecraft:potion_contents":{potion:"minecraft:harming",custom_color:16701501},"minecraft:custom_name":{"color":"yellow","text":"HE"}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:4},sell:{id:"minecraft:lingering_potion",count:1,components:{"minecraft:potion_contents":{potion:"minecraft:strong_harming",custom_color:11546150},"minecraft:custom_name":{"color":"red","text":"Молик"}}}}]}}

# Спавн для T (перед лицом каждого игрока)
execute as @a[team=T] at @s anchored eyes run summon villager ^ ^-1 ^ {Tags:["shop_npc"],Silent:1b,Invulnerable:1b,CustomNameVisible:1b,NoAI:1b,CustomName:{"color":"green","text":"Магаз"},VillagerData:{level:99,profession:"minecraft:weaponsmith",type:"minecraft:plains"},Offers:{Recipes:[{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:3},sell:{id:"minecraft:stone_sword",count:1,components:{"minecraft:unbreakable":{}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:6},sell:{id:"minecraft:iron_sword",count:1,components:{"minecraft:unbreakable":{}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:1},sell:{id:"minecraft:chainmail_helmet",count:1,components:{"minecraft:damage":115}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:2},sell:{id:"minecraft:chainmail_chestplate",count:1,components:{"minecraft:damage":190}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:2},sell:{id:"minecraft:iron_helmet",count:1,components:{"minecraft:damage":115}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:4},sell:{id:"minecraft:iron_chestplate",count:1,components:{"minecraft:damage":190}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:1},sell:{id:"minecraft:shears",count:1,components:{"minecraft:unbreakable":{},"minecraft:custom_name":'{"text":"Дефуза"}'}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:5},sell:{id:"minecraft:crossbow",count:1,components:{"minecraft:unbreakable":{},"minecraft:custom_name":{"color":"aqua","text":"Пистолет"},"minecraft:enchantments":{"quick_charge":3}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:10},sell:{id:"minecraft:crossbow",count:1,components:{"minecraft:unbreakable":{},"minecraft:custom_name":{"color":"gold","text":"Автомат"},"minecraft:enchantments":{"quick_charge":6,"piercing":2}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:18},sell:{id:"minecraft:bow",count:1,components:{"minecraft:unbreakable":{},"minecraft:custom_name":{"color":"dark_red","text":"Снайперская винтовка"},"minecraft:enchantments":{"power":5,"piercing":3}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:2},sell:{id:"minecraft:arrow",count:16,components:{"minecraft:custom_name":{"color":"dark_gray","text":"Патроны"}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:2},sell:{id:"minecraft:splash_potion",count:1,components:{"minecraft:potion_contents":{custom_color:10329495,custom_effects:[{id:"minecraft:blindness",amplifier:1,duration:200}]}, "minecraft:custom_name":{"color":"gray","text":"Флешка"}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:3},sell:{id:"minecraft:splash_potion",count:1,components:{"minecraft:potion_contents":{potion:"minecraft:harming",custom_color:16701501},"minecraft:custom_name":{"color":"yellow","text":"HE"}}}},{rewardExp:0b,maxUses:999,buy:{id:"minecraft:emerald",count:4},sell:{id:"minecraft:lingering_potion",count:1,components:{"minecraft:potion_contents":{potion:"minecraft:strong_harming",custom_color:11546150},"minecraft:custom_name":{"color":"red","text":"Молик"}}}}]}}

effect give @a regeneration 10 255 true

# 9. Выводим сообщение на экран
title @a title {"text":"Фаза закупки","color":"yellow"}
title @a subtitle {"text":"До начала раунда 20 секунд"}

# 10. Выдача базового снаряжения
function cs:give_loadout