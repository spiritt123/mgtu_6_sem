% плагин pulse waveform analyzer
% фкмб - фазо-кода манипулируемый сигнал кода Баркера
% нчм - непрерывная частотная модуляция
% лчм - линейно частотная модуляция
% Имитационное моделирование и графическая визуализация
% функции неопределенности простых и сложных сигналов
clear all; % Очистка памяти
close all; % Закрытие всех окон с графиками
clc; % Очистка окна команд и сообщений
fontSize=10; % Размер шрифта графиков
fontType=''; % Тип шрифта графиков
% Цвет графиков
tColor='b'; % Временная область
tColorLight=[0.3 0.7 0.9]; % Временная область
Color0='r'; % Эталонные сигналы
fColor=[1 0.4 0]; % Частотная область
eColor=[0.85 0.325 0.098]; % Погрешности
eColorLight=[0.9 0.9 0.4]; % Погрешности
eColorDark=[0.635 0.078 0.184]; % Погрешности
tstep = 0.05; % Шаг по оси времени
fstep = 0.05; % Шаг по оси частоты
dT = 3; % Длительность импульса
N = 1.5;
tmin = -N * dT; % Диапазон значений по времени (мин)
tmax = N * dT; % Диапазон значений по времени (макс)
fmin = round(-4/dT)-1; % Диапазон значений по частоте (мин)
fmax = round(4/dT)+1; % Диапазон значений по частоте (макс)
t = tmin:tstep:tmax; % Значения по оси времени
f = fmin:fstep:fmax; % Значения по оси частоты
% Формирование значений двумерной автокорреляционной
% функции тонального импульса
eps = 0.000001;
i = 0;
for ti = tmin:tstep:tmax
    i = i + 1;
    j = 0;
    for fj = fmin:fstep:fmax
        j = j + 1;
        val1 = 1 - abs(ti) / dT;
        val2 = pi * dT * (1.0 - abs(ti) / dT) * fj;
        x(j,i) = abs( val1 * sin(val2+eps)/(val2+eps));
    end
end

% Моделирование функции неопределености импульса с линейной частотной модуляцией
y = x.^2; % Формирование значений
% Формирование трехмерного графика
figure; mesh(t,f,y);
set(get(gcf, 'CurrentAxes'), 'FontSize', fontSize); % Изменение шрифта
xlabel ('Время,\it nT_д\rm, с'); % Надпись оси абсцисс
ylabel ('Частота,\it f\rm, Гц'); % Надпись оси ординат
zlabel('АКФ,\it A(t,f)'); % Надпись оси аппликат
title({'\rm Функция неопределенности для ЛЧМ-импульса'}); %Заголовок
% Формирование проекции
figure; contour(t,f,y,'Linewidth',1);
set(get(gcf, 'CurrentAxes'), 'FontSize', fontSize); % Изменение
шрифта
xlabel ('Время,\it nT_д\rm, с'); % Надпись оси абсцисс
ylabel ('Частота,\it f\rm, Гц'); % Надпись оси ординат
title({'\rm Проекция функции неопределенностидля ЛЧМ-импульса'}); % Заголовок


