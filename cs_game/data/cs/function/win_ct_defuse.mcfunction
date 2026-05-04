# Выводим сообщение
title @a title {"text":"БОМБА ОБЕЗВРЕЖЕНА","color":"blue"}
playsound minecraft:entity.player.levelup master @a ~ ~ ~ 1 1

# Удаляем блок TNT из мира (ищем в радиусе 3 блоков от маркера бомбы)
execute at @e[type=armor_stand,tag=c4_entity] run fill ~-3 ~-3 ~-3 ~3 ~3 ~3 air replace tnt

# Уничтожаем технический маркер бомбы
kill @e[type=armor_stand,tag=c4_entity]

# Вызываем твою стандартную функцию победы спецназа (чтобы выдать деньги и сменить раунд)
function cs:win_ct