# Меняем статус игры и таймер на 40 секунд
scoreboard players set #global game_state 3
scoreboard players set #global timer 40

# Звук и сообщение для всех
playsound minecraft:entity.tnt.primed master @a ~ ~ ~ 1 1
title @a title {"text":"БОМБА УСТАНОВЛЕНА","color":"dark_red"}