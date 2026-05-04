# --- ОТМЕНА УСТАНОВКИ ---

# 1. Стираем физический блок ТНТ
fill ~-5 ~-5 ~-5 ~5 ~5 ~5 air replace tnt

# Спавним предмет C4 с задержкой 2 секунды
summon item ~ ~1 ~ {PickupDelay:40s,Item:{id:"minecraft:tnt",count:1,components:{"minecraft:item_name":'{"italic":false,"color":"dark_red","bold":true,"text":"C4 (Бомба)"}',"minecraft:can_place_on":[{blocks:"minecraft:red_wool"}]}}}

# 3. Снимаем теги и убиваем временный маркер
tag @a remove planting_player
kill @s

# 4. Уведомляем команду
title @a[team=T] actionbar {"text":"Установка прервана! Бомба на земле.","color":"red"}