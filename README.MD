# ft_server
Проект для знакомства с докером.<br>
Сервер Nginx с Wordpress, phpMyAdmin и базой данных SQL.

### Создание образа
```$ docker build -t ft_server .```

### Запуск контейнера
```$ docker run -it -p80:80 -p443:443 ft_server```

По умолчанию в настройках nginx включен autoindex.<br>
При переходе на сайт http://localhost появится список директорий

<ul>
    <li>/pma - phpMyAdmin</li>
    <li>/wordpress - Сайт на wordpress</li>
</ul>

Чтобы отключить автоиндекс, необходимо перезапустить контейнер с дополнительной опцией --env<br>
```$ docker run --env AUTOINDEX=off -it -p80:80 -p443:443 ft_server```
<br>
<br>
Для доступа на страницу /pma<br>
**login** - admin<br>
**password** - password