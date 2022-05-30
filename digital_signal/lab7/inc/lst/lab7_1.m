pkg load mapping
pkg load communications
pkg load image
clear all; % Очистка памяти
close all; % Закрытие всех окон с графиками
clc; % Очистка окна команд и сообщений
fontSize=10; % Размер шрифта графиков
fontType=''; % Тип шрифта графиков
% Цвет графиков
tColor=[0,0.447,0.741]; % Временная область
tColorLight=[0.3 0.7 0.9]; % Временная область
Color0=[1 0 0]; % Эталонные сигналы
fColor=[1 0.4 0]; % Частотная область
eColor=[0.85 0.325 0.098]; % Погрешности
eColorLight=[0.9 0.9 0.4]; % Погрешности
eColorDark=[0.635 0.078 0.184]; % Погрешности
% Параметры области определения функций
nMax= 300; % Количество отсчетов по каждой полуоси
nScale=10;%.1; % Коэффициент масштабирования
% Время запуска текста в видео, с
startText0=5;
startText1=10;
frameRate=25; % Частота кадрирования
videoDuration=15; % Длительность видео
fCount=frameRate*videoDuration; % Количество кадров
function domain = getComplexDomain(nMax,nScale)
    domain = [];
    arr = -nMax:nScale:nMax;
    for y = arr
        d2 = [];
        for x = arr
            comp_arr = complex(x,y);
            d2 = cat(1, d2, comp_arr);
        end
        domain = cat(2, domain, d2);
    end
    domain = domain;
end
%getComplexDomain = @(nMax,nScale) complex(0:nScale:nMax,0:nScale:nMax);
% Формирование изображения комплексной функции
% f(z)=z
z=getComplexDomain(nMax,nScale); % Область определения
f=z; % Формирование значений
% Формирование изображения HSV
hsv1(:,:,1)=wrapTo2Pi(angle(f))/(2*pi); % Тон
hsv1(:,:,2)=1; % Насыщенность
hsv1(:,:,3)=abs(f)./max(abs(f)); % Яркость
rgb1=hsv2rgb(hsv1); % Преобразование в формат RGB
figure; imshow(rgb1); % Визуализация
f1=f;
% Формирование изображения комплексной функции
% f(z)=z*exp(z)
f=z.*exp(z) % Формирование значений
% Формирование изображения HSV
hsv2(:,:,1)=wrapTo2Pi(angle(f))/(2*pi); % Тон
hsv2(:,:,2)=1; % Насыщенность
hsv2(:,:,3)=abs(f1)./max(abs(f1)); % Яркость
rgb2=hsv2rgb(hsv2); % Преобразование в формат RGB
figure; imshow(rgb2); % Визуализация
% Формирование изображения комплексной функции
% f(z)=(z^2-i)/(z^2+i)
%nScale=nScale*.5; % Изменение масштаба
z=getComplexDomain(nMax,nScale); % Область определения
f=(z.^2-i)./(z.^3+i); % Формирование значений
% Формирование изображения HSV
hsv3(:,:,1)=wrapTo2Pi(angle(f))/(2*pi); % Тон
hsv3(:,:,2)=1; % Насыщенность
hsv3(:,:,3)=abs(f)./max(abs(f)); % Яркость
rgb3=hsv2rgb(hsv3); % Преобразование в формат RGB
figure; imshow(rgb3); % Визуализация
rgbn=imnoise(rgb3, "gaussian", 0, 0.001);
figure; imshow(rgbn); % Визуализация
% Объединение массивов изображений
size(rgb1)
size(rgb3)
rgb0=[rgb1 rgb2;rgb3 rgbn];
figure; imshow(rgb0,'InitialMagnification','fit'); % Визуализация
% Сохранение в формате JPG
imwrite(rgb0,'picture.jpg');
display("press any key to start animation")
pause()
close all
for i=0:0.001:01
    rgbn=imnoise(rgb3, "gaussian", 0, i);
    rgb0=[rgb1 rgb2;rgb3 rgbn];
    imshow(rgb0,'InitialMagnification','fit'); % Визуализация
    pause(0.01)
end