% Моделирование фазоманипулированных сигналов
clear all; % Очищаем память
close all; % Закрываем все окна с графиками
clc; % Очистка окна команд и сообщений
fontSize=10; % Размер шрифта графиков
fontType=''; % Тип шрифта графиков
% Цвет графиков
tColor=[0,0.447,0.741]; % Временная область
tColorLight=[0.3 0.7 0.9]; % Временная область
Color0='r'; % Эталонные сигналы
fColor=[1 0.4 0]; % Частотная область
eColor=[0.85 0.325 0.098]; % Погрешности
eColorLight=[0.9 0.9 0.4]; % Погрешности
eColorDark=[0.635 0.078 0.184]; % Погрешности
BarkerLength=7; % Длина поседовательности Баркера
PNpoly = [1 0 0 0 0 1 1]; % Задающий полином (z^6+z+1)
A=2; % Амплитуда сигнала
fd = 100; % Частота дискретизации,Гц
f=2; % Несущая частота,Гц
Qchip=7; % Количество чипов
Tchip = 1; % Длительность импульса,с
Nchip = Tchip*fd; % Количество отсчетов в одном чипе
tmin=0; % Начальное время моделирования,с
tmax=Qchip*Tchip; % Конечное время моделирования,с
td = linspace(tmin,tmax,Nchip*Qchip); % Формирование массива абсцисс точек графика

xc = A*sin(td*2*pi*f); % Формирование значений
% Формирование графика
figure; plot(td,xc,'Color',tColor,'LineWidth',3);
axis([tmin tmax -A A]); % Диапазон значений осей
set(get(gcf,'CurrentAxes'),'FontSize',fontSize); % Изменение шрифта
title({'\rm Сигнал несущей частоты'}); % Заголовок
xlabel ('Время,\it nT_д\rm, с'); % Надпись оси абсцисс
ylabel('Сигнал,\it x(nT_д )\rm, В'); % Надпись оси ординат
% Формирование последовательности Баркера заданной длины
barker = comm.BarkerCode(); % Создание генератора
barker.Length = BarkerLength; % Длина последовательности
% Формирование значений
seqBarker=[];
for ii=1:Qchip
    seq(1:Nchip)=barker();
    seqBarker=cat(2,seqBarker,seq);
end
% Формирование графика
figure; plot(td,seqBarker,'Color',tColor,'LineWidth',3);
axis([tmin tmax -1.1 1.1]); % Диапазон значений осей
yticks([-1,0,1]);
set(get(gcf,'CurrentAxes'),'FontSize',fontSize); % Изменение шрифта
title({['\rm Последовательность Баркера, N = ',num2str(BarkerLength)]});
% Заголовок
xlabel ('\it n\rm'); % Надпись оси абсцисс
ylabel('\it S_B(n)\rm'); % Надпись оси ординат
% Моделирование модуля автокорреляционной функции последовательности Баркера сигнала
[asd,lb]=xcorr(seqBarker,seqBarker,'coef'); % Формирование значений
asd=abs(asd); % Модуль Модуль АКФ
lb=lb/Nchip;
% Формирование графика
figure; plot(lb,asd,'Color',tColor,'LineWidth',3);
axis([-tmax tmax 0 1]); % Диапазон значений осей
set(get(gcf,'CurrentAxes'),'FontSize',fontSize); % Изменение шрифта
title({'\rm Модуль автокорреляционной функции',...
'последовательности Баркера'}); % Заголовок
xlabel ('\it n\rm'); % Надпись оси абсцисс
ylabel('Модуль АКФ,\it |R_s(n)|\rm'); % Надпись оси ординат
% Фазоманипулированный последовательностью Баркера сигнал
xd=xc.*seqBarker; % Формирование значений
% Формирование графика
figure; plot(td,xd,'Color',tColor,'LineWidth',3);
axis([tmin tmax -A A]); % Диапазон значений осей
set(get(gcf,'CurrentAxes'),'FontSize',fontSize); % Изменение шрифта
title({'\rm Фазоманипулированный последовательностью Баркера сигнал'});
% Заголовок
xlabel ('Время,\it nT_д\rm, с'); % Надпись оси абсцисс
ylabel('ФМ-сигнал,\it x_B(nT_д )\rm, В'); % Надпись оси ординат
% Моделирование модуля автокорреляционной функции фазоманипулированного последовательностью Баркера сигнала
[axd,ld]=xcorr(xd,xd,'coef'); % Формирование значений
axd=abs(axd); % Модуль Модуль АКФ
ld=ld/Nchip;
% Формирование графика
figure; plot(ld,axd,'Color',tColor,'LineWidth',3);
axis([-tmax tmax 0 1]); % Диапазон значений осей
set(get(gcf,'CurrentAxes'),'FontSize',fontSize); % Изменение шрифта
title({'\rm Модуль автокорреляционной функции',...
'фазоманипулированного последовательностью Баркера сигнала'}); %Заголовок
xlabel ('Время,\it nT_д\rm,с'); % Надпись оси абсцисс
ylabel('Модуль АКФ,\it |R_x(nT_д )|\rm'); % Надпись оси ординат

% Формирование последовательности M-последовательности заданной длины
pn=commsrc.pn('GenPoly',PNpoly); % Создание генератора
nM=length(PNpoly); % Длина последовательности
% Формирование значений
seqPN=[];
for ii=1:Qchip
    seqElem=generate(pn);
    if seqElem==0
        seqElem=-1;
    end
    seq(1:Nchip)=seqElem;
    seqPN=cat(2,seqPN,seq);
end
% Формируем график
figure; plot(td,seqPN,'Color',tColor,'LineWidth',3);
axis([tmin tmax -1.1 1.1]); % Диапазон значений осей
yticks([-1,0,1]);
set(get(gcf,'CurrentAxes'),'FontSize',fontSize); % Изменение шрифта
title({['\rm M-последовательность, M = ',num2str(nM)]}); % Заголовок
xlabel ('\it n\rm'); % Надпись оси абсцисс
ylabel('\it S_M(n)\rm'); % Надпись оси ординат

% Моделирование модуля автокорреляционной функции фазоманипулированного M-последовательностью сигнала
[asd,lb]=xcorr(seqPN,seqPN,'coef'); % Формирование значений
asd=abs(asd); % Модуль АКФ
lb=lb/Nchip;
% Формирование графика
figure; plot(lb,asd,'Color',tColor,'LineWidth',3);
axis([-tmax tmax 0 1]); % Диапазон значений осей
set(get(gcf,'CurrentAxes'),'FontSize',fontSize); % Изменение шрифта
title({'\rm Модуль автокорреляционной функции';'M-последовательности'});
% Заголовок
xlabel ('Время,\it n\rm,с'); % Надпись оси абсцисс
ylabel('Модуль АКФ,\it |R_s(n)|\rm'); % Надпись оси ординат

% Фазоманипулированный M-последовательностью сигнал
xd=xc.*seqPN; % Формирование значений
% Формирование графика
figure; plot(td,xd,'Color',tColor,'LineWidth',3);
axis([tmin tmax -A A]); % Диапазон значений осей
set(get(gcf,'CurrentAxes'),'FontSize',fontSize); % Изменение шрифта
title({'\rm Фазоманипулированный M-последовательностью сигнал'}); % Заго
xlabel ('Время,\it nT_д\rm, с'); % Надпись оси абсцисс
ylabel('ФМ-сигнал,\it z(nT_д )\rm, В'); % Надпись оси ординат


% Моделирование модуля автокорреляционной функции фазоманипулированного M-последовательностью сигнала
[axd,ld]=xcorr(xd,xd,'coef'); % Формирование значений
axd=abs(axd); % Модуль Модуль АКФ
ld=ld/Nchip;
% Формирование графика
figure; plot(ld,abs(axd),'Color',tColor,'LineWidth',3);
axis([-tmax tmax 0 1]); % Диапазон значений осей
set(get(gcf,'CurrentAxes'),'FontSize',fontSize); % Изменение шрифта
title({'\rm Модуль автокорреляционной функции',...
'фазоманипулированного M-последовательностью сигнала'}); % Заголовок
xlabel ('Время,\it nT_д\rm, с'); % Надпись оси абсцисс
ylabel('Модуль АКФ,\it |R_x(nT_д )|\rm'); % Надпись оси ординат

