# 1. Устанавливаем статус "Основной раунд" и таймер на 180 секунд
scoreboard players set #global game_state 2
scoreboard players set #global timer 180

# 2. Снимаем заморозку (возвращаем бег и прыжок)
# 1. Возвращаем движение
effect clear @a minecraft:slowness
execute as @a run attribute @s minecraft:jump_strength base set 0.42

# Удаление торговцев перед боем
kill @e[type=villager,tag=shop_npc]


# 3. Выводим сообщение и звук старта
title @a title {"text":"ИГРА НАЧАЛАСЬ!","color":"green"}
playsound minecraft:entity.ender_dragon.growl master @a ~ ~ ~ 1 1
effect give @a regeneration 1 255 true

# Включаем ПВП, когда начинается раунд
gamerule pvp true