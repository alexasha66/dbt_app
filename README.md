Показать и обяснить как работает модель dbt increment

на общем частом примере - обновление таблицы-приемника

на основании данных таблиц источников.



Проект создавался стандартно:

1. На локальной машине создан каталог проекта dbt_app, в котором создан каталог data для загрузки внешних файлов данных в формате csv

Для таблиц visits, dop_info_ump, dop_info_date тестовой базы dbtDB.

2. Создан проект dbt

Dbt init dbt_project

Для связи с БД указан profiles.yml в каталоге profiles

3. Сам тестовый проект построен на двух контейнерах docker (postgres и dbt), контейнер dbt “видит проект” через volumes



-------------------

В чем нужна помощь



Нужно построить инкрементальную модель (напр dst_visits) для таблиц источников visits, dop_info_ump, dop_info_date

Где из таблицы visits выбираются все данные по дате ключу уникальности id_service

Со значениями полей visits.ctrldate, visits.vid , которые в источнике пусты и дожны быть взяты из таблиц dop_info_date и dop_info_ump



то есть , если нет ключа, то добавляем запись из visits, если есть - обновлем запись из visits, НО

дату ctrldate берем из таблицы источника dop_info_date, а vid берем из dop_info_ump, используя case выражение


-------------------


Примерная логика:



declare @DB date

set @DB = (select min(ctrldate) from dop_info_date)



update visits set

  vid = case when u.case_ump = 4 then 'r'

  when u.case_ump = 3 then 'a'

  when u.case_ump = 2 then 'd'

  when u.case_ump = 1 then 's' end

from visits v

  join dop_info_ump u on v.id_service = c.id_service

where v.ctrldate >= @DB

  and v.vid is null;

commit;


-------------------


Кроме dbt_core и dbt_postgres также установлен dbt_utils (локально, не в докер)



Очень хотелось бы понять best practice в идеологии построения dbt проектов (включая докер)

для похожих операций, обновления справочников и тп
