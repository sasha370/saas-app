Приложение SAAS 
предназначено для груповвого ведения проектов 


Функционал:
Пользователь может выбрать один из двух тарифов. 
Создать свою компанию и в ней разместить от одного до бесконечности проектов.
В каждый проект можно пригласить по email любое количество новых пользователей.
В каждый проект можно загрузить файлы/вложения для общего пользования.


Использованно:
- Devise для учета пользователей
- Bootstrap 4.0 
- Milia - для создание Организации и вложенных проектов
- Datepicker - подключение календаря для выбора дат
- AWS S3 - хранение загруженных файлов на Amazon
- Все базы на реализованы на Postgresql
- SentGrid  - для почты 

Деплой на Heroku https://saas-app-sasha.herokuapp.com/  


Сложности: 
1)  Использование Milia
 - сложно и многоступенчато
 - множество ошибок из-за устаревших гемов ( в часности по tenants_id )
 - 
2) Подключение Datepicker - не срабатывали события JS 
3) Подключение postgres на development  - не принимались пароли
4) Подключение S3 - непринимал пароли из credentials 
5) 
