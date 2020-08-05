Приложение SAAS 
предназначено для груповвого ведения проектов 


Функционал:
Пользователь может выбрать один из двух тарифов. 
Создать свою компанию и в ней разместить от одного до бесконечности проектов.
В каждый проект можно пригласить по email любое количество новых пользователей.
В каждый проект можно загрузить файлы/вложения для общего пользования.
Админ может добавлять или удалять пользователей в конкретный проект
 

Использованно:
- Devise для учета пользователей
- Bootstrap 4.0 
- Milia - для создание Организации и вложенных проектов
- AWS S3 - хранение загруженных файлов на Amazon
- Все базы на реализованы на Postgresql
- MailTrap  - Почта для теста на Heroku  

Деплой на Heroku https://saas-app-sasha.herokuapp.com/  


Сложности: 
1)  Использование Milia
 - сложно и многоступенчато
 - множество ошибок из-за устаревших гемов ( в часности по tenants_id )
 
2) Подключение postgres на development  - не принимались пароли
3) Подключение S3 - непринимал пароли из credentials  ( был забанен на SendGrid за открытые ключи))
4) сложный деплой на heroku, т.к. Подключено ActiveStorage, который руинил любой push на Heroku 

