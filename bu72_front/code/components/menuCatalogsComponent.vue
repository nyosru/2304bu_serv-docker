<template>
    <div>
        <div class="dropdown">
            <NuxtLink class="nav-link active dropbtn" aria-current="page" to="/cat/0">Каталог</NuxtLink>
            <!-- менюшка -->
            <div class="dropdown-content">
                <a href="#">Ссылка 1</a>
                <a href="#">Ссылка 2</a>
                <a href="#">Ссылка 3</a>
                <a href="#">Ссылка 1</a>
                <a href="#">Ссылка 2</a>
                <a href="#">Ссылка 3</a>
            </div>
            {{ CatsAr }}
        </div>
    </div>
</template>

<script setup>

</script>

<style>
/* Кнопка выпадающего списка */
.dropbtn {
  /* background-color: #4CAF50; */
  color: white;
  /* padding: 16px; */
  /* font-size: 16px; */
  border: none;
}

/* Контейнер <div> - необходим для размещения выпадающего содержимого */
.dropdown {
  position: relative;
  display: inline-block;
}

/* Выпадающее содержимое (скрыто по умолчанию) */
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  /* min-width: 160px; */
  min-width: 360px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

/* Ссылки внутри выпадающего списка */
.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  /* display: block; */
  display: inline-block;
  width: 50%;
  float: left;
}

/* Изменение цвета выпадающих ссылок при наведении курсора */
.dropdown-content a:hover {background-color: #ddd;}

/* Показать выпадающее меню при наведении курсора */
.dropdown:hover .dropdown-content {display: block;}

/* Изменение цвета фона кнопки раскрывающегося списка при отображении содержимого раскрывающегося списка */
.dropdown:hover .dropbtn {background-color: #3e8e41;} 
</style>