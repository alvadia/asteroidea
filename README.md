# Ast**e**roidea

[![Build Status](https://travis-ci.org/cmc-haskell-2018/asteroidea.svg?branch=master)](https://travis-ci.org/cmc-haskell-2018/asteroidea)

## Сборка и запуск Asteroidea

Соберите проект при помощи [утилиты Stack](https://www.haskellstack.org):

```
stack setup
stack build
stack exec asteroidea
```
Запуск с параметром названия модели name (По умолчанию serpinski):
```
stack exec asteroidea -- pic name
```
Запуск с параметром интерполяции между парой моделей name0, name1 (По умолчанию serpinski, serpinski0):
```
stack exec asteroidea -- interpol name0 name1
```
Запуск с параметром анимации между парой моделей name0, name1 в gif-файл file (По умолчанию serpinski, serpinski0):
```
stack exec asteroidea -- anime name0 name1 file
```
Запуск с параметром загрузки модели из файла:
```
stack exec asteroidea -- read file
```
### Формат файла:
В файле для загрузки модели должны находиться параметры модели, которые необхожимо изменить, для получения желаемой модели.

Параметры хранятся в формате: <Имя параметра> <Список аргументов>. Порядок параметров не важен, наличие всех параметров необязательно.
В конце файла пишется end.

В модели могут быть параметры:
```
mName <Имя модели>
mGradient <Градиент>
mWidth <Ширина изображения>
mHeight <Высота изображения>
mScale <Масштаб>
mShiftX <Смещение камеры по х>
mShiftY <Смещение камеры по у>
mRotation <Поворот камеры>
mBackgroundColour <3 значения цвета в RGB>
mOuterIter <Количество точек>
mInnerIter <Глубина обсчета точки>
mTransforms <Список трансформ>
mFinal <Финальная трансформа> endF
```

Список трансформ содержит параметры трансформ, входящих в модель. Каждая трансформа в списке должна заканчиваться словом endT.

Параметры трансформ:
```
tWeight <Вес в вероятностном распределении>
tColorPosition <Указатель на позицию в градиенте>
tColorSpeed <"Скорость" изменения цвета>
tOpacity <Яркость>
tVariation <Вариации>
tXaos <Переопределение вероятностного пространства> (Параметров в Xaos должно быть столько же, сколько трансформ)
```

![](/other/aster.gif)

[Статья, лежащая в основе данного проекта.](http://flam3.com/flame.pdf)

##COPYING

Copyright © 2018, Зайцев И.О., Зизов В.С., Копылов О.П., Тутушкин А.Е.

Данная программа является результатом интеллектуальной деятельности, которому предоставляется правовая охрана.  Право на данный результат интеллектуальной  деятельности принадлежит коллективу авторов совместно. Ни название Asteroidea, ни имена её авторов не могут быть использованы в качестве поддержки или продвижения продуктов, основанных на этом ПО без предварительного письменного разрешения.

см. файл [LICENSE MIT](/LICENSE)

## Манифест

Мы - творцы, и счастливы представить миру своё творение.

Цель работы - понятность и простота, выражение средствами языка Haskell системы построения фракталов.

### Имя ей - Asteroidea.

Радость в наших сердцах - радость чаянным и нечаянным посетителям, случайным и намеренным визитам, людям любопытствующим, интересующимся и понимающим. Нам важен каждый, кому интересна тема фракталов, кто готов постигать их крастоу, кто видит изящество языка и прелесть чистых функций. Всякий добрый человек может рассчитывать на нашу поддержку и объяснение использованных техник, пояснение хода мыслей и любые разъяснения по тематике работы.

Мы готовы делиться знанием и результатами своего труда. Будем благодарны вашей признательности, поддержке и помощи. Рассчитываем на отзывы, конструктивную криитку и предложения. Каждый ценный вклад будет памятен в логах проекта.

В работе мы старались передать своё видение задачи и способов её решения. Она не окончена, и не может завершиться - так же, как недостижимо совершенство для требовательного взора. Мы не берём на себя обязательств и не гарантируем поддержку на протяжении жизни Asteroidea.

Наше творение свободно, и распространяется на условиях упоминания нас, команды разработчиков, как создателей сего продукта.

*Тому, кто не хочет изменить свою жизнь, помочь невозможно.*

### For the Great Good!

## Авторы и контакты:

- Зайцев Игорь

- Зизов Вадим     vadim1221@hotmail.com

- Копылов Олег

- Тутушкин Артём

## THANKS

Авторы выражают благодарность Московскому государственному университету.

